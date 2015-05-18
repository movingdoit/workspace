package com.syju.house.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.commons.service.CommonService;
import com.syju.house.entity.HouseMap;
import com.syju.house.repository.jpa.HouseMapDao;

@Service
@Transactional
public class HouseMapService extends CommonService {

	@Resource
	private HouseMapDao houseMapDao;

	public HouseMap saveHouseMap(HouseMap houseMap) {
		return houseMapDao.save(houseMap);
	}

	/**
	 * 通过外键查询
	 * 
	 * @param id
	 * @return
	 */
	public HouseMap findByHuoseId(Long id) {
		return houseMapDao.findByHouseInfoId(id);
	}
}
