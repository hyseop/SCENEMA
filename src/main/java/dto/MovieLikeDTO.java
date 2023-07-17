package dto;

public class MovieLikeDTO {
	int movieid;
	String userid;
	
	public MovieLikeDTO() {
		super();
	}
	public MovieLikeDTO(int movieid, String userid) {
		super();
		this.movieid = movieid;
		this.userid = userid;
	}
	public int getMovieid() {
		return movieid;
	}
	public void setMovieid(int movieid) {
		this.movieid = movieid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
