/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.condition.service;

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

	// 验证排序号是否存在
	public SpecialHouse checkPriority(Long priority) {
		SpecialHouse siteSlide = specialHouseServiceDao.findByPriority(priority);
		return siteSlide;
	}

	/**
	 * <p>
	 * 上移，下移
	 * </p>
	 * 
	 * @param id
	 * @param type
	 */
	public void move(Long id, String type) {
		SpecialHouse bean1 = specialHouseServiceDao.findOne(id); // bean1表示当前的分类对象
		if ((bean1 != null)) {
			if (type.equals("up")) { // 上移
				SpecialHouse bean2 = specialHouseServiceDao.findByPriority(specialHouseServiceDao.getMaxIndex(id));
				if (bean2 != null) { // bean2表示要和上一个排序号或下一个排序号的分类对象
					Long priority1 = bean1.getPriority();
					Long priority2 = bean2.getPriority();
					bean1.setPriority(priority2);
					bean2.setPriority(priority1);
				}
			} else if (type.equals("top")) { // 置顶

				Long priority = bean1.getPriority();

				specialHouseServiceDao.updateTopPriority(priority);// 批量修改 priority + 1
				bean1.setPriority((long) 1);
				specialHouseServiceDao.save(bean1);

			} else if (type.equals("down")) { // 置底
				Long priority = bean1.getPriority();

				specialHouseServiceDao.updateDownPriority(priority);// 批量修改 priority + 1
				Long downPriority = specialHouseServiceDao.getDownIndex(id);

				bean1.setPriority(downPriority + 1);
				specialHouseServiceDao.save(bean1);
			}

			else { // 下移
				System.out.println(specialHouseServiceDao.getMinIndex(id));
				SpecialHouse bean2 = specialHouseServiceDao.findByPriority(specialHouseServiceDao.getMinIndex(id));
				if (bean2 != null) {
					Long priority1 = bean1.getPriority();
					Long priority2 = bean2.getPriority();
					bean1.setPriority(priority2);
					bean2.setPriority(priority1);
				}
			}
		}
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
	
	// 获取最大排序号
	public Long getMaxPriority(){
		Long index = specialHouseServiceDao.getMaxPriority();
		if(index==null){
			return 1L;
		}
		return index;
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
