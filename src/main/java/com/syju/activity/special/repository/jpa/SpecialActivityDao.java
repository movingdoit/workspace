/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.activity.special.entity.SpecialActivity;

public interface SpecialActivityDao extends PagingAndSortingRepository<SpecialActivity, Long>,
		JpaSpecificationExecutor<SpecialActivity> {

}
