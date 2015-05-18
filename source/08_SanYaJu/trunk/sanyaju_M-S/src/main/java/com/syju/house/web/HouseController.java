package com.syju.house.web;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.syju.commons.controller.BaseController;
import com.syju.commons.util.DateUtils;
import com.syju.condition.entity.FeatureHouse;
import com.syju.condition.entity.HotRecommend;
import com.syju.condition.entity.HotSort;
import com.syju.condition.entity.NewFav;
import com.syju.condition.entity.SpecialHouse;
import com.syju.condition.service.FeatureHouseService;
import com.syju.condition.service.HotRecommendService;
import com.syju.condition.service.HotSortService;
import com.syju.condition.service.NewFavService;
import com.syju.condition.service.SpecialHouseService;
import com.syju.house.constrant.DictType;
import com.syju.house.entity.BuildInfo;
import com.syju.house.entity.HouseInfo;
import com.syju.house.entity.HouseIntroduce;
import com.syju.house.entity.HouseMap;
import com.syju.house.entity.HouseRim;
import com.syju.house.entity.PropertyInfo;
import com.syju.house.service.BuildService;
import com.syju.house.service.HouseIntroduceService;
import com.syju.house.service.HouseMapService;
import com.syju.house.service.HouseRimService;
import com.syju.house.service.HouseService;
import com.syju.house.service.PropertyService;

@Controller
@RequestMapping(value = "/house/detail")
public class HouseController extends BaseController {

	@Resource
	private HouseService houseService;

	@Resource
	private BuildService bulidService;

	@Resource
	private HouseIntroduceService houseIntroduceService;

	@Resource
	private PropertyService propertyService;

	@Resource
	private HouseRimService houseRimService;

	@Resource
	private HouseMapService houseMapService;

	/* 推荐service */
	@Resource
	private FeatureHouseService featureHouseService;
	@Resource
	private HotRecommendService hotRecommendService;
	@Resource
	private HotSortService hotSortService;
	@Resource
	private NewFavService newFavService;
	@Resource
	private SpecialHouseService specialHouseService;

	// 创建框
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {

		model.addAttribute("house", new HouseInfo());
		model.addAttribute("build", new BuildInfo());
		model.addAttribute("property", new PropertyInfo());

		/* 字典值 */
		model.addAttribute("houseType", DictType.getHouseType());
		model.addAttribute("homeType", DictType.getHomeType());
		model.addAttribute("areaType", DictType.getAreaType());
		model.addAttribute("decorateType", DictType.getDecorateType());
		model.addAttribute("saleStatus", DictType.getSaleStatus());
		model.addAttribute("recommend", DictType.getRecommend());

		model.addAttribute("action", "create");
		return "house/housedetail/houseForm";
	}

	/**
	 * 表单提交保存
	 * 
	 * @param model
	 * @param house
	 * @param introduce
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> saveHouseDetail(Model model, HttpServletRequest request, @Valid HouseInfo house,
			String introduce) {

		// @RequestParam(value = "file", required = false) MultipartFile file,

		Map<String, String> resultMap = new HashMap<String, String>();
		BuildInfo build = house.getBuild();
		PropertyInfo property = house.getProperty();
		HouseIntroduce houseIntroduce = new HouseIntroduce();
		HouseRim houseRim = house.getHouseRim();
		HouseMap houseMap = house.getHouseMap();

		/* 日期处理 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String beginDate = request.getParameter("startDate");
		String getHomeDate = request.getParameter("endDate");

		String code = "0000";
		String message = "保存成功";
		try {

			// 处理上传图片
			/*
			 * if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			 * house.setCoversPic(uploadFile(file, request, UPLOAD_ROOT_PATH)); }
			 */

			house.setBeginDate(new Timestamp((sdf.parse(beginDate)).getTime()));
			house.setGetHomeDate(new Timestamp((sdf.parse(getHomeDate)).getTime()));

			house.setCreateTime(DateUtils.getNowDate());
			HouseInfo houseInfo = houseService.saveHouse(house);

			/* 简介 */
			houseIntroduce.setContent(introduce);
			houseIntroduce.setHouseInfo(houseInfo);
			houseIntroduceService.saveHouseIntroduce(houseIntroduce);

