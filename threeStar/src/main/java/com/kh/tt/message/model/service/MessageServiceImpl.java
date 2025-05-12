package com.kh.tt.message.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public List<Message> getUploadedFiles(int roomId) {
        return mDao.getUploadedFiles(sqlSession,roomId);
    }
    
    
    // (Optional) → 파일 전용 메시지 불러오기도 추후 필요하면 여기에 추가
    @Override
    public List<Message> getFilesByRoomId(int roomId) {
        return mDao.getFilesByRoomId(sqlSession,roomId);
    }
}
