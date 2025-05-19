package com.kh.tt.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

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
    public List<Member> findTargetMember(SqlSessionTemplate sqlSession, int roomId, int myMemNo) {
        return sqlSession.selectList("chatMapper.findTargetMember", Map.of("roomId", roomId, "myMemNo", myMemNo));
    }
    
    public ChattingRoom selectChatRoomById(SqlSessionTemplate sqlSession, int roomId) {
        return sqlSession.selectOne("chatMapper.selectChatRoomById", roomId);
    }
    
    public List<Member> getChatRoomMembers(SqlSessionTemplate sqlSession, int roomId){
    	List<Member> memmem =  sqlSession.selectList("chatMapper.getChatRoomMembers",roomId);
    	return memmem;
    }
    
    //=======채팅방 나가기=================================================
    public int exitChatRoom(SqlSessionTemplate sqlSession, int chatId, int memNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("chatId", chatId);
        param.put("memNo", memNo);
        return sqlSession.delete("chatMapper.exitChatRoom", param);
    }
    
    
    
    //======그룹채팅방 생성=================================================
    
    public Integer findGroupChatRoom(SqlSessionTemplate sqlSession,List<Integer> memberNos) {
        Map<String, Object> param = new HashMap<>();
        param.put("list", memberNos);
        param.put("memberCount", memberNos.size());
        return sqlSession.selectOne("chatMapper.findGroupChatRoom", param);
    }
    
 // 채팅방 생성자 1명 insert
    public int insertChatRoom(SqlSessionTemplate sqlSession, int memNo, String chatName) {
        Map<String, Object> param = Map.of("memNo", memNo, "chatName", chatName);
        return sqlSession.insert("chatMapper.insertChatRoom", param);
    }

    // 다른 멤버들 추가
    public int insertRoomMember(SqlSessionTemplate sqlSession, int chatId, int memNo, String chatName) {
        Map<String, Object> param = Map.of("chatId", chatId, "memNo", memNo, "chatName", chatName);
        return sqlSession.insert("chatMapper.insertRoomMember", param);
    }
    
    //======친구초대=================================================
    
    public List<Integer> findExistingMembersInRoom(SqlSessionTemplate sqlSession, int chatId, List<Integer> memNos) {
        Map<String, Object> param = new HashMap<>();
        param.put("chatId", chatId);
        param.put("memNos", memNos);
        return sqlSession.selectList("chatMapper.findExistingMembersInRoom", param);
    }
    
    public List<String> findMemberNamesInRoom(SqlSessionTemplate sqlSession, int chatId) {
        return sqlSession.selectList("chatMapper.findMemberNamesInRoom", chatId);
    }

    public int updateChatRoomName(SqlSessionTemplate sqlSession, Map<String, Object> param) {
        return sqlSession.update("chatMapper.updateChatRoomName", param);
    }

//=============================채팅방 이름 변경==============================
    public int renameChatRoom(SqlSessionTemplate sqlSession, int roomId, int memNo, String newName) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomId", roomId);
        param.put("memNo", memNo); // ✅ 추가
        param.put("newName", newName);
        return sqlSession.update("chatMapper.renameChatRoom", param);
    }
    
}