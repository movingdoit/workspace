package com.syju.house.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
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

import com.syju.commons.controller.BaseController;
import com.syju.commons.util.DateUtils;
import com.syju.house.constrant.DictType;
import com.syju.house.entity.HouseInfo;
import com.syju.house.entity.HousePhoto;
import com.syju.house.service.HousePhotoService;
import com.syju.house.service.HouseService;

@Controller
@RequestMapping(value = "/house/photo")
public class HousePhotoController extends BaseController {

	@Resource
	private HousePhotoService housePhotoService;
	
	@Resource
	private HouseService houseService;
	
	
	/**
	 * 创建页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		
		model.addAttribute("recommendType",DictType.getRecommend());
		model.addAttribute("photoType",DictType.getHousePhoto());
		model.addAttribute("action", "create");
		return "house/housephoto/photoForm";
	}
	
	/**
	 * 保存相册
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> createForm(HousePhoto photo,Long houseId,HttpServletRequest request,
					@RequestParam(value = "file", required = false) MultipartFile file	) {
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "保存成功";
		
		if(houseId==null){
			code="1111";
			message = "保存失败，必须选择楼盘！";
		}else{
			try{
				HouseInfo house = houseService.findById(houseId);
				// 处理上传图片
				 if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
					 photo.setImageAddr((uploadFile(file, request, UPLOAD_ROOT_PATH))); 
				 }
				 
				 photo.setHouseInfo(house);
				 photo.setPhotoDate(DateUtils.getNowDate());
				 housePhotoService.savePhoto(photo);
			}catch(Exception e){
				code="1111";
				message = "保存失败,请重试";
			}
		}
		resultMap.put("code", code);
		resultMap.put("message", message);
		return resultMap;
	}
	
	
	/**
	 * 修改页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String createForm(Model model,@PathVariable("id") Long id) {
		
		HousePhoto photo = housePhotoService.findById(id);
		
		model.addAttribute("recommendType",DictType.getRecommend());
		model.addAttribute("photoType",DictType.getHousePhoto());
		model.addAttribute("photo",photo);
		model.addAttribute("action", "update");
		return "house/housephoto/photoForm";
	}
	
	/**
	 * 修改相册
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateForm(HousePhoto photo,Long houseId,HttpServletRequest request,
					@RequestParam(value = "file", required = false) MultipartFile file	) {
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "修改成功";
		
		if(houseId==null){
			code="1111";
			message = "修改失败，必须选择楼盘！";
		}else{
			try{
				HouseInfo house = houseService.findById(houseId);
				// 处理上传图片
				 if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
					 photo.setImageAddr((uploadFile(file, request, UPLOAD_ROOT_PATH))); 
				 }
				 
				 photo.setHouseInfo(house);
				 photo.setPhotoDate(DateUtils.getNowDate());
				 housePhotoService.savePhoto(photo);
			}catch(Exception e){
				code="1111";
				message = "修改失败,请重试";
			}
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
		
		Page<HousePhoto> photePage = housePhotoService.findByNameAndType(searchParams, pageNumber, pageSize, sortType);
		
		
		model.addAttribute("sortType", sortType);
		// 将搜索条件编码成字符串，用于排序，分页的URL
		model.addAttribute("search", searchParams);
		model.addAttribute("type", DictType.getHousePhoto());
		model.addAttribute("photoPage",photePage);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
	
		return "house/housephoto/photoList";
	}
	
	/**
	 * 获取
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "gethouse/{type}")
	@ResponseBody
	public List<HouseInfo> getHouse( @PathVariable("type") int type){
		List<HouseInfo> houseList = housePhotoService.getHouseByType(type);
		return houseList;
	}
	
	/**
	 * 通过id删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> deleteById(@PathVariable("id") Long id){
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "删除成功";
		
		if(!housePhotoService.deleteById(id)){
			code = "1111";
			message ="删除失败,请重试";
		}
		resultMap.put("code", code);
		resultMap.put("message", message);
		return resultMap;
	}
	
}
