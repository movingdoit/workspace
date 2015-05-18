package com.syju.house.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.commons.service.CommonService;
import com.syju.house.entity.PropertyInfo;
import com.syju.house.repository.jpa.PropertyDao;

@Service
@Transactional
public class PropertyService  extends CommonService{

	@Resource
	private PropertyDao propertyDao;
	
	public PropertyInfo saveProperty(PropertyInfo property){
		return propertyDao.save(property);
	}
	
	/**
	 * 通过外键查询
	 * @param id
	 * @return
	 */
	public PropertyInfo findByHuoseId(Long id){
		return propertyDao.findByHouseInfoId(id);
	}
}
