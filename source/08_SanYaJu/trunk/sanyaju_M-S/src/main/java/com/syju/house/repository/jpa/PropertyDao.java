package com.syju.house.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.BuildInfo;
import com.syju.house.entity.HouseIntroduce;
import com.syju.house.entity.PropertyInfo;

public interface PropertyDao extends PagingAndSortingRepository<PropertyInfo, Long>,
		JpaSpecificationExecutor<PropertyInfo> {

	/**
	 * 通过id查询物业信息
	 * @param id
	 * @return
	 */
	public abstract PropertyInfo findByHouseInfoId(Long id);
}
