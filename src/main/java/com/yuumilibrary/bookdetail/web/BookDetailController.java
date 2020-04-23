package com.yuumilibrary.bookdetail.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yuumilibrary.api.IApiBookDao;
import com.yuumilibrary.bookdetail.service.IBookService;
import com.yuumilibrary.bookdetail.vo.BookSearchVO;
import com.yuumilibrary.bookdetail.vo.BookVO;
import com.yuumilibrary.common.exception.BizException;
import com.yuumilibrary.common.exception.BizRegistFailException;
import com.yuumilibrary.member.vo.MemberVO;
import com.yuumilibrary.util.OpenApiJsonParsing;

@Controller
public class BookDetailController {

	private final Logger logger = LoggerFactory.getLogger(getClass());
	private final static String serviceKey = "db6ada1743d81494989b483d48d9c418f4fef4964e259503cfeaa17be955005b";

	@Autowired
	private IBookService bookService;
	
	@Autowired
	private IApiBookDao apiCallService;

	@RequestMapping("/book/bookList.lol")
	public void bookList(ModelMap model, BookSearchVO searchVO) throws Exception {
		
		
		List<BookVO> novel = apiCallService.novel();
		model.addAttribute("novel", novel);
		
		List<BookVO> history = apiCallService.history();
		model.addAttribute("history",history);
 		
		
		List<BookVO> art = apiCallService.art();
		model.addAttribute("art",art);
		
		List<BookVO> total = apiCallService.total();
		model.addAttribute("total",total);
		
		List<BookVO> list = bookService.getBookList(searchVO);
		logger.info("list size = {}", list.size());
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", list);
	}

	@RequestMapping(value = "book/bookView.lol", method = RequestMethod.GET, params = { "bookIsbn", "bookName" })
	public String getBook(@RequestParam("bookIsbn") String isbn, @RequestParam("bookName") String bookName, 
			String bookAuthors, ModelMap model) throws Exception {

		String address = "http://data4library.kr/api/srchDtlList?authKey=" + serviceKey + "&isbn13=" + isbn
				+ "&format=json";

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bookIsbn", isbn);
		map.put("bookName", bookName);
		map.put("bookAuthors", bookAuthors);

		OpenApiJsonParsing apiJsonParsing = new OpenApiJsonParsing();
		String json = apiJsonParsing.WebConnection(address);

		// API활용해서 책 소개 내용 가져오기 ^^
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(json);
		JSONObject resp = (JSONObject) obj.get("response");
		JSONArray info = (JSONArray) resp.get("detail");
		JSONObject arr = (JSONObject) info.get(0);
		JSONObject res = (JSONObject) arr.get("book");

		logger.info("book map============={}", map);
		BookVO book = bookService.getBook(map);
		
		List<BookVO> recommend = apiCallService.recommend(isbn);
		logger.info("recommend================={}",recommend);
		model.addAttribute("recommend", recommend);
		model.addAttribute("book", book);
		model.addAttribute("apibook", res);


		return "book/bookView";
	}

	@RequestMapping(value = "/book/loanList.lol", method = RequestMethod.GET, params = "memId")
	public void loanList(BookSearchVO searchVO, @RequestParam("memId") String memId, ModelMap model) throws Exception {
		System.out.println("야***********************야야야야양*******" + memId);
		searchVO.setMemId(memId);
		searchVO.setSearchWord(memId);
		searchVO.setSearchType("U");
		List<BookVO> loanList = bookService.getLoanList(searchVO);
		logger.info("list size = {}", loanList.size());
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("loanList", loanList);
	}

	@RequestMapping("/book/allLoanList.lol")
	public void allLoanList(BookSearchVO searchVO, ModelMap model) throws Exception {
		List<BookVO> loanList = bookService.getAllLoanList(searchVO);
		logger.info("list size = {}", loanList.size());
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("loanList", loanList);
	}

	////////////////////// 전체대출현황을 엑셀파일로 뽑아낸다
	@RequestMapping(value = "/book/getExcel.lol")
	public ModelAndView toExcel(HttpServletRequest req, HttpSession session, BookSearchVO searchVO, ModelMap model) {
		List<BookVO> loanList = bookService.getAllLoanListForExcel(searchVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("loanList", loanList);
		ModelAndView result = new ModelAndView();
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("query", req.getParameter("query")); // where에 들어갈 조건

		result.addObject(loanList);
		
		Calendar now = new GregorianCalendar();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH) + 1;
		int day = now.get(Calendar.DAY_OF_MONTH);
		int hour = now.get(Calendar.HOUR_OF_DAY);

		StringBuffer str = new StringBuffer();
		str.append(year).append(month).append(day).append(hour);
		req.setAttribute("filename", str);

		result.setViewName("book/getExcel");
		return result;
	}
	//////////////////////////////////////////////////////////////////
	
	
	
	@RequestMapping(value = "/book/bookLoan.lol",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loanBook(BookVO book, RedirectAttributes redirectAttributes, ModelMap model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			System.out.println("!!!!!!!!!!!!!!!!!!"+book);
			
			bookService.loanBook(book);

			System.out.println(map);
			map.put("message", "대출 성공");
			map.put("user",book.getLoaMemId());
			map.put("result",true);
//		redirectAttributes.addFlashAttribute("message", map);
			return map;
		} catch (BizException e) {
			map.put("message", "대출 실패");
			map.put("result",false);
//		redirectAttributes.addFlashAttribute("message", map);
			return map;
		}
	}

	@RequestMapping(value = "/book/returnBook.lol", method = RequestMethod.GET, params = {"bookIsbn", "bookName"})
	public String returnBook(BookVO book,@RequestParam("bookIsbn")String isbn, @RequestParam("bookName") String bookName, String bookAuthors, String loaMemId, RedirectAttributes redirectAttributes, ModelMap model) throws Exception {
//		ResultMessageVO messageVO = null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		try {
			map.put("bookIsbn", isbn);
			map.put("bookName", bookName);
			map.put("bookAuthors", bookAuthors);
			map.put("loaMemId", loaMemId);
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!"+map);
			
			book = bookService.getBook(map);
			System.out.println("@@@@@@@@@@@@@@@@@@@"+book);
			System.out.println("%%%%%%%%%%%%%%%%%%%%%" + map.get("loaMemId"));
			bookService.returnBook(map);

//			map.put("success", "return");
//			map.put("result",true);
//			redirectAttributes.addFlashAttribute("message", map);
			return "redirect:/book/loanList.lol?memId="+map.get("loaMemId");
		} catch (BizException e) {
//			map.put("error", "returnFail");
//			map.put("result",false);
//			redirectAttributes.addFlashAttribute("message", map);
			return "redirect:/";
		}
	}
}
