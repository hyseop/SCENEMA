package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.BoardDTO;
import dto.Criteria;

@Repository
public class BoardDAO {
	
	@Autowired
	SqlSession session;
	
	public int boardWriting(BoardDTO dto) {
		return session.insert("boardWriting", dto);
	}
	
	public List<BoardDTO> getBoardList(BoardDTO dto) {
        return session.selectList("getBoardList", dto);
    }
	
    public List<BoardDTO> getBoardListById(int boardid){
    	return session.selectList("getBoardListById", boardid);
    }

    public int boardViewUp(int boardid){
    	return session.update("boardViewUp", boardid);
    }

    public int boardUpdate(BoardDTO dto){
    	return session.update("boardUpdating", dto);
    }

    public int boardDelete(int boardid){
    	return session.delete("boardDelete", boardid);
    }
    
    public List<BoardDTO> list(Criteria cri) throws Exception{
    	return session.selectList("listPage", cri);
    }
    
    public int listCount() throws Exception {
    	return session.selectOne("listCount");
    }
    
}
