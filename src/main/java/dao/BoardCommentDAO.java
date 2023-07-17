package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.BoardCommentDTO;

@Repository
public class BoardCommentDAO {
	@Autowired
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<BoardCommentDTO> getCommentsByBoardId(int boardid){
		return sqlSession.selectList("getCommentsByBoardId", boardid);
	}

    public int insertBoardComment(BoardCommentDTO comment) {
    	 return sqlSession.insert("insertBoardComment", comment);
    }

}
