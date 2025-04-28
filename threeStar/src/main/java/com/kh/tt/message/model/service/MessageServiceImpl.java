package com.kh.tt.message.model.service;

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
	   
    @Override
    public int saveMessage(Message msg) {
    	System.out.println("✅ saveMessage() 호출! msg = " + msg);
        return mDao.insertMessage(sqlSession, msg);
    }
}
