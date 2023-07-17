package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.MovieDTO;
import main.MovieAPI;
import service.MovieDBService;

@Controller
public class MovieController {
	@Autowired
	MovieDBService service;

    @GetMapping("/movielist")
    public ModelAndView main() {
    	List<MovieDTO> movielist_action = service.getGenreMovie("액션");
    	List<MovieDTO> movielist_fantasy = service.getGenreMovie("판타지");
    	List<MovieDTO> movielist_drama = service.getGenreMovie("드라마");
    	List<MovieDTO> movielist_family = service.getGenreMovie("가족");
    	
    	ArrayList<List<MovieDTO>> movielist = new ArrayList<List<MovieDTO>>();
    	movielist.add(movielist_action);
    	movielist.add(movielist_fantasy);
    	movielist.add(movielist_drama);
    	movielist.add(movielist_family);
    	
    	for(List<MovieDTO> list : movielist) {
    		for(MovieDTO dto : list) {
    			String poster = dto.getPosterurl().split("\\|")[0];
    			dto.setPosterurl(poster);
    		}
    	}
    	
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("movielist",movielist);
    	mv.addObject("movielist_action",movielist_action);
    	mv.addObject("movielist_fantasy",movielist_fantasy);
    	mv.addObject("movielist_drama",movielist_drama);
    	mv.addObject("movielist_family",movielist_family);
    	mv.setViewName("movielist");
        return mv;
    }
}