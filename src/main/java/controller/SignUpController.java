package controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.SignUpDTO;
import service.SignUpService;

@Controller
public class SignUpController {
	@Autowired
	SignUpService service;
	
	@GetMapping("/signup")
	public String signUpForm(Model m) {
		m.addAttribute("signupDTO", new SignUpDTO());
		return "SignUpForm";
	}
	
	@PostMapping("/signup")
	public ModelAndView signUp(SignUpDTO dto) {
		int insert = service.signUp(dto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("insert", insert);
		mv.setViewName("main");
		return mv;
	}
	
	@RequestMapping("/duplicateCheck")
	@ResponseBody
	public Map<String, Boolean> duplicateCheck(@RequestParam(required = false) String userid){
		Map<String, Boolean> response = new HashMap<>();
		boolean isDuplicated = service.duplicateCheck(userid);
		response.put("isDuplicated", isDuplicated);
		return response;
	}
}
