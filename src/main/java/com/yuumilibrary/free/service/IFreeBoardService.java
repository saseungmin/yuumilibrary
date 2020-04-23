package com.yuumilibrary.free.service;

import java.util.HashMap;
import java.util.List;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.free.vo.FreeBoardVO;
import com.yuumilibrary.free.vo.FreeSearchVO;

public interface IFreeBoardService {

	public List<FreeBoardVO> getBoardList(FreeSearchVO searchVO) throws BizException;
	
	public FreeBoardVO getBoard(HashMap<String, Object> map) throws BizException;
	
	public void registBoard(FreeBoardVO board) throws BizException;
	
	public void modifyBoard(FreeBoardVO board) throws BizException;
	
	public void removeBoard(FreeBoardVO board) throws BizException;
	
	public void increaseHit(FreeBoardVO board) throws BizException;

	public void removeCheckedBoard(int[] boNums) throws BizException;
	
}
