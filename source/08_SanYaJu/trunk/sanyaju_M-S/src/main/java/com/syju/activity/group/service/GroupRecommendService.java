package com.syju.activity.group.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.activity.group.entity.GroupRecommend;
import com.syju.activity.group.repository.jpa.GroupRecommendDao;
import com.syju.commons.service.CommonService;

@Service
@Transactional
public class GroupRecommendService extends CommonService{

	@Resource
	private GroupRecommendDao groupRecommendDao;
	
	/**
	 * 保存实体对象
	 * @param group
	 * @return
	 */
	public GroupRecommend save(GroupRecommend group){
		return groupRecommendDao.save(group);
	}
	
	public GroupRecommend getGroupRecommend(Long id) {
		return groupRecommendDao.findOne(id);
	}
	
	public void deleteGroupRecommend(Long id) {
		groupRecommendDao.delete(id);
	}
	
	/**
	 * 查询所有
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<GroupRecommend> findAll(int pageNumber, int pageSize, String sortType){
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		
		return groupRecommendDao.findAll(pageRequest);
	}
	
	/**
	 * 获得最大的排序号
	 * @return
	 */
	public Long getMaxPriority(){
		Long index  = groupRecommendDao.getMaxPriority();
		if(index==null){
			index = 1L;
		}else{
			index = index+1;
		}
		return index;
	}
	
	/**
	 * 通过外键查找推荐
	 * @param groupId
	 * @return
	 */
	public GroupRecommend findByGroup(Long groupId){
		GroupRecommend recommend = groupRecommendDao.findByGroup(groupId);
		if(recommend==null){
			recommend = new GroupRecommend();
		}
		return recommend;
	}
	
	
	/**
	 * <p>
	 * 上移，下移
	 * </p>
	 * 
	 * @param id
	 * @param type
	 */
	public void move(Long id, String type) {
		GroupRecommend bean1 = groupRecommendDao.findOne(id); // bean1表示当前的分类对象
		if ((bean1 != null)) {
			if (type.equals("up")) { // 上移
				GroupRecommend bean2 = groupRecommendDao.findByPriority(groupRecommendDao.getMaxIndex(id));
				if (bean2 != null) { // bean2表示要和上一个排序号或下一个排序号的分类对象
					Long priority1 = bean1.getPriority();
					Long priority2 = bean2.getPriority();
					bean1.setPriority(priority2);
					bean2.setPriority(priority1);
				}
			} else if (type.equals("top")) { // 置顶

				Long priority = bean1.getPriority();

				groupRecommendDao.updateTopPriority(priority);// 批量修改 priority + 1
				bean1.setPriority((long) 1);
				groupRecommendDao.save(bean1);

			} else if (type.equals("down")) { // 置底
				Long priority = bean1.getPriority();

				groupRecommendDao.updateDownPriority(priority);// 批量修改 priority + 1
				Long downPriority = groupRecommendDao.getDownIndex(id);

				bean1.setPriority(downPriority + 1);
				groupRecommendDao.save(bean1);
			}

			else { // 下移
				System.out.println(groupRecommendDao.getMinIndex(id));
				GroupRecommend bean2 = groupRecommendDao.findByPriority(groupRecommendDao.getMinIndex(id));
				if (bean2 != null) {
					Long priority1 = bean1.getPriority();
					Long priority2 = bean2.getPriority();
					bean1.setPriority(priority2);
					bean2.setPriority(priority1);
				}
			}
		}
	}
	
	/**
	 * <p>
	 * 排序，可以输入排序号，进行排序
	 * </p>
	 * 
	 * @param oldPriority
	 *            //旧的排序号
	 * @param newPriority
	 *            //新的排序号
	 */
	public void sorting(Long oldPriority, Long newPriority) {
		if (oldPriority > newPriority) {
			groupRecommendDao.updateDESCPriority(oldPriority, newPriority);
		} else if (oldPriority < newPriority) {
			groupRecommendDao.updateASCPriority(oldPriority, newPriority);
		}
	}

	/**
	 * <p>
	 * 创建轮播图时，插入排序号，排序
	 * </p>
	 * 
	 * @param priority
	 * 
	 */
	public void insertSorting(Long priority) {
		groupRecommendDao.updateInsertPriority(priority);
	}

	/**
	 * <p>
	 * 删除轮播图时，它后面的排序号都减1
	 * </p>
	 * 
	 * @param priority
	 * 
	 */
	public void moveSorting(Long priority) {
		groupRecommendDao.updateMovePriority(priority);
	}
	
	
	/**
	 * 根据用户Id获取当前站点的幻灯片列表
	 *
	 * @param userId
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<GroupRecommend> getGroupRecommend(int pageNumber, int pageSize, String sortType,
			Map<String, Object> searchParams) {
		Specification<GroupRecommend> spec = null;
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);

		return groupRecommendDao.findAll(spec, pageRequest);
	}

	
	
	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.ASC, "priority");
		} else if ("priority".equals(sortType)) {
			sort = new Sort(Direction.ASC, "priority");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}
}
