package com.kh.tt.message.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
}
