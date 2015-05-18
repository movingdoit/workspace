package com.syju.activity.group.web;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.web.Servlets;

import com.syju.activity.group.entity.GroupActivity;
import com.syju.activity.group.service.GroupActivityService;
import com.syju.commons.controller.BaseController;
import com.syju.house.constrant.DictType;
import com.syju.house.entity.HouseInfo;
import com.syju.house.service.HouseService;

@Controller
@RequestMapping("/activity/group")
public class GroupActivityController extends BaseController {

	@Resource
	private HouseService houseService;
	
	@Resource
	private GroupActivityService groupService;

	/**
	 * 进入创建页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("recommendType", DictType.getRecommend());
		model.addAttribute("action","create");
		return "activity/group/groupActivityForm";
	}

	/**
	 * 保存页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,String> saveForm(GroupActivity group,Long houseId,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request) {
		
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "保存成功";
		
		/* 日期处理 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String beginDate = request.getParameter("startDate");
		String endDate = request.getParameter("overDate");
		
		try{
			
			// 处理上传图片
			if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
				String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
				if (StringUtils.isNotEmpty(fileName)) {
					group.setActivityImage(fileName);
				}
			}
			
			group.setBeginDate(new Timestamp((sdf.parse(beginDate)).getTime()));
			group.setEndDate(new Timestamp((sdf.parse(endDate)).getTime()));
			
			HouseInfo house = houseService.findById(houseId);
			group.setHouseInfo(house);
			groupService.save(group);
		}catch(Exception e){
			code="9999";
			message="保存失败,请重试";
			e.printStackTrace();
		}
		resultMap.put("code",code);
		resultMap.put("message", message);
		
		return resultMap;
	}

	/**
	 * 进入编辑页面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String toUpdate(Model model,@PathVariable("id") Long id){
		GroupActivity group = groupService.findById(id);
		model.addAttribute("recommendType", DictType.getRecommend());
		model.addAttribute("group", group);
		model.addAttribute("action","update");
		return "activity/group/groupActivityForm";
	}
	
	/**
	 * 更新页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,String> updateForm(GroupActivity group,Long houseId,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request) {
		
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "保存成功";
		
		/* 日期处理 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String beginDate = request.getParameter("startDate");
		String endDate = request.getParameter("overDate");
		
		try{
			
			// 处理上传图片
			if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
				String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
				if (StringUtils.isNotEmpty(fileName)) {
					group.setActivityImage(fileName);
				}
			}
			
			group.setBeginDate(new Timestamp((sdf.parse(beginDate)).getTime()));
			group.setEndDate(new Timestamp((sdf.parse(endDate)).getTime()));
			
			HouseInfo house = houseService.findById(houseId);
			group.setHouseInfo(house);
			groupService.save(group);
		}catch(Exception e){
			code="9999";
			message="保存失败,请重试";
			e.printStackTrace();
		}
		resultMap.put("code",code);
		resultMap.put("message", message);
		
		return resultMap;
	}
	
	
	/**
	 * 查询团购信息
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String toList(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request){
		
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		Page<GroupActivity> groups = groupService.findAllGroup(searchParams, pageNumber, pageSize, sortType);
		
		model.addAttribute("groups", groups);
		model.addAttribute("search", searchParams);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		return "activity/group/groupActivityList";
		
	}
	
	
	
	/**
	 * 获取
	 * 
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "gethouse/{type}")
	@ResponseBody
	public List<HouseInfo> getHouse(@PathVariable("type") int type) {
		List<HouseInfo> houseList = houseService.getHouseByType(type);
		return houseList;
	}
	
	
	
	

}
