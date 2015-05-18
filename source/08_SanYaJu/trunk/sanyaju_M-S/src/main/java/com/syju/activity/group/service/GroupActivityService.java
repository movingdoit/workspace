package com.syju.activity.group.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.activity.group.entity.GroupActivity;
import com.syju.activity.group.repository.jpa.GroupActivityDao;
import com.syju.commons.service.CommonService;

@Service
@Transactional
public class GroupActivityService extends CommonService{

	@Resource
	private GroupActivityDao groupDao;
	
	/**
	 * 保存实体对象
	 * @param group
	 * @return
	 */
	public GroupActivity save(GroupActivity group){
		return groupDao.save(group);
	}
	
	/**
	 * 查询所有
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<GroupActivity> findAllGroup(Map<String, Object> params,int pageNumber, int pageSize, String sortType){
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		
		String title = (String)params.get("EQ_title");
		if(StringUtils.isBlank(title)){
			return groupDao.findAllByPage(pageRequest);
		}else{
			title = "%"+title+"%";
			return groupDao.findByTitle(title,pageRequest);
		}
	}
	
	/**
	 * 通过id查找
	 * @param id
	 * @return
	 */
	public GroupActivity findById(Long id){
		return groupDao.findOne(id);
	}
	
	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "title");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}
}
