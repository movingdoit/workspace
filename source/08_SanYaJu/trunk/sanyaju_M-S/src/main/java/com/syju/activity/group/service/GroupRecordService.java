/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.group.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.javasimon.aop.Monitored;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;
import org.springside.modules.persistence.SearchFilter.Operator;

import com.syju.activity.group.entity.GroupActivity;
import com.syju.activity.group.repository.jpa.GroupRecordDao;
import com.syju.activity.special.entity.SpecialRecord;
import com.syju.commons.service.CommonService;

/**
 * 楼盘活动-专题报名记录业务类
 * 
 * @author zcm
 */
@Transactional
@Service
public class GroupRecordService extends CommonService {

	@Resource
	private GroupRecordDao groupRecordDao;

	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public boolean delete(Long id){
		try{
		groupRecordDao.delete(id);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 查询团购
	 * @param params 查询条件
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<SpecialRecord> findByGroup(Map<String,Object> params,int pageNumber, int pageSize, String sortType)
	{
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String name = (String)params.get("EQ_name");
		String title = (String)params.get("EQ_title");
		
		if(StringUtils.isBlank(name)&&StringUtils.isBlank(title)){
			return groupRecordDao.findByGroupId(pageRequest);
		}else if(StringUtils.isBlank(name)){
			title="%"+(StringUtils.isBlank(title)?"":title)+"%";
			return groupRecordDao.findByTitle(title, pageRequest);
		}else if(StringUtils.isBlank(title)){
			name ="%"+(StringUtils.isBlank(name)?"":name)+"%";
			return groupRecordDao.findByName(name, pageRequest);
		}else{
			name ="%"+(StringUtils.isBlank(name)?"":name)+"%";
			title="%"+(StringUtils.isBlank(title)?"":title)+"%";
			return groupRecordDao.findByTitleAndName(name, title, pageRequest);
		}
	}
	

	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.ASC, "id");
		} else if ("slideTitle".equals(sortType)) {
			sort = new Sort(Direction.DESC, "slideTitle");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}
	
	
	
	

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<SpecialRecord> buildSpecification(Long siteId, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("siteConfig.id", new SearchFilter("siteConfig.id", Operator.EQ, siteId));
		Specification<SpecialRecord> spec = DynamicSpecifications.bySearchFilter(filters.values(), SpecialRecord.class);
		return spec;
	}

	// -----------------//
	// Setter methods //
	// -----------------//

}
