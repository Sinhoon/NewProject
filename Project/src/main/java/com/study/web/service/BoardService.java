package com.study.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.study.web.dao.BoardDAO;
import com.study.web.vo.Board;

//Service 클래스를 Repository로 등록함으로서 빈(bean) 클래스로 사용하능하게한다. 
@Repository
public class BoardService implements BoardDAO {

	// Autowired를 사용하여 sqlSession을 사용할수 있다.
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Board> board_list() throws Exception {
		List<Board> list = sqlSession.selectList("board_list"); 
		return list;
	}

	

	@Override
	public Board board_read(int bNum) throws Exception{
		return sqlSession.selectOne("board_read", bNum);
		
	}
	@Override
	public Board board_mod(int bNum) throws Exception{
		return sqlSession.selectOne("board_read", bNum);
	}
	

	@Override
	public void board_write(Board board) throws Exception {
		sqlSession.insert("board_write", board);
	}
	
	@Override
	public void board_update(Board board) throws Exception {
		System.out.println(board.getbNum());
		System.out.println(board.getbTitle());
		System.out.println(board.getbContent());
		sqlSession.update("board_update", board);
	}
	
	@Override
	public void board_delete(int bNum) throws Exception {
		sqlSession.delete("board_delete", bNum);
	}
}
