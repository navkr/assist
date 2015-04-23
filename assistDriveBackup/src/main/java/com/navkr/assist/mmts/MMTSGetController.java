package com.navkr.assist.mmts;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.navkr.assist.bus.BusDetails;
import com.navkr.assist.dto.AjaxObject;
import com.navkr.assist.node.Node;
import com.navkr.assist.node.NodeFactory;

@Controller
public class MMTSGetController {
	private static final Logger logger = Logger.getLogger(MMTSGetController.class);

	@Autowired
	MMTSService mmtsService;
	
	@RequestMapping(method = RequestMethod.POST, value = "getMMTS")
	public @ResponseBody AjaxObject getMMTS(
			@RequestParam String source,
			@RequestParam String destination,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("get train details");
		AjaxObject ao = new AjaxObject();
		MMTSFirstDisplay md = null;
		List<MMTSFirstDisplay> mdList = new ArrayList<MMTSFirstDisplay>();
		List<Object[]> mmtsDetails = mmtsService.getBasicDetails(source, destination);
		for(Object[] ob: mmtsDetails) {
			logger.info(ob[0] + " " + ob[1]) ;
			md = new MMTSFirstDisplay((String) ob[0], (String) ob[1]);
			mdList.add(md);
		}
		ao.setData(mdList);
		return ao;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "getTrainDetails")
	public @ResponseBody AjaxObject getService(
			@RequestParam String id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("train service id: " + id ); 
		AjaxObject ob = new AjaxObject();
		List<Node> ndList = new ArrayList<Node>();
		
		Object[] serviceDetails = mmtsService.getFullDetails(id);
		String route = (String) serviceDetails[0];
		String[] routeDetails = route.split(",");
		for(String nodeId: routeDetails) {
			System.out.println(nodeId);
			ndList.add(NodeFactory.getNodeDetails(nodeId));
		}
		MMTSDetails md = new MMTSDetails(id, ndList, Integer.toString((Integer) serviceDetails[1]));
		ob.setData(md);
		return ob;
	}
	
}
