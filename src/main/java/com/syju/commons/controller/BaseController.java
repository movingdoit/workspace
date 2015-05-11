package com.syju.commons.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.common.collect.Maps;
import com.syju.commons.log.BusinessLogger;
import com.syju.sys.service.ShiroDbRealm.ShiroUser;

/**
 * 基础控制器，其他控制器需集成此控制器获得initBinder自动转换的功能
 * 
 * @author 张代浩
 * 
 */
@Controller
@RequestMapping("/baseController")
public class BaseController {

	protected static final String PAGE_SIZE = "5";
	protected static final String UPLOAD_ROOT_PATH = "/static/upload/";
	protected static final String DOWNLOAD_ROOT_PATH = "/static/download/";
	protected static final String BASE_URL = "http://www.taojr.com/";

	/**
	 * Logger for Service class
	 */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	protected BusinessLogger businessLogger;

	// 记录状态
	protected static Map<String, String> allStatus = Maps.newHashMap();
	static {
		allStatus.put("enabled", "有效");
		allStatus.put("disabled", "无效");
	}

	// 是否显示
	protected static Map<String, String> allDisplay = Maps.newHashMap();
	static {
		allDisplay.put("false", "隐藏");
		allDisplay.put("true", "显示");
	}

	// 绑定类型
	protected static Map<String, String> allBindType = Maps.newHashMap();
	static {
		allBindType.put("cms", "文章");
		allBindType.put("pro", "产品");
		allBindType.put("jingpin", "精品推荐");
		allBindType.put("youhui", "优惠活动");
		allBindType.put("pinpai", "品牌故事");
		allBindType.put("contact", "联系我们");
		allBindType.put("link", "链接");
		allBindType.put("fenlei", "全部产品");
		allBindType.put("personal", "个人中心");
	}

