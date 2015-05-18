package com.syju.house.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.commons.service.CommonService;
import com.syju.house.entity.BuildInfo;
import com.syju.house.repository.jpa.BuildDao;

@Service
@Transactional
public class BuildService  extends CommonService{

	@Resource
	private BuildDao buildDao;
	
	public BuildInfo saveBulid(BuildInfo bulid){
		return buildDao.save(bulid);
	}
	
	/**
	 * 通过外键查询
	 * @param id
	 * @return
	 */
	public BuildInfo findByHouseId(Long id){
		return buildDao.findByHouseInfoId(id);
	}
	
}
