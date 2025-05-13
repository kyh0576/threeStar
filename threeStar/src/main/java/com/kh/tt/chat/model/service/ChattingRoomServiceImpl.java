package com.kh.tt.chat.model.service;

import java.util.List;

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
    private ChattingRoomDao mDao; 

    @Autowired 
    private SqlSessionTemplate sqlSession;

    //===================채팅방=================================================
        @Override
        public Integer findChatRoom(int myMemNo, int targetMemNo) {
            return mDao.findChatRoom(sqlSession, myMemNo, targetMemNo);
        }

        @Override
        public int createChatRoom(int myMemNo, int targetMemNo) {
            // 1. 먼저 나(myMemNo) 채팅방 등록
            int result = mDao.createChatRoom(sqlSession, myMemNo);

            // 2. 채팅방 id (chatId) 가져오기
            int chatId = mDao.selectLastChatId(sqlSession);

            // 3. 상대방(targetMemNo)도 같은 방에 등록
            int result2 = mDao.createTargetChatRoom(sqlSession, chatId, targetMemNo, "채팅방");

            return chatId;  // ✅ 생성된 채팅방 ID를 반환
        }

        @Override
        public int selectLastChatId() {
            return mDao.selectLastChatId(sqlSession);
        }

        @Override
        public int createTargetChatRoom(int chatId, int targetMemNo, String chatName) {
            return mDao.createTargetChatRoom(sqlSession,chatId,targetMemNo,chatName);
        }
//채팅방 생성 ====================================================================
        @Override
        public List<ChattingRoom> getChatRoomsByMemberId(String memId) {
            return mDao.getChatRoomsByMemberId(sqlSession, memId);
        }
//채팅방 이름 변경=========================================================================
        
		@Override
		public Member findTargetMember(int roomId, int myMemNo) {
			return mDao.findTargetMember(sqlSession, roomId, myMemNo);
		}
		
		@Override
		public ChattingRoom selectChatRoomById(int roomId) {
		    return mDao.selectChatRoomById(sqlSession, roomId);
		}
		
		@Override
		public List<Member> getChatRoomMembers(int roomId) {
			return mDao.getChatRoomMembers(sqlSession, roomId);
		}

		
 //=======채팅방 나가기=================================================
		 @Override
		    public int exitChatRoom(int chatId, int memNo) {
		        System.out.println("🔥 받은 chatId1: " + chatId);
		        System.out.println("🔥 받은 memNo1: " + memNo);
		        return mDao.exitChatRoom(sqlSession,chatId, memNo);
		        
		    }
//=======================그룹채팅=====================================
		@Override
		public int createGroupChatRoom(List<Integer> memberNos) {
			  Integer existingRoomId = mDao.findGroupChatRoom(sqlSession, memberNos);
			    if (existingRoomId != null) {
			        return existingRoomId;  // ✅ 이미 있으면 그 방으로 리턴
			    }
			    
		    // 1. 방 생성자 insert
		    int firstMemNo = memberNos.get(0);
		    mDao.insertChatRoom(sqlSession, firstMemNo, "그룹 채팅");

		    // 2. 방 id 가져오기
		    int roomId = mDao.selectLastChatId(sqlSession);

		    // 3. 나머지 멤버 추가
		    for (int i = 1; i < memberNos.size(); i++) {
		        mDao.insertRoomMember(sqlSession, roomId, memberNos.get(i), "그룹 채팅");
		    }

		    return roomId;
		}

}