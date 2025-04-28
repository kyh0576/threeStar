package com.kh.tt.chat.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ChattingRoomDao {
	
	//===================채팅방==============================================     
    public Integer findChatRoom(SqlSessionTemplate sqlSession, int myMemNo, int targetMemNo) {
    	 return sqlSession.selectOne("chatMapper.findChatRoom", Map.of("myMemNo", myMemNo, "targetMemNo", targetMemNo));
    }
    
    public int createChatRoom(SqlSessionTemplate sqlSession, int myMemNo, int targetMemNo) {
    	 Map<String, Object> param = new HashMap<>();
    	    param.put("memNo", myMemNo); // 🧡 여기에 myMemNo 꼭 제대로 들어가야 해
    	    param.put("chatName", "채팅방");
    	    return sqlSession.insert("chatMapper.createChatRoom", param);
    }
    
    public int selectLastChatId(SqlSessionTemplate sqlSession) {
    	 return sqlSession.selectOne("chatMapper.selectLastChatId");
    }
    
    public int createTargetChatRoom(SqlSessionTemplate sqlSession, int chatId, int targetMemNo, String chatName) {
        return sqlSession.insert("chatMapper.createTargetChatRoom", 
            Map.of("chatId", chatId, "targetMemNo", targetMemNo, "chatName", chatName));
    }


}
