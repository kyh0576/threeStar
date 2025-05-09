package com.kh.tt.profile.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString

public class Friend {
	private int fromMem;
	private int toMem;
	private String areWeFriend;
	private String toNickname;
	
	
	
	private String receiver;
}
