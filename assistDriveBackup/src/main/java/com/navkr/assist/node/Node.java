package com.navkr.assist.node;

public class Node {
	private String name;
	private String geoLocation;
	
	public Node(String name, String geoLocation) {
		this.name = name;
		this.geoLocation = geoLocation;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGeoLocation() {
		return geoLocation;
	}
	public void setGeoLocation(String geoLocation) {
		this.geoLocation = geoLocation;
	}
}
