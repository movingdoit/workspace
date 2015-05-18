<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>楼盘相册列表</title>
<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-fileupload.css">

<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>

<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js"
	type="text/javascript"></script>
<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js"
	type="text/javascript"></script>
</head>

<body>

	<!-- Main Container -->
	<div id="content">
		<!-- Breadcrumbs -->
		<div id="content-header">
			<h1>楼盘户型图列表</h1>
		</div>

		<c:if test="${not empty message}">
			<div id="message" class="alert alert-success">
				<button data-dismiss="alert" class="close">×</button>${message}</div>
		</c:if>

		<!-- // Breadcrumbs -->
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<form class="form-inline pt15 pb15"
					action="${ctx}/house/phototype/search" method="get"
					style="position: relative; top: 0px; left: 700px; width: 100%; height: 100%;">
					<div class="form-group ml10">
						<select name="search_EQ_type" class="input-medium"
							id="type" data-rule-required="true">
							<option value=""></option>
							<c:forEach items="${type}" var="type">
								<c:choose>
									<c:when test="${search.EQ_type == type.key }">
										<option value="${type.key}" selected="selected">${type.value}</option>
									</c:when>
									<c:otherwise>
										<option value="${type.key}">${type.value}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> <input type="text" name="search_EQ_name"
							value="${search.EQ_name }" class="form-control"
							placeholder="请输入相册名称" style="width: 190px;">
						<button type="submit" class="btn btn-success ml10">搜索</button>
					</div>
				</form>
				<div class="span12">
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
							    <th>相册编号</th>
								<th>图片名称</th>
								<th>图片</th>
								<th>图片类型</th>
								<th>上传时间</th>
								<th>外链地址</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="proList">
							<c:if test="${not empty photoPage && photoPage.size >0 }">
								<c:forEach items="${photoPage.content}" var="photo">
									<tr>
									    <td>${photo.id}&nbsp;</td>
										<td>${photo.name}&nbsp;</td>
										<td>
										    <c:if test="${null != photo.imageAddr && photo.imageAddr != '' }">
										    	<img width="80px" height="100px"  alt="" src="${photo.imageAddr}"/>
										    </c:if>
										</td>
										<td>
										   <c:forEach items="${type}" var="type">
										   	   <c:if test="${type.key == photo.houseType}">
										   	   		${type.value}
										   	   </c:if>
										   </c:forEach>
										</td>
										<td>${photo.photoDate}&nbsp;</td>
										<td>${photo.forwardAddr}</td>
										<td>
										  <a href="${ctx}/house/phototype/update/${photo.id}" class="btn btn-mini">编辑</a> 
										  <a href="#" onclick="del(${photo.id})" class="btn btn-mini">删除</a> 
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty photoPage || photoPage.size ==0 }">
								<tr>
									<td colspan="6" class="text-center"><strong>没有任何信息
											*_*</strong></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<tags:pagination page="${photoPage}" paginationSize="5" />
				</div>
			</div>
		</div>
		<!-- // Action Boxes -->
	</div>
	<!-- // Main Container -->
	<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"></div>


	<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
		src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
	<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
	<script
		src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
	<script src="${ctx}/static/assets/js/form-wizard.js"></script>

	<script type="text/javascript">
	     function del(id){
	    	 if(confirm("确认删除吗？")){
	    		 $.post("${ctx}/house/phototype/delete/"+id,function(data){
	    			 debugger;
	 				alert(data.message);
	 				location.href = "${ctx}/house/phototype/search";
	 			});
	    	 }
	     }
	   
	</script>

</body>


</html>
