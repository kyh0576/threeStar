package com.kh.tt.google.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;

@Repository
public class GoogleLoginDao {
	
	public int loginUrlGoogle(SqlSessionTemplate sqlSession, Member g) {
		List<Member> list = sqlSession.selectList("googleMapper.loginUrlGoogle", g);
		return list.isEmpty() ? 0 : 1;
	}
	

}
