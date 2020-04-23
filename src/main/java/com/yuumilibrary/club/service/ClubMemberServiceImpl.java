package com.yuumilibrary.club.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.chat.vo.ChatMessageVO;
import com.yuumilibrary.club.dao.IClubMemberDao;
import com.yuumilibrary.club.vo.ClubMemberListVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubVO;
import com.yuumilibrary.common.exception.BizDuplicateException;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;

@Service
public class ClubMemberServiceImpl implements IClubMemberService {
	
	@Autowired
	private IClubMemberDao clubMemberDao;

	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public List<ClubVO> getClubList(ClubSearchVO searchVO) throws Exception {
		try {
			int rowCount = clubMemberDao.getClubCount(searchVO);
			searchVO.setTotalRowCount(rowCount);
			searchVO.setting();
			return clubMemberDao.getClubList(searchVO);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public ClubVO getClub(int bkNum) throws Exception {
		try {
			ClubVO club = clubMemberDao.getClub(bkNum);
			if (club == null) {
				throw new BizNotFoundException("클럽 [" + bkNum + "]을 조회하지 못했습니다.");
			}
			return club;
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public void registClub(ClubVO clubVO) throws Exception {
		try {
			clubMemberDao.registClub(clubVO);			
			logger.info("club=================={}",clubVO);
			clubMemberDao.registClubCap(clubVO);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public void modifyClub(ClubVO clubVO) throws Exception {
		try {
			ClubVO vo = clubMemberDao.getClub(clubVO.getBkNum());
			if (vo == null) {
				throw new BizNotFoundException("클럽이름 [" + clubVO.getBkClubName() + "]을 조회하지 못했습니다.");
			}
			clubMemberDao.modifyClub(clubVO);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public void removeClub(ClubVO clubVO) throws Exception {
		try {
			ClubVO vo = clubMemberDao.getClub(clubVO.getBkNum());
			if (vo == null) {
				throw new BizNotFoundException("클럽이름 [" + clubVO.getBkClubName() + "]을 조회하지 못했습니다.");
			}
			clubMemberDao.deleteClub(clubVO);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public List<ClubMemberListVO> getClubMemberList(ClubMemberListVO clubListVO) throws Exception {
		try {
//			int rowCount = clubMemberDao.getMemberCount(listVO);
//			listVO.setTotalRowCount(rowCount);
//			
//			searchVO.setting();
			
			return clubMemberDao.getClubMemberList(clubListVO);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}
	
	@Override
	public List<ClubMemberListVO> getClubMember(Map<Object, Object> map) throws Exception{
		logger.info("map========={}",map);
		return clubMemberDao.getClubMember(map);
	}
	
	@Override
	public void registMember(ClubMemberListVO clubListVO) throws Exception {
//		try {
			logger.info("clubList========={}",clubListVO);
			Map<Object, Object> map =new HashMap<Object, Object>();
			map.put("cmMemId", clubListVO.getCmMemId());
			List<ClubMemberListVO> vo = clubMemberDao.getClubMember(map);
			if (vo == null) {
				throw new BizDuplicateException("해당 회원이 신청되어있습니다.");
			}else {
				
				clubMemberDao.registMember(clubListVO);
			}
//		} catch (Exception e) {
//			throw new BizException(e);
//		}
	}

	@Override
	public void registMemberConfirm(Map<String, Object> map) throws Exception {
		clubMemberDao.registMemberConfirm(map);
	}

	@Override
	public void withdrawMember(Map<String, Object> map) throws Exception {
		clubMemberDao.withdrawMember(map);
	}

	@Override
	public List<ClubMemberListVO> getClubChatMember(int clubNum) throws Exception {
		ClubVO vo =clubMemberDao.getClub(clubNum);
		if(vo ==null) {
			throw new BizNotFoundException();
		}
		
		return clubMemberDao.getClubChatMember(clubNum);
		
	}

	@Override
	public ClubMemberListVO getClubMessage(ChatMessageVO message) throws Exception {
		
		
		return clubMemberDao.getChatMessage(message);
	}





}
