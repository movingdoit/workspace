/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.commons.component.kindeditor;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.syju.commons.controller.BaseController;

/**
 * KindEditor图片上传组件
 * 
 * @author 德仁
 *
 */
@Controller
@RequestMapping(value = "/component/kindeditor")
public class UploadImage extends BaseController {

	/**
	 * 处理单个文件上传操作
	 * 
	 * @param imgFile
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "uploadImage", method = RequestMethod.POST)
	public String uploadImage(@RequestParam(value = "imgFile", required = false) MultipartFile imgFile,
			HttpServletRequest request, HttpServletResponse response) {

		String fileName = uploadFile(imgFile, request, UPLOAD_ROOT_PATH);
		JSONObject obj = new JSONObject();
		obj.put("error", 0);
		obj.put("url", fileName.replace(File.separatorChar, '/'));

		try {
			response.getWriter().write(obj.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
}
