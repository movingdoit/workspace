<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <title>登录页</title>
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-login.css">
    <link rel="stylesheet" href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
    
    <link rel="icon" href="http://duomi.me/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="http://duomi.me/favicon.ico" type="image/x-icon"> 

</head>
<body>
<div id="loginbox">
    <form id="loginForm" action="${ctx}/login" method="post" class="form-vertical">
        <div class="control-group normal_text"> <h3><img src="${ctx}/static/assets/img/logo.png" alt="航冠科技" /></h3></div>
        <%
			String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
			if(error != null){
			%>
				<div class="alert alert-error input-medium controls">
					<button class="close" data-dismiss="alert">×</button>登录失败，请重试.
				</div>
		<%
			}
		%>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-user"></i></span><input type="text" placeholder="请输入用户名" id="username" name="username"  value="${username}"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" placeholder="请输入密码" id="password" name="password" />
                </div>
            </div>
        </div>
        <div class="form-actions">
            <span class="pull-left"><a class="flip-link btn btn-info" id="to-recover" href="#">忘记密码?</a></span>
            <span class="pull-right"><label class="checkbox inline" style="padding-top: 0;"><input type="checkbox" id="rememberMe" name="rememberMe"/>记住我</label>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-success"  type="submit"> 登录</button></span>
        </div>
    </form>

</div>

<div style="display: none">
	<script type="text/javascript">
		if(document.domain == "a.duomi.me"){
			var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5bce2900c4ad28996a087899ee8c94fe' type='text/javascript'%3E%3C/script%3E"));
		}
	</script>
</div>

<script src="${ctx}/static/assets/js/jquery.min.js"></script>
<script src="${ctx}/static/assets/js/matrix.login.js"></script>
</body>

</html>