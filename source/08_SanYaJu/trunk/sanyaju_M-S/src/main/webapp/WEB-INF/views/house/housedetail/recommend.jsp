<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>推荐选择</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

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
			<h1>
				<i class="icon-edit"></i>推荐选择
			</h1>
		</div>
		<!-- // Breadcrumbs -->
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">

						<div class="widget-content nopadding">
							<form id="recommendForm" action="/house/detail/recommend"
								method="post" class="form-horizontal form-validate"
								enctype="multipart/form-data">
								<input type="hidden" name="id" value="${house.id}">
								
								<c:forEach items="${recommend}" var="type">
								<div class="control-group">
								    <div class="controls">
									<c:choose>
                                        <c:when test="${fn:contains(house.recommend, type.key)}">
                                           ${type.value}<input type="checkbox" class="span1" name="recommend" value="${type.key}" checked="checked"/>
                                        </c:when>
	                                    <c:otherwise>
	                                       ${type.value}<input type="checkbox" class="span1"  name="recommend" value="${type.key}" />
	                                    </c:otherwise>
                                    </c:choose>
									</div>
								</div>
								</c:forEach>
								
								<div class="modal-footer">
									<button class="btn" data-dismiss="modal" aria-hidden="true" id="channel">关闭</button>
									<button type="button" id="save" class="btn btn-primary">保存</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- // Action Boxes -->
	</div>
	

	<!-- // Main Container -->
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


	<!-- 配置文件 -->
	<script type="text/javascript"
		src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
	<!-- 编辑器源码文件 -->
	<script type="text/javascript"
		src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>

	<script src="/static/assets/js/jquery.min.js"></script>
	<script src="/static/assets/js/jquery.form.min.js"></script>
	<script src="/static/assets/js/bootstrap.min.js"></script>
	<script src="/static/assets/js/validation/jquery.validate.min.js"></script>
	<script src="/static/assets/js/validation/additional-methods.min.js"></script>
	<script
		src="/static/assets/js/validation/localization/messages_zh.min.js"></script>
	<script src="/static/assets/js/daterangepicker/daterangepicker.js"></script>
	<script src="/static/assets/js/daterangepicker/moment.min.js"></script>
	<script src="/static/assets/js/fileupload/bootstrap-fileupload.min.js"></script>
	<script src="/static/assets/js/zhenyuan.js"></script>
	<script>
	    
	    
	    $("#channel").click(function(){
	    	//window.close();
	    	location.href = "${ctx}/house/detail/list";
	    });
	
		$("#save").click(function() {
			//if ($("#categoryForm").valid()) {
				$("#recommendForm").ajaxSubmit(function(data) { //提交成功的回调函数  
					if (data.code=="0000") {
						alert(data.message);
						location.href = "${ctx}/house/detail/list";
						//location.reload();
					} else {
						alert(data.message);
					}
				});
			//};
		});
	</script>
</body>
</html>
