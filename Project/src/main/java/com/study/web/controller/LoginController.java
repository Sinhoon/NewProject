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
import org.springframework.web.util.UrlPathHelper;

import com.study.web.dao.LoginDAO;
import com.study.web.dao.MemberDAO;
import com.study.web.vo.Member;
import com.study.web.service.MemberDAOService;

@Controller
public class LoginController {

	@Autowired
	private LoginDAO loginDAOService;
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	// 濡쒓렇�씤 �떎�뻾
	@ResponseBody
	@RequestMapping(value = "/loginPro.do", method = RequestMethod.POST)
	public HashMap<String, String> login(Locale locale, Model model, HttpServletRequest request, HttpSession session)
			throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		Member vo = new Member();
		vo.setuId(request.getParameter("id"));
		vo.setuPwd(request.getParameter("pwd"));
		Member chkld = loginDAOService.getIdchk(vo.getuId());
		if (chkld != null) {
			if (chkld.getuLock() < 5) {
				Member chkpwd = loginDAOService.getLogin(vo);
				if (chkpwd == null) {
					loginDAOService.setLock(chkld.getuId());
					result.put("Code", "0003");
				} else {
					session.setAttribute("Member", chkpwd);
					String time = (System.currentTimeMillis() + 100000 + "");
					Double settime = Double.parseDouble(time);
					System.out.println(settime);
					session.setAttribute("Time", settime);
					// session.setMaxInactiveInterval(10);
					result.put("Code", "0000");
					// result.put("Time", System.currentTimeMillis()+1000+"");
				}
			} else {
				result.put("Code", "0002");
			}
		} else {
			result.put("Code", "0001");
		}
		return result;
	}

	// 濡쒓렇�븘�썐
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}


	// �꽭�뀡媛깆떊
	@RequestMapping(value = "/timeReset", method = RequestMethod.GET)
	public String timeReset(HttpServletRequest request,HttpSession session) {
		session.setAttribute("Time", Double.parseDouble(System.currentTimeMillis() + 1000000 + ""));
		return "redirect:"+ request.getParameter("page") ;
	}
}
