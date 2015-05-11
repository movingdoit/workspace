<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>投票管理</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>投票管理</h1>
    </div>
    
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>
	
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/ams/vote/activity/create"><i class="icon-plus"></i>  发起投票</a></p>
                <table class="table table-bordered table-striped with-check">
                    <thead>
                    <tr>
                        <th><input id="title-checkbox" name="title-checkbox" type="checkbox"></th>
                        <th>投票标题</th>
                        <th>修改时间</th>
                        <th>状态</th>
                        <th>选项数量</th>
                        <th>浏览数量</th>
                        <th>投票数量</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty voteActivitys && voteActivitys.content != null && fn:length(voteActivitys.content) > 0}">
                     <c:forEach items="${voteActivitys.content}" var="activity">
						<tr>
							<td><input type="checkbox"></td>
							<td>${activity.title}&nbsp;</td>
							<td><fmt:formatDate value="${activity.modifyTime}" pattern="yyyy-MM-dd HH:mm"/>&nbsp;</td>
							<td><c:if test="${activity.status == 0}"><span class="label">未开始</span></c:if>
	                        <c:if test="${activity.status == 1}"><span class="label label-important">正在进行中</span></c:if>
	                        <c:if test="${activity.status == 2}"><span class="label">已结束</span></c:if>&nbsp;</td>
							<td>${fn:length(activity.voteItemList)}&nbsp;</td>
							<td>${activity.visitNumber}&nbsp;</td>
							<td>${activity.voteNumber}&nbsp;</td>
							<td>
								<%-- <shiro:hasPermission name="vote:edit"> --%>
									<a href="${baseUrl }${site.sitePath }/vote/${activity.id}" target="_blank" class="btn btn-mini">预览</a>
									<a href="${ctx}/ams/vote/activity/update/${activity.id}" class="btn btn-mini">编辑</a>
									<a href="${ctx}/ams/vote/activity/detail/${activity.id}" class="btn btn-mini">查看结果</a>
									<c:if test="${activity.status == 1}">
										<a href="${ctx}/ams/vote/activity/cancel/${activity.id}" class="btn btn-mini">结束投票</a>
									</c:if>
									<c:if test="${activity.status == 2}">
										<a href="${ctx}/ams/vote/activity/recover/${activity.id}" class="btn btn-mini">恢复投票</a>
									</c:if>
								<%-- </shiro:hasPermission> --%>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty voteActivitys || voteActivitys.content == null || fn:length(voteActivitys.content) == 0}">
						<tr>
	                       <td colspan="8" class="text-center"><strong>没有任何投票活动 *_*</strong></td>
	                   </tr>
					</c:if>
                    </tbody>
                </table>
                <!-- <p><button class="btn">结束所选投票</button></p> -->
                <c:if test="${not empty voteActivitys && voteActivitys.totalPages > 1}">
                	<tags:pagination page="${voteActivitys}" paginationSize="5"/>
                 </c:if>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

</body>
</html>
