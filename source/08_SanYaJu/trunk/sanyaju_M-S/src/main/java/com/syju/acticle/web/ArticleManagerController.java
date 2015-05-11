/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springside.modules.web.Servlets;

import com.syju.acticle.entity.Article;
import com.syju.acticle.entity.ArticleCategory;
import com.syju.acticle.service.ArticleCategoryService;
import com.syju.acticle.service.ArticleService;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping(value = "/article/manager")
public class ArticleManagerController extends BaseController {

	@Resource
	private ArticleService articleService;
	@Resource
	private ArticleCategoryService articleCategoryService;

	@RequestMapping(method = RequestMethod.GET)
	public String manager(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			@RequestParam(value = "custom", defaultValue = "0") Long custom, Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if ((null != searchParams) && StringUtils.isNotEmpty((String) searchParams.get("EQ_articleCategory.id"))) {
			Long catId = Long.parseLong((String) searchParams.get("EQ_articleCategory.id"));
			ArticleCategory articleCategory = articleCategoryService.getCategory(catId);
			model.addAttribute("articleCategory", articleCategory);
		}

		// 定制栏目
		model.addAttribute("custom", custom);

		Page<Article> articles = articleService.getArticlePage(false, searchParams, pageNumber, pageSize, sortType);
		model.addAttribute("articles", articles);

		List<ArticleCategory> articleCategorys = articleCategoryService.getArticleCategoryList(true, false);
		model.addAttribute("articleCategorys", articleCategorys);

		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "article/articleManager";
	}

	@RequestMapping(value = "choosePage", method = RequestMethod.GET)
	public String choosePage(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			@RequestParam(value = "custom", defaultValue = "0") Long custom, Model model, ServletRequest request) {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if ((null != searchParams) && StringUtils.isNotEmpty((String) searchParams.get("EQ_articleCategory.id"))) {
			Long channelId = Long.parseLong((String) searchParams.get("EQ_articleCategory.id"));
			ArticleCategory articleCategory = articleCategoryService.getCategory(channelId);
			model.addAttribute("articleCategory", articleCategory);
		}

		Page<Article> articles = articleService.getArticlePage(true, searchParams, pageNumber, pageSize, sortType);

		model.addAttribute("articles", articles);
		model.addAttribute("custom", custom);

		return "article/choosePage";
	}
}