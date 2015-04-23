package com.navkr.assist.commonservice;

public class CommonFirstDisplay {
	private String id;
	private String routeSummary;
	
	public CommonFirstDisplay(String id, String routeSummary) {
		this.id = id;
		this.routeSummary = routeSummary;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRouteSummary() {
		return routeSummary;
	}
	public void setRouteSummary(String routeSummary) {
		this.routeSummary = routeSummary;
	}
}
