package com.study.web.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.web.dao.LoginDAO;
import com.study.web.dao.MemberDAO;
import com.study.web.mapper.LoginMapper;
import com.study.web.mapper.MemberMapper;
import com.study.web.vo.Member;

//Service 클래스를 Repository로 등록함으로서 빈(bean) 클래스로 사용하능하게한다. 
@Repository
public class LoginService implements LoginDAO {

//Autowired를 사용하여 sqlSession을 사용할수 있다.
	@Autowired
	private SqlSession sqlSession;

	@Override
	public Member getLogin(Member vo) {
		Member result = new Member();
		// sqlSession을 통하여 매핑한다.
		LoginMapper loginMapper = sqlSession.getMapper(LoginMapper.class);
		// getMember()의 메소드명과 mapper.mxl과 id는 동일해야한다.
		try {
			result = loginMapper.getLogin(vo);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return result;
		}
		return result;

	}

	@Override
	public Member getIdchk(String id) {
		Member result = new Member();
		LoginMapper loginMapper = sqlSession.getMapper(LoginMapper.class);
		try {
			result = loginMapper.getIdchk(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return result;
		}
		return result;
	}

	@Override
	public void setLock(String id) {
		// TODO Auto-generated method stub
		LoginMapper loginMapper = sqlSession.getMapper(LoginMapper.class);
		loginMapper.setLock(id);
	}

}