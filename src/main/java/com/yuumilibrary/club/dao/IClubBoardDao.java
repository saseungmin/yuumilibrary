package com.yuumilibrary.club.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.club.vo.ClubBoardVO;
import com.yuumilibrary.common.exception.BizException;

@Mapper
public interface IClubBoardDao {

	public int getBoardCount(ClubSearchVO searchVO) throws BizException;

	public List<ClubBoardVO> getBoardList(ClubSearchVO searchVO) throws BizException;

	public ClubBoardVO getBoard(HashMap<String, Object> map);

	public int registBoard(ClubBoardVO board) throws BizException;

	public int modifyBoard(ClubBoardVO board) throws BizException;

	public int removeBoard(ClubBoardVO board) throws BizException;
	
	public int increaseHit(HashMap<String, Object> map) throws BizException;
	
	public int searchClubMemberCount(String memberId) throws BizException;
	
	public HashMap<String, Object> insertAttach(AttachVO attach) throws BizException;
}