			/* 建筑 */
			build.setHouseInfo(houseInfo);
			bulidService.saveBulid(build);

			/* 物业 */
			property.setHouseInfo(houseInfo);
			propertyService.saveProperty(property);

			/* 周边配套 */
			houseRim.setHouseInfo(houseInfo);
			houseRimService.saveHouseRim(houseRim);

			/* 地图 */
			houseMap.setHouseInfo(houseInfo);
			houseMapService.saveHouseMap(houseMap);

		} catch (Exception e) {
			code = "9999";
			message = "保存出错，请检查字段";
			e.printStackTrace();
		}

		resultMap.put("code", code);
		resultMap.put("message", message);
		return resultMap;
	}

	// 进入更新页面
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(Model model, @PathVariable("id") Long id) {
		/* 字典值 */
		model.addAttribute("houseType", DictType.getHouseType());
		model.addAttribute("homeType", DictType.getHomeType());
		model.addAttribute("areaType", DictType.getAreaType());
		model.addAttribute("decorateType", DictType.getDecorateType());
		model.addAttribute("saleStatus", DictType.getSaleStatus());
		model.addAttribute("recommend", DictType.getRecommend());

		HouseInfo house = houseService.findById(id);
		BuildInfo build = bulidService.findByHouseId(id);
		PropertyInfo property = propertyService.findByHuoseId(id);
		HouseIntroduce introduce = houseIntroduceService.findByHouseId(id);
		HouseRim houseRim = houseRimService.findByHuoseId(id);
		HouseMap houseMap = houseMapService.findByHuoseId(id);

		model.addAttribute("introduce", introduce);
		model.addAttribute("property", property);
		model.addAttribute("house", house);
		model.addAttribute("build", build);
		model.addAttribute("houseRim", houseRim);
		model.addAttribute("houseMap", houseMap);
		model.addAttribute("action", "update");
		return "house/housedetail/houseForm";
	}

	/**
	 * 更新楼盘明细
	 * 
	 * @param model
	 * @param request
	 * @param house
	 * @param introduce
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateHouseDetail(HttpServletRequest request, @Valid HouseInfo house, String introduce) {

		// @RequestParam(value = "file", required = false) MultipartFile file,
		Map<String, String> resultMap = new HashMap<String, String>();
		BuildInfo build = house.getBuild();
		PropertyInfo property = house.getProperty();
		HouseIntroduce houseIntroduce = new HouseIntroduce();
		HouseRim houseRim = house.getHouseRim();
		HouseMap houseMap = house.getHouseMap();

		/* 日期处理 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String beginDate = request.getParameter("startDate");
		String getHomeDate = request.getParameter("endDate");

		String code = "0000";
		String message = "修改成功";
		try {

			// 处理上传图片

			/*
			 * if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
			 * house.setCoversPic(uploadFile(file, request, UPLOAD_ROOT_PATH)); }
			 */

			house.setBeginDate(new Timestamp((sdf.parse(beginDate)).getTime()));
			house.setGetHomeDate(new Timestamp((sdf.parse(getHomeDate)).getTime()));

			house.setCreateTime(DateUtils.getNowDate());
			HouseInfo houseInfo = houseService.saveHouse(house);

			/* 简介 */
			houseIntroduce.setContent(introduce);
			houseIntroduce.setHouseId(house.getId());
			houseIntroduceService.saveHouseIntroduce(houseIntroduce);

			/* 建筑 */
			build.setHouseInfo(houseInfo);
			bulidService.saveBulid(build);

			/* 物业 */
			property.setHouseInfo(houseInfo);
			propertyService.saveProperty(property);

			/* 周边配套 */
			houseRim.setHouseInfo(houseInfo);
			houseRimService.saveHouseRim(houseRim);

			/* 地图 */
			houseMap.setHouseInfo(houseInfo);
			houseMapService.saveHouseMap(houseMap);

		} catch (Exception e) {
			code = "9999";
			message = "保存出错，请检查字段";
			e.printStackTrace();
		}

		resultMap.put("code", code);
		resultMap.put("message", message);
		return resultMap;
	}

	/**
	 * 显示楼盘列表
	 * 
	 * @param model
	 * @param request
	 * @param name
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String houseSearch(Model model, ServletRequest request,
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		String name = (String) searchParams.get("EQ_name");

		Long type = 0L;
		if (searchParams.get("EQ_recommend") != null) {
			if (!searchParams.get("EQ_recommend").toString().equals("")) {
				type = Long.parseLong(searchParams.get("EQ_recommend").toString());
			}
		}

		switch (type.intValue()) {
		case DictType.specialHouse: // 特价楼盘
			Page<SpecialHouse> page = specialHouseService.findBySpecialHouseAndHouse(name, pageNumber, pageSize,
					sortType);
			model.addAttribute("housePage", page);
			break;

		case DictType.featureHouse: // 特色楼盘

			Page<FeatureHouse> featureHouse = featureHouseService.findByFeatureHouseAndHouse(name, pageNumber,
					pageSize, sortType);
			model.addAttribute("housePage", featureHouse);
			break;
		case DictType.hotrecommend: // 热点推荐
			Page<HotRecommend> hotrecommend = hotRecommendService.findByHotRecommendAndHouse(name, pageNumber,
					pageSize, sortType);
			model.addAttribute("housePage", hotrecommend);
			break;
		case DictType.hotSort:// 热销排行
			Page<HotSort> hotSort = hotSortService.findByHotSortAndHouse(name, pageNumber, pageSize, sortType);
			model.addAttribute("housePage", hotSort);
			break;
		case DictType.newFav:// 最新优惠
			Page<NewFav> newFav = newFavService.findByNewFavAndHouse(name, pageNumber, pageSize, sortType);
			model.addAttribute("housePage", newFav);
			break;
		default:
			Page<HouseInfo> houseInfo = houseService.findByName(pageNumber, pageSize, sortType, name);
			model.addAttribute("housePage", houseInfo);
			break;
		}

		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("search", searchParams);
		model.addAttribute("recommendType", DictType.getRecommend().get(type.intValue()));
		model.addAttribute("recommend", DictType.getRecommend());
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));

		return "house/housedetail/houseList";

	}

	/**
	 * 查询所有数据
	 * 
	 * @param model
	 * @param request
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String houseList(Model model, ServletRequest request,
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = PAGE_SIZE) int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType) {

		Page<HouseInfo> houseInfo = houseService.findHouse(pageNumber, pageSize, sortType);
		model.addAttribute("housePage", houseInfo);
		model.addAttribute("recommend", DictType.getRecommend());

		return "house/housedetail/houseList";
	}

	/**
	 * 进入推荐页面
	 * 
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "recommend/{id}", method = RequestMethod.GET)
	public String recommendForm(Model model, @PathVariable("id") Long id) {
		/* 字典值 */
		model.addAttribute("recommend", DictType.getRecommend());

		HouseInfo house = houseService.findById(id);

		model.addAttribute("house", house);
		model.addAttribute("action", "update");
		return "house/housedetail/recommend";
	}

	/**
	 * 推荐页面post请求
	 * 
	 * @param model
	 * @param recommend
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "recommend", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> recommendFormPost(Model model, String recommend, Long id) {

		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "修改成功";

		HouseInfo house = houseService.findById(id);

		if (!houseService.saveRecommend(recommend, house)) {
			code = "9999";
			message = "修改失败";
		}

		/* 字典值 */
		// model.addAttribute("recommend", DictType.getRecommend());

		resultMap.put("code", code);
		resultMap.put("message", message);

		model.addAttribute("action", "update");
		return resultMap;
	}

	/**
	 * 改变显示方式
	 * 
	 * @param id
	 * @param isDisplay
	 * @return
	 */
	@RequestMapping(value = "changeDisplay", method = RequestMethod.POST)
	@ResponseBody
	public boolean changeDisplay(Long id, boolean isDisplay) {
		try {
			HouseInfo houseInfo = houseService.findById(id);
			houseInfo.setIsDisplay(isDisplay);
			houseService.saveHouse(houseInfo);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

}
