<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>婚礼邀请函管理</title>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>婚礼邀请函信息管理</h1>
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
                <p><a class="btn" href="${ctx}/wedding/invitation/edit"><i class="icon-plus"></i>  新增邀请函</a></p>
                 <table class="table table-bordered table-striped">
                     <thead>
                     <tr>
                         <th>标题</th>
                         <th>新郎</th>
                         <th>新娘</th>
                         <th>举办地点</th>
                         <th>举办时间</th>
                         <th>经度</th>
                         <th>纬度</th>
                         <th>操作</th>
                     </tr>
                     </thead>
                     <tbody id="proList">
                     <c:if test="${not empty pageData && pageData.size >0 }">
	                     <c:forEach items="${pageData.content}" var="item" varStatus="sta_">
							 <tr>
								<td>${item.subject}</td>
								<td>${item.groom}</td>
								<td>${item.bride}</td>
								<td>${item.weddingAddress}</td>
								<td>${item.weddingTime}</td>
								<td>${item.mapLongitude}</td>
								<td>${item.mapLatitude}</td>
								<td>
									<a href="${ctx}/wedding/invitation/edit?id=${item.id}">修改</a> |
									<a href="${ctx}/wedding/invitation/delete?id=${item.id}">删除</a> 
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty pageData || pageData.size ==0 }">
						<tr>
	                       <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
	                   </tr>
					</c:if>
                     </tbody>
                 </table>
                <tags:pagination page="${pageData}" paginationSize="5"/>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

</body>
</html>
