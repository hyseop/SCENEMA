package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.LoginDAO;
import dto.UserDTO;

@Service
public class LoginService {
	@Autowired
	LoginDAO dao;
	
	public UserDTO getUser(String userid) {
		return dao.getUser(userid);
	}
	
	public int userUpdate(UserDTO dto) {
		return dao.userUpdate(dto);
	}
	
	public int deleteUser(String userid) {
		return dao.deleteUser(userid);
	}
	
}
