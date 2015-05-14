/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.acticle.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.collect.Lists;
import com.syju.commons.entity.IdEntity;

/**
 * 用户.
 * 
 * @author 王德仁
 */
@Entity
@Table(name = "article_category")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ArticleCategory extends IdEntity {
	// fields
	private String name;
	private String path;
	private String coversPic;
	private Long priority;
	private Boolean isDisplay;
	private Boolean isCustom;
	// many to one
	private ArticleCategory parent;
	// SEO优化字段
	private String seoDescription;
	private String seoKeywords;
	private String seoTitle;

	// one to many
	private List<ArticleCategory> child = Lists.newArrayList();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getCoversPic() {
		return coversPic;
	}

	public void setCoversPic(String coversPic) {
		this.coversPic = coversPic;
	}

	public Long getPriority() {
		return priority;
	}

	public void setPriority(Long priority) {
		this.priority = priority;
	}

	public Boolean getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(Boolean isDisplay) {
		this.isDisplay = isDisplay;
	}

	public Boolean getIsCustom() {
		return isCustom;
	}

	public void setIsCustom(Boolean isCustom) {
		this.isCustom = isCustom;
	}

	public String getSeoDescription() {
		return seoDescription;
	}

	public void setSeoDescription(String seoDescription) {
		this.seoDescription = seoDescription;
	}

	public String getSeoKeywords() {
		return seoKeywords;
	}

	public void setSeoKeywords(String seoKeywords) {
		this.seoKeywords = seoKeywords;
	}

	public String getSeoTitle() {
		return seoTitle;
	}

	public void setSeoTitle(String seoTitle) {
		this.seoTitle = seoTitle;
	}

	// JPA 基于parent_id列的多对一关系定义
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id")
	public ArticleCategory getParent() {
		return parent;
	}

	public void setParent(ArticleCategory parent) {
		this.parent = parent;
	}

	@OneToMany(mappedBy = "parent")
	public List<ArticleCategory> getChild() {
		return child;
	}

	public void setChild(List<ArticleCategory> child) {
		this.child = child;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}