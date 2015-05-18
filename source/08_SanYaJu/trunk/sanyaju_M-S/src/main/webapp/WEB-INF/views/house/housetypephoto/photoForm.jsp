<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>${action == 'create' ? '添加' : '编辑' }楼盘户型相册</title>

<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-fileupload.css">
<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
<script src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
<script src="${ctx}/static/assets/js/form-wizard.js"></script>


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
				<i class="icon-edit"></i> ${action == 'create' ? '添加' : '编辑' }楼盘户型相册
			</h1>
		</div>
		<!-- // Breadcrumbs -->
		<!-- Action Boxes -->
		<div class="container-fluid">
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
	                        <h5> ${action == 'create' ? '添加' : '编辑' }楼盘户型相册</h5>
	                        <p style="margin: 0px;">
	                           <a class="btn" href="${ctx}/house/phototype/search"><i class="icon-plus"></i>相册列表</a>
	                        </p>
	                    </div>

						<div class="widget-content nopadding">
							<form id="photoForm" action="/house/phototype/${action }"
								method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
								
								
								<div class="control-group">
								    <c:if test="${action == 'create'}">
										<label class="control-label"><i class="red">*</i>  楼盘类别 :</label>
		                                <div class="controls">
		                                   <select name="recommendType" onchange="getHouse()" class="input-medium" id="recommendType" data-rule-required="true" >
		                                        <option value="0" ></option>
		                                        <c:forEach items="${recommendType}" var="type">
	                                                <option value="${type.key}" >${type.value}</option>
		                                        </c:forEach>
								           </select>
		                                </div>
	                                <label class="control-label"><i class="red">*</i>  选择楼盘 :</label>
	                                <div class="controls">
	                                   <select name="houseId"  class="input-medium" id="houseId" data-rule-required="true" >
							           </select>
	                                </div>
	                                </c:if>
	                                <c:if test="${not empty photo.houseInfo}">
	                                	<input type="hidden" name="houseId" value="${photo.houseInfo.id}">
	                                	<label class="control-label"><span class="red">*</span>楼盘名称:</label>
										<div class="controls">
											<input type="text" id="name" name="name" disabled="disabled" value="${photo.houseInfo.name}" class="span3">
										</div>	
                                    </c:if>
	                                
	                                
								</div>
								
								<div class="control-group">
									<label class="control-label"><i class="red">*</i>  户型 :</label>
	                                <div class="controls">
	                                   <select name="houseType" class="input-medium" id="cmsContent_channel" data-rule-required="true" >
	                                        <c:forEach items="${photoType}" var="type">
	                                          <c:choose>
	                                             <c:when test="${ photo.houseType == type.key }">
	                                                <option value="${type.key}" selected="selected" >${type.value}</option>
	                                             </c:when>
	                                             <c:otherwise>
	                                                <option value="${type.key}" >${type.value}</option>
	                                             </c:otherwise>
	                                          </c:choose>
	                                        </c:forEach>
							           </select>
	                                </div>
								</div>
								
								<input type="hidden" name="id" value="${photo.id}">
								
								
								<div class="control-group">
									<label class="control-label"><span class="red">*</span>
										图片名称 :</label>
									<div class="controls">
										<input type="text" id="name" name="name"
											value="${photo.name}" class="span3"
											data-rule-required="true" data-rule-maxlength="20"
											placeholder="最多20个字符">
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label"><span class="red">*</span>
										跳转地址 :</label>
									<div class="controls">
										<input type="text" id="forwardAddr" name="forwardAddr"
											value="${photo.forwardAddr}" class="span3" 
											data-rule-url="true" data-rule-maxlength="100"
											placeholder="最多100个字符">
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label">是否显示 :</label>
									<div class="controls">
										<label class="radio inline">
										 <input type="radio" name="isDisplay" value="true" id="isTrue" ${photo.isDisplay ? 'checked' : ''}>显示</label> 
										 <label class="radio inline"><input type="radio" name="isDisplay" value="false" ${!photo.isDisplay ? 'checked' : ''}>隐藏</label>
									</div>
								</div>
								
								 <div class="control-group">
									<label class="control-label">上传图片</label>
									<div class="controls">
										<div class="fileupload fileupload-new"
											data-provides="fileupload">
											<div class="fileupload-new thumbnail"
												style="width: 300px; height: 350px;">
												<img
													src="${(null != photo && photo.imageAddr != null && photo.imageAddr != '') ? photo.imageAddr : '/static/assets/img/noimage.gif'}" />
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
	<script src="/static/assets/js/jquery.form.min.js"></script>
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

	<script>
		$().ready(function() {
			if ("${photo}" == "") {
				$("#isTrue").attr("checked", "checked");
			}
		});

		$("#save").click(function() {
			if ($("#photoForm").valid()) {
				$("#photoForm").ajaxSubmit(function(data) { //提交成功的回调函数  
					if (data.code == "0000") {
						alert(data.message);
						location.href = "${ctx}/house/phototype/create";
						//location.reload();
					} else {
						alert("操作异常，请重试。");
					}
				});
			};
		});
		
		function getHouse(){
			$("#houseId").empty();
			var id = $("#recommendType  option:selected").val();
			$.post("${ctx}/house/phototype/gethouse/"+id,function(data){
				if(data){
					$(data).each(function(index) {
						var house = data[index];
						$("#houseId").append("<option value="+house.id+" >"+(index+1)+"-"+house.name+"</option>");
					});
				}
			});
		}
		
	</script>

</body>
</html>
