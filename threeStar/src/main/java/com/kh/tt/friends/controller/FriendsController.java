package com.kh.tt.friends.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.tt.friends.model.service.FriendsService;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

@Controller
@RequestMapping("/friends")
public class FriendsController {

	 @Autowired
	   private FriendsService friendService;
	
	 @GetMapping("list")
	 @ResponseBody
	 public List<Friend> FriendsList(@RequestParam("memNo") int memNo) {
	     System.out.println("✅ 요청 도착: memNo = " + memNo);
	     List<Friend> result = friendService.FriendsList(memNo);
	     System.out.println("✅ 결과 반환: " + result);
	     return result;
	 }
}
