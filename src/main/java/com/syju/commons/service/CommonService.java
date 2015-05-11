/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.commons.service;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.syju.commons.log.BusinessLogger;
import com.syju.sys.service.ShiroDbRealm.ShiroUser;

/**
 * 通用业务类.
 * 
 * @author 王德仁
 */
// Spring Service Bean的标识.
public class CommonService {

	/**
	 * Logger for Service class
	 */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	// protected NotifyMessageProducer notifyProducer;

	protected BusinessLogger businessLogger;

	@Autowired
	public void setBusinessLogger(BusinessLogger businessLogger) {
		this.businessLogger = businessLogger;
	}

	// @Autowired(required = false)
	// public void setNotifyProducer(NotifyMessageProducer notifyProducer) {
	// this.notifyProducer = notifyProducer;
	// }

	/**
	 * 取出Shiro中的当前用户LoginName.
	 */
	protected String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.loginName;
	}

}
