package com.kh.tt.chat.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.tt.chat.model.vo.ChattingRoom;
import com.kh.tt.member.model.vo.Member;

public interface ChattingRoomService {

    Integer findChatRoom(int myMemNo, int targetMemNo);
    int createChatRoom(int myMemNo, int targetMemNo);
    int selectLastChatId();
    int createTargetChatRoom(int chatId, int targetMemNo, String chatName);
   
    
//    ============채팅방===========
    List<ChattingRoom> getChatRoomsByMemberId(String memId);
    
    
//  ============채팅방 이름===========    
    Member findTargetMember(int roomId, int myMemNo);
    
    ChattingRoom selectChatRoomById(int roomId);
    
// 채팅방 나가기
    int exitChatRoom(int chatId, int memNo);
    
}