package com.yuumilibrary.free.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.free.vo.FreeBoardVO;
import com.yuumilibrary.free.vo.FreeSearchVO;


@Mapper
public interface IFreeBoardDao {

	/**
	  * 레코드 건수 조회 <br>
	 * <i>검색조건이 있는 경우 조건에 맞는 건수</i>
	 * @param searchVO
	 * @return
	 * @throws SQLException
	 */
	public int getBoardCount(FreeSearchVO searchVO)throws SQLException;
		
	public List<FreeBoardVO> getBoardList(FreeSearchVO searchVO) throws SQLException;
	
	public FreeBoardVO getBoard(HashMap<String, Object> map) throws SQLException;
	
	public int insertBoard(FreeBoardVO board) throws SQLException;
	
	public int updateBoard(FreeBoardVO board) throws SQLException;
	
	public int deleteBoard(FreeBoardVO board) throws SQLException;
	
	/**
	 * 조회수 증가 
	 * @param boNum
	 * @return int
	 * @throws SQLException
	 */
	public int increaseHit(FreeBoardVO board) throws SQLException;
	
	public int deleteCheckedBoard(int[] buNums) throws SQLException;
	
	
}
