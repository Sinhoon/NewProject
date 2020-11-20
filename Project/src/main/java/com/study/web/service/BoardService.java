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

//Service Ŭ������ Repository�� ��������μ� ��(bean) Ŭ������ ����ϴ��ϰ��Ѵ�. 
@Repository
public class BoardService implements BoardDAO {

	// Autowired�� ����Ͽ� sqlSession�� ����Ҽ� �ִ�.
	@Autowired
	private SqlSession sqlSession;


	   
	@Override
	public List<Board> board_list(HashMap<String, Object> map){
		List<Board> list = sqlSession.selectList("board_list", map); 
		
		return list;
	}
	
	
	public List<Board> notice_list(HashMap<String, Object> map){
		List<Board> list = sqlSession.selectList("notice_list", map); 
		return list;
	}

	@Override
	public int getCount(HashMap<String, Object> map) {
		return ((Integer) sqlSession.selectOne("boardCount", map)).intValue();
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
