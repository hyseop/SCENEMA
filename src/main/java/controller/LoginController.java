package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.UserDTO;
import service.LoginService;

@Controller
public class LoginController {
	@Autowired
	LoginService service;
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public @ResponseBody String loginUser(String userid, String pw, HttpSession session) {
		UserDTO loginUser = service.getUser(userid);
		String result = "";
		
		if(loginUser == null) {
			result="null";
		}else if(!loginUser.getPw().equals(pw)) {
			result="password error";
		}else {
			result="login sucess";
			session.setAttribute("userid", userid);
			session.setAttribute("loginUser", loginUser);
		}
		return result;
	}
	
	@GetMapping("/logout")
	public String logoutUser(HttpSession session) {
		session.removeAttribute("userid");
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
}
