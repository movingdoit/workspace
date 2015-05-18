package com.syju.house.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.HouseMap;

public interface HouseMapDao extends PagingAndSortingRepository<HouseMap, Long>, JpaSpecificationExecutor<HouseMap> {

	/**
	 * 通过id查询地图信息
	 * 
	 * @param id
	 * @return
	 */
	public abstract HouseMap findByHouseInfoId(Long id);
}
