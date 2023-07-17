package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDAO;
import dto.BoardDTO;
import dto.Criteria;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO dao;
	
	@Override
	public int boardWriting(BoardDTO dto) {
		return dao.boardWriting(dto);
	}

	@Override
	public List<BoardDTO> getBoardListById(int boardid) {
		return dao.getBoardListById(boardid);
	}

	@Override
	public int boardViewUp(int boardid) {
		return dao.boardViewUp(boardid);
	}

	@Override
	public int boardDelete(int boardid) {
		return dao.boardDelete(boardid);
	}

	@Override
	public int boardUpdate(BoardDTO dto) {
		return dao.boardUpdate(dto);
	}

	@Override
	public List<BoardDTO> list(Criteria cri) throws Exception {
		return dao.list(cri);
	}

	@Override
	public int listCount() throws Exception {
		return dao.listCount();
	}
		
}
