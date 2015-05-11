<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>分类管理</title>
	<script>
		$(document).ready(function() {
			$("#account-tab").addClass("active");
		});
	</script>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>分类管理</h1>
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
                <p><a class="btn" href="${ctx}/cms/channel/create?pid=${pid}"><i class="icon-plus"></i>  新增分类</a></p>
                 <table class="table table-bordered table-striped">
                     <thead>
                     <tr>
						<th>分类标题</th>
						<th>上级分类</th>
						<th>显示顺序</th>
						<th>是否显示</th>
						<th>操作</th>
					</tr>
                     </thead>
                     <tbody id="proList">
                     <c:if test="${not empty cmsChannels && cmsChannels.size >0 }">
                     <c:forEach items="${cmsChannels.content}" var="channel">
						<tr>
							<td><a href="${ctx}/cms/channel?search_EQ_parent.id=${channel.id}" >${channel.channelTitle}</a>&nbsp;</td>
							<td>${null != channel.parent ? channel.parent.channelTitle : '无'}&nbsp;</td>
							<td>${channel.priority}&nbsp;</td>
							<td>${channel.isDisplay ? '是' : '否'}&nbsp;</td>
							<td>
								<a href="${ctx}/cms/channel/update/${channel.id}" id="editLink-${channel.id}" class="btn btn-mini">修改</a>
								<a href="${ctx}/cms/channel/delete/${channel.id}" class="btn btn-mini">删除</a>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty cmsChannels || cmsChannels.size ==0 }">
						<tr>
	                       <td colspan="8" class="text-center"><strong>没有任何分类 *_*</strong></td>
	                   </tr>
					</c:if>
                     </tbody>
                 </table>
                <tags:pagination page="${cmsChannels}" paginationSize="5"/>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

</body>
</html>
