package com.syju.house.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "house_introduce")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class HouseIntroduce implements java.io.Serializable  {

	private static final long serialVersionUID = 467878917759847081L;

	private Long houseId;
	
	private String content;
	
	private HouseInfo houseInfo;
	
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "houseInfo"))
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "house_Id", unique = true, nullable = false)
	public Long getHouseId() {
		return houseId;
	}
	
	public void setHouseId(Long houseId) {
		this.houseId = houseId;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public HouseInfo getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(HouseInfo houseInfo) {
		this.houseInfo = houseInfo;
	}
}
