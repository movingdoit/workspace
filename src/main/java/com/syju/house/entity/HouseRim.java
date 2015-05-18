package com.syju.house.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 周边配套
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "house_rim")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HouseRim extends IdEntity implements Serializable {

	private static final long serialVersionUID = 8335869806479834780L;

	private HouseInfo houseInfo;
	private String school;// 学校
	private String hospital;// 医院
	private String bank;// 银行
	private String shopping;// 购物
	private String life;// 生活
	private String recreation;// 娱乐
	private String catering;// 餐饮

	// JPA 基于site_id列的多对一关系定义
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "house_id")
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getShopping() {
		return shopping;
	}

	public void setShopping(String shopping) {
		this.shopping = shopping;
	}

	public String getLife() {
		return life;
	}

	public void setLife(String life) {
		this.life = life;
	}

	public String getRecreation() {
		return recreation;
	}

	public void setRecreation(String recreation) {
		this.recreation = recreation;
	}

	public String getCatering() {
		return catering;
	}

	public void setCatering(String catering) {
		this.catering = catering;
	}

}
