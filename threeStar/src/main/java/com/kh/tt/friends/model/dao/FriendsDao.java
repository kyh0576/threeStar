package com.kh.tt.friends.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

@Repository
public class FriendsDao {
	
	public List<Friend> FriendsList(SqlSessionTemplate sqlSession,int memNo){
		return sqlSession.selectList("friendMapper.FriendsList",memNo);
	}
}
