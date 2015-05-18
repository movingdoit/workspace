package com.syju.house.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.syju.commons.service.CommonService;
import com.syju.house.constrant.DictType;
import com.syju.house.entity.HouseInfo;
import com.syju.house.entity.HouseTypePhoto;
import com.syju.house.repository.jpa.HouseDao;
import com.syju.house.repository.jpa.HouseTypePhotoDao;
/**
 * 楼盘户型服务类
 * @author Administrator
 *
 */
@Service
@Transactional
public class HouseTypePhotoService  extends CommonService{

	@Resource
	private HouseTypePhotoDao houseTypePhotoDao;
	
	
	
	
	/**
	 * 保存相册
	 * @param photo
	 * @return
	 */
	public HouseTypePhoto savePhoto(HouseTypePhoto photo){
		return houseTypePhotoDao.save(photo);
	}
	
	
	/**
	 * 通过id查询
	 * @param id
	 * @return
	 */
	public HouseTypePhoto findById(Long id){
		return houseTypePhotoDao.findOne(id);
	}
	
	/**
	 * 查询所有楼盘相册
	 * @param pageNumber
	 * @param pagzSize
	 * @param sortType
	 * @return
	 */
	public Page<HouseTypePhoto> findAllByHouse(int pageNumber, int pagzSize, String sortType){
		PageRequest pageRequest = buildPageRequest(pageNumber, pagzSize, sortType);
		return houseTypePhotoDao.findPhotoAndHouse(pageRequest);
		
	}
	
	/**
	 * 通过名称查询所有楼盘相册
	 * @param name
	 * @param pageNumber
	 * @param pagzSize
	 * @param sortType
	 * @return
	 */
	public Page<HouseTypePhoto> findByNameAndType(Map<String, Object> params,int pageNumber, int pagzSize, String sortType){
		
		Page<HouseTypePhoto> page = null;
		Integer type = -1;
		String name = (String)params.get("EQ_name");
		
		if(params.get("EQ_type")!=null && !params.get("EQ_type").toString().equals("")){
			type = Integer.parseInt(params.get("EQ_type").toString());
		}
		
		PageRequest pageRequest = buildPageRequest(pageNumber, pagzSize, sortType);
		
		if(type==-1 && StringUtils.isBlank(name)){
			page = houseTypePhotoDao.findPhotoAndHouse(pageRequest);
		}else if(type== -1){
			name="%"+name+"%";
			page = houseTypePhotoDao.findPhotoByName(name,pageRequest);
		}else{
		
			name="%"+name+"%";
			page = houseTypePhotoDao.findPhotoByNameAndType(name, type, pageRequest);
		}
		return page;
		
	}
	
	/**
	 * 删除相册
	 * @param id
	 * @return
	 */
	public boolean deleteById(Long id){
		try{
			houseTypePhotoDao.delete(id);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
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
