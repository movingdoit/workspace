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
import com.syju.house.entity.HousePhoto;
import com.syju.house.repository.jpa.HouseDao;
import com.syju.house.repository.jpa.HousePhotoDao;
/**
 * 楼盘相册服务类
 * @author Administrator
 *
 */
@Service
@Transactional
public class HousePhotoService  extends CommonService{

	@Resource
	private HousePhotoDao housePhotoDao;
	
	@Resource
	private HouseDao houseDao;
	
	
	/**
	 * 获取关联时的house对象
	 * @param type
	 * @return
	 */
	public List<HouseInfo> getHouseByType(int type){
		switch (type) {
		case DictType.specialHouse: // 特价楼盘
			return houseDao.findSpecialHouseAndHouse();
		case DictType.featureHouse: // 特色楼盘
			return houseDao.findFeatureHouseAndHouse();
		case DictType.hotrecommend: // 热点推荐
			return houseDao.findHotRecommendAndHouse();
		case DictType.hotSort:// 热销排行
			return houseDao.findHotSortAndHouse();
		case DictType.newFav:// 最新优惠
			return houseDao.findNewFavAndHouse();
		default:
			return houseDao.findByRecommendIsNull();
		}
	}
	
	
	/**
	 * 保存相册
	 * @param photo
	 * @return
	 */
	public HousePhoto savePhoto(HousePhoto photo){
		return housePhotoDao.save(photo);
	}
	
	
	/**
	 * 通过id查询
	 * @param id
	 * @return
	 */
	public HousePhoto findById(Long id){
		return housePhotoDao.findOne(id);
	}
	
	/**
	 * 查询所有楼盘相册
	 * @param pageNumber
	 * @param pagzSize
	 * @param sortType
	 * @return
	 */
	public Page<HousePhoto> findAllByHouse(int pageNumber, int pagzSize, String sortType){
		PageRequest pageRequest = buildPageRequest(pageNumber, pagzSize, sortType);
		return housePhotoDao.findPhotoAndHouse(pageRequest);
		
	}
	
	/**
	 * 通过名称查询所有楼盘相册
	 * @param name
	 * @param pageNumber
	 * @param pagzSize
	 * @param sortType
	 * @return
	 */
	public Page<HousePhoto> findByNameAndType(Map<String, Object> params,int pageNumber, int pagzSize, String sortType){
		
		Page<HousePhoto> page = null;
		Integer type = -1;
		String name = (String)params.get("EQ_name");
		
		if(params.get("EQ_type")!=null && !params.get("EQ_type").toString().equals("")){
			type = Integer.parseInt(params.get("EQ_type").toString());
		}
		
		PageRequest pageRequest = buildPageRequest(pageNumber, pagzSize, sortType);
		
		if(type==-1 && StringUtils.isBlank(name)){
			page = housePhotoDao.findPhotoAndHouse(pageRequest);
		}else if(type== -1){
			name="%"+name+"%";
			page = housePhotoDao.findPhotoByName(name,pageRequest);
		}else{
		
			name="%"+name+"%";
			page = housePhotoDao.findPhotoByNameAndType(name, type, pageRequest);
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
			housePhotoDao.delete(id);
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
