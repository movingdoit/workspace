/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.web.Servlets;

import com.syju.acticle.entity.ArticleCategory;
import com.syju.acticle.service.ArticleCategoryService;
import com.syju.commons.controller.BaseController;
import com.syju.commons.util.StringUtil;

@Controller
@RequestMapping(value = "/article/category")
public class ArticleCategoryController extends BaseController {

	@Resource
	private ArticleCategoryService articleCategoryService;

	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) {
		setShopURL(request);
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		// 设置新增按钮的父菜单ID
		model.addAttribute("pid", 1);
		if ((null == searchParams) || searchParams.isEmpty()) {
			searchParams.put("EQ_parent.id", "1");
		} else if (searchParams.containsKey("EQ_parent.id")) {
			model.addAttribute("pid", searchParams.get("EQ_parent.id"));
		}

		Page<ArticleCategory> articleCategorys = articleCategoryService.getArticleCategoryPage(searchParams,
				pageNumber, pageSize, sortType);

		model.addAttribute("articleCategorys", articleCategorys);
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "article/category/categoryList";
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(@RequestParam(value = "pid", defaultValue = "1") Long pid, Model model) {
		ArticleCategory articleCategory = new ArticleCategory();
		ArticleCategory parent = new ArticleCategory();
		parent.setId(pid);
		articleCategory.setParent(parent);
		model.addAttribute("articleCategory", articleCategory);

		model.addAttribute("action", "create");
		return "article/category/categoryForm";
	}

	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public boolean create(@Valid ArticleCategory articleCategory,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
		articleCategory.setIsCustom(false);
		ArticleCategory articleCategory_p = new ArticleCategory();
		articleCategory_p.setId((long) 1);
		articleCategory.setParent(articleCategory_p);

		// 处理上传图片
		if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			articleCategory.setCoversPic(uploadFile(file, request, UPLOAD_ROOT_PATH));
		}

		return articleCategoryService.saveCategory(articleCategory);
	}

	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, Model model) {
		ArticleCategory articleCategory = articleCategoryService.getCategory(id);
		model.addAttribute("category", articleCategory);

		model.addAttribute("action", "update");
		return "article/category/categoryForm";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public boolean update(@Valid @ModelAttribute("articleCategory") ArticleCategory articleCategory,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {

		// 处理上传图片
		if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			articleCategory.setCoversPic(uploadFile(file, request, UPLOAD_ROOT_PATH));
		}

		return articleCategoryService.saveCategory(articleCategory);
	}

	@RequestMapping(value = "/changeDisplay", method = RequestMethod.POST)
	@ResponseBody
	public boolean changeDisplay(Long id, boolean isDisplay) {
		return articleCategoryService.changeDisplay(id, isDisplay);
	}

	@RequestMapping(value = "delete/{id}")
	@ResponseBody
	public boolean delete(@PathVariable("id") Long id) {
		return articleCategoryService.deleteCategory(id);
	}

	@RequestMapping(value = "batDelete/{id}")
	@ResponseBody
	public boolean batDelete(@PathVariable("id") String id) {
		if (StringUtil.isNotEmpty(id)) {
			String[] ids = id.split(",");
			for (String id2 : ids) {
				articleCategoryService.deleteCategory(Long.parseLong(id2));
			}
		}
		return true;
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2 Preparable二次部分绑定的效果,先根据form的id从数据库查出CmsChannel对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getArticleCategory(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			ArticleCategory articleCategory = articleCategoryService.getCategory(id);
			model.addAttribute("articleCategory", articleCategory);
		}
	}
}