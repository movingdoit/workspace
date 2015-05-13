/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.condition.service;

import java.util.List;
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

import com.syju.commons.service.CommonService;
import com.syju.condition.entity.SpecialHouse;
import com.syju.condition.repository.jpa.SpecialHouseDao;

/**
 * 推荐管理-特价楼盘业务类.
 * 
 * @author zcm
 */
// Spring Service Bean的标识.
@Service("SpecialHouseService")
@Transactional
@Monitored
public class SpecialHouseService extends CommonService {

	// @Resource
	// private SiteConfigDao siteConfigDao;
	@Resource
	private SpecialHouseDao specialHouseServiceDao;

	public SpecialHouse getSpecialHouse(Long id) {
		return specialHouseServiceDao.findOne(id);
	}

	public void saveSpecialHouse(SpecialHouse entity) {
		specialHouseServiceDao.save(entity);
	}

	public void deleteSpecialHouse(Long id) {
		specialHouseServiceDao.delete(id);
	}

	// 验证轮播图标题是否存在
	public SpecialHouse checkTitle(String title) {
		SpecialHouse siteSlide = specialHouseServiceDao.findBySpecialHouseTitle(title);
		return siteSlide;
	}

	// 验证排序号是否存在
	public List<SpecialHouse> checkPriority(Long priority) {
		List<SpecialHouse> siteSlideList = specialHouseServiceDao.findByPriority(priority);
		return siteSlideList;
	}

	/**
	 * <p>
	 * 排序，可以输入排序号，进行排序
	 * </p>
	 * 
	 * @param oldPriority //旧的排序号
	 * @param newPriority //新的排序号
	 */
	public void sorting(Long oldPriority, Long newPriority) {
		if (oldPriority > newPriority) {
			specialHouseServiceDao.updateDESCPriority(oldPriority, newPriority);
		} else if (oldPriority < newPriority) {
			specialHouseServiceDao.updateASCPriority(oldPriority, newPriority);
		}
	}

	/**
	 * <p>
	 * 创建轮播图时，插入排序号，排序
	 * </p>
	 * 
	 * @param priority
	 * 
	 */
	public void insertSorting(Long priority) {
		specialHouseServiceDao.updateInsertPriority(priority);
	}

	/**
	 * <p>
	 * 删除轮播图时，它后面的排序号都减1
	 * </p>
	 * 
	 * @param priority
	 * 
	 */
	public void moveSorting(Long priority) {
		specialHouseServiceDao.updateMovePriority(priority);
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
	public Page<SpecialHouse> getSpecialHouse(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		Specification<SpecialHouse> spec = null;
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);

		return specialHouseServiceDao.findAll(spec, pageRequest);
	}

	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.ASC, "priority");
		} else if ("slideTitle".equals(sortType)) {
			sort = new Sort(Direction.DESC, "slideTitle");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<SpecialHouse> buildSpecification(Long siteId, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("siteConfig.id", new SearchFilter("siteConfig.id", Operator.EQ, siteId));
		Specification<SpecialHouse> spec = DynamicSpecifications.bySearchFilter(filters.values(), SpecialHouse.class);
		return spec;
	}

	// -----------------//
	// Setter methods //
	// -----------------//

}
