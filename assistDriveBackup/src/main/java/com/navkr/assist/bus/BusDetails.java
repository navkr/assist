package com.navkr.assist.bus;

import java.util.List;

import com.navkr.assist.commonservice.CommonServiceDetails;
import com.navkr.assist.node.Node;

public class BusDetails extends CommonServiceDetails {
	
	
	public BusDetails(String id, List<Node> nodeList, String frequency) {
		super(id, nodeList, frequency);
	}

}
