/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.condition.repository.jpa;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.ad.entity.Ad;
import com.syju.condition.entity.SpecialHouse;

public interface SpecialHouseDao extends PagingAndSortingRepository<SpecialHouse, Long>,
		JpaSpecificationExecutor<SpecialHouse> {

	Page<Ad> findBySiteConfigId(Long id, Pageable pageRequest);

	// 验证标题是否存在
	SpecialHouse findBySpecialHouseTitle(String title);

	// 验证排序号是否存在
	List<SpecialHouse> findByPriority(Long priority);

	@Query("from SpecialHouse sh where sh.bindValue=?1 and sh.bindPath=?2 ")
	List<SpecialHouse> findSpecialHouseListByBindValue_BindPath(String bindValue, String bindPath);

	@Modifying
	@Query("delete from SpecialHouse sh where sh.bindValue=?1 and sh.bindPath=?2 ")
	int deleteSpecialHouseByBindValue_BindPath(String bindValue, String bindPath);

	// 批量修改 排序号 (插入排序号)
	@Modifying
	@Query("update SpecialHouse sh set sh.priority = sh.priority+1 where sh.priority >= ?1")
	int updateInsertPriority(Long priority);

	// 批量修改 排序号 (删除后，后面的排序号都减1)
	@Modifying
	@Query("update SpecialHouse sh set sh.priority = sh.priority-1 where sh.priority > ?1")
	int updateMovePriority(Long priority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（3跟5之间的值） priority-1)（例如：3改成5）
	@Modifying
	@Query("update SpecialHouse sh set sh.priority = sh.priority-1 where sh.priority > ?1 and sh.priority <= ?2")
	int updateASCPriority(Long oldPriority, Long newPriority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（5跟3之间的值） priority+1)（例如：5改成3）
	@Modifying
	@Query("update SpecialHouse sh set sh.priority = sh.priority+1 where sh.priority < ?1 and sh.priority >= ?2")
	int updateDESCPriority(Long oldPriority, Long newPriority);
}
