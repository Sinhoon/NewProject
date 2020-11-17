package com.study.web.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.study.web.vo.Dept;
import com.study.web.vo.Member;

public interface MemberDAO {
	public List<Member> memberlist(HashMap<String, Object> map); // ȸ�� ���
	public int getCount(HashMap<String, Object> map); // ȸ���� - ����¡�� �ʿ��Ͽ� �߰��߽��ϴ�.
	public Member member_read(int uNum); // ȸ������ �󼼺���
	public void member_updateProc(HashMap<String, Object> map); // ȸ����������
	public Member Idchk(String id); // ȸ����� ���̵� �ߺ�üũ
	public List<Class> getClasslist();  // �����Ѹ���Ʈ
	public List<Dept> getDeptlist();   // ���μ�����Ʈ
	public void regMember(Member m);   // ȸ�� ���
	void unlock(String num);
	void golock(String num);
	public void modMember(Member vo);
}
