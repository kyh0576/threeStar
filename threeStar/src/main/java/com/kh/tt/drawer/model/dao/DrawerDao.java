package com.kh.tt.drawer.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.tt.message.model.vo.Message;

@Repository
public class DrawerDao {
	
	public List<Message> selectDrawer(SqlSessionTemplate session, Message d) {
		return session.selectList("drawerMapper.selectDrawer", d);
	}

}
