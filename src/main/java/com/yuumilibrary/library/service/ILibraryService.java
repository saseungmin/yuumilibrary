package com.yuumilibrary.library.service;

import java.util.List;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.library.vo.LibraryListVO;
import com.yuumilibrary.library.vo.LibrarySearchVO;

public interface ILibraryService {

	public List<LibraryListVO> getLibraryList(LibrarySearchVO searchVO) throws BizException;

	public LibraryListVO getLibraryDetail(int libCode) throws BizException;
}
