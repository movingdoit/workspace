/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 楼盘活动-专题活动-模板二-实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "hd_special_model_two")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SpecialModelTwo extends IdEntity {

	private String topImage; // 顶部大图
	private String housesPic; // 楼盘封面
	private String productName;// 项目名称
	private String productNamePath; // 项目名称链接地址
	private String peoductLocaltion; // 项目位置
	private String productLocaltionPath;// 项目位置链接地址
	private String productInfo; // 项目介绍
	private Double startingPrice; // 起价
	private Double averagePrice;// 均价
	private String decorateStatus; // 装修情况
	private String locationAdvantage; // 位置优势
	private String houseTypeImageOne; // 户型图一
	private String houseTypeOneName;// 户型图一名称
	private String houseTypeOnePath; // 户型图一路径
	private String houseTypeImageTwo; // 户型图二
	private String houseTypeTwoName; // 户型图二名称
	private String houseTypeTwoPath; // 户型图二路径

	// many to one
	private SpecialActivity specialActivity;// 专题活动-id(关系映射)

	// -----------------关系配置---------------
	// JPA 基于site_id列的多对一关系定义
	@OneToOne(fetch = FetchType.LAZY)
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

	public String getHousesPic() {
		return housesPic;
	}

	public void setHousesPic(String housesPic) {
		this.housesPic = housesPic;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductNamePath() {
		return productNamePath;
	}

	public void setProductNamePath(String productNamePath) {
		this.productNamePath = productNamePath;
	}

	public String getPeoductLocaltion() {
		return peoductLocaltion;
	}

	public void setPeoductLocaltion(String peoductLocaltion) {
		this.peoductLocaltion = peoductLocaltion;
	}

	public String getProductLocaltionPath() {
		return productLocaltionPath;
	}

	public void setProductLocaltionPath(String productLocaltionPath) {
		this.productLocaltionPath = productLocaltionPath;
	}

	public String getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}

	public Double getStartingPrice() {
		return startingPrice;
	}

	public void setStartingPrice(Double startingPrice) {
		this.startingPrice = startingPrice;
	}

	public Double getAveragePrice() {
		return averagePrice;
	}

	public void setAveragePrice(Double averagePrice) {
		this.averagePrice = averagePrice;
	}

	public String getDecorateStatus() {
		return decorateStatus;
	}

	public void setDecorateStatus(String decorateStatus) {
		this.decorateStatus = decorateStatus;
	}

	public String getLocationAdvantage() {
		return locationAdvantage;
	}

	public void setLocationAdvantage(String locationAdvantage) {
		this.locationAdvantage = locationAdvantage;
	}

	public String getHouseTypeImageOne() {
		return houseTypeImageOne;
	}

	public void setHouseTypeImageOne(String houseTypeImageOne) {
		this.houseTypeImageOne = houseTypeImageOne;
	}

	public String getHouseTypeOneName() {
		return houseTypeOneName;
	}

	public void setHouseTypeOneName(String houseTypeOneName) {
		this.houseTypeOneName = houseTypeOneName;
	}

	public String getHouseTypeOnePath() {
		return houseTypeOnePath;
	}

	public void setHouseTypeOnePath(String houseTypeOnePath) {
		this.houseTypeOnePath = houseTypeOnePath;
	}

	public String getHouseTypeImageTwo() {
		return houseTypeImageTwo;
	}

	public void setHouseTypeImageTwo(String houseTypeImageTwo) {
		this.houseTypeImageTwo = houseTypeImageTwo;
	}

	public String getHouseTypeTwoName() {
		return houseTypeTwoName;
	}

	public void setHouseTypeTwoName(String houseTypeTwoName) {
		this.houseTypeTwoName = houseTypeTwoName;
	}

	public String getHouseTypeTwoPath() {
		return houseTypeTwoPath;
	}

	public void setHouseTypeTwoPath(String houseTypeTwoPath) {
		this.houseTypeTwoPath = houseTypeTwoPath;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}