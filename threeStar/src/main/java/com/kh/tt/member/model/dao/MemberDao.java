package com.kh.tt.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;
import com.kh.tt.profile.model.vo.Friend;

@Repository
public class MemberDao {
   
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int selectClassCode(SqlSessionTemplate sqlSession, String classCode) {
		return sqlSession.selectOne("memberMapper.selectClassCode", classCode);
	}
    
    public int updateMember(SqlSessionTemplate sqlSession, Member m) {
        return sqlSession.update("memberMapper.updateMember", m);
    }

    public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
    	return sqlSession.update("memberMapper.deleteMember", userId);
    }

	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
	    return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}

	public ArrayList<Classes> selectClass(SqlSessionTemplate sqlSession) {
	    return (ArrayList)sqlSession.selectList("memberMapper.selectClass");
	}

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession, String classCode) {
	    return (ArrayList)sqlSession.selectList("memberMapper.selectMemberList", classCode);
	}

	public int online(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.online", m);
	}
   
	public int offline(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.offline", m);
	}

	public ArrayList<Member> selectFriendList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectFriendList", memNo);
	}

	public ArrayList<Member> selectWaitingList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectWaitingList", memNo);
	}

	public Member findId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findId", m);
	}

	public Member findPwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findPwd", m);
	}

	public int findUpdatePwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.findUpdatePwd", m);
	}

	public int acceptFriend(SqlSessionTemplate sqlSession, Friend friend) {
		return sqlSession.update("memberMapper.acceptFriend", friend);
	}

	public int rejectFriend(SqlSessionTemplate sqlSession, Friend friend) {
		return sqlSession.delete("memberMapper.rejectFriend", friend);
	}


   
}
