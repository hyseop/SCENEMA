package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MovieLikeDTO;


@Repository
public class MovieLikeDAO {
	@Autowired
	SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}

	public int isMovieLike(MovieLikeDTO dto) {
		return session.selectOne("isMovieLike", dto);
	}

	public int insertMovieLike(MovieLikeDTO dto) {
		return session.insert("insertMovieLike", dto);
	}
	
	public int deleteMovieLike(MovieLikeDTO dto) {
		return session.delete("deleteMovieLike", dto);
	}
	
	public int countMovieLike(int movieid) {
		return session.selectOne("countMovieLike", movieid);
	}
	
	public List<MovieLikeDTO> listMovieLikeByUser(String userid) {
		return session.selectList("listMovieLikeByUser", userid);
	}
	
	public List<MovieLikeDTO> listMovieLikeByUserPaging(HashMap<String, Object> map) {
		return session.selectList("listMovieLikeByUserPaging", map);
	}
}
