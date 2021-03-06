package com.syju.condition.web;

import java.text.ParseException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.syju.commons.controller.BaseController;
import com.syju.condition.entity.FeatureHouse;
import com.syju.condition.service.FeatureHouseService;

@Controller
@RequestMapping("/featureHouse")
public class FeatureHouseController extends BaseController {

	@Resource
	private FeatureHouseService featureHouseService;

	// 遍历所有特色楼盘列表
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Page<FeatureHouse> featureHouses = featureHouseService.getFeatureHouse(pageNumber, pageSize, sortType,
				searchParams);

		model.addAttribute("featureHouses", featureHouses);

		return "condition/featureHouse/featureHouseList";
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
		featureHouseService.move(id, type);
	}

	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		FeatureHouse featureHouse = featureHouseService.getFeatureHouse(id);
		Long priority = featureHouse.getPriority(); // 获取删除的分类排序号
		featureHouseService.deleteFeatureHouse(id);

		featureHouseService.moveSorting(priority); // 删除后后，批量修改排序号（-1）

		redirectAttributes.addFlashAttribute("message", "删除成功");
		return "redirect:/featureHouse/list";
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2
	 * Preparable二次部分绑定的效果,先根据form的id从数据库查出SiteSlide对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getFeatureHouse(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			FeatureHouse featureHouse = featureHouseService.getFeatureHouse(id);
			model.addAttribute("featureHouse", featureHouse);
		}
	}

}
