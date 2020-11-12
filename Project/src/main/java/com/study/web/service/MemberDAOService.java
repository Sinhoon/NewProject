package com.study.web.service;


import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.web.dao.MemberDAO;
import com.study.web.mapper.MemberMapper;
import com.study.web.vo.Member;

//Service Ŭ������ Repository�� ��������μ� ��(bean) Ŭ������ ����ϴ��ϰ��Ѵ�. 
@Repository
public class MemberDAOService implements MemberDAO {

//Autowired�� ����Ͽ� sqlSession�� ����Ҽ� �ִ�.
   @Autowired
   private SqlSession sqlSession;
   
   @Override
   public ArrayList<Member> getMembers() {
       ArrayList<Member> result = new ArrayList<Member>();
       //sqlSession�� ���Ͽ� �����Ѵ�.
            MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
       //getMember()�� �޼ҵ��� mapper.mxl�� id�� �����ؾ��Ѵ�.
       result = memberMapper.getMembers();
       
       return result;
   }

}