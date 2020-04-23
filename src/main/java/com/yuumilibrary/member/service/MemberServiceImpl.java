package com.yuumilibrary.member.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.yuumilibrary.common.exception.BizDuplicateException;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.exception.BizRegistFailException;
import com.yuumilibrary.common.vo.ResultMessageVO;
import com.yuumilibrary.member.dao.IMemberDao;
import com.yuumilibrary.member.vo.MemberSearchVO;
import com.yuumilibrary.member.vo.MemberVO;
import com.yuumilibrary.rsa.RSAsss;
import com.yuumilibrary.rsa.SHA256Util;

@Service
public class MemberServiceImpl  implements IMemberService{
	
	@Autowired
	private IMemberDao memberDao;
	
	
	@Override
	public List<MemberVO> getMemberList(MemberSearchVO searchVO) throws BizException {
		
		try {
			int rowCount = memberDao.getMemberCount(searchVO);
			searchVO.setTotalRowCount(rowCount);
			searchVO.setting();
			return memberDao.getMemberList(searchVO);
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}
	
	@Override
	public List<MemberVO> getMemberListForExcel() throws BizException {
		// 엑셀로 뽑아내기위한 서비스
		try {
			List<MemberVO> memberVO = memberDao.getMemberListForExcel(); 
			return memberVO;
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}

	@Override
	public MemberVO getMember(String memId) throws BizException {
		try {
			MemberVO member = memberDao.getMemberVO(memId);
			if(member == null) {
				throw new BizNotFoundException("회원 [" + memId + "]을 조회하지 못했습니다." ); 
			}
			return member;
		}catch (BizException e) {
			throw new BizRegistFailException(e); 
		}
	}

	@Override
	public void registMember(MemberVO member) throws BizException {
		try {
			
			MemberVO vo = memberDao.getMemberVO(member.getMemId());
			if(vo != null) {
				throw new BizDuplicateException("회원 [" + member.getMemId() + "]가 이미 가입되어있습니다." ); 
			}else {
				
				if(member.getMemHpYn()==null) {
					member.setMemHpYn("N");
				}else {
					member.setMemHpYn("Y");
				}
				if(member.getMemMailYn()==null) {
					member.setMemMailYn("N");
				}else {
					member.setMemMailYn("Y");
				}
				String salt=SHA256Util.generateSalt();
				
				HashMap<String,String> rsaKeyPair = RSAsss.createKeypairAsString();
				String publicKey = rsaKeyPair.get("publicKey");
				String privateKey = rsaKeyPair.get("privateKey");
				
				String encryptedText = RSAsss.encode(salt, publicKey);
				member.setMemSalt(encryptedText);
				member.setMemPrivateKey(privateKey);
				
				String passSalt=SHA256Util.getEncrypt(member.getMemPass(), salt);
				member.setMemPass(passSalt);	
				memberDao.privateKeyMember(member);
				memberDao.insertMember(member);		
				
			}
	
		} catch (DuplicateKeyException e) {
			throw new BizDuplicateException(e);
		}	
	}


	@Override
	public void modifyMember(MemberVO member) throws BizException {
		try {
			MemberVO vo = memberDao.getMemberVO(member.getMemId());
			
				String salt=vo.getMemSalt();
				String myPrivateKey=vo.getMemPrivateKey();
				
				String decodeSalt=RSAsss.decode(salt, myPrivateKey);
				
				String userSalt=SHA256Util.getEncrypt(member.getMemPass(), decodeSalt);

				if(vo.getMemPass().equals(userSalt)) {
					
					member.setMemPass(userSalt);
					memberDao.updateMember(member);
				}else {
					throw new BizRegistFailException();
				}
				
			
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}



	@Override
	public void removeMember(MemberVO member) throws BizException {
		try {
			MemberVO vo = memberDao.getMemberVO(member.getMemId());
			if(vo == null) {
				throw new BizNotFoundException("회원 [" + member.getMemId() + "]을 조회하지 못했습니다." ); 
			}else {
				
				String salt=vo.getMemSalt();
				String myPrivateKey=vo.getMemPrivateKey();
				
				String decodeSalt=RSAsss.decode(salt, myPrivateKey);
				
				String userSalt=SHA256Util.getEncrypt(member.getMemPass(), decodeSalt);

				if(vo.getMemPass().equals(userSalt)) {
					
					member.setMemPass(userSalt);
					memberDao.deletePrivatKey(member.getMemId());
					memberDao.deleteMember(member);
				}else {
					throw new BizRegistFailException();
				}
				
			}
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}
	
	
	@Override
	public void UpdateMemberImg(MemberVO member) throws BizException {
		
		MemberVO vo = memberDao.getMemberVO(member.getMemId());
		if(vo == null) {
			throw new BizNotFoundException("회원 [" + member.getMemId() + "]을 조회하지 못했습니다." ); 
		}else {
			memberDao.updateMemberImg(member);
		}
	}

	@Override
	public MemberVO getMemberId(String memId) throws BizException {
		MemberVO vo = memberDao.getMemberVO(memId);
		return vo;
		
	}

}
