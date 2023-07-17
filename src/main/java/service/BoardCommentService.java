package service;

import java.util.List;

import dto.BoardCommentDTO;

public interface BoardCommentService {
	public List<BoardCommentDTO> getCommentsByBoardId(int boardid);
	public int insertBoardCommnet(BoardCommentDTO comment);
}
