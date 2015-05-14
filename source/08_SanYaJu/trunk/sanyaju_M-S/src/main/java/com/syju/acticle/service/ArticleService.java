/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;
import org.springside.modules.persistence.SearchFilter.Operator;

import com.syju.acticle.entity.Article;
import com.syju.acticle.entity.ArticleCategory;
import com.syju.acticle.repository.jpa.ArticleDao;
import com.syju.commons.service.CommonService;

/**
 * 文章管理-文章管理业务类.
 * 
 * @author 王德仁
 */
@Service
@Transactional
public class ArticleService extends CommonService {

	@Resource
	private ArticleDao articleDao;

	public Article getArticle(Long id) {
		return articleDao.findOne(id);
	}

	public void saveArticle(Article entity) {
		articleDao.save(entity);
	}

	public void deleteArticle(Long id) {
		articleDao.delete(id);
	}

	public boolean changeDisplay(Boolean isDisplay, Long id, Long catId) {
		ArticleCategory articleCategory = new ArticleCategory();
		articleCategory.setId(catId);
		Article article = articleDao.findOne(id);
		if (article != null) {
			article.setArticleCategory(articleCategory);
			article.setIsDisplay(isDisplay);
			articleDao.save(article);
			return true;
		}
		return false;
	}

	/*
	 * public boolean changeDisplay(Long id, boolean isDisplay) { try { articleDao.changeDisplay(isDisplay, id); return
	 * true; } catch (Exception e) { logger.error(e.getMessage()); return false; } }
	 */

	/**
	 * 根据类别id获取该类别下的文章 列表
	 * 
	 * @param catId
	 * @return
	 */
	public Page<Article> getArticleListByCategoryId(Long catId, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		return articleDao.findByArticleCategoryIdAndIsDisplay(catId, true, pageRequest);
	}

	/**
	 * 根据用户Id获取当前站点的栏目列表
	 * 
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Article> getArticlePage(Boolean isCustom, Map<String, Object> searchParams, int pageNumber,
			int pageSize, String sortType) {
		Specification<Article> spec = null;
		if (isCustom) {
			spec = buildSpecification(searchParams);
		} else {
			spec = buildSpecification(false, searchParams);
		}
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);

		return articleDao.findAll(spec, pageRequest);
	}

	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "title");
		} else if (StringUtils.isNotEmpty(sortType)) {
			String[] sortTypes = sortType.split("#");
			if ((null != sortTypes) && (sortTypes.length > 1)) {
				Direction direction = "ASC".equals((sortTypes[0]).toUpperCase()) ? Direction.ASC : Direction.DESC;
				sort = new Sort(direction, sortTypes[1]);
			}
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<Article> buildSpecification(Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		Specification<Article> spec = DynamicSpecifications.bySearchFilter(filters.values(), Article.class);
		return spec;
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<Article> buildSpecification(boolean isCustom, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("articleCategory.isCustom", new SearchFilter("articleCategory.isCustom", Operator.EQ, isCustom));
		Specification<Article> spec = DynamicSpecifications.bySearchFilter(filters.values(), Article.class);
		return spec;
	}
	// -----------------//
	// Setter methods //
	// -----------------//

}
