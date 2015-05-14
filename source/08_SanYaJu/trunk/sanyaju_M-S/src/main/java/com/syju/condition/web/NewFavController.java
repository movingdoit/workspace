package com.syju.condition.web;

import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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

import com.syju.commons.controller.BaseController;
import com.syju.condition.entity.NewFav;
import com.syju.condition.service.NewFavService;

@Controller
@RequestMapping("/newFav")
public class NewFavController extends BaseController {

	@Resource
	private NewFavService newFavService;

	// 遍历所有最新优惠
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String lsit(@RequestParam(value = "page", defaultValue = "1") int pageNumber,
			@RequestParam(value = "page.size", defaultValue = "10") int pageSize,
			@RequestParam(value = "sortType", defaultValue = "auto") String sortType, Model model,
			HttpServletRequest request) throws ParseException {
		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");
		Page<NewFav> newFavs = newFavService.getNewFav(searchParams, pageNumber, pageSize, sortType);

		model.addAttribute("newFavs", newFavs);

		return "commons/newFav/newFavList";
	}

	// 创建框
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("newFav", new NewFav());

		// List<MemberGrnewFave> memberGrnewFaveList = memberGrnewFaveService.memberGrnewFaveList();
		// model.newFavdAttribute("memberGrnewFaveList", memberGrnewFaveList);

		model.addAttribute("action", "create");
		return "bbs/forum/forumForm";
	}

	// 添加板块
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> create(@Valid NewFav newFav,
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
			if (null == newFav) {
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
		NewFav newFav = newFavService.getNewFav(id);
		model.addAttribute("newFav", newFav);

		// List<MemberGrnewFave> memberGrnewFaveList = memberGrnewFaveService.memberGrnewFaveList();
		// model.newFavdAttribute("memberGrnewFaveList", memberGrnewFaveList);

		model.addAttribute("action", "update");
		return "bbs/forum/forumForm";
	}

	// 修改会员信息框
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> update(@Valid @ModelAttribute("newFav") NewFav newFav,
			@RequestParam(value = "attrList", defaultValue = "") String fenlei[],
			@RequestParam(value = "forumTitle", defaultValue = "") String forumTitle,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "paixu", defaultValue = "") Long priority, HttpServletRequest request) {
		if (null != newFav) {
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
		newFavService.move(id, type);
	}

	@RequestMapping(value = "delete/{id}")
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
		NewFav newFav = newFavService.getNewFav(id);
		Long priority = newFav.getPriority(); // 获取删除的分类排序号
		newFavService.deleteNewFav(id);

		newFavService.moveSorting(priority); // 删除后后，批量修改排序号（-1）

		redirectAttributes.addFlashAttribute("message", "删除成功");
		return "redirect:/newFav/list";
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2
	 * Preparable二次部分绑定的效果,先根据form的id从数据库查出SiteSlide对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getNewFav(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			NewFav newFav = newFavService.getNewFav(id);
			model.addAttribute("newFav", newFav);
		}
	}

}
