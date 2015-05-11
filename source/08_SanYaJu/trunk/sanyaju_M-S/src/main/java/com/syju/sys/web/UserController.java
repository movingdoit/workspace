/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.sys.web;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.web.Servlets;

import com.google.common.collect.Maps;
import com.syju.sys.entity.Role;
import com.syju.sys.entity.User;
import com.syju.sys.service.AccountService;
import com.syju.sys.service.ShiroDbRealm.ShiroUser;

@Controller
@RequestMapping(value = "/account/user")
public class UserController {

	private static Map<String, String> allStatus = Maps.newHashMap();

	static {
		allStatus.put("enabled", "有效");
		allStatus.put("disabled", "无效");
	}

	@Autowired
	private AccountService accountService;

	// 特别设定多个ReuireRoles之间为Or关系，而不是默认的And.
	// @RequiresRoles(value = { "Admin", "User" }, logical = Logical.OR)
	@RequiresRoles("Admin")
	@RequestMapping(value = "")
	public String list(Model model, ServletRequest request) {

		Map<String, Object> searchParams = Servlets.getParametersStartingWith(request, "search_");

		List<User> users = accountService.searchUser(searchParams);
		model.addAttribute("users", users);
		model.addAttribute("allStatus", allStatus);
		return "system/account/userList";
	}

	@RequiresRoles("Admin")
	@RequestMapping(value = "update/{id}", method = RequestMethod.GET)
	public String updateForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("user", accountService.getUser(id));
		model.addAttribute("allStatus", allStatus);
		model.addAttribute("allRoles", accountService.getAllRole());
		return "system/account/userForm";
	}

	/**
	 * 演示自行绑定表单中的checkBox roleList到对象中.
	 */
	// @RequiresPermissions("user:edit")
	@RequiresRoles("Admin")
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(@Valid @ModelAttribute("user") User user,
			@RequestParam(value = "roleList") List<Long> checkedRoleList, RedirectAttributes redirectAttributes) {

		// bind roleList
		user.getRoleList().clear();
		for (Long roleId : checkedRoleList) {
			Role role = new Role(roleId);
			user.getRoleList().add(role);
		}

		accountService.saveUser(user);

		redirectAttributes.addFlashAttribute("message", "保存用户成功");
		return "redirect:/account/user";
	}

	@RequiresRoles("User")
	@RequestMapping(value = "password/{id}", method = RequestMethod.GET)
	public String passwordForm(@PathVariable("id") Long id, Model model) {
		model.addAttribute("user", accountService.getUser(id));
		model.addAttribute("allStatus", allStatus);
		model.addAttribute("allRoles", accountService.getAllRole());
		return "system/account/userForm";
	}

	/**
	 * 演示自行绑定表单中的checkBox roleList到对象中.
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping(value = "password", method = RequestMethod.POST)
	public String password(@Valid @ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {

		// 取出Shiro中的当前用户Id.
		ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		String loginName = loginUser.loginName;
		Long loginId = loginUser.id;
		// 确保普通用户只能修改自己的账号信息
		if (!"admin".equals(loginName) && (loginId != user.getId())) {
			redirectAttributes.addFlashAttribute("message", "保存用户失败，权限不足！");
			return "redirect:/";
		}

		accountService.saveUser(user);

		redirectAttributes.addFlashAttribute("message", "保存用户成功");
		return "redirect:/account/user";
	}

	@RequiresRoles("User")
	@RequestMapping(value = "changePW", method = RequestMethod.GET)
	public String changePWForm() {
		return "system/account/changePW";
	}

	/**
	 * 演示自行绑定表单中的checkBox roleList到对象中.
	 */
	@RequiresPermissions("user:edit")
	@RequestMapping(value = "changePW", method = RequestMethod.POST)
	public String changePW(String oldPassword, String newPassword1, String newPassword2, Model model) {
		if (StringUtils.isNotEmpty(oldPassword)) {
			// 取出Shiro中的当前用户Id.
			ShiroUser loginUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			Long loginId = loginUser.id;

			User user = accountService.getUser(loginId);

			Subject subject = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(), oldPassword);
			try {
				// 验证老密码
				subject.login(token);
				if (StringUtils.isNotEmpty(newPassword1) && StringUtils.isNotEmpty(newPassword2)
						&& newPassword1.equals(newPassword2)) {
					// 更新新密码
					user.setPlainPassword(newPassword1);
					accountService.saveUser(user);
					model.addAttribute("message", "密码修改成功");
				} else {
					model.addAttribute("message", "密码修改失败，两次输入的新密码不一致！");
				}
			} catch (UnknownAccountException e) {
				model.addAttribute("message", "密码修改失败，您输入的当前密码不正确！");
			} catch (IncorrectCredentialsException e) {
				model.addAttribute("message", "密码修改失败，您输入的当前密码不正确！");
			} catch (AuthenticationException e) {
				// 其他错误，比如锁定，如果想单独处理请单独catch处理
				model.addAttribute("message", "密码修改失败，您输入的当前密码不正确！");
			}

		} else {
			model.addAttribute("message", "密码修改失败，当前密码不能为空！");
		}

		return "system/account/changePW";
	}

	@RequestMapping(value = "checkLoginName")
	@ResponseBody
	public String checkLoginName(@RequestParam("oldLoginName") String oldLoginName,
			@RequestParam("loginName") String loginName) {
		if (loginName.equals(oldLoginName)) {
			return "true";
		} else if (accountService.findUserByLoginName(loginName) == null) {
			return "true";
		}

		return "false";
	}

	/**
	 * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2
	 * Preparable二次部分绑定的效果,先根据form的id从数据库查出User对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
	 */
	@ModelAttribute
	public void getUser(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("user", accountService.getUser(id));
		}
	}

	/**
	 * 不自动绑定对象中的roleList属性，另行处理。
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setDisallowedFields("roleList");
	}
}
