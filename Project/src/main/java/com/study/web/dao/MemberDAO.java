package com.study.web.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.study.web.vo.Dept;
import com.study.web.vo.Member;

public interface MemberDAO {
	public List<Member> memberlist(HashMap<String, Object> map); // 회원 목록
	public int getCount(HashMap<String, Object> map); // 회원수 - 페이징시 필요하여 추가했습니다.
	public Member member_read(int uNum); // 회원정보 상세보기
	public void member_updateProc(HashMap<String, Object> map); // 회원정보수정
	public Member Idchk(String id); // 회원등록 아이디 중복체크
	public List<Class> getClasslist();  // 모든권한리스트
	public List<Dept> getDeptlist();   // 모든부서리스트
	public void regMember(Member m);   // 회원 등록
	void unlock(String num);
	void golock(String num);
	public void modMember(Member vo);
}
