package com.syju.house.repository.jpa;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.condition.entity.FeatureHouse;
import com.syju.condition.entity.HotRecommend;
import com.syju.condition.entity.HotSort;
import com.syju.condition.entity.NewFav;
import com.syju.condition.entity.SpecialHouse;
import com.syju.house.entity.HouseInfo;

public interface HouseDao extends PagingAndSortingRepository<HouseInfo, Long>, JpaSpecificationExecutor<HouseInfo> {

	/**
	 * 通过id查询楼盘
	 * 
	 * @param id
	 * @return
	 */
	public abstract HouseInfo findById(Long id);

	/**
	 * 通过名字查询
	 * 
	 * @param name
	 * @return
	 */
	@Query("select h from HouseInfo h where name like ?1 ")
	public abstract Page<HouseInfo> findByName(String name, Pageable pageRequest);

	/**
	 * 查询为空时情况
	 * 
	 * @return
	 */
	@Query("select h from HouseInfo h where name = null or name = '' ")
	public abstract Page<HouseInfo> findByNameIsNull(Pageable pageRequest);

	/**
	 * 查询所有
	 * 
	 * @param pageRequest
	 * @return
	 */
	@Query("select h from HouseInfo h ")
	public abstract Page<HouseInfo> findByHouse(Pageable pageRequest);
	
	/**
	 * 查询所有
	 * 
	 * @param pageRequest
	 * @return
	 */
	@Query("select h from HouseInfo h where h.recommend is null or h.recommend = '' ")
	public abstract List<HouseInfo> findByRecommendIsNull();
	
	
	/**
	 * 通过外检关联查询
	 * 
	 * @param name
	 * @param pageable
	 * @return
	 */
	@Query("select h from FeatureHouse s,HouseInfo h where s.houseInfo = h ")
	List<HouseInfo> findFeatureHouseAndHouse();
	
	/**
	 * 关联外键查询
	 * @param name
	 * @param pageable
	 * @return
	 */
	@Query("select h from HotRecommend s,HouseInfo h where s.houseInfo = h  ")
	List<HouseInfo> findHotRecommendAndHouse();
	
	/**
	 * 关联外键查询
	 * @param name
	 * @param pageable
	 * @return
	 */
	@Query("select h from HotSort s,HouseInfo h where s.houseInfo.id = h.id")
	List<HouseInfo> findHotSortAndHouse();
	
	/**
	 * 关联外键查询
	 * @param name
	 * @param pageable
	 * @return
	 */
	@Query("select h from NewFav s,HouseInfo h where s.houseInfo = h")
	List<HouseInfo> findNewFavAndHouse();
	
	@Query("select h from SpecialHouse s, HouseInfo h where s.houseInfo.id = h.id ")
	List<HouseInfo> findSpecialHouseAndHouse();
}
