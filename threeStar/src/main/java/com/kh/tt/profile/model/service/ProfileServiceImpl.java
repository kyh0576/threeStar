package com.kh.tt.profile.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.tt.member.model.dao.MemberDao;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.dao.ProfileDao;
import com.kh.tt.profile.model.vo.Friend;
import com.kh.tt.profile.model.vo.Profile;

@Service
public class ProfileServiceImpl implements ProfileService {
	
    @Autowired
    private MemberDao mDao;
	
	@Autowired
	private ProfileDao pDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member selectProfile(int memNo) {
		return pDao.selectProfile(sqlSession, memNo);
	}
	
	@Override
	public Member detailProfile(Member p) {
		return pDao.detailProfile(sqlSession, p);
	}
	
	@Override
	public Member loginMember(Member p) {
	   return mDao.loginMember(sqlSession, p);
	}
	
	@Override
	public int updateProfile(Member p) {
		return pDao.updateProfile(sqlSession, p);
	}
	
	@Override
	public int deleteProfile(Member p) {
		return pDao.deleteProfile(sqlSession, p);
	}

	@Override
	public int insertFriend(Friend friend) {
		return pDao.insertFriend(sqlSession, friend);
	}

	public int deleteFriend(Friend friend) {
		return pDao.deleteFriend(sqlSession, friend);
	}

	public ArrayList<Member> selectWaitingList(Friend friend) {
		return pDao.selectWaitingList(sqlSession, friend);
	}

	public int updateFriendName(Friend friend) {
		return pDao.updateFriendName(sqlSession, friend);
	}
	
	
}
