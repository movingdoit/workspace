<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>专题报名列表</title>
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
        <h1>专题报名列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                            	<th>用户姓名</th>
                                <th>手机号码</th>
		                        <th>登记时间</th>
		                        <!-- <th>操作</th> -->
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty specialRecords && specialRecords.size>0}">
	                            <c:forEach items="${specialRecords.content}" var="Item">
									<tr>
										<td>${Item.name}</td>
										<td>${Item.mobile}</td>
										<td><fmt:formatDate value="${Item.joinDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<%-- <td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/ad/update/${Item.id}" class="btn btn-mini">编辑</a>
												<a href="${ctx}/ad/delete/${Item.id}" class="btn btn-mini">删除</a>
											</shiro:hasPermission>
										</td> --%>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty specialRecords || specialRecords.totalPages == 0 }">
								<tr>
		                            <td colspan="3" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty specialRecords && specialRecords.totalPages >1 }">
                        	<tags:pagination page="${specialRecords}" paginationSize="10"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
</body>
</html>