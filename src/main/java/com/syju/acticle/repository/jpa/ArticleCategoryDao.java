/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.repository.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.acticle.entity.ArticleCategory;

public interface ArticleCategoryDao extends PagingAndSortingRepository<ArticleCategory, Long>,
		JpaSpecificationExecutor<ArticleCategory> {

	@Query("from ArticleCategory category where category.isDisplay=true and category.isCustom!=true")
	List<ArticleCategory> findCategoryList(Long sitId);

	@Query("SELECT COALESCE(MAX(priority),0) FROM ArticleCategory")
	Long getMaxPriority();
}
