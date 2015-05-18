package com.syju.house.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.house.entity.HousePhoto;
/**
 * 楼盘相册dao
 * @author Administrator
 *
 */

public interface HousePhotoDao extends
		PagingAndSortingRepository<HousePhoto, Long>,
		JpaSpecificationExecutor<HousePhoto> {

	
	/**
	 * 查询所有楼盘相册
	 * @param pageRequest
	 * @return
	 */
	@Query("select p from HousePhoto p, HouseInfo h where p.houseInfo.id = h.id ")
	Page<HousePhoto> findPhotoAndHouse(Pageable pageRequest);
	
	/**
	 * 通过名字查询所有相册
	 * @param name
	 * @param pageRequest
	 * @return
	 */
	@Query("select p from HousePhoto p, HouseInfo h where p.houseInfo.id = h.id and p.name like ?1 and p.photoType = ?2")
	Page<HousePhoto> findPhotoByNameAndType(String name,Integer type,Pageable pageRequest);
	
	/**
	 * 通过名字查询所有相册
	 * @param name
	 * @param pageRequest
	 * @return
	 */
	@Query("select p from HousePhoto p, HouseInfo h where p.houseInfo.id = h.id and p.name like ?1 ")
	Page<HousePhoto> findPhotoByName(String name,Pageable pageRequest);
	
}
