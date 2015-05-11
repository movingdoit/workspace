<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>修改密码</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 修改密码</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>修改密码</h5>
                        <c:if test="${not empty message}">
							<div id="message" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>${message}</div>
						</c:if>
                    </div>
                    <div class="widget-content nopadding">
                        <form class="form-horizontal" method="post" action="${ctx}/account/user/changePW" name="password_validate" id="password_validate" novalidate="novalidate">
                            <div class="control-group">
                                <label class="control-label">当前密码：</label>
                                <div class="controls">
                                    <input type="password" name="oldPassword" id="oldPassword" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">新密码：</label>
                                <div class="controls">
                                    <input type="password" name="newPassword1" id="newPassword1" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">确认密码：</label>
                                <div class="controls">
                                    <input type="password" name="newPassword2" id="newPassword2" />
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-success">保存</button>
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
<script src="${ctx}/static/assets/js/matrix.form_validation.js" type="text/javascript"></script>
</body>
</html>
