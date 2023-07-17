package controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.MovieDTO;
import main.MovieAPI;
import main.MovieDBMain;
import service.MovieDBService;

@Controller
public class MainController {
	@Autowired
	MovieDBService service;

    @GetMapping("/")
    public ModelAndView main() throws UnsupportedEncodingException {
    	//api호출
    	MovieAPI api = new MovieAPI();
    	String boxoffice = api.requestAPI();
    	
    	//movielist DB호출
    	String [] movies = boxoffice.split("\\|");
    	ArrayList<MovieDTO> movielist = new ArrayList<MovieDTO>();
    	
    	for(String movie : movies) {
    		String movieTitle = movie.split(",")[0];
    		String movieDate = movie.split(",")[1];
    		
    		MovieDTO dto = service.getMovieFromTitle(movieTitle);
    		
    		//현재 DB에 없는 영화일 경우 신규영화정보 불러와서 추가하기
    		if(dto == null) { 
    			ArrayList<MovieDTO> dtos = MovieDBMain.requestAPIone(movieTitle.replaceAll(" ", ""),movieDate.replaceAll("-", ""));
    			dto = dtos.get(0);
    			service.insertMovieDB(dto);
    			dto = service.getMovieFromTitle(movieTitle);
    		}
    		String poster = dto.getPosterurl().split("\\|")[0];
    		dto.setPosterurl(poster);
    		movielist.add(dto);
    	}
    	
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("boxofficelist",movielist);
    	mv.setViewName("main");
        return mv;
    }
    
    
}