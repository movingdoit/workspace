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
    		<li class="submenu ${fn:contains(url, '/bbs/slide') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>轮播图管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/bbs/slide/list')) ? 'class="active"' : ''}><a href="${ctx}/bbs/slide/list">轮播图列表</a></li>
	                <li ${fn:contains(url, '/bbs/slide/create') || fn:contains(url, '/slide/update') ? 'class="active"' : ''}><a href="${ctx}/bbs/slide/create">新增轮播图</a></li>
	            </ul>
	        </li>
	        
    		<li class="submenu ${fn:contains(url, '/bbs/forum') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>版块管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/bbs/forum/list')) ? 'class="active"' : ''}><a href="${ctx}/bbs/forum/list">版块列表</a></li>
	                <li ${fn:contains(url, '/bbs/forum/create') ? 'class="active"' : ''}><a href="${ctx}/bbs/forum/create">新建版块</a></li>
	            </ul>
	        </li>
	    	<li class="submenu ${(fn:contains(url, '/bbs/topic') || fn:contains(url, '/bbs/report') || fn:contains(url, '/bbs/post')) ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>话题管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/bbs/topic/list') || fn:contains(url, '/bbs/post/list')) ? 'class="active"' : ''}><a href="${ctx}/bbs/topic/list">话题列表</a></li>
	                <li ${fn:contains(url, '/bbs/report/untreated') || fn:contains(url, '/bbs/report/handle') ? 'class="active"' : ''}><a href="${ctx}/bbs/report/untreated">举报处理</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/member') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>会员管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/member/list')) ? 'class="active"' : ''}><a href="${ctx}/member/list">会员列表</a></li>
	                <li ${(fn:contains(url, '/member/create')) ? 'class="active"' : ''}><a href="${ctx}/member/create">添加会员</a></li>
	                <li ${fn:contains(url, '/member/grade/list') ? 'class="active"' : ''}><a href="${ctx}/member/grade/list">会员等级列表</a></li>
	                <li ${fn:contains(url, '/member/grade/create') ? 'class="active"' : ''}><a href="${ctx}/member/grade/create">添加会员等级</a></li>
	                <%-- <li ${(fn:contains(url, '/member/record/untreated') || fn:contains(url, '/member/handle/record') || fn:contains(url, '/member/data/') || fn:contains(url, '/member/info/') || fn:contains(url, '/member/address/')) ? 'class="active"' : ''}><a href="${ctx}/member/record/untreated">会员申请记录</a></li> --%>
	            </ul>
	        </li>
	        
	         <li class="submenu ${fn:contains(url, '/ad') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>广告管理</span> <span class="label"> > </span></a>
 	            <ul>
 	            	<li ${(fn:contains(url, '/ad/list')) ? 'class="active"' : ''}><a href="${ctx}/ad/list">广告列表</a></li>
	                <li ${(fn:contains(url, '/ad/create')) ? 'class="active"' : ''}><a href="${ctx}/ad/create">添加广告</a></li>
	                <%-- <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">楼盘展示页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">特价楼盘页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">搜索页广告</a></li>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">新闻咨询页广告</a></li> --%>
	            </ul>
	        </li>
	        
	         <li class="submenu ${fn:contains(url, '/activity/special') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>专题活动管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/activity/specialActivity/list')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/list">专题活动列表</a></li>
	                <li ${(fn:contains(url, '/activity/specialActivity/create')) ? 'class="active"' : ''}><a href="${ctx}/activity/specialActivity/create">添加专题</a></li>
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
