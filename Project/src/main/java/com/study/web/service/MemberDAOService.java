package com.study.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.web.dao.MemberDAO;
import com.study.web.mapper.LoginMapper;
import com.study.web.mapper.MemberMapper;
import com.study.web.vo.Dept;
import com.study.web.vo.Member;

//Service 클래스를 Repository로 등록함으로서 빈(bean) 클래스로 사용하능하게한다. 
@Repository
public class MemberDAOService implements MemberDAO {

//Autowired를 사용하여 sqlSession을 사용할수 있다.
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Member> memberlist(HashMap<String, Object> map) {
		System.out.println("회원목록조회 DAO 멤버서비스 작동");
		List<Member> list = sqlSession.selectList("memberList", map); // mapper.xml 에서 memberList 쿼리문을 실행하겠다
		return list;
	}

	@Override
	public int getCount(HashMap<String, Object> map) {
		System.out.println("글 갯수 DAO서비스 작동");
		return ((Integer) sqlSession.selectOne("Count", map)).intValue();
	}

	@Override
	public Member member_read(int uNum) {
		return sqlSession.selectOne("member_read", uNum);
	}

	@Override
	public Member Idchk(String uId) {
		return sqlSession.selectOne("Idchk", uId);
	}

	@Override
	public List<Class> getClasslist() {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		List<Class> list = memberMapper.getClasslist();
		return list;
	}

	@Override
	public List<Dept> getDeptlist() {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		List<Dept> list = memberMapper.getDeptlist();
		return list;
	}

	@Override
	public void regMember(Member m) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberMapper.regMember(m);
	}
	

}