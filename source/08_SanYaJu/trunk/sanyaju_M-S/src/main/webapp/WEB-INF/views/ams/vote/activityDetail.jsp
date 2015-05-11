<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>投票详细页</title>
	
	<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
    <link rel="stylesheet" href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-fileupload.css">
    
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>
            <div class="pull-right signout">
                <a href="javascript:history.go(-1);" class="btn pull-right"><i class="icon icon-fast-backward"></i> 返回</a>
            </div>
            ${voteActivity.title }
        </h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <table class="table table-bordered">
                    <tbody>
                    <tr>
                        <td>状态：
	                        <c:if test="${voteActivity.status == 0}"><span class="label">未开始</span></c:if>
	                        <c:if test="${voteActivity.status == 1}"><span class="label label-important">正在进行中</span></c:if>
	                        <c:if test="${voteActivity.status == 2}"><span class="label">已结束</span></c:if>
					  	</td>
                        <td>建立时间：<b><fmt:formatDate value="${voteActivity.createTime}" pattern="yyyy.MM.dd"/></b></td>
                        <td>选项数量：<b>${fn:length(voteActivity.voteItemList) }</b></td>
                    </tr>
                    <tr>
                        <td colspan="2">投票时间：<b><fmt:formatDate value="${voteActivity.startTime}" pattern="yyyy.MM.dd HH:mm"/></b> 至 <b><fmt:formatDate value="${voteActivity.endTime}" pattern="yyyy.MM.dd HH:mm"/></b></td>
                        <c:set var="nowTime" value="<%=System.currentTimeMillis()%>" />
                        <c:set var="interval" value="${(nowTime - voteActivity.startTime.time) / (3600*1000)}"/>
                        <td>已进行：<b><fmt:formatNumber type='number' value='${interval}' maxFractionDigits="0"></fmt:formatNumber> 时</b></td>
                    </tr>
                    <tr>
                        <td>浏览数量：<b>${voteActivity.visitNumber}</b></td>
                        <c:set var="voteNumber" value="0"/>
                        <c:if test="${not empty voteActivity.voteItemList && fn:length(voteActivity.voteItemList) > 0}">
	                    <c:forEach items="${voteActivity.voteItemList}" var="item" varStatus="status">
							<c:set var="voteNumber" value="${voteNumber + item.voteNumber}"/>
						</c:forEach>
						</c:if>
                        <td>投票数量：<b>${voteNumber }</b></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>排名</th>
                        <th>编号</th>
                        <th>选项标题</th>
                        <th>投票数量</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty voteActivity.voteItemList && fn:length(voteActivity.voteItemList) > 0}">
                    <c:forEach items="${voteActivity.voteItemList}" var="item" varStatus="status">
						<tr>
							<td>${status.index + 1}&nbsp;</td>
							<td>${item.id}&nbsp;</td>
							<td>${item.title}&nbsp;</td>
							<td>${item.voteNumber}&nbsp;</td>
						</tr>
					</c:forEach>
					</c:if>
                    <c:if test="${empty voteActivity.voteItemList || voteActivity.voteItemList == null || fn:length(voteActivity.voteItemList) == 0}">
						<tr>
	                        <td colspan="4" class="text-center"><strong>没有任何投票项目 *_*</strong></td>
	                   </tr>
					</c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
</body>
</html>
