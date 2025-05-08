package com.kh.tt.google.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;

@Repository
public class GoogleLoginDao {
	

	
	public int loginUrlGoogle(SqlSessionTemplate sqlSession, Member g) {
		Map<String, String> param = new HashMap<>();
		param.put("snsKey", g.getSnsKey());
		param.put("email", g.getEmail());
		
		List<Member> list = sqlSession.selectList("googleMapper.loginUrlGoogle", param);
		return list.isEmpty() ? 0 : 1;
	}
	
	public Member loginGoogleMember(SqlSessionTemplate sqlSession, Member g) {
		Map<String, String> param = new HashMap<>();
		param.put("snsKey", g.getSnsKey());
		param.put("email", g.getEmail());
		
		return sqlSession.selectOne("googleMapper.loginGoogleMember", param);
		
	}

}
