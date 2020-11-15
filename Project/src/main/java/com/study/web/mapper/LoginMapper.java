package com.study.web.mapper;

import java.util.ArrayList;
import com.study.web.vo.Member;

public interface LoginMapper {
	Member getLogin(Member vo);
	Member getIdchk(String id);
	void setLock(String id);
}