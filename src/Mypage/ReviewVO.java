package Mypage;

import java.sql.Date;

public class ReviewVO {

	private String id;
	private int num;
	private String title;
	private String content;
	private Date date;
	private int pos;
	private int depte;




	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getPos() {
		return pos;
	}

	public void setPos(int pos) {
		this.pos = pos;
	}

	public int getDepte() {
		return depte;
	}

	public void setDepte(int depte) {
		this.depte = depte;
	}
	
}