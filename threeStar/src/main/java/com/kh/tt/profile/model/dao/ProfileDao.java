package com.kh.tt.profile.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;
import com.kh.tt.profile.model.vo.Profile;

@Repository 
public class ProfileDao {
	
	public Member selectProfile(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("profileMapper.selectProfile", memNo);
	}
	
	public Member detailProfile(SqlSessionTemplate sqlSession, Member p) {
		return sqlSession.selectOne("profileMapper.detailProfile", p);
	}
	
   public Member loginMember(SqlSessionTemplate sqlSession, Member p) {

        return sqlSession.selectOne("profileMapper.loginMember", p);
    }
	
	public int updateProfile(SqlSessionTemplate sqlSession, Member p) {
		return sqlSession.update("profileMapper.updateProfile", p);
	}

	public int insertFriend(SqlSessionTemplate sqlSession, Friend friend) {
		return sqlSession.insert("profileMapper.insertFriend", friend);
	}

	public int deleteFriend(SqlSessionTemplate sqlSession, Friend friend) {
		return sqlSession.delete("profileMapper.deleteFriend", friend);
	}

	public ArrayList<Member> selectWaitingList(SqlSessionTemplate sqlSession, Friend friend) {
		return (ArrayList)sqlSession.selectList("profileMapper.selectWaitingList", friend);
	}
	
	public int deleteProfile(SqlSessionTemplate sqlSession, Member p) {
		return sqlSession.update("profileMapper.deleteProfile", p);
	}

	public int updateFriendName(SqlSessionTemplate sqlSession, Friend friend) {
		return sqlSession.update("profileMapper.updateFriendName", friend);
	}

	public Member selectFriend(SqlSessionTemplate sqlSession, Friend friend) {
		return sqlSession.selectOne("profileMapper.selectFriend", friend);
	}

}
