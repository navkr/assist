package com.navkr.assist.bus;

import java.util.List;

import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class BusService {

	private static final Logger logger = Logger.getLogger(BusService.class);

	@Autowired
	BusDAO busDao;
	
	@Transactional
	public List<Object[]> getBasicDetails(String source, String destination) {
		return busDao.getBasicDetails(source, destination);
	}
	
	@Transactional
	public Object[] getFullDetails(String id) {
		return busDao.getFullDetails(id);
	}
	
}
