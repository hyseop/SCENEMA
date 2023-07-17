package dto;

public class BoardCommentDTO {
	int commentid, boardid;
	String userid, bcCreateAt, contents;
	
	public int getCommentid() {
		return commentid;
	}

	public void setCommentid(int commentid) {
		this.commentid = commentid;
	}

	public int getBoardid() {
		return boardid;
	}

	public void setBoardid(int boardid) {
		this.boardid = boardid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getBcCreateAt() {
		return bcCreateAt;
	}

	public void setBcCreateAt(String bcCreateAt) {
		this.bcCreateAt = bcCreateAt;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
}
