/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.acticle.entity.Article;

public interface ArticleDao extends PagingAndSortingRepository<Article, Long>, JpaSpecificationExecutor<Article> {

	Page<Article> findByArticleCategoryId(Long id, Pageable pageRequest);

	Page<Article> findByArticleCategoryIdAndIsDisplay(Long id, boolean isDisplay, Pageable pageRequest);

	@Modifying
	@Query("update Article a set a.isDisplay =?1 where a.id =?2 ")
	int changeDisplay(Boolean isDisplay, Long id);
}
