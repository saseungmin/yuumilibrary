package com.yuumilibrary.club.service;

import java.util.HashMap;
import java.util.List;

import com.yuumilibrary.club.vo.ClubSearchVO;
import com.yuumilibrary.club.vo.ClubBoardVO;
import com.yuumilibrary.common.exception.BizException;

public interface IClubBoardService {

	public List<ClubBoardVO> getBoardList(ClubSearchVO searchVO) throws BizException;

	public ClubBoardVO getBoard(HashMap<String, Object> map);

	public void registBoard(ClubBoardVO board) throws BizException;

	public void modifyBoard(ClubBoardVO board) throws BizException;

	public void removeBoard(ClubBoardVO board) throws BizException;

	public void increaseHit(int cbBoNum, int cbBoClubNum) throws BizException;

	public int searchClubMember(String memberId) throws BizException;

	

}
