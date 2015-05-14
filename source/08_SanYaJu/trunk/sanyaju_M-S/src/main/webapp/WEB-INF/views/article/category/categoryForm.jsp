<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>${action == 'create' ? '添加' : '编辑' }新闻分类</title>


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
				<i class="icon-edit"></i> ${action == 'create' ? '添加' : '编辑' }新闻分类
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
							<form id="categoryForm" action="/article/category/${action }"
								method="post" class="form-horizontal form-validate"
								enctype="multipart/form-data">
								<input type="hidden" name="id" value="${category.id}">
								<div class="control-group">
									<label class="control-label"><span class="maroon">*</span>
										分类名称 :</label>
									<div class="controls">
										<input type="text" id="name" name="name"
											value="${category.name}" class="span3"
											data-rule-required="true" data-rule-maxlength="20"
											placeholder="最多20个字符">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">显示顺序 :</label>
									<div class="controls">
										<input type="text" class="span1" id="priority" name="priority"
											value="${category.priority}" data-rule-number="true">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">是否显示 :</label>
									<div class="controls">
										<label class="radio inline"><input type="radio"
											name="isDisplay" value="true" id="isTrue"
											${category.isDisplay ? 'checked' : ''}>显示</label> <label
											class="radio inline"><input type="radio"
											name="isDisplay" value="false"
											${!category.isDisplay ? 'checked' : ''}>隐藏</label>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">上传封面</label>
									<div class="controls">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new thumbnail"
												style="width: 200px; height: 150px;">
												<img
													src="${(null != category && category.coversPic != null && category.coversPic != '') ? category.coversPic : '/static/assets/img/noimage.gif'}" />
											</div>
											<div class="fileupload-preview fileupload-exists thumbnail"
												style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
											<div>
												<span class="btn btn-file"><span
													class="fileupload-new">选择图片</span><span
													class="fileupload-exists">更换</span><input type="file"
													name='file' /></span> <a href="#" class="btn fileupload-exists"
													data-dismiss="fileupload">删除</a>
											</div>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button class="btn" data-dismiss="modal" aria-hidden="true"
										onclick="window.history.go(-1);">关闭</button>
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
		$().ready(function() {
			if ("${category}" == "") {
				$("#isTrue").attr("checked", "checked");
			}
		});

		$("#save").click(function() {
			//if ($("#categoryForm").valid()) {
				$("#categoryForm").ajaxSubmit(function(data) { //提交成功的回调函数  
					if (data == true) {
						alert("保存成功");
						location.href = "${ctx}/article/category";
						//location.reload();
					} else {
						alert("操作异常，请重试。");
					}
				});
			//};
		});
	</script>

</body>
</html>
