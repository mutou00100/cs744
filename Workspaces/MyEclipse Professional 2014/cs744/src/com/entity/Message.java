package com.entity;

import java.sql.Date;

public class Message {
	private Date id;
	public Date getId() {
		return id;
	}
	public void setId(Date id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getOrigin() {
		return origin;
	}
	public void setOrigin(int origin) {
		this.origin = origin;
	}
	public int getDestination() {
		return destination;
	}
	public void setDestination(int destination) {
		this.destination = destination;
	}
	private String content;
	private int origin;
	private int destination;
}
