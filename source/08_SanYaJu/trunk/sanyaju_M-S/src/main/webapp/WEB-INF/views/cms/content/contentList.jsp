<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>${(null != custom && custom ==1) ? cmsChannel.channelTitle : '文章管理' }</title>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>${(null != custom && custom ==1) ? cmsChannel.channelTitle : '文章管理' }</h1>
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
                <p><a class="btn" href="${ctx}/cms/content/create?custom=${custom }${null != cmsChannel.id ? '&channelId=' : '' }${null != cmsChannel.id ? cmsChannel.id : '' }"><i class="icon-plus"></i>  新增文章</a></p>
                 <table class="table table-bordered table-striped">
                     <thead>
                     <tr>
                         <th>文章标题</th>
                         <th>所属分类</th>
                         <th>发布时间</th>
                         <th>排序</th>
                         <th>显示</th>
                         <th>操作</th>
                     </tr>
                     </thead>
                     <tbody id="proList">
                     <c:if test="${not empty cmsContents && cmsContents.size >0 }">
                     <c:forEach items="${cmsContents.content}" var="content">
					 <tr>
						<td>${content.titel}&nbsp;</td>
						<td>${content.cmsChannel.channelTitle}&nbsp;</td>
						<td><fmt:formatDate value="${content.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</td>
						<td>${content.priority}&nbsp;</td>
						<td>${content.isDisplay ? '<span class="label label-success">显示</span>' : '<span class="label">隐藏</span>'}&nbsp;</td>
						<td>
							<a href="${ctx}/cms/content/update/${content.id}/${custom }" id="editLink-${content.id}" class="btn btn-mini">编辑</a>
							<a href="${ctx}/cms/content/delete/${content.id}" class="btn btn-mini">删除</a>
						</td>
					</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty cmsContents || cmsContents.size ==0 }">
						<tr>
	                       <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
	                   </tr>
					</c:if>
                     </tbody>
                 </table>
                <tags:pagination page="${cmsContents}" paginationSize="5"/>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

</body>
</html>
