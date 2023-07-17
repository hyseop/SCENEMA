package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MovieCmtLikeDAO;
import dto.MovieCmtLikeDTO;

@Service
public class MovieCmtLikeService {
	@Autowired
	MovieCmtLikeDAO dao;
	
	public int isMovieCmtLike(MovieCmtLikeDTO dto) {
		return dao.isMovieCmtLike(dto);
	}
	
	public int insertMovieCmtLike(MovieCmtLikeDTO dto) {
		return dao.insertMovieCmtLike(dto);
	}
	
	public int deleteMovieCmtLike(MovieCmtLikeDTO dto) {
		return dao.deleteMovieCmtLike(dto);
	}
	
	public int countMovieCmtLike(int movieid) {
		return dao.countMovieCmtLike(movieid);
	}
	
}
