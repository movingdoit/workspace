/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 楼盘活动-专题活动-模板一-实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "hd_special_model_one")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SpecialModelOne extends IdEntity {

	private String topImage; // 顶部大图
	private String navOne; // 导航一名称
	private String navOneImage;// 导航一图片
	private String contentInfo; // 内容介绍一
	private String navTwo; // 导航二名称
	private String navTwoImage;// 导航二图片
	private String houseTypeImage; // 户型图
	private String houseTypePath; // 户型图链接地址
	private String houseTypeInfo;// 户型介绍
	private String houseImageOne; // 户型图一
	private String houseImageTwo; // 户型图二
	private String houseImageThree; // 户型图三
	private String houseImageFour;// 户型图四
	private String navThree; // 导航三名字
	private String navThreeImage; // 导航三图片
	private String housesImageOne; // 楼盘图一
	private String housesImageTwo; // 楼盘图二
	private String housesImageThree; // 楼盘图三

	// many to one
	private List<Slide> slides;// 模板一-轮播图-id(关系映射)

	private SpecialActivity specialActivity;// 专题活动-id(关系映射)

	// -----------------关系配置---------------
	// JPA 基于site_id列的多对一关系定义
	@OneToMany(mappedBy = "specialModelOne", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	public List<Slide> getSlides() {
		return slides;
	}

	public void setSlides(List<Slide> slides) {
		this.slides = slides;
	}

	// JPA 基于site_id列的多对一关系定义
	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name = "special_id")
	public SpecialActivity getSpecialActivity() {
		return specialActivity;
	}

	public void setSpecialActivity(SpecialActivity specialActivity) {
		this.specialActivity = specialActivity;
	}

	// -----------------end-----------------
	public String getTopImage() {
		return topImage;
	}

	public void setTopImage(String topImage) {
		this.topImage = topImage;
	}

	public String getNavOne() {
		return navOne;
	}

	public void setNavOne(String navOne) {
		this.navOne = navOne;
	}

	public String getNavOneImage() {
		return navOneImage;
	}

	public void setNavOneImage(String navOneImage) {
		this.navOneImage = navOneImage;
	}

	public String getContentInfo() {
		return contentInfo;
	}

	public void setContentInfo(String contentInfo) {
		this.contentInfo = contentInfo;
	}

	public String getNavTwo() {
		return navTwo;
	}

	public void setNavTwo(String navTwo) {
		this.navTwo = navTwo;
	}

	public String getNavTwoImage() {
		return navTwoImage;
	}

	public void setNavTwoImage(String navTwoImage) {
		this.navTwoImage = navTwoImage;
	}

	public String getHouseTypeImage() {
		return houseTypeImage;
	}

	public void setHouseTypeImage(String houseTypeImage) {
		this.houseTypeImage = houseTypeImage;
	}

	public String getHouseTypePath() {
		return houseTypePath;
	}

	public void setHouseTypePath(String houseTypePath) {
		this.houseTypePath = houseTypePath;
	}

	public String getHouseTypeInfo() {
		return houseTypeInfo;
	}

	public void setHouseTypeInfo(String houseTypeInfo) {
		this.houseTypeInfo = houseTypeInfo;
	}

	public String getHouseImageOne() {
		return houseImageOne;
	}

	public void setHouseImageOne(String houseImageOne) {
		this.houseImageOne = houseImageOne;
	}

	public String getHouseImageTwo() {
		return houseImageTwo;
	}

	public void setHouseImageTwo(String houseImageTwo) {
		this.houseImageTwo = houseImageTwo;
	}

	public String getHouseImageThree() {
		return houseImageThree;
	}

	public void setHouseImageThree(String houseImageThree) {
		this.houseImageThree = houseImageThree;
	}

	public String getHouseImageFour() {
		return houseImageFour;
	}

	public void setHouseImageFour(String houseImageFour) {
		this.houseImageFour = houseImageFour;
	}

	public String getNavThree() {
		return navThree;
	}

	public void setNavThree(String navThree) {
		this.navThree = navThree;
	}

	public String getNavThreeImage() {
		return navThreeImage;
	}

	public void setNavThreeImage(String navThreeImage) {
		this.navThreeImage = navThreeImage;
	}

	public String getHousesImageOne() {
		return housesImageOne;
	}

	public void setHousesImageOne(String housesImageOne) {
		this.housesImageOne = housesImageOne;
	}

	public String getHousesImageTwo() {
		return housesImageTwo;
	}

	public void setHousesImageTwo(String housesImageTwo) {
		this.housesImageTwo = housesImageTwo;
	}

	public String getHousesImageThree() {
		return housesImageThree;
	}

	public void setHousesImageThree(String housesImageThree) {
		this.housesImageThree = housesImageThree;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}