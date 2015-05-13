/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.condition.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;
import com.syju.house.entity.HouseInfo;

/**
 * 最新优惠-实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "tj_newfav")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class NewFav extends IdEntity {

	private Double sale; // 优惠价格
	private Long priority;// 排序号

	private HouseInfo houseInfo;// 楼盘信息-id(关系映射)

	// -----------------关系配置---------------
	// JPA 基于site_id列的多对一关系定义
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "house_id")
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}

	// -----------------end-----------------
	public Double getSale() {
		return sale;
	}

	public void setSale(Double sale) {
		this.sale = sale;
	}

	public Long getPriority() {
		return priority;
	}

	public void setPriority(Long priority) {
		this.priority = priority;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}