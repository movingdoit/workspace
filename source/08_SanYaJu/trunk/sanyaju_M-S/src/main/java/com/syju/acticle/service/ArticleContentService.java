/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.acticle.entity.ArticleContent;
import com.syju.acticle.repository.jpa.ArticleContentDao;
import com.syju.commons.service.CommonService;

/**
 * 文章管理-文章管理业务类.
 * 
 * @author 王德仁
 */
@Service
@Transactional
public class ArticleContentService extends CommonService {

	@Resource
	private ArticleContentDao articleContentDao;

	public ArticleContent getArticleContent(Long id) {
		return articleContentDao.findOne(id);
	}

	public void saveArticleContent(ArticleContent entity) {
		articleContentDao.save(entity);
	}

	public void deleteArticleContent(Long id) {
		articleContentDao.delete(id);
	}

	// -----------------//
	// Setter methods //
	// -----------------//

}
