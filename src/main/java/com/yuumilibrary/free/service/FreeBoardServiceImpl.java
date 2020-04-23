package com.yuumilibrary.free.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.attach.dao.IAttachDao;
import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.common.exception.BizDuplicateException;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.exception.BizRegistFailException;
import com.yuumilibrary.free.dao.IFreeBoardDao;
import com.yuumilibrary.free.vo.FreeBoardVO;
import com.yuumilibrary.free.vo.FreeSearchVO;
import com.yuumilibrary.member.dao.IMemberDao;
import com.yuumilibrary.member.vo.MemberVO;
import com.yuumilibrary.rsa.RSAsss;
import com.yuumilibrary.rsa.SHA256Util;

@Service
public class FreeBoardServiceImpl implements IFreeBoardService {
	
	@Autowired
	private IFreeBoardDao freeDao;
	
	@Autowired
	private IMemberDao memberDao;
	
	@Autowired
	private IAttachDao attachDao;
	
	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<FreeBoardVO> getBoardList(FreeSearchVO searchVO) throws BizException {
		try {
			int rowCount = freeDao.getBoardCount(searchVO);
			searchVO.setTotalRowCount(rowCount);
			searchVO.setting();
			return freeDao.getBoardList(searchVO);
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}

	@Override
	public FreeBoardVO getBoard(HashMap<String, Object> map) throws BizException {
		try {
			FreeBoardVO free = freeDao.getBoard(map);
			if (free == null) { 
				throw new BizNotFoundException("글번호 : " + map.get("boNum") + "을 조회하지 못했습니다.");
			}
			free.setAttaches(attachDao.selectAttachByParentNo(map));
			return free;
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}

	@Override
	public void registBoard(FreeBoardVO free) throws BizException {
		try {
			if(free.getBoCategory().equals("BC01")) {
				free.setBoNotice(0);
			}else {
				free.setBoNotice(1);
			}
			int res = freeDao.insertBoard(free);
			if (res < 1) {
				throw new BizRegistFailException();
			}
			
			//첨부파일이 존재하는 경우 첨부파일 등록 , parentNo 설정 필요
			List<AttachVO> atchList = free.getAttaches();
			if(atchList !=null) {
				for(AttachVO vo : atchList) {
					vo.setAtchParentCategory(free.getBoNotice());
					vo.setAtchParentNo(free.getBoNum());
					logger.info("freeboNum={}",free.getBoNum());
					attachDao.insertAttach(vo);
				}
			}
			
		} catch (SQLException e) {
			// 중복에러
			if (e.getErrorCode() == 1) {
				throw new BizDuplicateException(e);
			}
			throw new BizException(e);
		}
		
	}

	@Override
	public void modifyBoard(FreeBoardVO board) throws BizException {
		try {
			MemberVO vo = memberDao.getMemberVO(board.getBoMemId());
			if(vo == null) {
				throw new BizNotFoundException("회원 [" + board.getBoMemId() + "]을 조회하지 못했습니다." ); 
			}else {
				
				String salt = vo.getMemSalt();
				String myPrivateKey=vo.getMemPrivateKey();
				
				String decodeSalt=RSAsss.decode(salt, myPrivateKey);
				
				String userSalt=SHA256Util.getEncrypt(board.getBoMemPass(), decodeSalt);

				if(vo.getMemPass().equals(userSalt)) {

						freeDao.updateBoard(board);
						if(board.getDelAtchNos() !=null) {						
							attachDao.deleteAttaches(board.getDelAtchNos());
						}

					
				}else {
					throw new BizRegistFailException();
				}
				
			}
		} catch (SQLException e) {
			throw new BizException(e);
		}
	}

	@Override
	public void removeBoard(FreeBoardVO board) throws BizException {
		try {
			MemberVO vo = memberDao.getMemberVO(board.getBoMemId());
			if(vo == null) {
				throw new BizNotFoundException("회원 [" + board.getBoMemId() + "]을 조회하지 못했습니다." ); 
			}else {
				
				String salt = vo.getMemSalt();
				String myPrivateKey=vo.getMemPrivateKey();
				
				String decodeSalt=RSAsss.decode(salt, myPrivateKey);
				
				String userSalt=SHA256Util.getEncrypt(board.getBoMemPass(), decodeSalt);

				if(vo.getMemPass().equals(userSalt)) {

					freeDao.deleteBoard(board);
					
					if(board.getDelAtchNos() !=null) {						
						attachDao.deleteAttaches(board.getDelAtchNos());
					}
				}else {
					throw new BizRegistFailException();
				}
				
			}
		} catch (SQLException e) {
			throw new BizException(e);
		}
		
	}

	@Override
	public void increaseHit(FreeBoardVO free) throws BizException {
		try {
			freeDao.increaseHit(free);
		} catch (SQLException e) {
			throw new BizException(e);
		}
		
	}

	@Override
	public void removeCheckedBoard(int[] boNums) throws BizException {
		try {
			freeDao.deleteCheckedBoard(boNums);
		} catch (SQLException e) {
			throw new BizException(e);
		}
		
	}
	
	

}
