package com.syju.house.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.commons.service.CommonService;
import com.syju.house.entity.HouseRim;
import com.syju.house.repository.jpa.HouseRimDao;

@Service
@Transactional
public class HouseRimService extends CommonService {

	@Resource
	private HouseRimDao houseRimDao;

	public HouseRim saveHouseRim(HouseRim houseRim) {
		return houseRimDao.save(houseRim);
	}

	/**
	 * 通过外键查询
	 * 
	 * @param id
	 * @return
	 */
	public HouseRim findByHuoseId(Long id) {
		return houseRimDao.findByHouseInfoId(id);
	}
}
