<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="url" value="${pageContext.request.requestURL}"/>
<c:set var="parameterMap" value="${pageContext.request.parameterMap}"/>
<c:set var="parameters" value=""/>

<c:forEach var="parameter" items="${parameterMap}">   
	<c:set var="parameters" value="${parameter.key}=${parameter.value[0]}&${parameters }"/>
</c:forEach>  
<c:set var="parameters" value="${fn:substring(parameters, 0, (fn:length(parameters) -1)) }"/>

<!-- Sidebar Menu -->
<div id="sidebar">
    <ul>
    	<shiro:hasRole name="User">
    		 <li class="submenu ${fn:contains(url, '/house/detail') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>房源管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/house/detail/create')) ? 'class="active"' : ''}><a href="${ctx}/house/detail/create">楼盘详情</a></li>
	                <li ${ fn:contains(url, '/house/photo/create') ? 'class="active"' : ''}><a href="${ctx}/house/photo/create">楼盘相册</a></li>
	                <li ${ fn:contains(url, '/house/phototype/create') ? 'class="active"' : ''}><a href="${ctx}/house/phototype/create">楼盘户型</a></li>
	            </ul>
	        </li>
	        <li class="submenu ${((fn:contains(url, '/article/manager') || fn:contains(url, '/article/detail') || fn:contains(url, '/article/category'))
	                   && !fn:contains(parameters, 'custom=1')) ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i>
	             <span>文章管理</span> <span class="label"> > </span></a>

	            <ul>
	                <li ${(null != url && fn:contains(url, '/article/manager')) ? 'class="active"' : '' }>
		                <a href="/article/manager">新闻列表</a> 
		            </li>
		            <li ${(null != url && fn:contains(url, '/article/detail')) ? 'class="active"' : '' }>
		                <a href="/article/detail/create">新闻发布</a>
		            </li>
		             <li ${(null != url && fn:contains(url, '/article/category')) ? 'class="active"' : '' }>
		                <a href="/article/category">新闻分类</a>
		            </li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/activity/special') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>专题活动管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/activity/specialActivity/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/list">专题活动列表</a></li>
	                <li ${(fn:contains(url, '/activity/specialActivity/create')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/create">添加专题</a></li>
	                <li ${(fn:contains(url, '/activity/specialRecord/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialRecord/list">专题报名记录</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/activity/group') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>团购活动管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/activity/group/search')) ? 'class="active"' : ''}><a href="${ctx}/activity/group/search">团购活动列表</a></li>
	                <li ${(fn:contains(url, '/activity/group/create')) ? 'class="active"' : ''}><a href="${ctx}/activity/group/create">添加团购</a></li>
	                <li ${(fn:contains(url, '/activity/groupRecord/search')) ? 'class="active"' : ''}><a href="${ctx}/activity/groupRecord/search">团购报名记录</a></li>
	            </ul>
	        </li>
	         <li class="submenu ${fn:contains(url, '/ad') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>广告管理</span> <span class="label"> > </span></a>
 	            <ul>
 	            	<li ${(fn:contains(url, '/ad/list')) ? 'class="active"' : ''}><a href="${ctx}/ad/list">广告列表</a></li>
	                <li ${(fn:contains(url, '/ad/create')) ? 'class="active"' : ''}><a href="${ctx}/ad/create">新增广告</a></li>
	                <%-- <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">楼盘展示页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">特价楼盘页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">搜索页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">新闻咨询页广告</a></li> --%>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/activity/groupRecommend') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>团购推荐管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/activity/specialActivity/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/list">专题活动列表</a></li>
	                <li ${(fn:contains(url, '/activity/specialActivity/create')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/create">新增专题</a></li>
	                <li ${(fn:contains(url, '/activity/specialRecord/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialRecord/list">专题报名记录</a></li>
	                <li ${(fn:contains(url, '/activity/groupRecommend/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/groupRecommend/list">团购推荐列表</a></li>
	            </ul>
	        </li>
	        
	         <li class="submenu ${fn:contains(url, '/ad') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>广告管理</span> <span class="label"> > </span></a>
 	            <ul>
 	            	<li ${(fn:contains(url, '/ad/list')) ? 'class="active"' : ''}><a href="${ctx}/ad/list">广告列表</a></li>
	                <li ${(fn:contains(url, '/ad/create')) ? 'class="active"' : ''}><a href="${ctx}/ad/create">新增广告</a></li>
	                <%-- <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">楼盘展示页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">特价楼盘页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">搜索页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">新闻咨询页广告</a></li> --%>
	            </ul>
	        </li>
	        
	         <li class="submenu ${fn:contains(url, '/activity/special') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>专题活动管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/activity/specialActivity/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/list">专题活动列表</a></li>
	                <li ${(fn:contains(url, '/activity/specialActivity/create')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/create">新增专题</a></li>
	                <li ${(fn:contains(url, '/activity/specialRecord/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialRecord/list">专题报名记录</a></li>
	            </ul>
	        </li>
    	  
	        <li class="submenu ${fn:contains(url, '/specialHouse') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>特价楼盘管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/specialHouse/list')) ? 'class="active"' : ''}><a href="${ctx}/specialHouse/list">特价楼盘列表</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/featureHouse') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>特色楼盘管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/featureHouse/list')) ? 'class="active"' : ''}><a href="${ctx}/featureHouse/list">特色楼盘列表</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/houseRecommend') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>楼盘推荐管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/houseRecommend/list')) ? 'class="active"' : ''}><a href="${ctx}/houseRecommend/list">楼盘推荐列表</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/newGuide') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>新盘导购管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/newGuide/list')) ? 'class="active"' : ''}><a href="${ctx}/newGuide/list">新盘导购列表</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/hotRecommend') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>热点推荐管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/hotRecommend/list')) ? 'class="active"' : ''}><a href="${ctx}/hotRecommend/list">热点推荐列表</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/hotSort') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>热销排行管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/hotSort/list')) ? 'class="active"' : ''}><a href="${ctx}/hotSort/list">热销排行列表</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/newFav') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>最新优惠管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/newFav/list')) ? 'class="active"' : ''}><a href="${ctx}/newFav/list">最新优惠列表</a></li>
	            </ul>
	        </li>
	        
    	</shiro:hasRole>
    </ul>
</div>
<!-- // Sidebar Menu -->

