/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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

import com.syju.acticle.entity.ArticleCategory;
import com.syju.acticle.repository.jpa.ArticleCategoryDao;
import com.syju.commons.service.CommonService;

/**
 * 内容管理-类别管理业务类.
 * 
 * @author 王德仁
 */
// Spring Service Bean的标识.
@Service
@Transactional
public class ArticleCategoryService extends CommonService {

	@Resource
	private ArticleCategoryDao articleCategoryDao;

	public ArticleCategory getCategory(Long id) {
		return articleCategoryDao.findOne(id);
	}

	public boolean saveCategory(ArticleCategory articleCategory) {
		try {
			if (articleCategory.getPriority() == null) {
				articleCategory.setPriority(articleCategoryDao.getMaxPriority() + 1);
			}
			articleCategoryDao.save(articleCategory);
			return true;
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
	}

	public boolean deleteCategory(Long id) {
		articleCategoryDao.delete(id);
		return true;
	}

	public boolean deleteCategory(Long[] ids) {
		try {
			for (Long id : ids) {
				articleCategoryDao.delete(id);
			}
			return true;
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
	}

	public boolean changeDisplay(Long id, boolean isDisplay) {
		try {
			articleCategoryDao.findOne(id).setIsDisplay(isDisplay);
			return true;
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
	}

	/**
	 * 根据用户Id获取当前站点的类别列表
	 * 
	 * @param userId
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<ArticleCategory> getArticleCategoryPage(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		Specification<ArticleCategory> spec = buildSpecification(false, searchParams);
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);

		return articleCategoryDao.findAll(spec, pageRequest);
	}

	/**
	 * 根据用户Id获取当前站点的类别列表
	 * 
	 * @param userId
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public List<ArticleCategory> getAllUserArticleCategory(Long userId, Map<String, Object> searchParams) {
		Specification<ArticleCategory> spec = null;

		return articleCategoryDao.findAll(spec);
	}

	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("name".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<ArticleCategory> buildSpecification(Long siteId, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("siteConfig.id", new SearchFilter("siteConfig.id", Operator.EQ, siteId));
		Specification<ArticleCategory> spec = DynamicSpecifications.bySearchFilter(filters.values(),
				ArticleCategory.class);
		return spec;
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<ArticleCategory> buildSpecification(boolean isCustom, Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		filters.put("isCustom", new SearchFilter("isCustom", Operator.EQ, isCustom));
		Specification<ArticleCategory> spec = DynamicSpecifications.bySearchFilter(filters.values(),
				ArticleCategory.class);
		return spec;
	}

	public List<ArticleCategory> getArticleCategoryList(boolean isDisplay, boolean isCustom) {
		Map<String, SearchFilter> filters = new HashMap<String, SearchFilter>();
		filters.put("isDisplay", new SearchFilter("isDisplay", Operator.EQ, isDisplay));
		filters.put("isCustom", new SearchFilter("isCustom", Operator.EQ, isCustom));
		Specification<ArticleCategory> spec = DynamicSpecifications.bySearchFilter(filters.values(),
				ArticleCategory.class);
		return articleCategoryDao.findAll(spec, new Sort(Direction.DESC, "priority"));
	}
	// -----------------//
	// Setter methods //
	// -----------------//

}
