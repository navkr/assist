package com.navkr.assist.mmts;

import java.util.List;

import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MMTSService {

	private static final Logger logger = Logger.getLogger(MMTSService.class);

	@Autowired
	MMTSDAO mmtsDao;
	
	@Transactional
	public List<Object[]> getBasicDetails(String source, String destination) {
		return mmtsDao.getBasicDetails(source, destination);
	}
	
	@Transactional
	public Object[] getFullDetails(String id) {
		return mmtsDao.getFullDetails(id);
	}
	
}
