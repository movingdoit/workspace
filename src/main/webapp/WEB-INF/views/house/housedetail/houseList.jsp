<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>楼盘列表</title>
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
			<h1>楼盘列表</h1>
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
					action="${ctx}/house/detail/search" method="get"
					style="position: relative; top: 0px; left: 700px; width: 100%; height: 100%;">
					<div class="form-group ml10">
						<select name="search_EQ_recommend" class="input-medium"
							id="recommend" data-rule-required="true">
							<option value=""></option>
							<c:forEach items="${recommend}" var="type">
								<c:choose>
									<c:when test="${search.EQ_recommend == type.key }">
										<option value="${type.key}" selected="selected">${type.value}</option>
									</c:when>
									<c:otherwise>
										<option value="${type.key}">${type.value}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> <input type="text" name="search_EQ_name"
							value="${search.EQ_name }" class="form-control"
							placeholder="请输入楼盘标题" style="width: 190px;">
						<button type="submit" class="btn btn-success ml10">搜索</button>
					</div>
				</form>
				<div class="span12">
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>编号</th>
								<th>楼盘标题</th>
								<th>发布时间</th>
								<th>均价</th>
								<th>推荐类目</th>
								<th>显示</th>
								<th>排序</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="proList">
							<c:if test="${not empty housePage && housePage.size >0 }">
								<c:forEach items="${housePage.content}" var="house">
									<tr>
										<c:if test="${not empty house.houseInfo }">
											<td>${house.houseInfo.id}&nbsp;</td>
											<td>${house.houseInfo.name}&nbsp;</td>
											<td><fmt:formatDate
													value="${house.houseInfo.createTime}"
													pattern="yyyy-MM-dd HH:mm:ss" /> &nbsp;</td>
											<td>${house.houseInfo.avgPrice}&nbsp;</td>
											<td>${recommendType}</td>
											<td>
												<c:if test="${house.houseInfo.isDisplay}"><a href="javascript:void(0)" onclick="changeDisplay(false,${house.houseInfo.id});" class="label label-success toggle-hide">显示</a></c:if>
												<c:if test="${!house.houseInfo.isDisplay}"><a href="javascript:void(0)" onclick="changeDisplay(true, ${house.houseInfo.id});" class="label toggle-show">隐藏</a></c:if>
											</td>
											<td>${house.priority}</td>
											<td>
											  <a href="${ctx}/cms/content/update/${house.houseInfo.id}" class="btn btn-mini">预览</a> 
											  <a href="${ctx}/house/detail/update/${house.houseInfo.id}" class="btn btn-mini">编辑</a> 
										      <a href="#"onclick="update(${house.houseInfo.id})" class="btn btn-mini">推荐</a>
											</td>
										</c:if>
										<c:if test="${empty house.houseInfo }">
											<td>${house.id}&nbsp;</td>
											<td>${house.name}&nbsp;</td>
											<td><fmt:formatDate
													value="${house.createTime}"
													pattern="yyyy-MM-dd HH:mm:ss" /> &nbsp;</td>
											<td>${house.avgPrice}&nbsp;</td>
											<td>&nbsp;</td>
											<td>
												<c:if test="${house.isDisplay}"><a href="javascript:void(0)" onclick="changeDisplay(false,${house.id});" class="label label-success toggle-hide">显示</a></c:if>
												<c:if test="${!house.isDisplay}"><a href="javascript:void(0)" onclick="changeDisplay(true, ${house.id});" class="label toggle-show">隐藏</a></c:if>
											</td>
											<td>&nbsp;</td>
											<td><a href="${ctx}/cms/content/update/${house.id}" class="btn btn-mini">预览</a> 
												<a href="${ctx}/house/detail/update/${house.id}" class="btn btn-mini">编辑</a>
												<a href="#" onclick="update(${house.id})" class="btn btn-mini">推荐</a>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty housePage || housePage.size ==0 }">
								<tr>
									<td colspan="8" class="text-center"><strong>没有任何信息
											*_*</strong></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<tags:pagination page="${housePage}" paginationSize="5" />
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
	// 修改新闻分类
	function update(id){
		$.get("${ctx}/house/detail/recommend/"+id,function(data){
			if(data){
	    		$('#myModal').html(data);
	   			$('#myModal').modal();
	    	}else{
	        	alert("操作失败,请联系管理员");
	    	}
		});
	}
	
	
	// 修改是否显示
	function changeDisplay(isDisplay, id){
		$.post("/house/detail/changeDisplay",{'isDisplay':isDisplay, 'id':id},function(data){
			data == true ? location.reload() : alert("操作失败,请联系管理员");
		})
	}
	
</script>

</body>


</html>
