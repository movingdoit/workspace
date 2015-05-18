package com.syju.house.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.HouseInfo;
import com.syju.house.entity.HouseIntroduce;

public interface HouseIntroduceDao extends PagingAndSortingRepository<HouseIntroduce, Long>,
		JpaSpecificationExecutor<HouseIntroduce> {

	/**
	 * 通过id查询楼盘简介
	 * @param id
	 * @return
	 */
	public abstract HouseIntroduce findByHouseInfoId(Long id);
}
