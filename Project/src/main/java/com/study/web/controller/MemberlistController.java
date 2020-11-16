// ȸ�������� ���� ��Ʈ�ѷ� �Դϴ�. -������

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

	// ȸ����ȸ ���� ������
	@RequestMapping(value = "/chklist.do", method = RequestMethod.GET) // http://localhost:8090/web/memberlist
	public ModelAndView cread(Locale locale, Model model, HttpServletRequest request, HttpSession session,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "") String keyField, // ����, �̸�, ����, ��ü
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord) {
		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		
		String keyword = "";
		HashMap<String, Object> map = new HashMap(); // �������ѹ�, Ű�ʵ�, Ű���� �����ͼ� �ؽ� �ʿ� ����
		if (request.getParameter("keyWord") == "".toString()) {
			System.out.println("����ִ�.");
		}else {
			keyword = request.getParameter("keyWord");
		}
		map.put("showDept", request.getParameter("sdept")); // �μ� ����
		map.put("keyField", request.getParameter("keyField"));
		map.put("keyWord", keyword); // �ؽ��� Ÿ���� map �� ���� keyWord���� �Ķ����� ������ keyWord�� ����

		int count = this.memberDAOService.getCount(map); // DAO ���� ī��Ʈ�� ����

		System.out.println("���� ȸ������ = " + count);
		System.out.println("�˻����� , Ű���尪(�˻���) = " + keyField + ' ' + keyWord);

		Paging page = new Paging(keyField, keyWord, currentPage, count, this.pageSize, this.blockCount,
				"memberlist.do");

		pagingHtml = page.getPagingHtml().toString();

		map.put("start", Integer.valueOf(page.getStartCount()) - 1);
		map.put("end", Integer.valueOf(page.getEndCount()));

		System.out.println(Integer.valueOf(page.getStartCount())); // 1 1��������ϳ�?
		System.out.println(Integer.valueOf(page.getEndCount())); // 10

		List<com.study.web.vo.Member> memberList = null;
		if (count > 0) { // ���ڵ� ������ 0���� ũ��
			System.out.println(map);
			memberList = this.memberDAOService.memberlist(map); // DAO�� ����
			System.out.println("count�� 0���� Ů�ϴ�.");
		} else {
			memberList = Collections.emptyList(); // �ƴϸ� ����ְ� ��������
			System.out.println("count�� 0���� �۽��ϴ�.");
		}
		int number = count - (currentPage - 1) * this.pageSize;

		// view ȭ���� main.jsp�� DB�κ��� �о�� �����͸� �����ش�.
		ModelAndView result = new ModelAndView();
		// addObject view�� �Ѿ�� ������

		System.out.println(memberList);

		result.setViewName("/member/memberlist"); // ���� jsp �̸�
		result.addObject("result", memberList); // ȸ�����
		result.addObject("count", Integer.valueOf(count)); // �ۼ�
		result.addObject("currentPage", Integer.valueOf(currentPage)); // ����������
		result.addObject("pagingHtml", pagingHtml);
		result.addObject("number", Integer.valueOf(number)); // ��ü ������

		List<Dept> deptlist = memberDAOService.getDeptlist(); // �μ� ����
		deptlist.remove(0);
		result.addObject("deptlist", deptlist);

		return result;
	}

	// ȸ����ȸ ������
	@RequestMapping(value = "/memberlist") // http://localhost:8090/web/memberlist
	public ModelAndView read(Locale locale, Model model, HttpServletRequest request, HttpSession session,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "") String keyField, // ����, �̸�, ����, ��ü
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord) {
		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		HashMap<String, Object> map = new HashMap(); // �������ѹ�, Ű�ʵ�, Ű���� �����ͼ� �ؽ� �ʿ� ����
		Member mav = (Member) session.getAttribute("Member");
		String sDept = mav.getuClass();
		map.put("showDept", sDept); // �μ� ����
		map.put("keyField", keyField);
		map.put("keyWord", keyWord); // �ؽ��� Ÿ���� map �� ���� keyWord���� �Ķ����� ������ keyWord�� ����

		int count = this.memberDAOService.getCount(map); // DAO ���� ī��Ʈ�� ����

		System.out.println("���� ȸ������ = " + count);
		System.out.println("�˻����� , Ű���尪(�˻���) = " + keyField + ' ' + keyWord);

		Paging page = new Paging(keyField, keyWord, currentPage, count, this.pageSize, this.blockCount,
				"memberlist.do");

		pagingHtml = page.getPagingHtml().toString();

		map.put("start", Integer.valueOf(page.getStartCount()) - 1);
		map.put("end", Integer.valueOf(page.getEndCount()));

		System.out.println(Integer.valueOf(page.getStartCount())); // 1 1��������ϳ�?
		System.out.println(Integer.valueOf(page.getEndCount())); // 10

		List<com.study.web.vo.Member> memberList = null;
		if (count > 0) { // ���ڵ� ������ 0���� ũ��
			memberList = this.memberDAOService.memberlist(map); // DAO�� ����
			System.out.println("count�� 0���� Ů�ϴ�.");
		} else {
			memberList = Collections.emptyList(); // �ƴϸ� ����ְ� ��������
			System.out.println("count�� 0���� �۽��ϴ�.");
		}
		int number = count - (currentPage - 1) * this.pageSize;

		// view ȭ���� main.jsp�� DB�κ��� �о�� �����͸� �����ش�.
		ModelAndView result = new ModelAndView();
		// addObject view�� �Ѿ�� ������

		System.out.println(memberList);

		result.setViewName("/member/memberlist"); // ���� jsp �̸�
		result.addObject("result", memberList); // ȸ�����
		result.addObject("count", Integer.valueOf(count)); // �ۼ�
		result.addObject("currentPage", Integer.valueOf(currentPage)); // ����������
		result.addObject("pagingHtml", pagingHtml);
		result.addObject("number", Integer.valueOf(number)); // ��ü ������

		List<Dept> deptlist = memberDAOService.getDeptlist(); // �μ� ����
		deptlist.remove(0);
		result.addObject("deptlist", deptlist);

		return result;
	}

	private ServletRequest session() {
		// TODO Auto-generated method stub
		return null;
	}

