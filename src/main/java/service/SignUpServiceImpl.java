package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.SignUpDAO;
import dto.SignUpDTO;

@Service
public class SignUpServiceImpl implements SignUpService {

	@Autowired
	SignUpDAO dao;
	
	@Override
	public int signUp(SignUpDTO dto) {
		return dao.signUp(dto);
	}

	@Override
	public boolean duplicateCheck(String userid) {
		return dao.duplicateCheck(userid);
	}

}
