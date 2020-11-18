package com.study.web.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.study.web.vo.Board;
public interface BoardDAO {

	public List<Board> board_list() throws Exception; // 글 목록

	
	public Board board_read(int bNum) throws Exception; // 게시글 보기
	
	public Board board_mod(int bNum) throws Exception; // 게시글 수정 보기

	
	// 게시글 작성
	public void board_write(Board board)throws Exception;

	// 게시글 수정
	public void board_update(Board board)throws Exception;
	
	// 게시글 삭제
	public void board_delete(int bNum) throws Exception;
}
