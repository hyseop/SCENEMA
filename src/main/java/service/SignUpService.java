package service;

import dto.SignUpDTO;

public interface SignUpService {
	public int signUp(SignUpDTO dto);
	public boolean duplicateCheck(String userid);
}
