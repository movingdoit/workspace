package com.syju.activity.group.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springside.modules.web.Servlets;

import com.syju.activity.group.service.GroupActivityService;
import com.syju.activity.group.service.GroupRecordService;
import com.syju.activity.special.entity.SpecialRecord;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping("/activity/groupRecord")
public class GroupRecordController extends BaseController {

	@Resource
	private GroupActivityService  groupService;
	@Resource
	private GroupRecordService groupRecordService;

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

		Page<SpecialRecord> groups = groupRecordService.findByGroup(searchParams, pageNumber, pageSize, sortType);
		
		model.addAttribute("groupRecords", groups);
		model.addAttribute("search", searchParams);
		model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
		
		return "activity/group/groupRecordList";
		
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,String> delete(@PathVariable("id") Long id){
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "删除成功";
		if(!groupRecordService.delete(id)){
			code = "9999";
			message = "删除失败";
		}
		resultMap.put("code",code);
		resultMap.put("message", message);
		
		return resultMap;
	}

}
