// 회원관리를 위한 컨트롤러 입니다. -이의찬

package com.study.web.controller;

import java.text.DateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.study.web.dao.MemberDAO;
import com.study.web.vo.Member;
import com.study.web.service.MemberDAOService;
import com.study.web.paging.Paging;

@Controller
public class MemberlistController {

	@SuppressWarnings("unused")
	// private Logger log = Logger.getLogger(getClass());
	private int pageSize = 10;
	private int blockCount = 10;

	@Autowired
	private MemberDAO memberDAOService;

	private static final Logger logger = LoggerFactory.getLogger(MemberlistController.class);

	// 회원조회
	@RequestMapping("/memberlist") // http://localhost:8090/web/memberlist
	public ModelAndView read(Locale locale, Model model, HttpServletRequest request,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "") String keyField, // 제목, 이름, 내용, 전체
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord) {
		logger.info("Welcome main.", locale);

		System.out.println("MemberlistController 컨트롤러 작동");

		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		HashMap<String, Object> map = new HashMap(); // 페이지넘버, 키필드, 키워드 가져와서 해쉬 맵에 저장
		map.put("keyField", keyField);
		map.put("keyWord", keyWord); // 해쉬맵 타입의 map 에 저장 keyWord에는 파람으로 가져온 keyWord를 저장

		int count = this.memberDAOService.getCount(map); // DAO 연결 카운트에 저장

		System.out.println("현재 회원수는 = " + count);
		System.out.println("검색유형 , 키워드값(검색어) = " + keyField + ' ' + keyWord);

		Paging page = new Paging(keyField, keyWord, currentPage, count, this.pageSize, this.blockCount,
				"memberlist.do");

		pagingHtml = page.getPagingHtml().toString();

		map.put("start", Integer.valueOf(page.getStartCount()) - 1);
		map.put("end", Integer.valueOf(page.getEndCount()));

		System.out.println(Integer.valueOf(page.getStartCount())); // 1 1을뺴줘야하나?
		System.out.println(Integer.valueOf(page.getEndCount())); // 10

		List<com.study.web.vo.Member> memberList = null;
		if (count > 0) { // 레코드 갯수가 0보다 크면
			memberList = this.memberDAOService.memberlist(map); // DAO에 연결
			System.out.println("count는 0보다 큽니다.");
		} else {
			memberList = Collections.emptyList(); // 아니면 비어있게 나오게함
			System.out.println("count는 0보다 작습니다.");
		}
		int number = count - (currentPage - 1) * this.pageSize;

		// view 화면인 main.jsp에 DB로부터 읽어온 데이터를 보여준다.
		ModelAndView result = new ModelAndView();
		// addObject view에 넘어가는 데이터

		System.out.println(memberList);

		result.setViewName("/member/memberlist"); // 뷰의 jsp 이름
		result.addObject("result", memberList); // 회원목록
		result.addObject("count", Integer.valueOf(count)); // 글수
		result.addObject("currentPage", Integer.valueOf(currentPage)); // 현재페이지
		result.addObject("pagingHtml", pagingHtml);
		result.addObject("number", Integer.valueOf(number)); // 전체 페이지

		return result;
	}

/////////////////////////////////////////////
	// 회원 자세히 보기 컨트롤러

	@RequestMapping(value = "/member_read.do", method = RequestMethod.GET)
	public ModelAndView read(@RequestParam("uNum") int uNum, Model model) {
		System.out.println("회원상세보기 컨트롤러 작동"); // 작동은함
		System.out.println("조회하는 회원의 uNum=" + uNum); // 잘받아옴

		Member member = memberDAOService.member_read(uNum); // 일해라 DB

		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/member_read");
		mav.addObject("member", member);

		return mav;
	}

////////////////////////////////////////////////////////////////////////////////

}
