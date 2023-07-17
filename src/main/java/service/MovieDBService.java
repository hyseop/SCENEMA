package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MovieDAO;
import dto.MovieDTO;

@Service
public class MovieDBService {
	@Autowired
	MovieDAO dao;
	
	public int insertMovieDB(MovieDTO dto) {
		return dao.insertMovieDB(dto);
	}
	
	public MovieDTO getMovieFromID(int movieid) {
		return dao.getMovieFromID(movieid);
	}
	
	public MovieDTO getMovieFromTitle(String title) {
		return dao.getMovieFromTitle(title);
	}

	public List<MovieDTO> getAllMovie() {
		return dao.getAllMovie();
	}
	
	public List<MovieDTO> getGenreMovie(String genre){
		return dao.getGenreMovie(genre);
	}
	
}
