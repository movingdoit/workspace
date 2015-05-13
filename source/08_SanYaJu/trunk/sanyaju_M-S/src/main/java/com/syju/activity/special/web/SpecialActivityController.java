package com.syju.activity.special.web;

import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springside.modules.web.Servlets;

import com.syju.activity.special.entity.SpecialActivity;
import com.syju.activity.special.service.SpecialActivityService;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping("/specialActivity")
public class SpecialActivityController extends BaseController {

	// @Resource
	// private ForumService forumService;
	@Resource
	private SpecialActivityService specialActivityService;

	// 遍历所有会员信息
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		// Page<SpecialActivity> forums = specialActivityService.SpecialActivityPage(pageNumber, pageSize, sortType,
		// searchParams);

		// model.SpecialActivitydAttribute("forums", forums);

		return "bbs/forum/forumList";
	}

	// 创建框
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("specialActivity", new SpecialActivity());

		// List<MemberGrSpecialActivitye> memberGrSpecialActivityeList =
		// memberGrSpecialActivityeService.memberGrSpecialActivityeList();
		// model.SpecialActivitydAttribute("memberGrSpecialActivityeList", memberGrSpecialActivityeList);

		model.addAttribute("action", "create");
		return "bbs/forum/forumForm";
	}

	// 添加板块
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> create(@Valid SpecialActivity SpecialActivity,
			@RequestParam(value = "forumTitle", defaultValue = "") String forumTitle,
			@RequestParam(value = "attrList", defaultValue = "") String fenlei[],
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "paixu", defaultValue = "1") Long priority, HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "论坛名字已存在，请换个！";

		if (0 == 0) { // 不为零时才能添加
			// Forum checkTile = forumService.checkTitle(forumTitle);// 验证数据库是否存在 改论坛名字
			// Forum checkPriority = forumService.checkPriority(priority); // 检查 排序号是否存在
			if (null == SpecialActivity) {
				try {
				} catch (Exception e) {
					e.printStackTrace();
					message = "可能填写错误了，请注意提示！";
				}
			}
		}
		resultMap.put("code", code);
		resultMap.put("msg", message);

		return resultMap;
	}

	// 创建修改会员信息框
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, Model model) {
		SpecialActivity SpecialActivity = specialActivityService.getSpecialActivity(id);
		model.addAttribute("specialActivity", SpecialActivity);

		// List<MemberGrSpecialActivitye> memberGrSpecialActivityeList =
		// memberGrSpecialActivityeService.memberGrSpecialActivityeList();
		// model.SpecialActivitydAttribute("memberGrSpecialActivityeList", memberGrSpecialActivityeList);

		model.addAttribute("action", "update");
		return "bbs/forum/forumForm";
	}

	// 修改会员信息框
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> update(@Valid @ModelAttribute("specialActivity") SpecialActivity specialActivity,
			@RequestParam(value = "attrList", defaultValue = "") String fenlei[],
			@RequestParam(value = "forumTitle", defaultValue = "") String forumTitle,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "paixu", defaultValue = "") Long priority, HttpServletRequest request) {
		if (null != specialActivity) {
		}
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "修改失败，请重试！";
		if (0 == 0) { // 不为0 是才能修改
			// SiteConfig siteConfig = siteService.getSiteConfigByUserId(getCurrentUserId());
			// Forum checkPriority = forumService.checkPriority(priority); // 检查 排序号是否存在
			// String checkTitle = forum.getTitle(); // 数据库的论坛名字
		}
		resultMap.put("code", code);
		resultMap.put("msg", message);

		return resultMap;
	}

	// 修改 论坛是否 开启
	@RequestMapping(value = "changeStatus", method = RequestMethod.GET)
	public String changeStatus(@Valid @ModelAttribute("SpecialActivity") SpecialActivity specialActivity,
			@RequestParam(value = "status", defaultValue = "") boolean status) {

		try {
			if (null != specialActivity) {
				// SpecialActivity.setStatus(status);
				specialActivityService.saveSpecialActivity(specialActivity);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/bbs/forum/list";
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
