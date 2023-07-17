package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardCommentDAO;
import dto.BoardCommentDTO;

@Service
public class BoardCommentServiceImpl implements BoardCommentService {

	@Autowired
	BoardCommentDAO dao;
	
	@Override
	public List<BoardCommentDTO> getCommentsByBoardId(int boardid) {
		return dao.getCommentsByBoardId(boardid);
	}

	@Override
	public int insertBoardCommnet(BoardCommentDTO comment) {
		return dao.insertBoardComment(comment);
	}

}
