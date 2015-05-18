package com.syju.activity.group.web;

import java.text.ParseException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.syju.activity.group.entity.GroupActivity;
import com.syju.activity.group.entity.GroupRecommend;
import com.syju.activity.group.service.GroupActivityService;
import com.syju.activity.group.service.GroupRecommendService;
import com.syju.commons.controller.BaseController;
import com.syju.commons.util.DateUtils;

@Controller
@RequestMapping("/activity/groupRecommend")
public class GroupRecommendController extends BaseController {

	@Resource
	private GroupActivityService groupService;
	@Resource
	private GroupRecommendService groupRecommendService;

	/**
	 * 保存推荐
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "recommend/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> recommend(@PathVariable("id") Long groupId) {

		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "推荐成功";

		GroupActivity group = groupService.findById(groupId);
		GroupRecommend recommend = groupRecommendService.findByGroup(groupId);

		try {
			recommend.setCreateTime(DateUtils.getNowDate());
			recommend.setPriority(groupRecommendService.getMaxPriority());
			recommend.setGroupActivity(group);
			groupRecommendService.save(recommend);
		} catch (Exception e) {
			code = "9999";
			message = "推荐失败";
			e.printStackTrace();
		}
		resultMap.put("code", code);
		resultMap.put("message", message);

		return resultMap;
	}

	// 遍历所有特色楼盘列表
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(
			@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
			Model model, HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(
				request, "search_");
		Page<GroupRecommend> GroupRecommends = groupRecommendService
				.getGroupRecommend(pageNumber, pageSize, sortType, searchParams);

		model.addAttribute("groupRecommends", GroupRecommends);

		return "condition/groupRecommend/groupRecommendList";
	}

	/**
	 * <p>
	 * 上移,下移,置顶,置底
	 * </p>
	 * 
	 * @param id
	 * @param type
	 */
	@RequestMapping(value = "move", method = RequestMethod.POST)
	@ResponseBody
	public void move(@RequestParam(value = "id", defaultValue = "") Long id,
			@RequestParam(value = "type", defaultValue = "") String type) {
		groupRecommendService.move(id, type);
	}

	/**
	 * 删除推荐
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "delete/{id}")
	@ResponseBody
	public Map<String, String> delete(@PathVariable("id") Long id,
			RedirectAttributes redirectAttributes) {
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "0000";
		String message = "删除成功";
		GroupRecommend GroupRecommend = groupRecommendService
				.getGroupRecommend(id);
		Long priority = GroupRecommend.getPriority(); // 获取删除的分类排序号
		groupRecommendService.deleteGroupRecommend(id);

		groupRecommendService.moveSorting(priority); // 删除后后，批量修改排序号（-1）

		resultMap.put("code", code);
		resultMap.put("message", message);
		return resultMap;
	}

}
