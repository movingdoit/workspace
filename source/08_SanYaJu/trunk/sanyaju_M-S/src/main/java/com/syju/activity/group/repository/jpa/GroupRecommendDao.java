package com.syju.activity.group.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.activity.group.entity.GroupRecommend;
import com.syju.condition.entity.FeatureHouse;

/**
 * 团购推荐dao层
 * 
 * @author Administrator
 *
 */
public interface GroupRecommendDao extends
		PagingAndSortingRepository<GroupRecommend, Long>,
		JpaSpecificationExecutor<GroupRecommend> {

	@Query("select Max(priority) from GroupRecommend")
	Long getMaxPriority();

	@Query("select g from GroupRecommend g where g.groupActivity.id= ?1")
	GroupRecommend findByGroup(Long id);
	
	// 验证排序号是否存在
	GroupRecommend findByPriority(Long priority);

	// 批量修改 排序号 (插入排序号)
	@Modifying
	@Query("update GroupRecommend fh set fh.priority = fh.priority+1 where fh.priority >= ?1")
	int updateInsertPriority(Long priority);

	// 批量修改 排序号 (删除后，后面的排序号都减1)
	@Modifying
	@Query("update GroupRecommend fh set fh.priority = fh.priority-1 where fh.priority > ?1")
	int updateMovePriority(Long priority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（3跟5之间的值） priority-1)（例如：3改成5）
	@Modifying
	@Query("update GroupRecommend fh set fh.priority = fh.priority-1 where fh.priority > ?1 and fh.priority <= ?2")
	int updateASCPriority(Long oldPriority, Long newPriority);

	// 批量修改 排序号 (可以输入想要修改的值，然后再（5跟3之间的值） priority+1)（例如：5改成3）
	@Modifying
	@Query("update GroupRecommend fh set fh.priority = fh.priority+1 where fh.priority < ?1 and fh.priority >= ?2")
	int updateDESCPriority(Long oldPriority, Long newPriority);

	// 根据ID查询出排序号，然后找出小于当前排序号的最大排序号（用来上移）
	@Query("select MAX(priority) from GroupRecommend where priority < (select priority from GroupRecommend where id=?1)")
	Long getMaxIndex(Long id);

	// 根据ID查询出排序号，然后找出大于当前排序号的最小排序号（用来下移）
	@Query("select MIN(priority) from GroupRecommend where priority > (select priority from GroupRecommend where id=?1)")
	Long getMinIndex(Long id);

	// 根据ID查询出排序号，然后找出小于当前排序号的最小排序号（用来置顶）
	@Query("select MIN(priority) from GroupRecommend where priority < (select priority from GroupRecommend where id=?1)")
	Long getTopIndex(Long id);

	// 根据ID查询出排序号，然后找出大于当前排序号的最大排序号（用来置底）
	@Query("select MAX(priority) from GroupRecommend where priority > (select priority from GroupRecommend where id=?1)")
	Long getDownIndex(Long id);

	// 批量修改 排序号 (置顶)
	@Modifying
	@Query("update GroupRecommend fh set fh.priority = fh.priority+1 where fh.priority < ?1")
	int updateTopPriority(Long priority);

	// 批量修改 排序号 (置底)
	@Modifying
	@Query("update GroupRecommend fh set fh.priority = fh.priority-1 where fh.priority > ?1")
	int updateDownPriority(Long priority);

}
