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

import com.syju.condition.entity.SpecialHouse;

public interface SpecialHouseDao extends PagingAndSortingRepository<SpecialHouse, Long>,
		JpaSpecificationExecutor<SpecialHouse> {

	// 验证排序号是否存在
	SpecialHouse findByPriority(Long priority);

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

	// 根据ID查询出排序号，然后找出小于当前排序号的最大排序号（用来上移）
	@Query("select MAX(priority) from SpecialHouse where priority < (select priority from SpecialHouse where id=?1)")
	Long getMaxIndex(Long id);

	// 根据ID查询出排序号，然后找出大于当前排序号的最小排序号（用来下移）
	@Query("select MIN(priority) from SpecialHouse where priority > (select priority from SpecialHouse where id=?1)")
	Long getMinIndex(Long id);

	// 根据ID查询出排序号，然后找出小于当前排序号的最小排序号（用来置顶）
	@Query("select MIN(priority) from SpecialHouse where priority < (select priority from SpecialHouse where id=?1)")
	Long getTopIndex(Long id);

	// 根据ID查询出排序号，然后找出大于当前排序号的最大排序号（用来置底）
	@Query("select MAX(priority) from SpecialHouse where priority > (select priority from SpecialHouse where id=?1)")
	Long getDownIndex(Long id);

	// 批量修改 排序号 (置顶)
	@Modifying
	@Query("update SpecialHouse sh set sh.priority = sh.priority+1 where sh.priority < ?1")
	int updateTopPriority(Long priority);

	// 批量修改 排序号 (置底)
	@Modifying
	@Query("update SpecialHouse sh set sh.priority = sh.priority-1 where sh.priority > ?1")
	int updateDownPriority(Long priority);

	// 获取最大排序号
	@Query("select MAX(priority) from SpecialHouse ")
	Long getMaxPriority();

	// 通过外键查找
	SpecialHouse findByHouseInfoId(Long id);

	@Modifying
	@Query("delete from  SpecialHouse sh  where sh.houseInfo.id = ?1")
	int deleteByHouse(Long id);

	@Query("select s from SpecialHouse s, HouseInfo h where s.houseInfo.id = h.id and h.name like ?1 ")
	Page<SpecialHouse> findBySpecialHouseAndHouse(String name, Pageable pageRequest);
	
	@Query("select s from SpecialHouse s, HouseInfo h where s.houseInfo.id = h.id ")
	List<SpecialHouse> findBySpecialHouseAndHouse();

}
