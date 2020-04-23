package com.yuumilibrary.club.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.attach.dao.IAttachDao;
import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.club.dao.IClubBoardDao;
import com.yuumilibrary.club.vo.ClubBoardVO;
import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.common.exception.BizRegistFailException;

@Service
public class ClubBoardServiceImpl implements IClubBoardService {

	@Autowired
	IClubBoardDao boardDao;

	@Autowired
	private IAttachDao attachDao;

	@Override
	public List<ClubBoardVO> getBoardList(ClubSearchVO searchVO) throws BizException {
		try {

			int rowcount = boardDao.getBoardCount(searchVO);
			searchVO.setTotalRowCount(rowcount);
			searchVO.setting();
			return boardDao.getBoardList(searchVO);
		} catch (Exception e) {
			throw new BizException();
		}
	}

	@Override
	public ClubBoardVO getBoard(HashMap<String, Object> map) {
		try {
			ClubBoardVO boardVO = boardDao.getBoard(map);
			if (boardVO == null) {
				throw new BizNotFoundException("잘못된 클럽게시판번호입니다.");
			}
			boardVO.setAttaches(attachDao.selectAttachByParentNo(map));
			return boardVO;
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public void registBoard(ClubBoardVO board) throws BizException {
		try {
			int res = boardDao.registBoard(board);
			if (res < 1) {
				throw new BizRegistFailException();
			}

			// 첨부파일이 존재하는 경우 첨부파일 등록 , parentNo 설정 필요
			List<AttachVO> atchList = board.getAttaches();
			if (atchList != null) {
				for (AttachVO vo : atchList) {
					vo.setAtchParentCategory(board.getCbBoNotice());
					vo.setAtchParentNo(board.getCbBoNum());
					attachDao.insertAttach(vo);
				}
			}
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public void modifyBoard(ClubBoardVO board) throws BizException {
		try {
			int res = boardDao.modifyBoard(board);
			if (res < 1) {
				throw new BizException();
			}
			
			if(board.getDelAtchNos() != null) {
				attachDao.deleteAttaches(board.getDelAtchNos());
			}
			
		} catch (Exception e) {
			throw new BizException();
		}
	}

	@Override
	public void removeBoard(ClubBoardVO board) throws BizException {
		try {
			int res = boardDao.removeBoard(board);
			if (res < 1) {
				throw new BizException();
			}
			
			if(board.getDelAtchNos() != null) {
				attachDao.deleteAttaches(board.getDelAtchNos());
			}
			
		} catch (Exception e) {
			throw new BizException();
		}
	}

	@Override
	public void increaseHit(int cbBoNum, int cbBoClubNum) throws BizException {
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("cbBoNum", cbBoNum);
			map.put("cbBoClubNum", cbBoClubNum);

			int res = boardDao.increaseHit(map);
			if (res < 1) {
				System.out.println("조회수 증가 실패");
				throw new BizNotFoundException();
			}
		} catch (Exception e) {
			throw new BizException(e);
		}

	}

	@Override
	public int searchClubMember(String memberId) throws BizException {
		int res = boardDao.searchClubMemberCount(memberId);
		return res;
	}

}
