package com.navkr.assist.node;

import java.util.HashMap;
import java.util.Map;

public class NodeFactory {

	private static NodeFactory instance = null;
	private Map<String,Node> map = null;
	
	private NodeFactory() {
		map = new HashMap<String,Node>();
		map.put("0", new Node("Koti", "17.386027,78.486680"));
		map.put("1", new Node("Abids", "17.393144,78.476363"));
		map.put("2", new Node("Lakdikapool", "17.403655,78.465211"));
		map.put("3", new Node("MasabTank", "17.404465,78.452360"));
		
		map.put("3", new Node("koti andhra bank bus-stop","17.384707,78.484223"));
		map.put("3", new Node("koti medical college bus-stop","17.383361,78.483150"));
		map.put("3", new Node("abids general post office bus-stop","17.387776,78.476124"));
		map.put("3", new Node("abids hotel annapurna bus-stop","17.389112,78.473093"));
		map.put("3", new Node("nampally railway station bus-stop","17.395033,78.470312"));
		map.put("3", new Node("nampally public gardens bus-stop","17.396391,78.470867"));
		map.put("3", new Node("assembly bus-stop","17.400193,78.469913"));
		map.put("3", new Node("lakdikapool bus-stop","17.403377,78.465254"));
		map.put("3", new Node("lakdikapool red hills bus-stop","17.402842,78.460593"));
		map.put("3", new Node("masab tank ac guards substation bus-stop","17.402653,78.458346"));
		map.put("3", new Node("masab tank mahavir statue bus-stop","17.403124,78.456817"));
		map.put("3", new Node("masab tank bus-stop","17.404332,78.451780"));
		map.put("3", new Node("masab tank pension office bus-stop","17.407453,78.451123"));
		map.put("3", new Node("banjara hills kaman bus-stop","17.409429,78.437916"));
		map.put("3", new Node("banjara hills insert into node values(check-post road) bus-stop","17.416083,78.420085"));
		map.put("3", new Node("banjara hills road no-12 bhola nagar bus-stop","17.407914,78.450002"));
		map.put("3", new Node("jublee hills apollo hospital bus-stop","17.418643,78.412982"));
		map.put("3", new Node("jublee hills road no:1 journalist colony bus-stop","17.421319,78.410675"));
		map.put("3", new Node("jublee hills checkpost bus-stop","17.427446,78.414323"));
		map.put("3", new Node("jublee hills bus-stop","17.430174,78.410890"));
		map.put("3", new Node("jublee hilss odysis bus-stop","17.429724,78.409678"));
		map.put("3", new Node("jublee hills peddamma gudi bus-stop","17.432032,78.406861"));
		map.put("3", new Node("kavuri hills road no-36  bus-stop","17.437395,78.400220"));
		map.put("3", new Node("madhapur police station bus-stop","17.439450,78.395929"));
		map.put("3", new Node("madhapur petrol bunk bus-stop","17.441114,78.391431"));
		map.put("3", new Node("madhapur image gardens bus-stop","17.446473,78.384806"));
		map.put("3", new Node("hitech city shilparamam bus-stop","17.452230,78.380208"));
		map.put("3", new Node("hitech city s&p, capital iq bus-stop","17.457742,78.371518"));
		map.put("3", new Node("kothaguda bus-stop","17.458468,78.366953"));
		map.put("3", new Node("kothaguda miyapur road bus-stop","17.459400,78.366014"));
		map.put("3", new Node("kondapur cross road bus-stop","17.464077,78.366990"));
		
	}
	
	public static synchronized NodeFactory getInstance() {
		if(instance == null) {
			instance = new NodeFactory();
		}
		return instance;
	}
	
	public static Node getNodeDetails(String nodeId) {
		return NodeFactory.getInstance().map.get(nodeId);
	}
	
}
