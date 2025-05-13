package com.kh.tt.friends.model.service;

import java.util.List;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

public interface FriendsService {
	List<Friend> FriendsList(int memNo);
}
