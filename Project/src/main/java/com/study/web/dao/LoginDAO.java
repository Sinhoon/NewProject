package com.study.web.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.study.web.vo.Member;

public interface LoginDAO {
	public Member getLogin(Member vo);
	public Member getIdchk(String id);
	public void setLock(String id);
}