package com.kh.tt.chat.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.chat.model.dao.ChattingRoomDao;
import com.kh.tt.chat.model.vo.ChattingRoom;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.message.model.dao.MessageDao;
@Service
public class ChattingRoomServiceImpl implements ChattingRoomService {

    @Autowired 
    private ChattingRoomDao cDao; 

    @Autowired 
    private SqlSessionTemplate sqlSession;

    //===================채팅방=================================================
        @Override
        public Integer findChatRoom(int myMemNo, int targetMemNo) {
            return cDao.findChatRoom(sqlSession, myMemNo, targetMemNo);
        }

        @Override
        public int createChatRoom(int myMemNo, int targetMemNo) {
            // 1. 먼저 나(myMemNo) 채팅방 등록
            int result = cDao.createChatRoom(sqlSession, myMemNo);

            // 2. 채팅방 id (chatId) 가져오기
            int chatId = cDao.selectLastChatId(sqlSession);

            // 3. 상대방(targetMemNo)도 같은 방에 등록
            int result2 = cDao.createTargetChatRoom(sqlSession, chatId, targetMemNo, "채팅방");

            return chatId;  // ✅ 생성된 채팅방 ID를 반환
        }

        @Override
        public int selectLastChatId() {
            return cDao.selectLastChatId(sqlSession);
        }

        @Override
        public int createTargetChatRoom(int chatId, int targetMemNo, String chatName) {
            return cDao.createTargetChatRoom(sqlSession,chatId,targetMemNo,chatName);
        }
//채팅방 생성 ====================================================================
        @Override
        public List<ChattingRoom> getChatRoomsByMemberId(String memId) {
            return cDao.getChatRoomsByMemberId(sqlSession, memId);
        }
//채팅방 이름 변경=========================================================================
        
		@Override
		public List<Member> findTargetMember(int roomId, int myMemNo) {
			return cDao.findTargetMember(sqlSession, roomId, myMemNo);
		}
		
		@Override
		public ChattingRoom selectChatRoomById(int roomId) {
		    return cDao.selectChatRoomById(sqlSession, roomId);
		}
		
		@Override
		public List<Member> getChatRoomMembers(int roomId) {
			return cDao.getChatRoomMembers(sqlSession, roomId);
		}

		
 //=======채팅방 나가기=================================================
		 @Override
		    public int exitChatRoom(int chatId, int memNo) {
		        return cDao.exitChatRoom(sqlSession,chatId, memNo);
		        
		    }
//=======================그룹채팅=====================================
		@Override
		public int createGroupChatRoom(List<Integer> memberNos) {
			  Integer existingRoomId = cDao.findGroupChatRoom(sqlSession, memberNos);
			    if (existingRoomId != null) {
			        return existingRoomId;  // ✅ 이미 있으면 그 방으로 리턴
			    }
			    
		    // 1. 방 생성자 insert
		    int firstMemNo = memberNos.get(0);
		    cDao.insertChatRoom(sqlSession, firstMemNo, "그룹 채팅");

		    // 2. 방 id 가져오기
		    int roomId = cDao.selectLastChatId(sqlSession);

		    // 3. 나머지 멤버 추가
		    for (int i = 1; i < memberNos.size(); i++) {
		        cDao.insertRoomMember(sqlSession, roomId, memberNos.get(i), "그룹 채팅");
		    }

		    return roomId;
		}
//=======================친구초대===========================
		@Override
		public List<Integer> findExistingMembersInRoom(int chatId, List<Integer> memNos) {
		    return cDao.findExistingMembersInRoom(sqlSession, chatId, memNos);
		}

		@Override
		public int insertRoomMember(int chatId, int memNo, String chatName) {
			return cDao.insertRoomMember(sqlSession,chatId, memNo, chatName);
		}

		@Override
		public List<String> findMemberNamesInRoom(int chatId) {
			return cDao.findMemberNamesInRoom(sqlSession, chatId);
		}

		@Override
		public int updateChatRoomName(int chatId, String chatName) {
		    Map<String, Object> param = new HashMap<>();
		    param.put("chatId", chatId);
		    param.put("chatName", chatName);
		    return cDao.updateChatRoomName(sqlSession, param);
		}
//==========================채팅방 이름 변경===========================
		@Override
		public int renameChatRoom(int roomId, String newName, int memNo) {
			 return cDao.renameChatRoom(sqlSession, roomId, memNo, newName);
		}

}