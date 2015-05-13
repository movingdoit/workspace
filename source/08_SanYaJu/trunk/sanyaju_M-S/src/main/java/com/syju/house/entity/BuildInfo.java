package com.syju.house.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 建筑公司实体类
 * 
 * @author Administrator
 *
 */

@Entity
@Table(name = "syj_buildinfo")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class BuildInfo extends IdEntity implements Serializable {

	private static final long serialVersionUID = 4041119785952213611L;

	private int propertyRight;

	private float planArea;

	private float buildArea;

	private String houseType;

	private String decorateType;

	private int sumHome;

	private HouseInfo houseInfo;

	@OneToOne
	@JoinColumn(name = "house_id")
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}

	public int getPropertyRight() {
		return propertyRight;
	}

	public void setPropertyRight(int propertyRight) {
		this.propertyRight = propertyRight;
	}

	public float getPlanArea() {
		return planArea;
	}

	public void setPlanArea(float planArea) {
		this.planArea = planArea;
	}

	public float getBuildArea() {
		return buildArea;
	}

	public void setBuildArea(float buildArea) {
		this.buildArea = buildArea;
	}

	public String getHouseType() {
		return houseType;
	}

	public void setHouseType(String houseType) {
		this.houseType = houseType;
	}

	public String getDecorateType() {
		return decorateType;
	}

	public void setDecorateType(String decorateType) {
		this.decorateType = decorateType;
	}

	public int getSumHome() {
		return sumHome;
	}

	public void setSumHome(int sumHome) {
		this.sumHome = sumHome;
	}

}
