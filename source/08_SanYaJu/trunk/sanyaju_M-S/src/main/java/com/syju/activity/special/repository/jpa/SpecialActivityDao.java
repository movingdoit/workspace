/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.activity.special.entity.SpecialActivity;

public interface SpecialActivityDao extends PagingAndSortingRepository<SpecialActivity, Long>,
		JpaSpecificationExecutor<SpecialActivity> {
	/**
	 * 通过外检关联查询 (模板一)
	 * 
	 * @param pageable
	 * @return
	 */
	@Query("select sa from SpecialActivity sa,SpecialModelOne sm where sa.id = sm.specialActivity.id ")
	Page<SpecialActivity> findSpecialActivityAndSpecialModelOne(Pageable pageable);

	/**
	 * 通过外检关联查询 (模板二)
	 *
	 * @param pageable
	 * @return
	 */
	@Query("select sa from SpecialActivity sa,SpecialModelTwo sm where sa.id = sm.specialActivity.id ")
	Page<SpecialActivity> findSpecialActivityAndSpecialModelTwo(Pageable pageable);

}
