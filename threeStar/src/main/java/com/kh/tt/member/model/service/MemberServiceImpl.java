package com.kh.tt.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.member.model.dao.MemberDao;
import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

@Service
public class MemberServiceImpl implements MemberService{

   @Autowired // spring! 나를 injection(주입) 해줘
   private MemberDao mDao; // spring이 직접 생성해줘서 new 필요없음 @Repository로 해줬었음
   
   @Autowired // 컨트롤 + 클릭 하면 클래스로 이동됨
   private SqlSessionTemplate sqlSession; // 이 친구는 xml파일로 등록해야함 (클래스 파일은 수정할 수 없기 때문에 @(어노테이션)을 쓸 수 잆엄
   
   @Override
   public Member loginMember(Member m) {
      return mDao.loginMember(sqlSession, m);
   }

   @Override
   public int insertMember(Member m) {
      return mDao.insertMember(sqlSession, m);
   }

   @Override
   public int selectClassCode(String classCode) {
      return mDao.selectClassCode(sqlSession, classCode);
   }
   
   @Override
   public int updateMember(Member m) {
      return 0;
   }

   @Override
   public int deleteMember(String userId) {
      return 0;
   }

   @Override
   public int idCheck(String userId) {
      return mDao.idCheck(sqlSession, userId);
   }

   @Override
   public ArrayList<Classes> selectClass() {
      return mDao.selectClass(sqlSession);
   }

   @Override
   public ArrayList<Member> selectMemberList(String classCode) {
      return mDao.selectMemberList(sqlSession, classCode);
   }

   @Override
   public int online(Member m) {
      return mDao.online(sqlSession, m);
   }

   @Override
   public int offline(Member m) {
      return mDao.offline(sqlSession, m);
   }

   @Override
   public ArrayList<Member> selectFriendList(int memNo) {
      return mDao.selectFriendList(sqlSession, memNo);
   }

	@Override
	public ArrayList<Member> selectWaitingList(int memNo) {
		return mDao.selectWaitingList(sqlSession, memNo);
	}

	@Override
	public Member findId(Member m) {
		return mDao.findId(sqlSession, m);
	}

	@Override
	public Member findPwd(Member m) {
		return mDao.findPwd(sqlSession, m);
	}

	@Override
	public int findUpdatePwd(Member m) {
		return mDao.findUpdatePwd(sqlSession, m);
	}

	public int acceptFriend(Friend friend) {
		return mDao.acceptFriend(sqlSession, friend);
	}

	public int rejectFriend(Friend friend) {
		return mDao.rejectFriend(sqlSession, friend);
	}

	@Override
	public ArrayList<Member> getOnlineMembers(Member m) {
		return mDao.getOnlineMembers(sqlSession, m);
	}
	


}
