package com.syju.house.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

@Entity
@Table(name = "house_typephoto")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HouseTypePhoto extends IdEntity implements Serializable {

	private static final long serialVersionUID = -3099615304079886507L;
	private String name; // 楼盘名称
	private Date photoDate; // 创建日期
	private String imageAddr;// 图片地址
	private String forwardAddr; // 跳转地址
	private int houseType; // 照片类型
	private HouseInfo houseInfo;
	private Boolean isDisplay;
	
	public Boolean getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(Boolean isDisplay) {
		this.isDisplay = isDisplay;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getPhotoDate() {
		return photoDate;
	}

	public void setPhotoDate(Date photoDate) {
		this.photoDate = photoDate;
	}

	public String getImageAddr() {
		return imageAddr;
	}

	public void setImageAddr(String imageAddr) {
		this.imageAddr = imageAddr;
	}

	public String getForwardAddr() {
		return forwardAddr;
	}

	public void setForwardAddr(String forwardAddr) {
		this.forwardAddr = forwardAddr;
	}

	public int getHouseType() {
		return houseType;
	}

	public void setHouseType(int houseType) {
		this.houseType = houseType;
	}

	// JPA 基于site_id列的多对一关系定义
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "house_id")
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}


}
