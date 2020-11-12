package com.study.web.service;


import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.web.dao.MemberDAO;
import com.study.web.mapper.MemberMapper;
import com.study.web.vo.Member;

//Service 클래스를 Repository로 등록함으로서 빈(bean) 클래스로 사용하능하게한다. 
@Repository
public class MemberDAOService implements MemberDAO {

//Autowired를 사용하여 sqlSession을 사용할수 있다.
   @Autowired
   private SqlSession sqlSession;
   
   @Override
   public ArrayList<Member> getMembers() {
       ArrayList<Member> result = new ArrayList<Member>();
       //sqlSession을 통하여 매핑한다.
            MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
       //getMember()의 메소드명과 mapper.mxl과 id는 동일해야한다.
       result = memberMapper.getMembers();
       
       return result;
   }

}