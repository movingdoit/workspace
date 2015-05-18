package com.syju.activity.group.repository.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.activity.group.entity.GroupActivity;
/**
 * 团购活动dao层
 * @author Administrator
 *
 */
public interface GroupActivityDao extends
		PagingAndSortingRepository<GroupActivity, Long>,
		JpaSpecificationExecutor<GroupActivity> {

	@Query("select g from GroupActivity g")
	public Page<GroupActivity> findAllByPage(Pageable page);
	
	
	@Query("select g from GroupActivity g where g.title = ?1")
	public Page<GroupActivity> findByTitle(String title,Pageable page);
}
