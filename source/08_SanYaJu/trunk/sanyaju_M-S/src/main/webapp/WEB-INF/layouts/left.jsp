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
    	  
	        <li class="submenu ${((fn:contains(url, '/cms/content') || fn:contains(url, '/cms/channel')) && !fn:contains(parameters, 'custom=1')) ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>文章管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/cms/content') && !fn:contains(parameters, 'custom=1')) ? 'class="active"' : ''}><a href="${ctx}/cms/content/manager">文章管理</a></li>
	                <li ${fn:contains(url, '/cms/channel') ? 'class="active"' : ''}><a href="${ctx}/cms/channel">分类管理</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu ${fn:contains(url, '/ams/vote') ? 'active open' : ''}"> <a href="#"><i class="icon icon-leaf"></i> <span>投票管理</span> <span class="label"> > </span></a>
 	            <ul>
	                <li ${(fn:contains(url, '/ams/vote') && !fn:contains(url, '/ams/vote/activity/create')) ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity">投票列表</a></li>
	                <li ${fn:contains(url, '/ams/vote/activity/create') ? 'class="active"' : ''}><a href="${ctx}/ams/vote/activity/create">发起投票</a></li>
	            </ul>
	        </li>
	        
	        <li class="submenu">
	        	<a href="#"><i class="icon icon-leaf"></i><span>微喜帖管理</span><span class="label"> > </span></a>
	        	<ul>
	        		<li>
	        			<a href="${ctx}/wedding/invitation/list">婚礼邀请函管理</a>
	        		</li>
	        		<li>
	        			<a href="${ctx}/wedding/attache/list">邀请函封面管理</a>
	        		</li>
	        		<li>	
	        			<a href="${ctx}/wedding/photo/list">婚纱照管理</a>
	        		</li>
	        		<li>
	        			<a href="${ctx}/wedding/bless/list">祝福信息管理</a>
	        		</li>
	        		<li>
	        			<a href="${ctx}/wedding/acceptor/list">确认出席婚礼信息管理</a>
	        		</li>
	        	</ul>
	        </li>
    	</shiro:hasRole>
    </ul>
</div>
<!-- // Sidebar Menu -->
