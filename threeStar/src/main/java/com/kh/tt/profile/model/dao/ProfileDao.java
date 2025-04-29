package com.kh.tt.profile.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Profile;

@Repository 
public class ProfileDao {
	
	public int selectProfile(SqlSessionTemplate sqlSession, int memNo) {
		int result = sqlSession.selectOne("profileMapper.selectProfile", memNo);
		return result;
	}
	
	public Member detailProfile(SqlSessionTemplate sqlSession, Member p) {
		return sqlSession.selectOne("profileMapper.detailProfile", p);
	}
	
   public Member loginMember(SqlSessionTemplate sqlSession, Member p) {

        return sqlSession.selectOne("profileMapper.loginMember", p);
    }
	
	public int updateProfile(SqlSessionTemplate sqlSession, Member p) {
		int result = sqlSession.update("profileMapper.updateProfile", p);
		return result;
	}
	
	public int deleteProfile(SqlSessionTemplate sqlSession, Member p) {
		return sqlSession.update("profileMapper.deleteProfile", p);
	}

}
