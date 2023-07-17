package dto;

public class MovieCmtLikeDTO {
	int movieCommentid;
	String userid;
	
	public MovieCmtLikeDTO() {
		super();
	}
	public MovieCmtLikeDTO(int movieCommentid, String userid) {
		super();
		this.movieCommentid = movieCommentid;
		this.userid = userid;
	}
	public int getMovieCommentid() {
		return movieCommentid;
	}
	public void setMovieCommentid(int movieCommentid) {
		this.movieCommentid = movieCommentid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
