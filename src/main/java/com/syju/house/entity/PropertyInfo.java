package com.syju.house.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 物业公司实体类
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "syj_propertyinfo")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class PropertyInfo extends IdEntity implements Serializable {

	private static final long serialVersionUID = -5260643213910875775L;

	private float plot;

	private float greenRate;

	private float managementFee;

	private String propertyCompany;

	private HouseInfo houseInfo;

	@OneToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "house_id")
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}

	public float getPlot() {
		return plot;
	}

	public void setPlot(float plot) {
		this.plot = plot;
	}

	public float getGreenRate() {
		return greenRate;
	}

	public void setGreenRate(float greenRate) {
		this.greenRate = greenRate;
	}

	public float getManagementFee() {
		return managementFee;
	}

	public void setManagementFee(float managementFee) {
		this.managementFee = managementFee;
	}

	public String getPropertyCompany() {
		return propertyCompany;
	}

	public void setPropertyCompany(String propertyCompany) {
		this.propertyCompany = propertyCompany;
	}
}
