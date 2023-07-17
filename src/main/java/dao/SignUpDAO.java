package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.SignUpDTO;

@Repository
public class SignUpDAO {
	
	@Autowired
	SqlSession session;
	
	public int signUp(SignUpDTO dto) {
		return session.insert("signUp", dto);
	}
	
	public boolean duplicateCheck(String userid) {
		Integer count = session.selectOne("duplicateCheck", userid);
		return count > 0;
	}
}
