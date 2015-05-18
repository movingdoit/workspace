/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.activity.special.entity;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.activity.group.entity.GroupActivity;
import com.syju.commons.entity.IdEntity;

/**
 * 楼盘活动-专题报名记录实体类（关系映射）
 * 
 * @author zcm
 */
@Entity
@Table(name = "hd_user")
// 默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SpecialRecord extends IdEntity {

	private String mobile; // 手机号
	private Timestamp joinDate; // 登记时间
	private String activityType;// 活动类型
	private String name;// 用户姓名

	private SpecialActivity specialActivity;// 用户姓名
	
	private GroupActivity groupActivity; //团购活动-用户映射

	// -----------------关系配置---------------
	
	
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "activity_id")
	public SpecialActivity getSpecialActivity() {
		return specialActivity;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "group_id")
	public GroupActivity getGroupActivity() {
		return groupActivity;
	}

	
	public void setGroupActivity(GroupActivity groupActivity) {
		this.groupActivity = groupActivity;
	}

	public void setSpecialActivity(SpecialActivity specialActivity) {
		this.specialActivity = specialActivity;
	}

	// -----------------end-----------------
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Timestamp getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Timestamp joinDate) {
		this.joinDate = joinDate;
	}

	public String getActivityType() {
		return activityType;
	}

	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}