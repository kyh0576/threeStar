package com.kh.tt.profile.model.dao;


import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.profile.model.vo.Profile;

@Repository 
public class ProfileDao {
	
	public int selectProfile(SqlSessionTemplate sqlSession, int memNo) {
		int result = sqlSession.selectOne("profileMapper.selectProfile", memNo);
		System.out.println("Dao : " + result);
		return result;
	}
	
	public int selectProfileDetail(SqlSessionTemplate sqlSession, int memNo) {
		int result = sqlSession.selectOne("profileMapper.selectProfileDetail", memNo);
		// System.out.println(result);
		return result;
	}
	
	public int updateProfile(SqlSessionTemplate sqlSession, Profile p) {
		int result = sqlSession.update("profileMapper.updateProfile", p);
		// System.out.println(result);
		return result;
		
	}

}
