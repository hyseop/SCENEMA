package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MovieCommentDTO;

@Repository
public class MovieCommentDAO {
	@Autowired
	SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}

	public int insertMovieComment(MovieCommentDTO dto) {
		return session.insert("insertMovieComment", dto);
	}
	
	public List<MovieCommentDTO> getMovieComments(int movieid){
		return session.selectList("getMovieComments", movieid);
	}

	public List<MovieCommentDTO> getPagingComments(HashMap<String, Integer> map){
		return session.selectList("getPagingComments", map);
	}
	
	public double getMovieScore(int movieid) {
		return session.selectOne("getMovieScore", movieid);
	}
	
	public int getCommentsCount(int movieid) {
		return session.selectOne("getCommentsCount", movieid);
	}
	
	public int deleteComment(int movieCommentid) {
		return session.delete("deleteComment",movieCommentid);
	}
	
	public int updateLikeUp(int movieCommentid) {
		return session.update("updateLikeUp", movieCommentid);
	}

	public int updateLikeDown(int movieCommentid) {
		return session.update("updateLikeDown", movieCommentid);
	}
}
