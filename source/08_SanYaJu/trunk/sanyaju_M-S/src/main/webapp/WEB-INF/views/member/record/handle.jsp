<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>处理申请会员页面</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 处理申请会员页面</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>处理申请会员页面</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" action="#" method="post" class="form-horizontal form-validate">
                        	<input type="hidden" name="id" value="${member.id}"/>
                            <div class="control-group">
                                <label class="control-label"> 是否同过申请:</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="handleResult" value="true">通过申请</label>
                                    <label class="radio inline"><input type="radio" name="handleResult" value="false">拒绝申请</label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 备注 :</label>
                                <div class="controls">
                                    <textarea id="remark" name="remark" rows="6" style="width: 400px;"></textarea>
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
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	
	// 保存
	$('#save').click(function(){
		$("#J_addForm").attr("action","${ctx}/member/${action}");
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            		location.href = "${ctx}/member/handle/record";
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
