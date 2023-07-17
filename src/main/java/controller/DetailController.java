package controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.MovieCmtLikeDTO;
import dto.MovieCommentDTO;
import dto.MovieDTO;
import dto.MovieLikeDTO;
import service.MovieCmtLikeService;
import service.MovieCommentService;
import service.MovieDBService;
import service.MovieLikeService;

@Controller
public class DetailController {
	@Autowired
	MovieDBService service;
	@Autowired
	MovieCommentService service_c;
	@Autowired
	MovieLikeService service_like;
	@Autowired
	MovieCmtLikeService service_cmtlike;
	
	
	@RequestMapping("/detailpage")
	public ModelAndView detailPage(int movieid, HttpSession session,
			@RequestParam(value="page", required=false, defaultValue="1" ) int page) {
		
		//user정보저장
		String userid = (String) session.getAttribute("userid");
		
		MovieDTO dto = service.getMovieFromID(movieid);
		
		//포스터 및 스틸컷 하나씩 별도 분리
		String posters [] = dto.getPosterurl().split("\\|");
		String stillcuts [] = dto.getStillcuturls().split("\\|");
		
		//View에 보일 날짜 형식 바꾸기
		String year = dto.getReleaseDate().substring(0, 4);
		String month = dto.getReleaseDate().substring(4, 6);
		String day = dto.getReleaseDate().substring(6, 8);
		dto.setReleaseDate(year+"."+month+"."+day);
		
		//Video url
		String newVideoUrls = dto.getVideourl();
		String newVideos [] = newVideoUrls.split("\\|");
		
		//영화 평점
		String movieScore = "0";
		int commentsCount = 0;
		int pageblock = page/10;
		int maxpage = 0;
		
		List<MovieCommentDTO> comments = null;
		
		if(service_c.getCommentsCount(movieid)!=0) {
			//영화 평점
			if(service_c.getMovieScore(movieid)==10) {
				movieScore = String.format("%.0f",service_c.getMovieScore(movieid));
			}else {
				movieScore = String.format("%.1f",service_c.getMovieScore(movieid));
			}
			
			//영화 평점댓글 페이징
			commentsCount = service_c.getCommentsCount(movieid); //전체 영화 댓글 개수
			maxpage = commentsCount%10!=0?commentsCount/10+1:commentsCount%10;
		
			HashMap<String, Integer> cmtmap = new HashMap<String, Integer>();
			cmtmap.put("movieid", movieid);
			cmtmap.put("page",(page-1)*10);
			cmtmap.put("limit",10);
		
			comments = service_c.getPagingComments(cmtmap); // 댓글 리스트(page=1)
			//댓글 시간변경
			for(MovieCommentDTO cmts : comments) {
				String str = cmts.getCreateAt();
				str = str.substring(0,str.lastIndexOf(" "));
				cmts.setCreateAt(str);
			
				//댓글좋아요검사
				MovieCmtLikeDTO cmt_like_dto = new MovieCmtLikeDTO(cmts.getMovieCommentid(), userid);
				int cmtslike = service_cmtlike.countMovieCmtLike(cmts.getMovieCommentid());
				cmts.setLike(cmtslike);
				if(service_cmtlike.isMovieCmtLike(cmt_like_dto) != 0) {
					cmts.setHate(service_cmtlike.isMovieCmtLike(cmt_like_dto));
				}
			}
			
		}
		
		//영화좋아요
		MovieLikeDTO movielikedto = new MovieLikeDTO(movieid, userid);
		int ismovielike = service_like.isMovieLike(movielikedto);
		int movielikecount = service_like.countMovieLike(movieid);
		
		
		//ModelAndView 객체
		ModelAndView mv = new ModelAndView();
		
		//Movie정보
		mv.addObject("movie",dto);
		mv.addObject("posters", posters);
		mv.addObject("stillcuts", stillcuts);
		mv.addObject("videos", newVideos);
		mv.addObject("ismovielike", ismovielike);
		mv.addObject("movielikecount", movielikecount);
		
		//Comment정보
		mv.addObject("comments", comments);
		mv.addObject("commentsCount", commentsCount);
		
		//page정보
		mv.addObject("currentpage", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", 1);
		mv.addObject("endpage", 10);
		
		mv.addObject("pageblock", pageblock);
		mv.addObject("movieScore", movieScore);
		
//		mv.setViewName("test");
		mv.setViewName("DetailPage");
		return mv;
	}
	
	//영화좋아요처리
	@GetMapping("/movielike")
    public @ResponseBody MovieLikeDTO movielike(int movieid, HttpSession session) {
    	String userid = (String) session.getAttribute("userid");
		MovieLikeDTO dto = new MovieLikeDTO(movieid, userid);
    	
    	if(service_like.isMovieLike(dto) == 0) {
    		service_like.insertMovieLike(dto);
    		session.setAttribute("ismovielike", 1);
    	}else {
    		service_like.deleteMovieLike(dto);
    		session.setAttribute("ismovielike", 0);
    	}
        return dto;
    }
	
	//댓글좋아요처리
	@GetMapping("/moviecommentlike")
    public @ResponseBody MovieCmtLikeDTO moviecmtlike(int moviecommentid, HttpSession session) {
    	String userid = (String) session.getAttribute("userid");
		MovieCmtLikeDTO dto = new MovieCmtLikeDTO(moviecommentid, userid);
    	if(service_cmtlike.isMovieCmtLike(dto) == 0) {
    		service_cmtlike.insertMovieCmtLike(dto);
    		service_c.updateLikeUp(moviecommentid);
    	}else {
    		service_cmtlike.deleteMovieCmtLike(dto);
    		service_c.updateLikeDown(moviecommentid);
    	}
        return dto;
    }
	
	//평점댓글 작성
	@RequestMapping(value="/commentinsert", produces = {"application/json;charset=utf-8"})
	public @ResponseBody List<MovieCommentDTO> detailComment(int movieid, int score, String contents,HttpSession session) {
		MovieCommentDTO dto = new MovieCommentDTO();
		dto.setMovieid(movieid);
		dto.setContents(contents);
		dto.setUserid((String)session.getAttribute("userid"));
		dto.setScore(score);
		
		service_c.insertMovieComment(dto);
		
		List<MovieCommentDTO> comments_new = service_c.getMovieComments(movieid);
		
		return comments_new;
	}
	
	//평점댓글 페이징처리
	@RequestMapping(value="/commentpaging", produces = {"application/json;charset=utf-8"})
	public @ResponseBody String detailComment(int page, HttpSession session) {
		session.setAttribute("currentpage", page);
		return "{\"page\":"+page+"}";
	}
	
	//평점댓글 페이징처리 ( > )
	@RequestMapping(value="/commentpagingnext", produces = {"application/json;charset=utf-8"})
	public @ResponseBody String nextPagingComment(int page, int maxpage, HttpSession session) {
		int startpage = page+1;
		
		if(startpage < maxpage) {
			session.setAttribute("startpage", startpage);
			int endpage = startpage+9>maxpage?maxpage:startpage+9;
			session.setAttribute("endpage", endpage);
			session.setAttribute("currentpage", startpage);
		}else {
			startpage = page;
		}
		return "{\"startpage\":"+startpage+"}";
	}
	
	//평점댓글 페이징처리 ( < )
	@RequestMapping(value="/commentpagingprev", produces = {"application/json;charset=utf-8"})
	public @ResponseBody String prevPagingComment(int page, HttpSession session) {
		int startpage = 1;
		if(page!=1) {
			startpage = page-10;
			session.setAttribute("startpage", startpage);
			session.setAttribute("endpage", startpage+9);
			session.setAttribute("currentpage", startpage);
		}
		return "{\"startpage\":"+startpage+"}";
	}
	
	//평점댓글 삭제
	@RequestMapping(value="/commentdelete", produces = {"application/json;charset=utf-8"})
	public String deleteComment(int movieid, int moviecommentid) {
		service_c.deleteComment(moviecommentid);
		return "redirect:/detailpage?movieid="+movieid;
	}
    
}
