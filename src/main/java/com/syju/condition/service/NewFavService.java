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
import com.syju.condition.entity.NewFav;
import com.syju.condition.repository.jpa.NewFavDao;

/**
 * 推荐管理-最新优惠业务类.
 * 
 * @author zcm
 */
// Spring Service Bean的标识.
@Service("NewFavService")
@Transactional
@Monitored
public class NewFavService extends CommonService {

	// @Resource
	// private SiteConfigDao siteConfigDao;
	@Resource
	private NewFavDao newFavDao;

	public NewFav getNewFav(Long id) {
		return newFavDao.findOne(id);
	}

	public void saveNewFav(NewFav entity) {
		newFavDao.save(entity);
	}

	public void deleteNewFav(Long id) {
		newFavDao.delete(id);
	}

	// 验证排序号是否存在
	public NewFav checkPriority(Long priority) {
		NewFav siteSlide = newFavDao.findByPriority(priority);
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
		NewFav bean1 = newFavDao.findOne(id); // bean1表示当前的分类对象
		if ((bean1 != null)) {
			if (type.equals("up")) { // 上移
				NewFav bean2 = newFavDao.findByPriority(newFavDao.getMaxIndex(id));
				if (bean2 != null) { // bean2表示要和上一个排序号或下一个排序号的分类对象
					Long priority1 = bean1.getPriority();
					Long priority2 = bean2.getPriority();
					bean1.setPriority(priority2);
					bean2.setPriority(priority1);
				}
			} else if (type.equals("top")) { // 置顶

				Long priority = bean1.getPriority();

				newFavDao.updateTopPriority(priority);// 批量修改 priority + 1
				bean1.setPriority((long) 1);
				newFavDao.save(bean1);

			} else if (type.equals("down")) { // 置底
				Long priority = bean1.getPriority();

				newFavDao.updateDownPriority(priority);// 批量修改 priority + 1
				Long downPriority = newFavDao.getDownIndex(id);

				bean1.setPriority(downPriority + 1);
				newFavDao.save(bean1);
			}

			else { // 下移
				System.out.println(newFavDao.getMinIndex(id));
				NewFav bean2 = newFavDao.findByPriority(newFavDao.getMinIndex(id));
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
	 * @param oldPriority
	 *            //旧的排序号
	 * @param newPriority
	 *            //新的排序号
	 */
	public void sorting(Long oldPriority, Long newPriority) {
		if (oldPriority > newPriority) {
			newFavDao.updateDESCPriority(oldPriority, newPriority);
		} else if (oldPriority < newPriority) {
			newFavDao.updateASCPriority(oldPriority, newPriority);
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
		newFavDao.updateInsertPriority(priority);
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
		newFavDao.updateMovePriority(priority);
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
	public Page<NewFav> getNewFav(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		Specification<NewFav> spec = null;
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);

		return newFavDao.findAll(spec, pageRequest);
	}

	// 获取最大排序号
	public Long getMaxPriority() {
		Long index = newFavDao.getMaxPriority();
		if (index == null) {
			return 1L;
		}else{
			index=index+1;
		}
		return index;
	}

	/**
	 * 通过外键获取对象
	 * 
	 * @param id
	 * @return
	 */
	public NewFav findByHouse(Long id) {
		return newFavDao.findByHouseInfoId(id);
	}

	/**
	 * 组合查询
	 * 
	 * @param name
	 * @param pageNumber
	 * @param pagzSize
	 * @param sortType
	 * @return
	 */
	public Page<NewFav> findByNewFavAndHouse(String name, int pageNumber, int pagzSize, String sortType) {
		if (name != null) {
			name = "%" + name.trim() + "%";
		}
		PageRequest pageable = buildPageRequest(pageNumber, pagzSize, sortType);
		return newFavDao.findNewFavAndHouse(name, pageable);
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
	private Specification<NewFav> buildSpecification(Long siteId, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("siteConfig.id", new SearchFilter("siteConfig.id", Operator.EQ, siteId));
		Specification<NewFav> spec = DynamicSpecifications.bySearchFilter(filters.values(), NewFav.class);
		return spec;
	}

	// -----------------//
	// Setter methods //
	// -----------------//

}
