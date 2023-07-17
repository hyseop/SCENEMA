package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.UserDTO;

@Repository
public class LoginDAO {
	@Autowired
	SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}

	public UserDTO getUser(String userid) {
		return session.selectOne("getUserlogin", userid);
	}
	
	public int userUpdate(UserDTO dto) {
		return session.update("UserUpdate",dto);
	}
	
	public int deleteUser(String userid) {
		return session.delete("UserDelete",userid);
	}
	
}
