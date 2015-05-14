/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.condition.entity;

import java.sql.Timestamp;

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
 * 热点推荐-实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "tj_hotrecommend")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HotRecommend extends IdEntity {

	private Long fangwenCount; // 访问次数
	private String redianInfo;// 热点信息
	private Long priority;// 排序号
	private Timestamp createTime;// 创建时间

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

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Long getFangwenCount() {
		return fangwenCount;
	}

	public void setFangwenCount(Long fangwenCount) {
		this.fangwenCount = fangwenCount;
	}

	public String getRedianInfo() {
		return redianInfo;
	}

	public void setRedianInfo(String redianInfo) {
		this.redianInfo = redianInfo;
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