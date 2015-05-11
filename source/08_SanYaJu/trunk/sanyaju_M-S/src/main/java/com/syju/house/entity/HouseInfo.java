package com.syju.house.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;
/**
 * 楼盘实体
 * @author Administrator
 *
 */
@Entity
@Table(name = "syj_houseinfo")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HouseInfo extends IdEntity implements Serializable{

	private static final long serialVersionUID = -5021761816489548733L;

	private String Name;

	private float plot;

	private String saleAddr;

	private String saleMobile;

	private float beginPrice;

	private float avgPrice;

	private int planHome;

	private Date beginDate;

	private Date getHomeDate;

	private String saleStatus;

	private String developer;

	private String areaType;

	private String houseType;

	private String homeType;

	private String priceType;


	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public float getPlot() {
		return plot;
	}

	public void setPlot(float plot) {
		this.plot = plot;
	}

	public String getSaleAddr() {
		return saleAddr;
	}

	public void setSaleAddr(String saleAddr) {
		this.saleAddr = saleAddr;
	}

	public String getSaleMobile() {
		return saleMobile;
	}

	public void setSaleMobile(String saleMobile) {
		this.saleMobile = saleMobile;
	}

	public float getBeginPrice() {
		return beginPrice;
	}

	public void setBeginPrice(float beginPrice) {
		this.beginPrice = beginPrice;
	}

	public float getAvgPrice() {
		return avgPrice;
	}

	public void setAvgPrice(float avgPrice) {
		this.avgPrice = avgPrice;
	}

	public int getPlanHome() {
		return planHome;
	}

	public void setPlanHome(int planHome) {
		this.planHome = planHome;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getGetHomeDate() {
		return getHomeDate;
	}

	public void setGetHomeDate(Date getHomeDate) {
		this.getHomeDate = getHomeDate;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public String getDeveloper() {
		return developer;
	}

	public void setDeveloper(String developer) {
		this.developer = developer;
	}

	public String getAreaType() {
		return areaType;
	}

	public void setAreaType(String areaType) {
		this.areaType = areaType;
	}

	public String getHouseType() {
		return houseType;
	}

	public void setHouseType(String houseType) {
		this.houseType = houseType;
	}

	public String getHomeType() {
		return homeType;
	}

	public void setHomeType(String homeType) {
		this.homeType = homeType;
	}

	public String getPriceType() {
		return priceType;
	}

	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}

}