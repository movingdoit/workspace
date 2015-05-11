<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${(memberGrade.id!=null)? '编辑会员等级' : '新增会员等级'}</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> ${(memberGrade.id!=null)? '编辑会员等级' : '新增会员等级'}</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${(memberGrade.id!=null)? '编辑会员等级' : '新增会员等级'}</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" modelAttribute="memberGrade" action="${ctx}/member/grade/${action}" method="post" class="form-horizontal form-validate">
							<input type="hidden" name="id" value="${memberGrade.id}"/>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 等级名称 :</label>
                                <div class="controls">
                                    <input type="text" id="name" name="name" value="${memberGrade.gradeName}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多15个字符">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><span class="color-red">*</span>特权设置</label>
		                        <div class="controls">
		                            <div class="form-actions">
		                                                                                 折扣：<input type="text" class="span3" name="discount"  value="${memberGrade.discount}" placeholder="会员等级所享受的折扣">
		                            </div>
		                            <div class="form-actions">
		                               	 积分：<input type="text" class="span3" name="gradeIntegral"  value="${memberGrade.gradeIntegral}" placeholder="会员等级所拥有的积分">
		                            </div>
		                        </div>
                            </div>
                             <div class="control-group">
                                <label for="desc" class="control-label">说明</label>
		                        <div class="controls">
		                            <textarea class="form-control" id="desc" name="content" >${memberGrade.content}</textarea>
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
		$("#gradeName").focus();
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
		$("#J_addForm").attr("action","${ctx}/member/grade/${action}");
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            	location.href = "${ctx}/member/grade/list";
		        		}else if('1111' == data.code){
		        			// $('#message').text("您的操作超时，请重试！");
			            	alert(data.msg);
		        		}else {
		        			// $('#message').text(data.msg);
			            	alert(data.message);
		        		}
		        	}else{
		            	alert("操作异常，请重试。");
		        	}
		        });
	});
</script>
</body>
</html>
