// 회원관리를 위한 컨트롤러 입니다. -이의찬

package com.study.web.controller;

import java.text.DateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.support.RequestPartServletServerHttpRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.study.web.dao.MemberDAO;
import com.study.web.vo.Dept;
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

	// 회원조회 페이지
	@RequestMapping(value = "/memberlist") // http://localhost:8090/web/memberlist
	public ModelAndView read(Locale locale, Model model, HttpServletRequest request, HttpSession session,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "all") String keyField, // 제목, 이름, 내용, 전체
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord,
			@RequestParam(value = "showdept", defaultValue = "") String showdept,
			@RequestParam(value = "before_showdept", defaultValue = "0") String before_showdept,
			@RequestParam(value = "before_keyWord", defaultValue = "") String before_keyWord,
			@RequestParam(value = "before_keyField", defaultValue = "all") String before_keyField
			) {
		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		HashMap<String, Object> map = new HashMap(); // 페이지넘버, 키필드, 키워드 가져와서 해쉬 맵에 저장
		Member mav = (Member) session.getAttribute("Member");
		String sDept = mav.getuDept();	
		if (showdept.equals("")) {
			showdept = mav.getuDept();
		}

		map.put("showdept", showdept); // 부서 선택
		map.put("keyField", keyField);
		map.put("keyWord", keyWord); // 해쉬맵 타입의 map 에 저장 keyWord에는 파람으로 가져온 keyWord를 저장

		int count = this.memberDAOService.getCount(map); // DAOs 연결 카운트에 저장
		System.out.println("현재 회원수는 = " + count);
		System.out.println("검색유형 , 키워드값(검색어) = " + keyField + ' ' + keyWord);
		Paging page = new Paging(showdept, keyField, keyWord, currentPage, count, this.pageSize, this.blockCount,
				"memberlist.do");

		pagingHtml = page.getPagingHtml().toString();

		map.put("start", Integer.valueOf(page.getStartCount()) - 1);
		map.put("end", Integer.valueOf(page.getEndCount()));

		List<com.study.web.vo.Member> memberList = null;
		if (count > 0) { // 레코드 갯수가 0보다 크면
			System.out.println(map);
			memberList = this.memberDAOService.memberlist(map); // DAO에 연결
			System.out.println(count);
		} else {
			memberList = Collections.emptyList(); // 아니면 비어있게 나오게함
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
		List<Dept> deptlist = memberDAOService.getDeptlist(); // 부서 종류
		deptlist.remove(0);
		result.addObject("deptlist", deptlist);
		result.addObject("before_showdept", showdept); // 이전 페이지 선택옵션
		result.addObject("before_keyWord", keyWord); // 이전 페이지 선택옵션
		result.addObject("before_keyField", keyField); // 이전 페이지 선택옵션
		return result;
	}

	private ServletRequest session() {
		// TODO Auto-generated method stub
		return null;
	}

/////////////////////////////////////////////
// 회원 자세히 보기 컨트롤러

	@RequestMapping(value = "/member_read.do", method = RequestMethod.GET)
	public ModelAndView read(@RequestParam("uNum") int uNum, Model model) {
		System.out.println("회원상세보기 컨트롤러 작동"); // 작동은함
		System.out.println("조회하는 회원의 uNum=" + uNum); // 잘받아옴

		Member member = memberDAOService.member_read(uNum); // 일해라 DB
		List<Class> classlist = memberDAOService.getClasslist();
		List<Dept> deptlist = memberDAOService.getDeptlist();
		classlist.remove(0);
		deptlist.remove(0);
		ModelAndView mav = new ModelAndView();
		member.setuBirth(member.getuBirth().replace("-", ""));
		mav.addObject("member", member);
		mav.addObject("classlist", classlist);
		mav.addObject("deptlist", deptlist);
		mav.setViewName("member/member_read");
		return mav;
	}

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// 수정폼 불러오는 컨트롤러
	@RequestMapping("/member_update.do")
	public ModelAndView member_update(@RequestParam("uNum") int uNum, Model model) {
		System.out.println("회원정보 수정폼 불러오는 컨트롤러 작동"); // 작동은함
		System.out.println("넘어오는 uNum값 " + uNum);
		Member member = memberDAOService.member_read(uNum);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("member/member_update");
		mav.addObject("member", member);
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////// 수정된 글을 DB에 저장하는 컨트롤러
	@RequestMapping(value = "member_updateProc.do", method = RequestMethod.POST)
	public ModelAndView member_updateProc(HttpServletRequest request, Member member,
			@RequestParam("select_uDept") int select_uDept) { // 받아오는거

// 사진 변경을위해 파일 업로드관련 코드 추가

//////////////////////////////

		HashMap<String, Object> map = new HashMap();
		map.put("uNum", member.getuNum());
		map.put("uPhone", member.getuPhone());
		map.put("uDept", Integer.toString(select_uDept));

		System.out.println("수정후 저장하려는 회원번호= " + member.getuNum());
		System.out.println("수정후 저장하려는 전화번호= " + member.getuPhone());
		System.out.println("수정후 저장하려는 부서번호= " + select_uDept);

		System.out.println("수정된 회원정보를 저장하는 컨트롤러 작동"); // 작동확인
		memberDAOService.member_updateProc(map); // DAO 연결

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/memberlist.do"); // 작동
// mav.setViewName("/member_read.do?uNum=member.getuNum()"); 	
		return mav;
	}

	// 계정 잠금
	@ResponseBody
	@RequestMapping(value = "/lockPro.do", method = RequestMethod.GET)
	public String lock(HttpServletRequest request) throws Exception {
		String unum = request.getParameter("unum");
		memberDAOService.golock(unum);
		return "success";
	}

	// 계정 잠금 해체
	@ResponseBody
	@RequestMapping(value = "/unlockPro.do", method = RequestMethod.GET)
	public String unlock(HttpServletRequest request) throws Exception {
		String unum = request.getParameter("unum");
		memberDAOService.unlock(unum);
		return "success";
	}

}
