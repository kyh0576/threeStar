package com.kh.tt.friends.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.friends.model.dao.FriendsDao;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

@Service
public class FriendsServiceImpl implements FriendsService{
	
	  @Autowired
	    private FriendsDao fDao;
	  
	    @Autowired 
	    private SqlSessionTemplate sqlSession;


	@Override
	public List<Friend> FriendsList(int memNo) {
		System.out.println("여기는 서비스용"+memNo);
		return fDao.FriendsList(sqlSession,memNo);
	}

}
