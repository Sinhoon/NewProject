package com.study.web.service;

import java.util.ArrayList;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.web.dao.LoginDAO;
import com.study.web.dao.MemberDAO;
import com.study.web.mapper.LoginMapper;
import com.study.web.mapper.MemberMapper;
import com.study.web.vo.Member;

//Service Ŭ������ Repository�� ��������μ� ��(bean) Ŭ������ ����ϴ��ϰ��Ѵ�. 
@Repository
public class LoginService implements LoginDAO {

//Autowired�� ����Ͽ� sqlSession�� ����Ҽ� �ִ�.
	@Autowired
	private SqlSession sqlSession;

	@Override
	public Member getLogin(Member vo) {
		Member result = new Member();
		// sqlSession�� ���Ͽ� �����Ѵ�.
		LoginMapper loginMapper = sqlSession.getMapper(LoginMapper.class);
		// getMember()�� �޼ҵ��� mapper.mxl�� id�� �����ؾ��Ѵ�.
		result = loginMapper.getLogin(vo);
		return result;
	}

}