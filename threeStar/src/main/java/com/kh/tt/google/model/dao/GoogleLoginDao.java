package com.kh.tt.google.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;

@Repository
public class GoogleLoginDao {
	
	public int SelectGoogleLogin(SqlSessionTemplate sqlSession, Member g) {
		return sqlSession.selectOne("googleMapper.SelectGoogleLogin", g);
	}
	

}
