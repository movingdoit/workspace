/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.condition.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.condition.entity.HouseRecommend;
import com.syju.condition.entity.NewFav;
import com.syju.condition.entity.NewGuide;

public interface HouseRecommendDao extends PagingAndSortingRepository<HouseRecommend, Long>,
		JpaSpecificationExecutor<HouseRecommend> {

	// 验证排序号是否存在
	HouseRecommend findByPriority(Long priority);

	// 批量修改 排序号 (插入排序号)
	@Modifying
	@Query("update HouseRecommend hr set hr.priority = hr.priority+1 where hr.priority >= ?1")
	int updateInsertPriority(Long priority);

	// 批量修改 排序号 (删除后，后面的排序号都减1)
	@Modifying
	@Query("update HouseRecommend hr set hr.priority = hr.priority-1 where hr.priority > ?1")
	int updateMovePriority(Long priority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（3跟5之间的值） priority-1)（例如：3改成5）
	@Modifying
	@Query("update HouseRecommend hr set hr.priority = hr.priority-1 where hr.priority > ?1 and hr.priority <= ?2")
	int updateASCPriority(Long oldPriority, Long newPriority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（5跟3之间的值） priority+1)（例如：5改成3）
	@Modifying
	@Query("update HouseRecommend hr set hr.priority = hr.priority+1 where hr.priority < ?1 and hr.priority >= ?2")
	int updateDESCPriority(Long oldPriority, Long newPriority);

	// 根据ID查询出排序号，然后找出小于当前排序号的最大排序号（用来上移）
	@Query("select MAX(priority) from HouseRecommend where priority < (select priority from HouseRecommend where id=?1)")
	Long getMaxIndex(Long id);

	// 根据ID查询出排序号，然后找出大于当前排序号的最小排序号（用来下移）
	@Query("select MIN(priority) from HouseRecommend where priority > (select priority from HouseRecommend where id=?1)")
	Long getMinIndex(Long id);

	// 根据ID查询出排序号，然后找出小于当前排序号的最小排序号（用来置顶）
	@Query("select MIN(priority) from HouseRecommend where priority < (select priority from HouseRecommend where id=?1)")
	Long getTopIndex(Long id);

	// 根据ID查询出排序号，然后找出大于当前排序号的最大排序号（用来置底）
	@Query("select MAX(priority) from HouseRecommend where priority > (select priority from HouseRecommend where id=?1)")
	Long getDownIndex(Long id);

	// 批量修改 排序号 (置顶)
	@Modifying
	@Query("update HouseRecommend hr set hr.priority = hr.priority+1 where hr.priority < ?1")
	int updateTopPriority(Long priority);

	// 批量修改 排序号 (置底)
	@Modifying
	@Query("update HouseRecommend hr set hr.priority = hr.priority-1 where hr.priority > ?1")
	int updateDownPriority(Long priority);
	
	// 获取最大排序号
	@Query("select MAX(priority) from HouseRecommend ")
	Long getMaxPriority();

	
	/**
	 * 通过外检删除
	 * 
	 * @param id
	 * @return
	 */
	@Modifying
	@Query("delete from  HouseRecommend sh  where sh.houseInfo.id = ?1")
	int deleteByHouse(Long id);
	// 通过外键查找
	HouseRecommend findByHouseInfoId(Long id);
	/**
	 * 通过外检关联查询
	 * 
	 * @param name
	 * @param pageable
	 * @return
	 */
	@Query("select s from HouseRecommend s,HouseInfo h where s.houseInfo.id = h.id and h.name like ?1 ")
	Page<HouseRecommend> findHouseRecommendAndHouse(String name, Pageable pageable);
}