/////////////////////////////////////////////
// ȸ�� �ڼ��� ���� ��Ʈ�ѷ�

	@RequestMapping(value = "/member_read.do", method = RequestMethod.GET)
	public ModelAndView read(@RequestParam("uNum") int uNum, Model model) {
		System.out.println("ȸ���󼼺��� ��Ʈ�ѷ� �۵�"); // �۵�����
		System.out.println("��ȸ�ϴ� ȸ���� uNum=" + uNum); // �߹޾ƿ�

		Member member = memberDAOService.member_read(uNum); // ���ض� DB

		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/member_read");
		mav.addObject("member", member);

		return mav;
	}

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// ������ �ҷ����� ��Ʈ�ѷ�
	@RequestMapping("/member_update.do")
	public ModelAndView member_update(@RequestParam("uNum") int uNum, Model model) {
		System.out.println("ȸ������ ������ �ҷ����� ��Ʈ�ѷ� �۵�"); // �۵�����
		System.out.println("�Ѿ���� uNum�� " + uNum);
		Member member = memberDAOService.member_read(uNum);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("member/member_update");
		mav.addObject("member", member);
		return mav;
	}
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////// ������ ���� DB�� �����ϴ� ��Ʈ�ѷ�
	@RequestMapping(value = "member_updateProc.do", method = RequestMethod.POST)
	public ModelAndView member_updateProc(HttpServletRequest request, Member member,
			@RequestParam("select_uDept") int select_uDept) { // �޾ƿ��°�

// ���� ���������� ���� ���ε���� �ڵ� �߰�

//////////////////////////////

		HashMap<String, Object> map = new HashMap();
		map.put("uNum", member.getuNum());
		map.put("uPhone", member.getuPhone());
		map.put("uDept", Integer.toString(select_uDept));

		System.out.println("������ �����Ϸ��� ȸ����ȣ= " + member.getuNum());
		System.out.println("������ �����Ϸ��� ��ȭ��ȣ= " + member.getuPhone());
		System.out.println("������ �����Ϸ��� �μ���ȣ= " + select_uDept);

		System.out.println("������ ȸ�������� �����ϴ� ��Ʈ�ѷ� �۵�"); // �۵�Ȯ��
		memberDAOService.member_updateProc(map); // DAO ����

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/memberlist.do"); // �۵�
// mav.setViewName("/member_read.do?uNum=member.getuNum()"); 	
		return mav;
	}

	// ���� ���
	@ResponseBody
	@RequestMapping(value = "/lockPro.do", method = RequestMethod.GET)
	public String lock(HttpServletRequest request) throws Exception {
		String unum = request.getParameter("unum");
		memberDAOService.golock(unum);
		return "success";
	}

	// ���� ��� ��ü
	@ResponseBody
	@RequestMapping(value = "/unlockPro.do", method = RequestMethod.GET)
	public String unlock(HttpServletRequest request) throws Exception {
		String unum = request.getParameter("unum");
		memberDAOService.unlock(unum);
		return "success";
	}

}
