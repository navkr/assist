package com.navkr.assist.bus;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BusDAO {

	private static final Logger logger = Logger.getLogger(BusService.class);

	@Autowired
	SessionFactory sessionFactory;
	
	public List<Object[]> getBasicDetails(String source, String destination) {
		Session session = sessionFactory.getCurrentSession();
		String queryString = "select b.id, b.route_summary from bus_routes r, bus b where b.id in (r.bus_numbers) and r.source_node = :source and r.destination_node = :destination";
		SQLQuery query = session.createSQLQuery(queryString);
		query.setParameter("source", Integer.parseInt(source));
		query.setParameter("destination", Integer.parseInt(destination));
		return query.list();
	}
	
	public Object[] getFullDetails(String id) {
		Session session = sessionFactory.getCurrentSession();
		String queryString = "select b.route_description,b.frequency from bus b where b.id = :id";
		SQLQuery query = session.createSQLQuery(queryString);
		query.setParameter("id", id);
		List<Object[]> details  = query.list();
		return details.get(0);
	}
	
}
