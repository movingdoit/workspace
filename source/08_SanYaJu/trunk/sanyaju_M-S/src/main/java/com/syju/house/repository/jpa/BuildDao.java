package com.syju.house.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.BuildInfo;
import com.syju.house.entity.HouseInfo;

public interface BuildDao extends PagingAndSortingRepository<BuildInfo, Long>,
		JpaSpecificationExecutor<BuildInfo> {

	
	/**
	 * 通过houseid查询建筑
	 * @param id
	 * @return
	 */
	public abstract BuildInfo findByHouseInfoId(Long houseId);
	
	
	
}
