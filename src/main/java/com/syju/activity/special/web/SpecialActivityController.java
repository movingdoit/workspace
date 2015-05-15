package com.syju.activity.special.web;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.syju.activity.special.entity.SpecialActivity;
import com.syju.activity.special.service.SpecialActivityService;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping("/activity/specialActivity")
public class SpecialActivityController extends BaseController {

	@Resource
	private SpecialActivityService specialActivityService;

	// 遍历所有信息
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Page<SpecialActivity> specialActivitys = specialActivityService.getSpecialActivity(searchParams, pageNumber,
				pageSize, sortType);

		model.addAttribute("specialActivitys", specialActivitys);

		return "activity/special/specialActivityList";
	}

	// 创建框
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("specialActivity", new SpecialActivity());

		// List<MemberGrSpecialActivitye> memberGrSpecialActivityeList =
		// memberGrSpecialActivityeService.memberGrSpecialActivityeList();
		// model.SpecialActivitydAttribute("memberGrSpecialActivityeList", memberGrSpecialActivityeList);

		model.addAttribute("action", "create");
		return "activity/special/specialActivityForm";
	}

	// 添加板块
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> create(@Valid SpecialActivity specialActivity,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "创建失败，请重试！";
		if (specialActivity != null) {
			try {
				// 处理上传图片
				if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
					String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialActivity.setActivityImage(fileName);
					}
				}
				specialActivity.setBeginDate(new Timestamp(System.currentTimeMillis()));
				specialActivityService.saveSpecialActivity(specialActivity);
				code = "0000";
				message = "保存成功";

			} catch (Exception e) {
				e.printStackTrace();
				message = "可能填写错误了，请注意提示！";
			}
		}
		resultMap.put("code", code);
		resultMap.put("msg", message);

		return resultMap;
	}

	// 创建修改信息框
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, Model model) {
		SpecialActivity SpecialActivity = specialActivityService.getSpecialActivity(id);
		model.addAttribute("specialActivity", SpecialActivity);

		model.addAttribute("action", "update");
		return "activity/special/specialActivityForm";
	}

	// 修改信息框
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> update(@Valid @ModelAttribute("specialActivity") SpecialActivity specialActivity,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "修改失败，请重试！";
		if (specialActivity != null) {
			try {
				// 处理上传图片
				if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
					String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialActivity.setActivityImage(fileName);
					}
				}
				specialActivity.setBeginDate(new Timestamp(System.currentTimeMillis()));
				specialActivityService.saveSpecialActivity(specialActivity);
				code = "0000";
				message = "修改成功";

			} catch (Exception e) {
				e.printStackTrace();
				message = "可能填写错误了，请注意提示！";
			}
		}
		resultMap.put("code", code);
		resultMap.put("msg", message);

		return resultMap;
	}

	// 修改 是否 开启
	@RequestMapping(value = "changeStatus", method = RequestMethod.GET)
	public String changeStatus(@Valid @ModelAttribute("specialActivity") SpecialActivity specialActivity,
			@RequestParam(value = "status", defaultValue = "") boolean status) {

		try {
			if (null != specialActivity) {
				// SpecialActivity.setStatus(status);
				specialActivityService.saveSpecialActivity(specialActivity);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/activity/specialActivity/list";
	}

	// 删除专题活动
	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		specialActivityService.deleteSpecialActivity(id);
		redirectAttributes.addFlashAttribute("message", "删除成功");
		return "redirect:/activity/specialActivity/list";
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2
	 * Preparable二次部分绑定的效果,先根据form的id从数据库查出SiteSlide对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getSpecialActivity(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			SpecialActivity specialActivity = specialActivityService.getSpecialActivity(id);
			model.addAttribute("specialActivity", specialActivity);
		}
	}

}
