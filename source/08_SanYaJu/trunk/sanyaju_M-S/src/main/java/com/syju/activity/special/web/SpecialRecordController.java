package com.syju.activity.special.web;

import java.text.ParseException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.syju.activity.special.entity.SpecialRecord;
import com.syju.activity.special.service.SpecialRecordService;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping("/activity/specialRecord")
public class SpecialRecordController extends BaseController {

	@Resource
	private SpecialRecordService specialRecordService;

	// 遍历所有会员信息
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		// Page<SpecialRecord> specialRecords = specialRecordService.getSpecialRecord(searchParams, pageNumber,
		// pageSize,
		// sortType);
		Page<SpecialRecord> specialRecords = specialRecordService.getSpecialRecords(pageNumber, pageSize, sortType);
		model.addAttribute("specialRecords", specialRecords);

		return "activity/special/specialRecordList";
	}

	// 删除专题活动
	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		specialRecordService.deleteSpecialRecord(id);
		redirectAttributes.addFlashAttribute("message", "删除成功");
		return "redirect:/activity/specialRecord/list";
	}
	

}
