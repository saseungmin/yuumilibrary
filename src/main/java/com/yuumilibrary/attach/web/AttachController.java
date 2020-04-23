package com.yuumilibrary.attach.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yuumilibrary.attach.service.IAttachService;
import com.yuumilibrary.attach.vo.AttachVO;
import com.yuumilibrary.common.exception.BizNotFoundException;
import com.yuumilibrary.fileupload.web.UploadController;

@Controller
public class AttachController {

	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	@Value("#{app['file.upload.path']}")
	private String uploadPath;
	@Autowired
	private IAttachService attachService;

	// @PathVariable 사용하여 url상의 경로를 변수에 할당 "/attach/download/25625"
	@RequestMapping("/attach/download/{atchNo:[0-9]{1,16}}")
	public void process(@PathVariable(name = "atchNo") int atchNo, HttpServletResponse resp) throws Exception {
		
		logger.debug("atchNo = {}", atchNo);

		try {

			
			// 서비스를 통해 첨부파일 가져오기
			AttachVO vo = attachService.selectAttach(atchNo);
			// 파일명에 한글이 있는경우 처리
			String originalName = new String(vo.getAtchOriginalName().getBytes("utf-8"), "iso-8859-1");
			String filePath = uploadPath + File.separatorChar + vo.getAtchPath();
			String fileName = vo.getAtchFileName();
			logger.debug("originalName = {}", originalName);
			logger.debug("filePath = {}", filePath);
			logger.debug("fileName = {}", fileName);
			File f = new File(filePath, fileName);
			if (!f.isFile()) {
				throw new BizNotFoundException("해당 첨부파일이 존재하지 않습니다.");
			}
			// 다운로드를 위한 헤더 생성
			resp.setHeader("Content-Type", "application/octet-stream;");
			resp.setHeader("Content-Disposition", "attachment;filename=\"" + originalName + "\";");
			resp.setHeader("Content-Transfer-Encoding", "binary;");
			resp.setContentLength((int) f.length()); // 진행율
			resp.setHeader("Pragma", "no-cache;");
			resp.setHeader("Expires", "-1;");
			// 저장된 파일을 응답객체의 스트림으로 내보내기
			FileUtils.copyFile(f, resp.getOutputStream());
			resp.getOutputStream().close();
			try {
				attachService.increaseDownloadCount(atchNo);
			} catch (Throwable e) {
				logger.error(e.getMessage(), e);
			}
		} catch (BizNotFoundException e) {
			logger.error(e.getMessage(), e);
			printMessage(resp, "해당 첨부파일이 존재하지 않습니다.");
		} catch (IOException e) {
			resp.reset();
			resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
		}
	}

	// 정상적인 다운로드가 안될경우 메시지 처리
	private void printMessage(HttpServletResponse resp, String msg) throws Exception {
		resp.setCharacterEncoding("utf-8");
		resp.setHeader("Content-Type", "text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		// target이 지정되지 않은 경우 history.back() 으로 처리
		out.println("<script type='text/javascript'> ");
		out.println("alert('" + msg + "');");
		out.println("self.close();");
		out.println("</script>");
		out.println("<h4>첨부파일 문제 " + msg + "</h4> ");
		out.println("<button onclick='self.close()'>닫기</button>");
	}
}