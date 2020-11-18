package com.study.web.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.study.web.vo.Dept;
import com.study.web.vo.Member;

public interface MemberMapper {
    ArrayList<Member> getMembers();
    Member Idchk(String id);
    List<Class> getClasslist();
    List<Dept> getDeptlist();
    void regMember(Member m);
    void golock(String num);
    void unlock(String num);
    void modMember(Member vo);
    void rmMember(String unum);
}

