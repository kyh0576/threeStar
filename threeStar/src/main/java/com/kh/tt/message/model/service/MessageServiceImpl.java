package com.kh.tt.message.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.calendar.model.vo.Calendar;
import com.kh.tt.message.model.dao.MessageDao;
import com.kh.tt.message.model.vo.Message;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired 
    private MessageDao mDao; 
    
    @Autowired 
    private SqlSessionTemplate sqlSession;

    // 메시지 저장 (일반 텍스트 + 파일 포함)
    @Override
    public int saveMessage(Message msg) {
        return mDao.insertMessage(sqlSession, msg);
    }

    // 이전 메시지 불러오기 (히스토리)
    @Override
    public List<Message> sendMessage(int roomId) {
        return mDao.sendMessage(sqlSession, roomId);
    }

    //첨부파일
    
    @Override
    public List<Message> getUploadedFiles(int roomId) {
        return mDao.getUploadedFiles(sqlSession,roomId);
    }
    
    
    @Override
    public List<Message> getFilesByRoomId(int roomId) {
        return mDao.getFilesByRoomId(sqlSession,roomId);
    }

	@Override
	public int deleteMessage(int messageNo) {
		System.out.println("여기는 서비스임플 "+messageNo);
		return mDao.deleteMessage(sqlSession,messageNo);
	}
	
	@Override
	public int insertCalendar(Calendar c){
		return mDao.insertCalendar(sqlSession, c);
	}
	
	@Override
	public List<Calendar> getCalendarEvents(int roomId){
		return mDao.getCalendarEvents(sqlSession, roomId);
	}
	
	@Override
	public int getUpdateCalendarEvents(int calId, int calWriter){
		return mDao.getUpdateCalendarEvents(sqlSession, calId, calWriter);
	}
	
    // ✅ 추가: 특정 유저가 특정 채팅방에서 보낸 메시지 전체 삭제
    @Override
    public int deleteMessagesByUserInRoom(int chatId, int memNo) {
        return mDao.deleteMessagesByUserInRoom(sqlSession, chatId, memNo);
    }
	
}
