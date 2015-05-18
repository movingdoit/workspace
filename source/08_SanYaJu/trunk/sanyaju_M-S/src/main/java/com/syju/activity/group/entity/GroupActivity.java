/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.group.entity;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;
import com.syju.house.entity.HouseInfo;

/**
 * 楼盘活动-团购活动实体类（关系映射）
 * 
 * @author gmb
 */
@Entity
@Table(name = "hd_groupactivity")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GroupActivity extends IdEntity {

	private Timestamp beginDate; // 活动时间
	private Timestamp endDate; // 结束时间
	private String content;// 活动信息
	private String title; // 活动标题
	private Integer joinLimit; // 报名人数上限
	private String activityImage; // 专题活动图片
	private int joinCount; //报名人数
	private String oldSale; //原价格
	private String newSale; //新价格
	private String summary;//摘要
	private String discount;//折扣信息
	

	private HouseInfo houseInfo;// 楼盘信息-id(关系映射)
	
	private GroupRecommend groupRecommend;

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
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getJoinCount() {
		return joinCount;
	}

	public void setJoinCount(int joinCount) {
		this.joinCount = joinCount;
	}

	public String getOldSale() {
		return oldSale;
	}

	public void setOldSale(String oldSale) {
		this.oldSale = oldSale;
	}

	public String getNewSale() {
		return newSale;
	}

	public void setNewSale(String newSale) {
		this.newSale = newSale;
	}
	
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	@Transient
	public GroupRecommend getGroupRecommend() {
		return groupRecommend;
	}

	public void setGroupRecommend(GroupRecommend groupRecommend) {
		this.groupRecommend = groupRecommend;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}