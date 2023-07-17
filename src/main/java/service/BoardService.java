package service;

import java.util.List;

import dto.BoardDTO;
import dto.Criteria;

public interface BoardService {
	public int boardWriting(BoardDTO dto);
	public List<BoardDTO> getBoardListById(int boardid);
	public int boardViewUp(int boardid);
	public int boardDelete(int boardid);
	public int boardUpdate(BoardDTO dto);
	public List<BoardDTO> list(Criteria cri) throws Exception;
	public int listCount() throws Exception;
}
