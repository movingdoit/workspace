<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>会员管理-新增会员积分</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 会员管理-新增会员积分</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>会员管理-新增会员积分</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm"  action="#" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
							<input type="hidden" name="id" value="${member.id}"/>
                          		<div class="control-group">
			                        <label for="idfield" class="control-label">会员积分</label>
			                        <div class="controls">
			                            <input id="jifen" name="jifen" type="text" class="form-control"  value="" >
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label for="namefield" class="control-label">订单金额</label>
			                        <div class="controls">
			                            <input type="text" name="total" value="" class="form-control" >
			                        </div>
			                    </div>
			                    <div class="control-group">
			                        <label for="namefield" class="control-label">订单号</label>
			                        <div class="controls">
			                            <input type="text" name="code" value="" class="form-control" >
			                        </div>
			                    </div>
			                    <div class="control-group">
	                                <label class="control-label">凭证图片</label>
	                                <div class="controls">
	                                    <img class="default-slider" src="/static/assets/img/noimage.gif">
	                                	<input type="file" name="file"/>
	                                    <!-- <a class="btn insertimage">上传</a> -->
	                                    <span class="help-inline">建议尺寸：宽360像素，高200像素</span>
	                                </div>
                           		</div>
			                    <div class="control-group">
			                        <label for="phone" class="control-label"><span class="color-red">*</span>备注</label>
			                        <div class="controls">
			                            <textarea class="form-control" name="remark" rows="5" data-rule-required="true" data-rule-phoneCN="true"></textarea>
			                        </div>
			                    </div>
                            <div class="form-actions">
                                <button type="button" id="save" class="btn btn-primary" >保存</button>
                                <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
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
<script src="/static/assets/js/jquery.min.js"></script>
<script src="/static/assets/js/jquery.form.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#jifen").focus();
		//为inputForm注册validate函数
		//$("#inputForm").validate();
	});
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#save').click(function(){
		var action = "${action}";
		$("#J_addForm").attr("action","${ctx}/member/${action}");
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            	if(action=="create"){
			            		location.href = "${ctx}/member/list";
			            		location.reload();
			            	}else{
			            		location.href = "${ctx}/member/list";
			            	}
		        		}else if('1111' == data.code){
		        			// $('#message').text("您的操作超时，请重试！");
			            	alert(data.msg);
		        		}else {
		        			// $('#message').text(data.msg);
			            	alert(data.msg);
		        		}
		        	}else{
		            	alert("操作异常，请重试。");
		        	}
		        });
	});
</script>
</body>
</html>
