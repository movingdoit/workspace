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

import com.syju.activity.special.entity.SpecialRecord;

public interface SpecialRecordDao extends PagingAndSortingRepository<SpecialRecord, Long>,
		JpaSpecificationExecutor<SpecialRecord> {

	/**
	 * 通过外检关联查询 (专题活动列表)
	 * 
	 * @param name
	 * @param pageable
	 * @return
	 */
	@Query("select sr from SpecialRecord sr,SpecialActivity sa where sr.specialActivity.id = sa.id")
	Page<SpecialRecord> findSpecialRecords(Pageable pageable);

}
