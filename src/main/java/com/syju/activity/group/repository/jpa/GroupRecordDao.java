/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.group.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.activity.group.entity.GroupActivity;
import com.syju.activity.special.entity.SpecialRecord;

public interface GroupRecordDao extends PagingAndSortingRepository<SpecialRecord, Long>,
		JpaSpecificationExecutor<SpecialRecord> {

	/**
	 * 通过外检关联查询 (团购活动列表)
	 * 
	 * @param pageable
	 * @return
	 */
	@Query("select sr from SpecialRecord sr,GroupActivity sa where sr.groupActivity.id = sa.id")
	Page<SpecialRecord> findByGroupId(Pageable pageable);
	
	/**
	 * 模糊查询
	 * 
	 * @param pageable
	 * @return
	 */
	@Query("select sr from SpecialRecord sr,GroupActivity sa where sr.groupActivity.id = sa.id and sr.name like ?1 and sa.title like ?2")
	Page<SpecialRecord> findByTitleAndName(String name,String title,Pageable pageable);
	
	
	/**
	 * 模糊查询
	 * 
	 * @param pageable
	 * @return
	 */
	@Query("select sr from SpecialRecord sr,GroupActivity sa where sr.groupActivity.id = sa.id and  sa.title like ?1")
	Page<SpecialRecord> findByTitle(String title,Pageable pageable);
	
	/**
	 * 模糊查询
	 * 
	 * @param pageable
	 * @return
	 */
	@Query("select sr from SpecialRecord sr,GroupActivity sa where sr.groupActivity.id = sa.id and  sr.name like ?1")
	Page<SpecialRecord> findByName(String name,Pageable pageable);

}
