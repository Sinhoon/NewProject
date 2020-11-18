package com.study.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.web.dao.BoardDAO;
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

	// 占쌉쏙옙占쏙옙 占쏙옙占� 占쏙옙회
	/*@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardList(Model model) throws Exception {
		System.out.println("占쌉쏙옙占쏙옙 占쏙옙占쏙옙占싫� cont 占쌜듸옙");
		model.addAttribute("list", boardService.board_list());
		return "/board/boardList";
	}*/

	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardList(Model model) throws Exception {
		System.out.println("게시판 목록");
		model.addAttribute("list", boardService.board_list());
		return "/board/boardList";
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