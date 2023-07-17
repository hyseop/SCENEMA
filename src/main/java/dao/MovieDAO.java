package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MovieDTO;

@Repository
public class MovieDAO {
	@Autowired
	SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}

	public int insertMovieDB(MovieDTO dto) {
		return session.insert("insertMovieDB", dto);
	}
	
	public MovieDTO getMovieFromID(int movieid) {
		return session.selectOne("getMovieFromID",movieid);
	}
	
	public MovieDTO getMovieFromTitle(String title) {
		return session.selectOne("getMovieFromTitle",title);
	}

	public List<MovieDTO> getAllMovie() {
		return session.selectList("getAllMovie");
	}
	
	public List<MovieDTO> getGenreMovie(String genre) {
		return session.selectList("getGenreMovie", genre);
	}
	
	
}
