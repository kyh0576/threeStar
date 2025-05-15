package com.kh.tt.message.model.service;

import java.util.List;

import com.kh.tt.message.model.vo.Message;

public interface MessageService {

    // 메시지 저장 (일반/파일 포함)
    int saveMessage(Message message);

    // 메시지 불러오기 (히스토리)
    List<Message> sendMessage(int roomId);
    
    List<Message> getUploadedFiles(int roomId);
    
    List<Message> getFilesByRoomId(int roomId);
    
    int deleteMessage(int messageNo);
}
