package com.kh.tt.chat.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.chat.model.dao.ChattingRoomDao;
import com.kh.tt.message.model.dao.MessageDao;
@Service
public class ChattingRoomServiceImpl implements ChattingRoomService {
	
    @Autowired 
    private ChattingRoomDao mDao; 
    
    @Autowired 
    private SqlSessionTemplate sqlSession;

	//===================채팅방=================================================
		@Override
		public Integer findChatRoom(int myMemNo, int targetMemNo) {
			return mDao.findChatRoom(sqlSession, myMemNo, targetMemNo);
		}

		@Override
		public int createChatRoom(int myMemNo, int targetMemNo) {
			return mDao.createChatRoom(sqlSession, myMemNo, targetMemNo);
		}

		@Override
		public int selectLastChatId() {
			return mDao.selectLastChatId(sqlSession);
		}

		@Override
		public int createTargetChatRoom(int chatId, int targetMemNo, String chatName) {
			return mDao.createTargetChatRoom(sqlSession,chatId,targetMemNo,chatName);
		}

}
