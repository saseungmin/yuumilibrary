package com.yuumilibrary.library.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.library.vo.LibraryListVO;
import com.yuumilibrary.library.vo.LibrarySearchVO;

@Mapper
public interface ILibraryDao {
	
	public int getLibraryCount(LibrarySearchVO searchVO) throws BizException;

	public List<LibraryListVO> getLibraryList(LibrarySearchVO searchVO) throws BizException;
	
	public LibraryListVO getLibraryDetail(int libCode) throws BizException;

}
