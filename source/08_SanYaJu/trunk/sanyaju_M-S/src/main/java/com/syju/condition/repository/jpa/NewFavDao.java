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

import com.syju.condition.entity.NewFav;

public interface NewFavDao extends PagingAndSortingRepository<NewFav, Long>, JpaSpecificationExecutor<NewFav> {

	Page<NewFav> findBySiteConfigId(Long id, Pageable pageRequest);

	// 验证标题是否存在
	NewFav findByNewFavTitle(String title);

	// 验证排序号是否存在
	List<NewFav> findByPriority(Long priority);

	@Query("from NewFav nf where nf.bindValue=?1 and nf.bindPath=?2 ")
	List<NewFav> findNewFavListByBindValue_BindPath(String bindValue, String bindPath);

	@Modifying
	@Query("delete from NewFav nf where nf.bindValue=?1 and nf.bindPath=?2 ")
	int deleteNewFavByBindValue_BindPath(String bindValue, String bindPath);

	// 批量修改 排序号 (插入排序号)
	@Modifying
	@Query("update NewFav nf set nf.priority = nf.priority+1 where nf.priority >= ?1")
	int updateInsertPriority(Long priority);

	// 批量修改 排序号 (删除后，后面的排序号都减1)
	@Modifying
	@Query("update NewFav nf set nf.priority = nf.priority-1 where nf.priority > ?1")
	int updateMovePriority(Long priority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（3跟5之间的值） priority-1)（例如：3改成5）
	@Modifying
	@Query("update NewFav nf set nf.priority = nf.priority-1 where nf.priority > ?1 and nf.priority <= ?2")
	int updateASCPriority(Long oldPriority, Long newPriority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（5跟3之间的值） priority+1)（例如：5改成3）
	@Modifying
	@Query("update NewFav nf set nf.priority = nf.priority+1 where nf.priority < ?1 and nf.priority >= ?2")
	int updateDESCPriority(Long oldPriority, Long newPriority);
}
