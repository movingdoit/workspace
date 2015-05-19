package com.syju.activity.special.web;

import java.io.File;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.syju.activity.special.entity.Slide;
import com.syju.activity.special.entity.SpecialActivity;
import com.syju.activity.special.entity.SpecialModelOne;
import com.syju.activity.special.entity.SpecialModelTwo;
import com.syju.activity.special.service.SpecialActivityService;
import com.syju.activity.special.service.SpecialModelOneService;
import com.syju.activity.special.service.SpecialModelTwoService;
import com.syju.commons.controller.BaseController;

@Controller
@RequestMapping("/activity/specialActivity")
public class SpecialActivityController extends BaseController {

	@Resource
	private SpecialActivityService specialActivityService;
	@Resource
	private SpecialModelOneService specialModelOneService;

	@Resource
	private SpecialModelTwoService specialModelTwoService;

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
		model.addAttribute("specialModelOne", new SpecialModelOne());

		// List<MemberGrSpecialActivitye> memberGrSpecialActivityeList =
		// memberGrSpecialActivityeService.memberGrSpecialActivityeList();
		// model.SpecialActivitydAttribute("memberGrSpecialActivityeList", memberGrSpecialActivityeList);

		model.addAttribute("action", "create");
		return "activity/special/specialActivityForm";
	}

	/***
	 * 保存文件
	 * 
	 * @param file
	 * @return
	 */
	private boolean saveFile(MultipartFile file, HttpServletRequest request) {
		// 判断文件是否为空
		if (!file.isEmpty()) {
			try {
				// 文件保存路径
				String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/"
						+ file.getOriginalFilename();
				// 转存文件
				file.transferTo(new File(filePath));
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	// 添加专题和模板一
	@RequestMapping(value = "createOne", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> createOne(@Valid SpecialActivity specialActivity,
			@Valid SpecialModelOne specialModelOne,
			@RequestParam(value = "files", required = false) MultipartFile[] files,
			@RequestParam(value = "attrList", required = false) String[] slidePath,
			@RequestParam(value = "activityImageFile", required = false) MultipartFile activityImage,
			@RequestParam(value = "topImageFile", required = false) MultipartFile topImage,
			@RequestParam(value = "navOneImageFile", required = false) MultipartFile navOneImage,
			@RequestParam(value = "navTwoImageFile", required = false) MultipartFile navTwoImage,
			@RequestParam(value = "houseTypeImageFile", required = false) MultipartFile houseTypeImage,
			@RequestParam(value = "houseImageOneFile", required = false) MultipartFile houseImageOne,
			@RequestParam(value = "houseImageTwoFile", required = false) MultipartFile houseImageTwo,
			@RequestParam(value = "houseImageThreeFile", required = false) MultipartFile houseImageThree,
			@RequestParam(value = "houseImageFourFile", required = false) MultipartFile houseImageFour,
			@RequestParam(value = "navThreeImageFile", required = false) MultipartFile navThreeImage,
			@RequestParam(value = "housesImageOneFile", required = false) MultipartFile housesImageOne,
			@RequestParam(value = "housesImageTwoFile", required = false) MultipartFile housesImageTwo,
			@RequestParam(value = "housesImageThreeFile", required = false) MultipartFile housesImageThree,
			HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "创建失败，请重试！";
		if (specialActivity != null) {
			try {
				// SpecialModelOne specialModelOne = new SpecialModelOne(); // new 一个新的模板一

				// 判断file数组不能为空并且长度大于0 （轮播图图片和链接地址）
				if (files != null && files.length > 0) {
					List<Slide> slides = new ArrayList<Slide>();
					// 循环获取file数组中得文件
					for (int i = 0; i < files.length; i++) {
						Slide slide = new Slide();
						MultipartFile file = files[i];
						// 处理上传图片
						if ((null != file) && StringUtils.isNotEmpty(file.getOriginalFilename())) {
							String fileName = uploadFile(file, request, UPLOAD_ROOT_PATH);
							if (StringUtils.isNotEmpty(fileName)) {
								slide.setSpecialModelOne(specialModelOne);
								slide.setSlideImage(fileName);
								slide.setSlidePath(slidePath[i]);
								slides.add(slide);
							}
						}
						specialModelOne.setSlides(slides);
					}

				}
				// 处理活动封面图片上传
				if ((null != activityImage) && StringUtils.isNotEmpty(activityImage.getOriginalFilename())) {
					String fileName = uploadFile(activityImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialActivity.setActivityImage(fileName);
					}
				}
				// 处理顶部大图图片上传
				if ((null != topImage) && StringUtils.isNotEmpty(topImage.getOriginalFilename())) {
					String fileName = uploadFile(topImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setTopImage(fileName);
					}
				}
				// 处理导航一图片上传
				if ((null != navOneImage) && StringUtils.isNotEmpty(navOneImage.getOriginalFilename())) {
					String fileName = uploadFile(navOneImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setNavOneImage(fileName);
					}
				}
				// 处理导航二图片上传
				if ((null != navTwoImage) && StringUtils.isNotEmpty(navTwoImage.getOriginalFilename())) {
					String fileName = uploadFile(navTwoImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setNavTwoImage(fileName);
					}
				}
				// 处理户型图片上传
				if ((null != houseTypeImage) && StringUtils.isNotEmpty(houseTypeImage.getOriginalFilename())) {
					String fileName = uploadFile(houseTypeImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHouseTypeImage(fileName);
					}
				}
				// 处理户型一图片上传
				if ((null != houseImageOne) && StringUtils.isNotEmpty(houseImageOne.getOriginalFilename())) {
					String fileName = uploadFile(houseImageOne, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHouseImageOne(fileName);
					}
				}
				// 处理户型二图片上传
				if ((null != houseImageTwo) && StringUtils.isNotEmpty(houseImageTwo.getOriginalFilename())) {
					String fileName = uploadFile(houseImageTwo, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHouseImageTwo(fileName);
					}
				}
				// 处理户型三图片上传
				if ((null != houseImageThree) && StringUtils.isNotEmpty(houseImageThree.getOriginalFilename())) {
					String fileName = uploadFile(houseImageThree, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHouseImageThree(fileName);
					}
				}
				// 处理户型四图片上传
				if ((null != houseImageFour) && StringUtils.isNotEmpty(houseImageFour.getOriginalFilename())) {
					String fileName = uploadFile(houseImageFour, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHouseImageFour(fileName);
					}
				}
				// 处理导航三图片上传
				if ((null != navThreeImage) && StringUtils.isNotEmpty(navThreeImage.getOriginalFilename())) {
					String fileName = uploadFile(navThreeImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setNavThreeImage(fileName);
					}
				}
				// 处理楼盘一图片上传
				if ((null != housesImageOne) && StringUtils.isNotEmpty(housesImageOne.getOriginalFilename())) {
					String fileName = uploadFile(housesImageOne, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHousesImageOne(fileName);
					}
				}
				// 处理楼盘二图片上传
				if ((null != housesImageTwo) && StringUtils.isNotEmpty(housesImageTwo.getOriginalFilename())) {
					String fileName = uploadFile(housesImageTwo, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHousesImageTwo(fileName);
					}
				}
				// 处理楼盘三图片上传
				if ((null != housesImageThree) && StringUtils.isNotEmpty(housesImageThree.getOriginalFilename())) {
					String fileName = uploadFile(housesImageThree, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelOne.setHousesImageThree(fileName);
					}
				}
				specialModelOneService.saveSpecialModelOne(specialModelOne);

				specialActivity.setBeginDate(new Timestamp(System.currentTimeMillis()));
				specialActivity.setSpecialModelOne(specialModelOne);
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

	// 添加专题和模板二
	@RequestMapping(value = "createTwo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> createTwo(@Valid SpecialActivity specialActivity,
			@Valid SpecialModelTwo specialModelTwo,
			@RequestParam(value = "activityImageFile", required = false) MultipartFile activityImage,
			@RequestParam(value = "topImageFile", required = false) MultipartFile topImage,
			@RequestParam(value = "housesPicFile", required = false) MultipartFile housesPic,
			@RequestParam(value = "houseTypeImageOneFile", required = false) MultipartFile houseTypeImageOne,
			@RequestParam(value = "houseTypeImageTwoFile", required = false) MultipartFile houseTypeImageTwo,
			HttpServletRequest request) {
		// 定义返回json格式的Map数据
		Map<String, String> resultMap = new HashMap<String, String>();
		String code = "1111";
		String message = "创建失败，请重试！";
		if (specialActivity != null) {
			try {
				// 处理活动封面图片上传
				if ((null != activityImage) && StringUtils.isNotEmpty(activityImage.getOriginalFilename())) {
					String fileName = uploadFile(activityImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialActivity.setActivityImage(fileName);
					}
				}
				// 处理顶部大图图片上传
				if ((null != topImage) && StringUtils.isNotEmpty(topImage.getOriginalFilename())) {
					String fileName = uploadFile(topImage, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelTwo.setTopImage(fileName);
					}
				}
				// 处理楼盘封面图片上传
				if ((null != housesPic) && StringUtils.isNotEmpty(housesPic.getOriginalFilename())) {
					String fileName = uploadFile(housesPic, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelTwo.setHousesPic(fileName);
					}
				}
				// 处理户型图一 图片上传
				if ((null != houseTypeImageOne) && StringUtils.isNotEmpty(houseTypeImageOne.getOriginalFilename())) {
					String fileName = uploadFile(houseTypeImageOne, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelTwo.setHouseTypeImageOne(fileName);
					}
				}
				// 处理户型图二图片上传
				if ((null != houseTypeImageTwo) && StringUtils.isNotEmpty(houseTypeImageTwo.getOriginalFilename())) {
					String fileName = uploadFile(houseTypeImageTwo, request, UPLOAD_ROOT_PATH);
					if (StringUtils.isNotEmpty(fileName)) {
						specialModelTwo.setHouseTypeImageTwo(fileName);
					}
				}

				specialModelTwoService.saveSpecialModelTwo(specialModelTwo);

				specialActivity.setBeginDate(new Timestamp(System.currentTimeMillis()));
				specialActivity.setSpecialModelTwo(specialModelTwo);
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
