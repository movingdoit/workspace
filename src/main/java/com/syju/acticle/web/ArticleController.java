/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.web;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.syju.acticle.entity.Article;
import com.syju.acticle.entity.ArticleCategory;
import com.syju.acticle.service.ArticleCategoryService;
import com.syju.acticle.service.ArticleContentService;
import com.syju.acticle.service.ArticleService;
import com.syju.commons.controller.BaseController;
import com.syju.commons.util.StringUtil;
import com.syju.sys.entity.User;

@Controller
@RequestMapping(value = "/article/detail")
public class ArticleController extends BaseController {

	@Resource
	private ArticleService articleService;
	@Resource
	private ArticleContentService articleContentService;
	@Resource
	private ArticleCategoryService articleCategoryService;
	
	/*@Resource
	private StockService stockService;*/

	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			@RequestParam(value = "custom", defaultValue = "0") Long custom, Model model, HttpServletRequest request) {
		setShopURL(request);
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		if ((null != searchParams) && StringUtils.isNotEmpty((String) searchParams.get("EQ_articleCategory.id"))) {
			Long catId = Long.parseLong((String) searchParams.get("EQ_articleCategory.id"));
			ArticleCategory articleCategory = articleCategoryService.getCategory(catId);
			model.addAttribute("articleCategory", articleCategory);
		}
		// 定制栏目
		model.addAttribute("custom", custom);

		Page<Article> articles = articleService.getArticlePage(true, searchParams, pageNumber, pageSize, sortType);

		model.addAttribute("articles", articles);
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "article/detail/detailList";
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(@RequestParam(value = "custom", defaultValue = "0") Long custom,
			@RequestParam(value = "catId", defaultValue = "0") Long catId,
			@RequestParam(value = "isAjax", defaultValue = "0") Long isAjax, Model model, HttpServletRequest request) {
		setShopURL(request);
		model.addAttribute("allDisplay", allDisplay);
		model.addAttribute("allBindType", allBindType);

		if (custom == 0) {
			List<ArticleCategory> articleCategorys = articleCategoryService.getArticleCategoryList(true, false);
			model.addAttribute("articleCategorys", articleCategorys);
		}

		if (catId > 1) {
			ArticleCategory articleCategory = articleCategoryService.getCategory(catId);
			model.addAttribute("articleCategory", articleCategory);
		}

		// 定制栏目
		model.addAttribute("custom", custom);

		String returnUrl = request.getHeader("referer");
		if ((null != returnUrl) && returnUrl.contains("manager")) {
			model.addAttribute("manager", "manager");
		}

		model.addAttribute("action", ((null != isAjax) && (isAjax == 0)) ? "create" : "create4Ajax");
		return ((null != isAjax) && (isAjax == 0)) ? "article/detail/detailForm" : "article/detail/detailAjaxForm";
	}

	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(@RequestParam(value = "custom", defaultValue = "0") Long custom, @Valid Article article,
			@RequestParam(value = "content", required = false) String content,
			@RequestParam(value = "manager", required = false) String manager,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		/*User user = new User();
		user.setId(getCurrentUserId());
		article.setUser(user);*/
		article.setAddTime(new Timestamp(System.currentTimeMillis()));
		article.setUpdateTime(new Timestamp(System.currentTimeMillis()));
		// 处理上传图片
		if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
			if (StringUtils.isNotEmpty(fileName)) {
				article.setCoversPic(fileName);
			}
		}

		article.getArticleContent().setArticle(article);
		articleService.saveArticle(article);

		redirectAttributes.addFlashAttribute("message", "创建成功");
		if (custom == 0) {
			return "redirect:/article/manager?custom=" + custom + "&search_EQ_articleCategory.id="
					+ article.getArticleCategory().getId();
		} else {
			return "redirect:/article/detail?custom=" + custom + "&search_EQ_articleCategory.id="
					+ article.getArticleCategory().getId();
		}
	}

	@RequestMapping(value = "create4Ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> create4Ajax(@Valid Article article,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "创建失败，请重试！";

		/*User user = new User();
		user.setId(getCurrentUserId());
		article.setUser(user);*/
		article.setAddTime(new Timestamp(System.currentTimeMillis()));

		if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
			if (StringUtils.isNotEmpty(fileName)) {
				article.setCoversPic(fileName);
			}
		}

		article.getArticleContent().setArticle(article);
		articleService.saveArticle(article);
		code = "0000";
		message = "创建成功";

		resultMap.put("code", code);
		resultMap.put("msg", message);

		return resultMap;
	}

	@RequestMapping(value = "update/{id}/{custom}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, @PathVariable("custom") Long custom, Model model,
			@RequestParam(value = "isAjax", defaultValue = "0") Long isAjax, HttpServletRequest httpServletRequest) {
		Article article = articleService.getArticle(id);
		model.addAttribute("article", article);
		model.addAttribute("allDisplay", allDisplay);
		model.addAttribute("allBindType", allBindType);

		if (custom == 0) {
			List<ArticleCategory> articleCategorys = articleCategoryService.getArticleCategoryList(true, false);
			model.addAttribute("articleCategorys", articleCategorys);
		}

		// 定制栏目
		model.addAttribute("custom", custom);

		String returnUrl = httpServletRequest.getHeader("referer");
		if ((null != returnUrl) && returnUrl.contains("manager")) {
			model.addAttribute("manager", "manager");
		}

		model.addAttribute("action", ((null != isAjax) && (isAjax == 0)) ? "update" : "update4Ajax");
		return ((null != isAjax) && (isAjax == 0)) ? "article/detail/detailForm" : "article/detail/detailAjaxForm";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(@Valid @ModelAttribute("article") Article article,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "manager", required = false) String manager,
			@RequestParam(value = "custom", defaultValue = "0", required = false) Long custom,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {

		article.setUpdateTime(new Timestamp(System.currentTimeMillis()));
		User user = new User();
		user.setId(getCurrentUserId());
		//article.setUpdateUser(user);

		if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
			if (StringUtils.isNotEmpty(fileName)) {
				article.setCoversPic(fileName);
			}
		}
		ArticleCategory articleCategory = new ArticleCategory();
		articleCategory.setId(article.getArticleCategory().getId());
		article.setArticleCategory(articleCategory);
		articleService.saveArticle(article);

		if (custom == 0) {
			return "redirect:/article/manager?custom=" + custom + "&search_EQ_articleCategory.id="
					+ article.getArticleCategory().getId();
		} else {
			return "redirect:/article/detail?custom=" + custom + "&search_EQ_articleCategory.id="
					+ article.getArticleCategory().getId();
		}

	}

	@RequestMapping(value = "update4Ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> update4Ajax(@Valid @ModelAttribute("article") Article article,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "更新失败，请重试！";

		article.setUpdateTime(new Timestamp(System.currentTimeMillis()));
		User user = new User();
		user.setId(getCurrentUserId());
		//article.setUpdateUser(user);

		if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
			if (StringUtils.isNotEmpty(fileName)) {
				article.setCoversPic(fileName);
			}
		}
		ArticleCategory articleCategory = new ArticleCategory();
		articleCategory.setId(article.getArticleCategory().getId());
		article.setArticleCategory(articleCategory);
		articleService.saveArticle(article);
		// articleCategory = articleCategoryService.getCategory(article.getArticleCategory().getId());

		code = "0000";
		message = "更新成功";

		resultMap.put("code", code);
		resultMap.put("msg", message);

		return resultMap;
	}

	@RequestMapping(value = "/changeDisplay", method = RequestMethod.POST)
	@ResponseBody
	public boolean changeDisplay(boolean isDisplay, Long id, Long cateId) {
		return articleService.changeDisplay(isDisplay, id, cateId);
	}

	@RequestMapping(value = "delete/{id}")
	@ResponseBody
	public boolean delete(@PathVariable("id") Long id) {
		articleService.deleteArticle(id);
		return true;
	}

	@RequestMapping(value = "batDelete/{id}")
	@ResponseBody
	public boolean batDelete(@PathVariable("id") String id) {
		if (StringUtil.isNotEmpty(id)) {
			String[] ids = id.split(",");
			for (String id2 : ids) {
				articleService.deleteArticle(Long.parseLong(id2));

			}
		}
		return true;
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2 Preparable二次部分绑定的效果,先根据form的id从数据库查出Article对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getArticle(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			Article article = articleService.getArticle(id);
			// 清空管理的栏目对象，解决级联更新栏目ID报错问题。原因？
			article.setArticleCategory(null);
			model.addAttribute("article", article);
		}
	}

}