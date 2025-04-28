package com.kh.tt.message.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.message.model.vo.Message;

@Repository
public class MessageDao {

    public int insertMessage(SqlSessionTemplate sqlSession, Message msg) {
        return sqlSession.insert("messageMapper.insertMessage", msg);
    }
}
