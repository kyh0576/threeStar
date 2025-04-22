package com.kh.tt.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.tt.member.model.dao.MemberDao;
import com.kh.tt.member.model.vo.Member;

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
		return 0;
	}

	

}
