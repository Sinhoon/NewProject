package com.study.web.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.study.web.dao.LoginDAO;
import com.study.web.dao.MemberDAO;
import com.study.web.vo.Member;
import com.study.web.service.MemberDAOService;

@Controller
public class LoginController {

	@Autowired
	private LoginDAO loginDAOService;
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	// 로그인 페이지
	@RequestMapping("/login")
	public String loginForm() {
		return "login/loginForm";
	}

	// 시작 메인화면.
	@ResponseBody
	@RequestMapping(value = "/loginPro.do", method = RequestMethod.POST)
	public HashMap<String, String> login(Locale locale, Model model, HttpServletRequest request, HttpSession session)
			throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		// ModelAndView result = null;
		Member vo = new Member();
		vo.setId(request.getParameter("id"));
		vo.setPwd(request.getParameter("pwd"));

		Member chkvo = loginDAOService.getLogin(vo);
		if (chkvo == null) {
			// result = new ModelAndView(new RedirectView("/login"));
			result.put("Code", "0001");
		} else {
			session.setAttribute("Member", chkvo);
			// result = new ModelAndView(new RedirectView("/home"));
			result.put("Code", "0000");
		}
		return result;
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Member member, Model model, HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
