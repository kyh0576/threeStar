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
    
    List<Member> getChatRoomMembers(int roomId);
    
    //  ============채팅방 이름===========    
    List<Member> findTargetMember(int roomId, int myMemNo);
    
    ChattingRoom selectChatRoomById(int roomId);
    
    // 채팅방 나가기
    int exitChatRoom(int chatId, int memNo);
    
    //그룹채팅
    int createGroupChatRoom (List<Integer> memberNos);
    
    //친구초대
    List<Integer> findExistingMembersInRoom(int chatId, List<Integer> memNos);//중복방지
    int insertRoomMember(int chatId, int memNo, String chatName);
    
    List<String> findMemberNamesInRoom(int chatId);
    int updateChatRoomName(int chatId,String chatName);
    
    //채팅방 이름 변경
	int renameChatRoom(int roomId, String newName, int memNo);
    
    
}