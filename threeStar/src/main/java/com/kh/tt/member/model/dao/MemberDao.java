package com.kh.tt.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.member.model.vo.Classes;
import com.kh.tt.member.model.vo.Member;

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
		System.out.println("DAO");
		return sqlSession.update("memberMapper.online", m);
	}
	
	public int offline(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.offline", m);
	}

	
}
