package com.syju.house.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.commons.service.CommonService;
import com.syju.house.entity.HouseIntroduce;
import com.syju.house.repository.jpa.HouseIntroduceDao;

@Service
@Transactional
public class HouseIntroduceService  extends CommonService{

	@Resource
	private HouseIntroduceDao houseIntroduceDao;
	
	public HouseIntroduce saveHouseIntroduce(HouseIntroduce introduce){
		return houseIntroduceDao.save(introduce);
		
	}
	
	/**
	 * 通过外键查询简介
	 * @param id
	 * @return
	 */
	public HouseIntroduce findByHouseId(Long id){
		return houseIntroduceDao.findByHouseInfoId(id);
	}
	
}
