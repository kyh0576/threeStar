package com.kh.tt.chat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ChattingRoom {
	private int chatId;
	private int chMemNo;
	private String chatName;
	private String status;
	
	private String lastMessage;
}
