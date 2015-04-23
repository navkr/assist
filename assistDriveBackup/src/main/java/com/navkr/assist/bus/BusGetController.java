package com.navkr.assist.bus;

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
import org.springframework.web.servlet.ModelAndView;

import com.navkr.assist.dto.AjaxObject;
import com.navkr.assist.node.Node;
import com.navkr.assist.node.NodeFactory;

@Controller
public class BusGetController {
	private static final Logger logger = Logger.getLogger(BusService.class);

	@Autowired
	BusService busService;
	
	@RequestMapping(method = RequestMethod.POST, value = "getBus")
	public @ResponseBody AjaxObject getBus(
			@RequestParam String source,
			@RequestParam String destination,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("get bus details");
		AjaxObject ao = new AjaxObject();
		BusFirstDisplay bd = null;
		List<BusFirstDisplay> bdList = new ArrayList<BusFirstDisplay>();
		List<Object[]> busDetails = busService.getBasicDetails(source, destination);
		for(Object[] ob: busDetails) {
			logger.info(ob[0] + " " + ob[1]) ;
			bd = new BusFirstDisplay((String) ob[0], (String) ob[1]);
			bdList.add(bd);
		}
		ao.setData(bdList);
		return ao;
	}
	
	
	@RequestMapping(method = RequestMethod.GET, value = "assist")
	public ModelAndView showHomePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("index");
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "getBusDetails")
	public @ResponseBody AjaxObject getService(
			@RequestParam String id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("service id: " + id ); 
		AjaxObject ob = new AjaxObject();
		List<Node> ndList = new ArrayList<Node>();
		
		Object[] serviceDetails = busService.getFullDetails(id);
		String route = (String) serviceDetails[0];
		String[] routeDetails = route.split(",");
		for(String nodeId: routeDetails) {
			ndList.add(NodeFactory.getNodeDetails(nodeId));
		}
		BusDetails bd = new BusDetails(id, ndList, Integer.toString((Integer) serviceDetails[1]));
		ob.setData(bd);
		return ob;
	}
}
