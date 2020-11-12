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

import com.study.web.dao.LoginDAO;
import com.study.web.dao.MemberDAO;
import com.study.web.vo.Member;
import com.study.web.service.MemberDAOService;

@Controller
public class LoginController {

	@Autowired
	private LoginDAO loginDAOService;
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	// 시작 메인화면.
	@RequestMapping("/loginPro")
	public ModelAndView main(Locale locale, Model model) {
		ModelAndView result = new ModelAndView("login/loginForm");
		Member vo = new Member();
		vo.setId("root");
		vo.setPwd("1234");
		Member chk_vo = loginDAOService.getLogin(vo);
		System.out.println(chk_vo.getname());
		result.addObject("result", chk_vo);
		return result;
	}
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "login/loginForm";
	}
	
}
