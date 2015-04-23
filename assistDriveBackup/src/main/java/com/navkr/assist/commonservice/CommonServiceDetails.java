package com.navkr.assist.commonservice;

import java.util.List;

import com.navkr.assist.node.Node;

public class CommonServiceDetails {
	private String id;
	private List<Node> nodeList;
	private String frequency;
	
	public CommonServiceDetails(String id, List<Node> nodeList, String frequency) {
		this.id = id;
		this.nodeList = nodeList;
		this.frequency = frequency;
	}
	

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public List<Node> getNodeList() {
		return nodeList;
	}


	public void setNodeList(List<Node> nodeList) {
		this.nodeList = nodeList;
	}


	public String getFrequency() {
		return frequency;
	}


	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	
}
