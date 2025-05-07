package com.kh.tt.message.model.service;

import java.util.List;

import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.model.vo.Message;

public interface MessageService {

	int saveMessage(Message message);
	List<Message> sendMessage(int roomId);
}
