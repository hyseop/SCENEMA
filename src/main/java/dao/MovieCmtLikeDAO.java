package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MovieCmtLikeDTO;


@Repository
public class MovieCmtLikeDAO {
	@Autowired
	SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}

	public int isMovieCmtLike(MovieCmtLikeDTO dto) {
		return session.selectOne("isMovieCmtLike", dto);
	}

	public int insertMovieCmtLike(MovieCmtLikeDTO dto) {
		return session.insert("insertMovieCmtLike", dto);
	}
	
	public int deleteMovieCmtLike(MovieCmtLikeDTO dto) {
		return session.delete("deleteMovieCmtLike", dto);
	}
	
	public int countMovieCmtLike(int movieid) {
		return session.selectOne("countMovieCmtLike", movieid);
	}
}
