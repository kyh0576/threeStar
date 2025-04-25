package com.kh.tt.profile.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.profile.model.vo.Profile;

@Repository 
public class ProfileDao {
	
	public int selectProfile(SqlSessionTemplate sqlSession, int memNo) {
		int result = sqlSession.selectOne("profileMapper.selectProfile", memNo);
		return result;
	}
	
	public int updateProfile(SqlSessionTemplate sqlSession, Profile p) {
		int result = sqlSession.update("profileMapper.updateProfile", p);
		return result;
		
	}

}
