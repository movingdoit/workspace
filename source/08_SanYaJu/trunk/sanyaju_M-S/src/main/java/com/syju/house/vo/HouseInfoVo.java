package com.syju.house.vo;

import java.util.Date;
import java.util.Map;

import com.syju.house.constrant.DictType;

public class HouseInfoVo {

	private Long id;
	
	private String name;
	
	private Date  createTime;
	
	private float avgPrice;
	
	private Long priority;
	
	private String type;
	
	public HouseInfoVo(Long id,Long priority){
		this.id = id;
		this.priority = priority;
	}

	public Long getPriority() {
		return priority;
	}

	public void setPriority(Long priority) {
		this.priority = priority;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public void setType(Long type) {
		Map<Integer,String> map = DictType.getRecommend();
		if(map.get(type)!=null){
			this.type = map.get(type).toString();
		}
		this.type=null;
	}
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public float getAvgPrice() {
		return avgPrice;
	}

	public void setAvgPrice(float avgPrice) {
		this.avgPrice = avgPrice;
	}
	
	
	
}
