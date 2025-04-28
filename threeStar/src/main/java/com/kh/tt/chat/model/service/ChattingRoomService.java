package com.kh.tt.chat.model.service;

import org.mybatis.spring.SqlSessionTemplate;

public interface ChattingRoomService {
	
	Integer findChatRoom(int myMemNo, int targetMemNo);
	int createChatRoom(int myMemNo, int targetMemNo);
	int selectLastChatId();
	int createTargetChatRoom(int chatId, int targetMemNo, String chatName);
	

}
