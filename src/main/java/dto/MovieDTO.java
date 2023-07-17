package dto;

import org.springframework.stereotype.Component;

@Component
public class MovieDTO {
	int movieid;
	String title, titleEng, story, genre;
	int runtime;
	String director, releaseDate, rating, posterurl, stillcuturls, videourl;
	int comments, movielike;
	float score;
	
	public int getMovieid() {
		return movieid;
	}
	public void setMovieid(int movieid) {
		this.movieid = movieid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTitleEng() {
		return titleEng;
	}
	public void setTitleEng(String titleEng) {
		this.titleEng = titleEng;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getRuntime() {
		return runtime;
	}
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getPosterurl() {
		return posterurl;
	}
	public void setPosterurl(String posterurl) {
		this.posterurl = posterurl;
	}
	public String getStillcuturls() {
		return stillcuturls;
	}
	public void setStillcuturls(String stillcuturls) {
		this.stillcuturls = stillcuturls;
	}
	public String getVideourl() {
		return videourl;
	}
	public void setVideourl(String videourl) {
		this.videourl = videourl;
	}
	public int getComments() {
		return comments;
	}
	public void setComments(int comments) {
		this.comments = comments;
	}
	public int getMovielike() {
		return movielike;
	}
	public void setMovielike(int movielike) {
		this.movielike = movielike;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	
}
