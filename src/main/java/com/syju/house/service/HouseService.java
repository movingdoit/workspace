package com.syju.house.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.DynamicSpecifications;
import org.springside.modules.persistence.SearchFilter;
import org.springside.modules.persistence.SearchFilter.Operator;

import com.syju.commons.service.CommonService;
import com.syju.commons.util.DateUtils;
import com.syju.condition.entity.FeatureHouse;
import com.syju.condition.entity.HotRecommend;
import com.syju.condition.entity.HotSort;
import com.syju.condition.entity.HouseRecommend;
import com.syju.condition.entity.NewFav;
import com.syju.condition.entity.NewGuide;
import com.syju.condition.entity.SpecialHouse;
import com.syju.condition.repository.jpa.FeatureHouseDao;
import com.syju.condition.repository.jpa.HotRecommendDao;
import com.syju.condition.repository.jpa.HotSortDao;
import com.syju.condition.repository.jpa.HouseRecommendDao;
import com.syju.condition.repository.jpa.NewFavDao;
import com.syju.condition.repository.jpa.NewGuideDao;
import com.syju.condition.repository.jpa.SpecialHouseDao;
import com.syju.house.constrant.DictType;
import com.syju.house.entity.HouseInfo;
import com.syju.house.repository.jpa.HouseDao;

@Service
@Transactional
public class HouseService extends CommonService {

	@Resource
	private HouseDao houseDao;

	/* 推荐类目 */
	@Resource
	private FeatureHouseDao featureHouseDao;
	@Resource
	private HotRecommendDao hotRecommendDao;
	@Resource
	private HotSortDao hotSortDao;
	@Resource
	private NewFavDao newFavDao;
	@Resource
	private SpecialHouseDao specialHouseDao;
	@Resource
	private NewGuideDao newGuideDao; // 新盘导购
	@Resource
	private HouseRecommendDao recommendDao; // 楼盘推荐

	/**
	 * 保存楼盘
	 * 
	 * @param house
	 * @return
	 */
	public HouseInfo saveHouse(HouseInfo house) {
		return houseDao.save(house);
	}

	public HouseInfo findById(Long id) {
		return houseDao.findById(id);
	}

	/**
	 * 查询所有房源
	 * 
	 * @return
	 */
	public Page<HouseInfo> findHouse(int pageNumber, int pageSize,
			String sortType) {

		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		return houseDao.findByHouse(pageRequest);
	}

	/**
	 * 查询所有房源
	 * 
	 * @return
	 */
	public Page<HouseInfo> findByName(int pageNumber, int pageSize,
			String sortType, String name) {

		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);

