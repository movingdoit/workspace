<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>会员基本信息</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 会员基本信息</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>会员基本信息</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="inputForm" modelAttribute="member" action="#" method="post" class="form-horizontal form-validate">
							<input type="hidden" name="id" value="${member.id}"/>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 会员号 :</label>
                                <div class="controls">
                                   ${member.num}
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 姓名 :</label>
                                <div class="controls">
                                    ${member.name}
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">性别 :</label>
                                <div class="controls">
                               	 	    ${(member.id == null || member.sex=='男') ? '男' : ''}
						           	  	${(member.id == null || member.sex=='女') ? '女' : ''}
						           	  	${(member.id == null || member.sex=='保密') ? '保密' : ''}
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 联系电话 :</label>
                                <div class="controls">
                                    ${member.phone}
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 会员等级 :</label>
                                <div class="controls">
                                    ${member.memberGrade.gradeName}
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 会员状态 :</label>
                                <div class="controls">
                                    <c:if test="${member.status != null}">${(member.status == true) ? '已激活' : '未激活'}</c:if>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 入会时间 :</label>
                                <div class="controls">
                                   ${member.registerTime}<fmt:formatDate value="${member.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </div>
                            </div>
                            <div class="form-actions">
                                <!-- <button type="button" class="btn btn-success btn-alt mr5 mb10" >查看消费记录</button> -->
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
</body>
</html>
