<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="url" value="${pageContext.request.requestURL}"/>
<!-- Header -->
<div id="header">
    <h1><a href="${'' != ctx ? ctx : '/'}">航冠科技后台管理系统</a></h1>
</div>
<!-- // Header -->
<!-- Top Menu -->
<div id="top-menu" class="navbar navbar-inverse">
    <ul id="user-nav" class="nav">
    	<shiro:user>
        <li class="dropdown" id="profile-messages">
            <a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle">
                <img class="top-avatar" src="http://duomi.me/favicon.ico">  <span class="text"><shiro:principal property="name"/></span><b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
                <li><a href="${ctx}/account/user/changePW"><i class="icon-user"></i>修改密码</a></li>
                <li class="divider"></li>
                <li><a href="${ctx}/logout"><i class="icon-key"></i> 退出</a></li>
            </ul>
        </li>
        <li><a title="" href="${ctx}/logout"><i class="icon icon-share-alt"></i> <span class="text">退出</span></a></li>
        </shiro:user>
        
        <shiro:guest><li class=""><a title="" href="${ctx}/login"><i class="icon icon-share-alt"></i> <span class="text">登录</span></a></li></shiro:guest>
    </ul>
    <ul id="main-nav" class="nav">
		<shiro:hasRole name="User">  
	        <li class="active"><a href="${'' != ctx ? ctx : ''}/cms/content/manager"><span class="text">插件开发</span></a></li>
    	</shiro:hasRole>
    </ul>
</div>
<!-- // Top Menu -->