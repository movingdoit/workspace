package com.syju.house.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.syju.commons.entity.IdEntity;

/**
 * 楼盘实体
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "syj_houseinfo")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HouseInfo extends IdEntity implements Serializable {

	private static final long serialVersionUID = -5021761816489548733L;

	private String Name;

	private float plot;

	private String saleAddr;

	private String saleMobile;

	private float beginPrice;

	private float avgPrice;

	private int planHome;

	private Timestamp beginDate;

	private Timestamp getHomeDate;

	private String saleStatus;

	private String developer;

	private int areaType;

	private int houseType;

	private int homeType;

	private int priceType;

	private String summary;

	private String houseAddr;

	private String recommend;

	private Date createTime;

	private String coversPic;

	private boolean isDisplay;

	/* 辅助字段 */
	private BuildInfo build;

	private PropertyInfo property;

	private HouseInfo houseInfo;

	private HouseRim houseRim;

	private HouseMap houseMap;

	@Transient
	public HouseMap getHouseMap() {
		return houseMap;
	}

	public void setHouseMap(HouseMap houseMap) {
		this.houseMap = houseMap;
	}

	@Transient
	public HouseRim getHouseRim() {
		return houseRim;
	}

	public void setHouseRim(HouseRim houseRim) {
		this.houseRim = houseRim;
	}

	@Transient
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}

	@Transient
	public BuildInfo getBuild() {
		return build;
	}

	public void setBuild(BuildInfo bulid) {
		this.build = bulid;
	}

	@Transient
	public PropertyInfo getProperty() {
		return property;
	}

	public String getCoversPic() {
		return coversPic;
	}

	public void setCoversPic(String coversPic) {
		this.coversPic = coversPic;
	}

	public void setProperty(PropertyInfo property) {
		this.property = property;
	}

	public String getHouseAddr() {
		return houseAddr;
	}

	public void setHouseAddr(String houseAddr) {
		this.houseAddr = houseAddr;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

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

	public Timestamp getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Timestamp beginDate) {
		this.beginDate = beginDate;
	}

	public Timestamp getGetHomeDate() {
		return getHomeDate;
	}

	public void setGetHomeDate(Timestamp getHomeDate) {
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

	public int getAreaType() {
		return areaType;
	}

	public void setAreaType(int areaType) {
		this.areaType = areaType;
	}

	public int getHouseType() {
		return houseType;
	}

	public void setHouseType(int houseType) {
		this.houseType = houseType;
	}

	public int getHomeType() {
		return homeType;
	}

	public void setHomeType(int homeType) {
		this.homeType = homeType;
	}

	public int getPriceType() {
		return priceType;
	}

	public void setPriceType(int priceType) {
		this.priceType = priceType;
	}

	public String getRecommend() {
		return recommend;
	}

	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public boolean getIsDisplay() {
		return isDisplay;
	}

	public void setIsDisplay(boolean isDisplay) {
		this.isDisplay = isDisplay;
	}

}