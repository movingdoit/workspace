<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>会员等级管理</title>
	<script>
		$(document).ready(function() {
			$("#account-tab").addClass("active");
		});
	</script>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>会员等级管理</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/member/grade/create"><i class="icon-plus"></i>  新增会员等级</a>
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                  			<thead>
                            <tr>
                                <th class="per15">会员等级</th>
                                <th class="per20">会员特权</th>
                                <th class="per10">现有人数</th>
                                <th class="per20">说明</th>
                                <th class="per20">操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty memberGradeList}">
	                            <c:forEach items="${memberGradeList}" var="memberGrade">
									<tr>
										<td>${memberGrade.gradeName}</td>
										<td>折扣:${memberGrade.discount}折 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 积分:${memberGrade.gradeIntegral}</td>
										<td>${memberGrade.users}</td>
										<td>${memberGrade.content}</td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/member/grade/update/${memberGrade.id}" class="btn btn-mini">编辑</a>
												<!-- <a href="#" class="btn btn-mini" >查看消费记录</a> -->
                                          		<a href="${ctx}/member/grade/delete/${memberGrade.id}" class="btn btn-mini">删除</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
                            </tbody>
                        </table>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script>
 	
 	// 修改是否   封号  或  激活
	function changeStatus(id, status){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/member/changeStatus/?id='+id+'&status='+status,
	        async: false,
	        success: function(data) {},
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
</script>
</body>
</html>