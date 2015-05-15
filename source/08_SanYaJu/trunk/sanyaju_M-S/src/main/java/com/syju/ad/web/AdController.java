package com.syju.ad.web;

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

import com.syju.ad.entity.Ad;
import com.syju.ad.service.AdService;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping("/ad")
public class AdController extends BaseController {

	// @Resource
	// private ForumService forumService;
	@Resource
	private AdService adService;

	// 遍历所有首页广告
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		Page<Ad> ads = adService.getAd(searchParams, pageNumber, pageSize, sortType);

		model.addAttribute("ads", ads);

		return "ad/adList";
	}

	// 创建框
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("ad", new Ad());

		model.addAttribute("action", "create");
		return "ad/adForm";
	}

	// 添加首页广告
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> create(@Valid Ad ad, @RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "创建失败，请重试！";

		if (null != ad) {
			try {
				// 处理上传图片
				if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
					String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						ad.setImageAddr(fileName);
					}
				}
				ad.setCreateTime(new Timestamp(System.currentTimeMillis()));
				adService.saveAd(ad);
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

	// 创建修改会员信息框
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, Model model) {
		Ad ad = adService.getAd(id);
		model.addAttribute("ad", ad);

		// List<MemberGrade> memberGradeList = memberGradeService.memberGradeList();
		// model.addAttribute("memberGradeList", memberGradeList);

		model.addAttribute("action", "update");
		return "ad/adForm";
	}

	// 修改会员信息框
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> update(@Valid @ModelAttribute("ad") Ad ad,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "修改失败，请重试！";
		if (ad != null) {
			try {
				// 处理上传图片
				if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
					String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						ad.setImageAddr(fileName);
					}
				}
				ad.setCreateTime(new Timestamp(System.currentTimeMillis()));
				adService.saveAd(ad);
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

	// 修改 论坛是否 开启
	@RequestMapping(value = "changeDisplay", method = RequestMethod.GET)
	public String changeDisplay(@Valid @ModelAttribute("ad") Ad ad,
			@RequestParam(value = "isDisplay", defaultValue = "") boolean isDisplay) {
		try {
			if (null != ad) {
				ad.setIsDisplay(isDisplay);
				adService.saveAd(ad);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/ad/list";
	}

	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		adService.deleteAd(id);
		redirectAttributes.addFlashAttribute("message", "删除成功");
		return "redirect:/ad/list";
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2
	 * Preparable二次部分绑定的效果,先根据form的id从数据库查出SiteSlide对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getAd(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			Ad ad = adService.getAd(id);
			model.addAttribute("ad", ad);
		}
	}

}
