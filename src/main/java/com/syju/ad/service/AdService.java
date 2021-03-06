/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.ad.service;

import java.util.Map;

import javax.annotation.Resource;

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

import com.syju.ad.entity.Ad;
import com.syju.ad.repository.jpa.AdDao;
import com.syju.commons.service.CommonService;

/**
 * 站点管理-幻灯片配置业务类.
 * 
 * @author 王德仁
 */
// Spring Service Bean的标识.
@Service("AdService")
@Transactional
@Monitored
public class AdService extends CommonService {

	@Resource
	private AdDao adDao;

	public Ad getAd(Long id) {
		return adDao.findOne(id);
	}

	public void saveAd(Ad entity) {
		adDao.save(entity);
	}

	public void deleteAd(Long id) {
		adDao.delete(id);
	}

	/**
	 * 根据用户Id获取当前站点的幻灯片列表
	 *
	 * @param userId
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Ad> getAd(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		Specification<Ad> spec = null;
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);

		return adDao.findAll(spec, pageRequest);
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
	private Specification<Ad> buildSpecification(Long siteId, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("siteConfig.id", new SearchFilter("siteConfig.id", Operator.EQ, siteId));
		Specification<Ad> spec = DynamicSpecifications.bySearchFilter(filters.values(), Ad.class);
		return spec;
	}

	// -----------------//
	// Setter methods //
	// -----------------//

}
