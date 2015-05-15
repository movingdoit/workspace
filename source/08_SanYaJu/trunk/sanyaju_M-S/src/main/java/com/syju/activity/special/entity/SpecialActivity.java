/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;
import com.syju.house.entity.HouseInfo;

/**
 * 楼盘活动-专题活动实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "hd_specialactivity")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SpecialActivity extends IdEntity {

	private Timestamp beginDate; // 活动时间
	private Timestamp endDate; // 结束时间
	private String content;// 活动信息
	private String activityTitle; // 活动标题
	private Integer joinLimit; // 报名人数上限
	private String activityImage; // 专题活动图片

	// many to one
	private HouseInfo houseInfo;// 楼盘信息-id(关系映射)

	private List<SpecialRecord> specialRecord;// 楼盘信息-id(关系映射)

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

	@OneToMany(mappedBy = "specialActivity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	public List<SpecialRecord> getSpecialRecord() {
		return specialRecord;
	}

	public void setSpecialRecord(List<SpecialRecord> specialRecord) {
		this.specialRecord = specialRecord;
	}

	// -----------------end-----------------
	public Timestamp getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Timestamp beginDate) {
		this.beginDate = beginDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getActivityTitle() {
		return activityTitle;
	}

	public void setActivityTitle(String activityTitle) {
		this.activityTitle = activityTitle;
	}

	public Integer getJoinLimit() {
		return joinLimit;
	}

	public void setJoinLimit(Integer joinLimit) {
		this.joinLimit = joinLimit;
	}

	public String getActivityImage() {
		return activityImage;
	}

	public void setActivityImage(String activityImage) {
		this.activityImage = activityImage;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}