package com.syju.house.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.HouseRim;

public interface HouseRimDao extends PagingAndSortingRepository<HouseRim, Long>, JpaSpecificationExecutor<HouseRim> {

	/**
	 * 通过id查询物业信息
	 * 
	 * @param id
	 * @return
	 */
	public abstract HouseRim findByHouseInfoId(Long id);
}
