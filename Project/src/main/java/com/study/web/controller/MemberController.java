package com.study.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mysql.cj.xdevapi.JsonArray;
import com.study.web.dao.MemberDAO;
import com.study.web.paging.FileUpload;
import com.study.web.vo.Dept;
import com.study.web.vo.Member;
import com.study.web.service.MemberDAOService;

@Controller
public class MemberController {
	@Autowired
	private MemberDAO memberDAOService;
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	// 회원 등록 페이지
	@RequestMapping("/member_regist")
	public ModelAndView mregist() {
		ModelAndView mav = new ModelAndView();
		List<Class> classlist = memberDAOService.getClasslist();
		List<Dept> deptlist = memberDAOService.getDeptlist();
		classlist.remove(0);
		deptlist.remove(0);
		mav.addObject("classlist", classlist);
		mav.addObject("deptlist", deptlist);
		mav.setViewName("/member/member_regist");
		return mav;
	}
	
	

	// 중복 체크
	@ResponseBody
	@RequestMapping(value = "/ridChk.do", method = RequestMethod.POST)
	public HashMap<String, String> ridChk(HttpServletRequest request) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		Member vo = new Member();
		vo.setuId(request.getParameter("id"));
		Member chkld = memberDAOService.Idchk(vo.getuId());
		if (chkld == null) {
			result.put("Code", "0000");
		} else {
			result.put("Code", "0001");
		}
		return result;
	}

	// 회원 등록
	@ResponseBody
	@RequestMapping(value = "/rId.do", method = RequestMethod.POST)
	public HashMap<String, String> rId(Locale locale, Model model,MultipartHttpServletRequest multipartRequest,HttpSession session) throws IOException {
		HashMap<String, String> result = new HashMap<String, String>();
		Member vo = new Member();
		MultipartFile file = multipartRequest.getFile("upload");
		Calendar cal = Calendar.getInstance();
		String fileName = file.getOriginalFilename();
		String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		String replaceName = cal.getTimeInMillis() + fileType;
		String path = "c://image";
		FileUpload.fileUpload(file, path, replaceName);
		System.out.println(multipartRequest.getParameter("user_dept"));
		vo.setuName(multipartRequest.getParameter("user_name"));
		vo.setuId(multipartRequest.getParameter("user_id"));
		vo.setuPwd(multipartRequest.getParameter("user_pw"));
		vo.setuClass(multipartRequest.getParameter("user_class"));
		vo.setuDept(multipartRequest.getParameter("user_dept"));
		vo.setuBirth(multipartRequest.getParameter("user_birth"));
		vo.setuPhone(multipartRequest.getParameter("user_phone"));
		vo.setuEmail(multipartRequest.getParameter("user_email"));
		vo.setuImg(path+"/"+replaceName);
		vo.setuReguser(session.getId());
		try {
			memberDAOService.regMember(vo);
		} catch (Exception e) {
			result.put("Code", "0001");
			return result;
		}
		result.put("Code", "0000");
		return result;
	}

}