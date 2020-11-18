/*package com.study.web.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.web.dao.BoardDAO;
import com.study.web.dao.MemberDAO;
import com.study.web.mapper.BoardMapper;
import com.study.web.mapper.MemberMapper;
import com.study.web.vo.Board;
import com.study.web.vo.Member;

//Service 클占쏙옙占쏙옙占쏙옙 Repository占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙關占� 占쏙옙(bean) 클占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙求占쏙옙構占쏙옙磯占�. 
@Repository
public class BoardDAOService implements BoardDAO {

//Autowired占쏙옙 占쏙옙占쏙옙臼占� sqlSession占쏙옙 占쏙옙占쏙옙寗占� 占쌍댐옙.
   @Autowired
   private SqlSession sqlSession;
   
   @Override
   public ArrayList<Board> getBoards() {
       ArrayList<Board> result = new ArrayList<Board>();
       //sqlSession占쏙옙 占쏙옙占싹울옙 占쏙옙占쏙옙占싼댐옙.
            BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
       result = boardMapper.getBoards();
       
       return result;
   }
   
   
   @Override
   public List<Board> boardlist(HashMap<String, Object> map) {
	   System.out.println("회占쏙옙占쏙옙占쏙옙占싫� DAO 占쏙옙占쏙옙占쏙옙占� 占쌜듸옙");
	   List<Board> list = sqlSession.selectList("boardList", map); 
		return list;
   }
    

@Override
public int getCount(HashMap<String, Object> map) {
	System.out.println("占쏙옙 占쏙옙占쏙옙 DAO占쏙옙占쏙옙 占쌜듸옙");
	return ((Integer) sqlSession.selectOne("Count", map)).intValue(); 
}

 




}*/