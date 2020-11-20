package com.study.web.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.study.web.dao.BoardDAO;
import com.study.web.paging.Paging;
import com.study.web.vo.Board;

@Controller
// @RequestMapping("/board/*") 
public class BoardController {

	@SuppressWarnings("unused")
	// private Logger log = Logger.getLogger(getClass());
	private int pageSize = 10;
	private int blockCount = 10;

	@Autowired
	private BoardDAO boardService;

	@RequestMapping(value = "/boardList")
	public ModelAndView boardList(Locale locale, Model model, HttpServletRequest request,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "all") String keyField, 
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord,
			@RequestParam(value = "keyDept", defaultValue = "0") int keyDept) throws Exception {
		
		System.out.println("게시판 목록");
		
		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		HashMap<String, Object> map = new HashMap(); 
		map.put("keyField", keyField);
		map.put("keyWord", keyWord); 
		map.put("keyDept", keyDept);
		
		int count = this.boardService.getCount(map);
		
		
		Paging page = new Paging(Integer.toString(keyDept), keyField, keyWord, currentPage, count, this.pageSize, this.blockCount,
				"boardList");

		pagingHtml = page.getPagingHtml().toString();

		map.put("start", Integer.valueOf(page.getStartCount()) - 1);
		map.put("end", Integer.valueOf(page.getEndCount()));

		System.out.println(Integer.valueOf(page.getStartCount())); // 1 1��������ϳ�?
		System.out.println(Integer.valueOf(page.getEndCount())); // 10

		List<com.study.web.vo.Board> boardList = null;
		List<com.study.web.vo.Board> noticeList = null;
		
		if (count > 0) { 
			noticeList = this.boardService.notice_list(map); 
			System.out.println("notice");
		} else {
			noticeList = Collections.emptyList();
			System.out.println("count�� 0���� �۽��ϴ�.");
		}
		
		if (count > 0) { 
			boardList = this.boardService.board_list(map); 
			System.out.println("board > 0");
		} else {
			boardList = Collections.emptyList();
			System.out.println("board < 0");
		}
		int number = count - (currentPage - 1) * this.pageSize;

		// view ȭ���� main.jsp�� DB�κ��� �о�� �����͸� �����ش�.
		ModelAndView result = new ModelAndView();
		
		//System.out.println("sssssssssssssssssssss"+keyDept);

		System.out.println("sssssssssssssssssssss"+count);

		
		result.setViewName("/board/boardList"); // ���� jsp �̸�
		result.addObject("notice", noticeList);
		result.addObject("list", boardList); // ȸ�����
		result.addObject("count", Integer.valueOf(count)); // �ۼ�
		result.addObject("currentPage", Integer.valueOf(currentPage)); // ����������
		result.addObject("pagingHtml", pagingHtml);
		result.addObject("number", Integer.valueOf(number)); // ��ü ������
		result.addObject("keyDeptSave",keyDept);

		return result;		
	}
	
	
	// 게시글 읽기
	@RequestMapping(value = "/board_read.do", method = RequestMethod.GET)
	public String board_read(@RequestParam("bNum") int bNum, Model model) throws Exception {
		model.addAttribute("read", boardService.board_read(bNum));
		return "/board/boardRead";
	}

	// 게시글 작성폼
	@RequestMapping(value = "/boardRegForm.do")
	public String boardRegForm() throws Exception {
		return "/board/boardRegForm";
	}

	// 게시글 작성
	@RequestMapping(value = "/board_write.do", method = RequestMethod.POST)
	public String board_write(@ModelAttribute Board board) throws Exception {
		boardService.board_write(board);
		return "redirect:/boardList";
	}

	// 게시글 수정폼
	@RequestMapping(value = "/boardModForm.do", method = RequestMethod.GET)
	public String boardModForm(@RequestParam("bNum") int bNum, Model model) throws Exception {
		model.addAttribute("update", boardService.board_mod(bNum));
		return "/board/boardModForm";
	}

	// 게시글 수정
	@RequestMapping(value = "/board_update.do", method = RequestMethod.POST)
	public String board_update(@ModelAttribute Board board) throws Exception {
		boardService.board_update(board);
		System.out.println("게시글 수정");
		return "redirect:/boardList";
	}

	// 게시글 삭제
	@RequestMapping(value = "/board_delete.do")
	public String board_delete(@RequestParam("bNum") int bNum) throws Exception {
		boardService.board_delete(bNum);
		return "redirect:/boardList";
	}
}