		if (StringUtils.isBlank(name)) {
			return houseDao.findByNameIsNull(pageRequest);
		} else {
			name = "%" + name.trim() + "%";
			return houseDao.findByName(name, pageRequest);
		}
	}

	/**
	 * 保存推荐类目
	 * 
	 * @param recommend
	 * @param house
	 * @return
	 */
	public boolean saveRecommend(String recommend, HouseInfo house) {
		String[] re = recommend.split(",");
		Long index = 1L;

		SpecialHouse specialHouse = new SpecialHouse();
		FeatureHouse featureHouse = new FeatureHouse();
		HotRecommend hotrecommend = new HotRecommend();
		HotSort hotSort = new HotSort();
		NewFav newFav = new NewFav();
		NewGuide newGuide = new NewGuide();
		HouseRecommend hr = new HouseRecommend();

		/* 当前时间 */
		Date date = DateUtils.getNowDate();
		Timestamp time = new Timestamp(date.getTime());

		String houseRecommend = house.getRecommend();
		if (!StringUtils.isBlank(houseRecommend)) {
			for (int i = 0; i < re.length; i++) {
				if (houseRecommend.contains(re[i])) {
					houseRecommend.replace(re[i], "-100");
					re[i] = "-" + re[i];
				}
			}
		}

		/* 保存推荐处理 */
		try {
			for (int i = 0; i < re.length; i++) {
				switch (Integer.parseInt(re[i])) {
				case DictType.specialHouse: // 特价楼盘
					specialHouse.setCreateTime(time);
					specialHouse.setHouseInfo(house);
					index = specialHouseDao.getMaxPriority();
					specialHouse.setPriority(index == null ? 1L : index);
					specialHouseDao.save(specialHouse);
					break;

				case DictType.featureHouse: // 特色楼盘
					featureHouse.setCreateTime(time);
					featureHouse.setHouseInfo(house);
					index = featureHouseDao.getMaxPriority();
					featureHouse.setPriority(index == null ? 1L : index);
					featureHouseDao.save(featureHouse);
					break;
				case DictType.hotrecommend: // 热点推荐
					hotrecommend.setCreateTime(time);
					hotrecommend.setHouseInfo(house);
					index = hotRecommendDao.getMaxPriority();
					hotrecommend.setPriority(index == null ? 1L : index + 1);
					hotRecommendDao.save(hotrecommend);
					break;
				case DictType.hotSort:// 热销排行
					hotSort.setCreateTime(time);
					hotSort.setHouseInfo(house);
					index = hotSortDao.getMaxPriority();
					hotSort.setPriority(index == null ? 1L : index + 1);
					hotSortDao.save(hotSort);
					break;
				case DictType.newFav:// 最新优惠
					newFav.setCreateTime(time);
					newFav.setHouseInfo(house);
					index = newFavDao.getMaxPriority();
					newFav.setPriority(index == null ? 1L : index + 1);
					newFavDao.save(newFav);
					break;
				case DictType.newGuide:// 新盘导购
					newGuide.setCreateTime(time);
					newGuide.setHouseInfo(house);
					index = newGuideDao.getMaxPriority();
					newGuide.setPriority(index == null ? 1L : index + 1);
					newGuideDao.save(newGuide);
					break;
				case DictType.houseRecommend:// 最新优惠
					hr.setCreateTime(time);
					hr.setHouseInfo(house);
					index = newFavDao.getMaxPriority();
					hr.setPriority(index == null ? 1L : index + 1);
					recommendDao.save(hr);
					break;
				default:
					break;
				}
			}

			/* 删除多余的推荐 */
			if (!StringUtils.isBlank(houseRecommend)) {
				deleteByHouse(houseRecommend, house.getId());
			}

			/* 保存推荐 */
			recommend = "";
			for (int i = 0; i < re.length; i++) {
				re[i] = re[i].replace("-", "");
				recommend += re[i] + ",";
			}
			if (!recommend.equals("")) {
				recommend = recommend.substring(0, recommend.length() - 1);
				house.setRecommend(recommend);
				houseDao.save(house);
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 查询推荐
	 * 
	 * @param id
	 * @return
	 */
	public String queryRecommend(Long id) {
		String recommend = "";
		try {
			if (specialHouseDao.findByHouseInfoId(id) != null) {
				recommend += DictType.specialHouse + ",";
			} else if (featureHouseDao.findByHouseInfoId(id) != null) {
				recommend += DictType.featureHouse + ",";
			} else if (hotRecommendDao.findByHouseInfoId(id) != null) {
				recommend += DictType.hotrecommend + ",";
			} else if (hotSortDao.findByHouseInfoId(id) != null) {
				recommend += DictType.hotSort + ",";
			} else if (newFavDao.findByHouseInfoId(id) != null) {
				recommend += DictType.newFav + ",";
			} else if (newGuideDao.findByHouseInfoId(id) != null) {
				recommend += DictType.newGuide + ",";
			} else if (recommendDao.findByHouseInfoId(id) != null) {
				recommend += DictType.houseRecommend + ",";
			}

			if (!StringUtils.isBlank(recommend)) {
				recommend = recommend.substring(0, recommend.length() - 1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return recommend;
	}

	/**
	 * 删除推荐
	 * 
	 * @param recommend
	 * @param id
	 * @return
	 */
	public boolean deleteByHouse(String recommend, Long id) {
		String[] re = recommend.split(",");
		try {
			for (int i = 0; i < re.length; i++) {
				switch (Integer.parseInt(re[i])) {
				case DictType.specialHouse: // 特价楼盘
					specialHouseDao.deleteByHouse(id);
					break;
				case DictType.featureHouse: // 特色楼盘
					featureHouseDao.deleteByHouse(id);
					break;
				case DictType.hotrecommend: // 热点推荐
					hotRecommendDao.deleteByHouse(id);
					break;
				case DictType.hotSort:// 热销排行
					hotSortDao.deleteByHouse(id);
					break;
				case DictType.newFav:// 最新优惠
					newFavDao.deleteByHouse(id);
					break;
				case DictType.newGuide:// 楼盘导购
					newGuideDao.deleteByHouse(id);
					break;
				case DictType.houseRecommend:// 最新优惠
					recommendDao.deleteByHouse(id);
					break;
				default:
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "title");
		}

		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	/**
	 * 创建动态查询条件组合.
	 */
	private Specification<HouseInfo> buildSpecification(String name,
			Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = SearchFilter.parse(searchParams);
		if (name != null) {
			filters.put("name", new SearchFilter("name", Operator.EQ, name));
		}

		Specification<HouseInfo> spec = DynamicSpecifications.bySearchFilter(
				filters.values(), HouseInfo.class);
		return spec;
	}

}
