package com.kh.tt.profile.model.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.tt.profile.model.vo.Profile;

@Repository 
public class ProfileDao {
	
	public Profile selectProfile(SqlSession sqlSession, int memNo) {
		return sqlSession.selectOne("profileMapper.selectProfile", memNo);
	}
	
	public Profile selectProfileDetail(SqlSession sqlSession, String memId) {
		return sqlSession.selectOne("profileMapper.selectProfileDetail", memId);
	}
	
	public int updateProfile(SqlSession sqlSession, Profile p) {
		return sqlSession.update("profileMapper.updateProfile", p);
	}

}
