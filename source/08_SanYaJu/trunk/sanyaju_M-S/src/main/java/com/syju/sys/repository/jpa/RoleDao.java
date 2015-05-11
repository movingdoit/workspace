/*******************************************************************************
 * Copyright (c) 2005, 2014 springside.github.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *******************************************************************************/
package com.syju.sys.repository.jpa;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.syju.sys.entity.Role;

public interface RoleDao extends PagingAndSortingRepository<Role, Long> {

}
