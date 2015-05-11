<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>哆咪微站:用户注册</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<link type="image/x-icon" href="${ctx}/static/images/favicon.ico" rel="shortcut icon">
<link href="${ctx}/static/bootstrap/2.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/default.min.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<script>
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#loginName").focus();
		//为inputForm注册validate函数
		$("#inputForm").validate({
			rules: {
				loginName: {
					remote: "${ctx}/register/checkLoginName"
				}
			},
			messages: {
				loginName: {
					remote: "用户登录名已存在"
				}
			}
		});
	});
</script>
</head>

<body>
	<div class="container">
		<%@ include file="/WEB-INF/layouts/header.jsp"%>
		<div id="content">
			<form id="inputForm" action="${ctx}/register" method="post" class="form-horizontal">
				<fieldset>
					<legend><small>用户注册</small></legend>
					<div class="control-group">
						<label for="loginName" class="control-label">登录名:</label>
						<div class="controls">
							<input type="text" id="loginName" name="loginName" class="input-large required" minlength="3"/>
						</div>
					</div>
					<div class="control-group">
						<label for="name" class="control-label">用户名:</label>
						<div class="controls">
							<input type="text" id="name" name="name" class="input-large required"/>
						</div>
					</div>
					<div class="control-group">
						<label for="plainPassword" class="control-label">密码:</label>
						<div class="controls">
							<input type="password" id="plainPassword" name="plainPassword" class="input-large required"/>
						</div>
					</div>
					<div class="control-group">
						<label for="confirmPassword" class="control-label">确认密码:</label>
						<div class="controls">
							<input type="password" id="confirmPassword" name="confirmPassword" class="input-large required" equalTo="#plainPassword"/>
						</div>
					</div>
					<div class="form-actions">
						<input id="submit_btn" class="btn btn-primary" type="submit" value="提交"/>&nbsp;	
						<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()"/>
					</div>
				</fieldset>
			</form>
		</div>
		<%@ include file="/WEB-INF/layouts/footer.jsp"%>
	</div>
	
</body>
</html>
