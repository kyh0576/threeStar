package com.kh.tt.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.chat.model.vo.ChattingRoom;
import com.kh.tt.member.model.vo.Member;

@Repository
public class ChattingRoomDao {

    // ===== 채팅방 존재 여부 찾기 =====
    public Integer findChatRoom(SqlSessionTemplate sqlSession, int myMemNo, int targetMemNo) {
        return sqlSession.selectOne("chatMapper.findChatRoom", 
            Map.of("myMemNo", myMemNo, "targetMemNo", targetMemNo));
    }

    // ===== 나(myMemNo) 채팅방 생성 =====
    public int createChatRoom(SqlSessionTemplate sqlSession, int myMemNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("memNo", myMemNo);   // 나
        param.put("chatName", "채팅방"); // 기본값
        return sqlSession.insert("chatMapper.createChatRoom", param);
    }

    // ===== 마지막 채팅방 번호 가져오기 =====
    public int selectLastChatId(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("chatMapper.selectLastChatId");
    }

    // ===== 상대방(targetMemNo) 채팅방 생성 =====
    public int createTargetChatRoom(SqlSessionTemplate sqlSession, int chatId, int targetMemNo, String chatName) {
        return sqlSession.insert("chatMapper.createTargetChatRoom", 
            Map.of("chatId", chatId, "targetMemNo", targetMemNo, "chatName", chatName));
    }

    public  List<ChattingRoom> getChatRoomsByMemberId(SqlSessionTemplate sqlSession ,String memId){
        return sqlSession.selectList("chatMapper.selectRoomsByMemberId" ,memId);
    }
    
    // ===== 채팅방 이름 ================================================
    public Member findTargetMember(SqlSessionTemplate sqlSession, int roomId, int myMemNo) {
        return sqlSession.selectOne("chatMapper.findTargetMember", Map.of("roomId", roomId, "myMemNo", myMemNo));
    }
    
    public ChattingRoom selectChatRoomById(SqlSessionTemplate sqlSession, int roomId) {
        return sqlSession.selectOne("chatMapper.selectChatRoomById", roomId);
    }
}