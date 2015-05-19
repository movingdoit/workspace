/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 楼盘活动-专题活动-模板一-轮播图-实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "hd_special_model_one_slide")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Slide extends IdEntity {

	private String slideImage; // 轮播图图片
	private String slidePath; // 轮播图链接地址

	private SpecialModelOne specialModelOne; // 轮播图链接地址

	// -----------------关系配置---------------
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "model_one_id")
	public SpecialModelOne getSpecialModelOne() {
		return specialModelOne;
	}

	public void setSpecialModelOne(SpecialModelOne specialModelOne) {
		this.specialModelOne = specialModelOne;
	}

	// -----------------end-----------------
	public String getSlideImage() {
		return slideImage;
	}

	public void setSlideImage(String slideImage) {
		this.slideImage = slideImage;
	}

	public String getSlidePath() {
		return slidePath;
	}

	public void setSlidePath(String slidePath) {
		this.slidePath = slidePath;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}