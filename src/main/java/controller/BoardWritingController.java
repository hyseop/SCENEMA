package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import dto.BoardDTO;
import service.BoardService;

@Controller
public class BoardWritingController {

	@Autowired
	BoardService service;

	@GetMapping("/boardwriting")
	public String writingForm(Model m) {
		m.addAttribute("boardDTO", new BoardDTO());
		return "WritingForm";
	}

	@PostMapping("/boardwriting")
	public String writingProcess(BoardDTO dto) {
		int insert = service.boardWriting(dto);
		return "redirect:/boardlist";

	}

}
