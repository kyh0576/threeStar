package com.kh.tt.message.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.message.model.vo.Message;

@Repository
public class MessageDao {

    // 메시지 저장 (일반 텍스트 + 파일 포함)
    public int insertMessage(SqlSessionTemplate sqlSession, Message msg) {
        return sqlSession.insert("messageMapper.insertMessage", msg);
    }

    // 저장된 메시지 불러오기 (메시지 히스토리)
    public List<Message> sendMessage(SqlSessionTemplate sqlSession, int roomId) {
        return sqlSession.selectList("messageMapper.sendMessage", roomId);
    }
    
 // 저장된 메시지 불러오기 (메시지 히스토리)
    public List<Message> getUploadedFiles(SqlSessionTemplate sqlSession, int roomId) {
        return sqlSession.selectList("messageMapper.getUploadedFiles", roomId);
    }
    
    public List<Message> getFilesByRoomId(SqlSessionTemplate sqlSession,int roomId) {
        return sqlSession.selectList("messageMapper.getFilesByRoomId", roomId);
    }
    
    public int deleteMessage (SqlSessionTemplate sqlSession,int messageNo) {
    	System.out.println("메시지 다오 " + messageNo);
    	 return sqlSession.delete("messageMapper.deleteMessage", messageNo);
    }
    
    public int insertCalendar(SqlSessionTemplate sqlSession, Calendar c){
    	return sqlSession.insert("calendarMapper.insertCalendar", c);
    }
    
    public List<Calendar> getCalendarEvents(SqlSessionTemplate sqlSession, int roomId){
    	return sqlSession.selectList("calendarMapper.getCalendarEvents", roomId);
    }
    
    public int getUpdateCalendarEvents(SqlSessionTemplate sqlSession, int calId, int calWriter){
    	Map<String, Object> param = new HashMap<>();
    	param.put("calId", calId);
    	param.put("calWriter", calWriter);
    	return sqlSession.delete("calendarMapper.getUpdateCalendarEvents", param);
    }
    
 // ✅ 특정 유저가 특정 채팅방에서 보낸 메시지 전부 삭제
    public int deleteMessagesByUserInRoom(SqlSessionTemplate sqlSession, int chatId, int memNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("chatId", chatId);
        param.put("memNo", memNo);
        return sqlSession.delete("messageMapper.deleteMessagesByUserInRoom", param);
    }
    
}