	/**
	 * 不自动绑定对象中的roleList属性，另行处理。
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setDisallowedFields("roleList");
	}

	/**
	 * 取出Shiro中的当前用户Id.
	 */
	protected Long getCurrentUserId() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.id;
	}

	/**
	 * 取出Shiro中的当前用户LoginName.
	 */
	protected String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.name;
	}

	/**
	 * 取出Shiro中的当前用户LoginName.
	 */
	protected String getCurrentLoginName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}

	/**
	 * 上传文件-返回成功上传存储的文件路径
	 * 
	 * @param file
	 * @param request
	 * @param rootPath
	 * @return
	 */
	protected String uploadFile(MultipartFile file, HttpServletRequest request, String rootPath) {
		Calendar calendar = Calendar.getInstance();// 可以对每个时间域单独修改
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		// 设置存储的相对目录
		String path = new StringBuffer("").append(rootPath).append(getCurrentUserId()).append("/").append(year)
				.append("-").append(month).append("/").toString();
		String realPath = request.getSession().getServletContext().getRealPath(path);
		String fileName = file.getOriginalFilename();
		if (StringUtils.isNotEmpty(fileName)) {
			String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			fileName = new StringBuffer("").append(new Date().getTime()).append(fileType).toString();
			System.out.println(realPath);
			File targetFile = new File(realPath, fileName);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			// 保存文件
			try {
				file.transferTo(targetFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new StringBuffer(path).append(fileName).toString();
	}

	/**
	 * 上传文件-返回成功上传存储的文件名
	 * 
	 * @param file
	 * @param request
	 * @param rootPath
	 * @return
	 */
	protected List<Map<String, String>> uploadFileList4Map(MultipartHttpServletRequest request, String rootPath) {

		MultiValueMap<String, MultipartFile> multiValueMap = request.getMultiFileMap();
		Calendar calendar = Calendar.getInstance();// 可以对每个时间域单独修改
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		// 设置存储的相对目录
		String path = new StringBuffer("").append(rootPath).append(getCurrentUserId()).append("/").append(year)
				.append("-").append(month).append("/").toString();
		String realPath = request.getSession().getServletContext().getRealPath(path);
		String fileName = "";
		List<Map<String, String>> nameList = null;
		if ((null != multiValueMap) && !multiValueMap.isEmpty()) {
			nameList = new ArrayList<Map<String, String>>();
			for (String key : multiValueMap.keySet()) {
				List<MultipartFile> fileList = multiValueMap.get(key);
				if ((null != fileList) && (fileList.size() > 0)) {
					for (int i = 0; i < fileList.size(); i++) {
						MultipartFile file = fileList.get(i);
						fileName = file.getOriginalFilename();
						if (StringUtils.isNotEmpty(fileName)) {
							String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
							String saveName = new StringBuffer("").append(new Date().getTime()).append(fileType)
									.toString();
							System.out.println(realPath);
							File targetFile = new File(realPath, saveName);
							if (!targetFile.exists()) {
								targetFile.mkdirs();
							}
							// 保存文件
							try {
								file.transferTo(targetFile);
							} catch (Exception e) {
								e.printStackTrace();
							}
							String storPath = ((new StringBuffer(path).append(saveName)).toString()).replace(
									File.separatorChar, '/');
							Map<String, String> nameMap = new HashMap<String, String>();
							nameMap.put("key_" + fileName.replace(".", "_"), storPath);

							nameList.add(nameMap);
						}
					}
				}
			}
		}
		return nameList;
	}

	/**
	 * 上传文件-返回成功上传存储的文件名
	 * 
	 * @param file
	 * @param request
	 * @param rootPath
	 * @return
	 */
	protected List<String> uploadFile(MultipartHttpServletRequest request, String rootPath) {

		MultiValueMap<String, MultipartFile> multiValueMap = request.getMultiFileMap();
		Calendar calendar = Calendar.getInstance();// 可以对每个时间域单独修改
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		// 设置存储的相对目录
		String path = new StringBuffer("").append(rootPath).append(getCurrentUserId()).append("/").append(year)
				.append("-").append(month).append("/").toString();
		String realPath = request.getSession().getServletContext().getRealPath(path);
		String fileName = "";
		List<String> nameList = null;
		if ((null != multiValueMap) && !multiValueMap.isEmpty()) {
			nameList = new ArrayList<String>();
			for (String key : multiValueMap.keySet()) {
				List<MultipartFile> fileList = multiValueMap.get(key);
				if ((null != fileList) && (fileList.size() > 0)) {
					for (int i = 0; i < fileList.size(); i++) {
						MultipartFile file = fileList.get(i);
						fileName = file.getOriginalFilename();
						if (StringUtils.isNotEmpty(fileName)) {
							String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
							String saveName = new StringBuffer("").append(new Date().getTime()).append(fileType)
									.toString();
							System.out.println(realPath);
							File targetFile = new File(realPath, saveName);
							if (!targetFile.exists()) {
								targetFile.mkdirs();
							}
							// 保存文件
							try {
								file.transferTo(targetFile);
							} catch (Exception e) {
								e.printStackTrace();
							}
							nameList.add(((new StringBuffer(path).append(saveName)).toString()).replace(
									File.separatorChar, '/'));
						}
					}
				}
			}
		}
		return nameList;
	}

	/**
	 * 上传文件-返回成功上传存储的File文件对象
	 * 
	 * @param file
	 * @param request
	 * @param rootPath
	 * @return
	 */
	protected File uploadFile2(MultipartFile file, HttpServletRequest request, String rootPath) {
		Calendar calendar = Calendar.getInstance();// 可以对每个时间域单独修改
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		// 设置存储的相对目录
		String path = new StringBuffer("").append(rootPath).append(getCurrentUserId()).append("/").append(year)
				.append("-").append(month).append("/").toString();
		String realPath = request.getSession().getServletContext().getRealPath(path);
		String fileName = file.getOriginalFilename();
		File targetFile = null;
		if (StringUtils.isNotEmpty(fileName)) {
			String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			fileName = new StringBuffer("").append(new Date().getTime()).append(fileType).toString();
			System.out.println(realPath);
			targetFile = new File(realPath, fileName);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			// 保存文件
			try {
				file.transferTo(targetFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return targetFile;
	}

	/**
	 * searchParams中key的格式为OPERATOR_FIELDNAME
	 */
	protected Map<String, Object> parse(Map<String, Object> searchParams) {
		Map<String, Object> filters = Maps.newHashMap();

		for (Entry<String, Object> entry : searchParams.entrySet()) {
			// 过滤掉空值
			String key = entry.getKey();
			Object value = entry.getValue();
			if (StringUtils.isBlank((String) value)) {
				continue;
			}

			// 拆分operator与filedAttribute
			String[] names = StringUtils.split(key, "_");
			if (names.length != 2) {
				throw new IllegalArgumentException(key + " is not a valid search filter name");
			}
			String filedName = names[1];
			filters.put(filedName, value);
		}

		return filters;
	}

	protected void setShopURL(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String request_url = new StringBuffer(
				(StringUtils.isNotEmpty(request.getRequestURL())) ? request.getRequestURL() : "").toString();
		String query_string = new StringBuffer(
				(StringUtils.isNotEmpty(request.getQueryString())) ? ("?" + request.getQueryString()) : "").toString();
		// 获取当前请求URL
		String redirect_uri = new StringBuffer().append(request_url).append(query_string).toString();
		System.out.println(">>>shopURL: " + redirect_uri);

		session.setAttribute("shopURL", redirect_uri);
	}

	protected void setRequestURL(String urlKey, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String request_url = new StringBuffer(
				(StringUtils.isNotEmpty(request.getRequestURL())) ? request.getRequestURL() : "").toString();
		String query_string = new StringBuffer(
				(StringUtils.isNotEmpty(request.getQueryString())) ? ("?" + request.getQueryString()) : "").toString();
		// 获取当前请求URL
		String redirect_uri = new StringBuffer().append(request_url).append(query_string).toString();
		System.out.println(urlKey + ":>>> " + redirect_uri);

		session.setAttribute(urlKey, redirect_uri);
	}

	@Autowired
	public void setBusinessLogger(BusinessLogger businessLogger) {
		this.businessLogger = businessLogger;
	}
}
