/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.sys.repository.jpa;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.sys.entity.User;

public interface UserDao extends PagingAndSortingRepository<User, Long>,
		JpaSpecificationExecutor<User> {

	User findByName(String name);

	User findByLoginName(String loginName);
}
