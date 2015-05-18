package com.syju.house.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.HouseTypePhoto;
/**
 * 楼盘户型图dao
 * @author Administrator
 *
 */

public interface HouseTypePhotoDao extends
		PagingAndSortingRepository<HouseTypePhoto, Long>,
		JpaSpecificationExecutor<HouseTypePhoto> {

	
	/**
	 * 查询所有楼盘户型相册
	 * @param pageRequest
	 * @return
	 */
	@Query("select p from HouseTypePhoto p, HouseInfo h where p.houseInfo.id = h.id ")
	Page<HouseTypePhoto> findPhotoAndHouse(Pageable pageRequest);
	
	/**
	 * 通过名字查询所有户型相册
	 * @param name
	 * @param pageRequest
	 * @return
	 */
	@Query("select p from HouseTypePhoto p, HouseInfo h where p.houseInfo.id = h.id and p.name like ?1 and p.houseType = ?2")
	Page<HouseTypePhoto> findPhotoByNameAndType(String name,Integer type,Pageable pageRequest);
	
	/**
	 * 通过名字查询所有户型相册
	 * @param name
	 * @param pageRequest
	 * @return
	 */
	@Query("select p from HouseTypePhoto p, HouseInfo h where p.houseInfo.id = h.id and p.name like ?1 ")
	Page<HouseTypePhoto> findPhotoByName(String name,Pageable pageRequest);
	
}
