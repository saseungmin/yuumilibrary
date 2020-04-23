package com.yuumilibrary.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.library.dao.ILibraryDao;
import com.yuumilibrary.library.vo.LibraryListVO;
import com.yuumilibrary.library.vo.LibrarySearchVO;

@Service
public class LibraryServiceImpl implements ILibraryService {

	@Autowired
	ILibraryDao libraryDao;

	@Override
	public List<LibraryListVO> getLibraryList(LibrarySearchVO searchVO) throws BizException {
		try {
			int rowCount = libraryDao.getLibraryCount(searchVO);
			searchVO.setTotalRowCount(rowCount);
			searchVO.setting();
			return libraryDao.getLibraryList(searchVO);
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	@Override
	public LibraryListVO getLibraryDetail(int libCode) throws BizException {
		LibraryListVO lib;
		try {
			lib = libraryDao.getLibraryDetail(libCode);
			if (lib == null) {
				throw new BizNotFoundException("조회 할 수 없습니다. (잘못된 코드번호입니다" + libCode + ")");
			}
			return lib;
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

}
