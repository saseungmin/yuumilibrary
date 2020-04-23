package com.yuumilibrary.library.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.yuumilibrary.library.service.ILibraryService;
import com.yuumilibrary.library.vo.LibraryListVO;
import com.yuumilibrary.library.vo.LibrarySearchVO;

@Controller
public class LibraryListController {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private ILibraryService libraryService;

	@RequestMapping("/library/libraryList.lol")
	public String libraryList(ModelMap model, LibrarySearchVO searchVO, String searchWord) throws Exception {
		searchVO.setSearchWord(searchWord);
		List<LibraryListVO> list = libraryService.getLibraryList(searchVO);
		logger.debug("list size = {}", list.size());

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", list);

		return "/library/libraryList";
	}

	@RequestMapping(value = "/library/libraryList.lol", method = RequestMethod.GET, params = "libCode")
	public String libraryDetail(ModelMap model, LibrarySearchVO searchVO, HttpServletRequest req,
			HttpServletResponse resp, @RequestParam("libCode") int libCode) throws Exception {

		List<LibraryListVO> list = libraryService.getLibraryList(searchVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", list);
		searchVO.setting();

		LibraryListVO detail = libraryService.getLibraryDetail(libCode);
		req.setAttribute("detail", detail);

		return "/library/libraryList";
	}

}
