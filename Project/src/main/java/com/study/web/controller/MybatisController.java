package com.study.web.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.study.web.dao.MemberDAO;
import com.study.web.vo.Member;
import com.study.web.service.MemberDAOService;

@Controller
public class MybatisController {

	@Autowired
	private MemberDAO memberDAOService;

	private static final Logger logger = LoggerFactory.getLogger(MybatisController.class);

	// 시작 메인화면.
	@RequestMapping("/test")
	public ModelAndView main(Locale locale, Model model) {
		logger.info("Welcome main.", locale);

		// view 화면인 main.jsp에 DB로부터 읽어온 데이터를 보여준다.
		ModelAndView result = new ModelAndView("/main");
		// addObject view에 넘어가는 데이터
		List<com.study.web.vo.Member> memberList = memberDAOService.getMembers();
		System.out.println(memberList);
		result.addObject("result", memberList);
		result.setViewName("main");
		return result;
	}
	

}
