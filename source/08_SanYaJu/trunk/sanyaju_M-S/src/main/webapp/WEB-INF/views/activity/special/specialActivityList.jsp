<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>活动专题列表</title>
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
        <h1>活动专题列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/activity/specialActivity/create"><i class="icon-plus"></i> 新增活动专题</a>
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>活动标题</th>
		                        <th>活动封面</th>
		                        <!-- <th>报名人数上限</th> -->
		                        <th>活动信息</th>
		                        <th>开始时间</th>
		                        <th>结束时间</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty specialActivitys && specialActivitys.size>0}">
	                            <c:forEach items="${specialActivitys.content}" var="Item">
									<tr>
										<td>${Item.activityTitle}</td>
										<td>
											<c:if test="${null != Item.activityImage && Item.activityImage != '' }">
													<img width="60px" height="50px"  alt="" src="${Item.activityImage}"/>
											</c:if>
										</td>
										<%-- <td>${Item.joinLimit}</td> --%>
										<td>${Item.content}</td>
										<td><fmt:formatDate value="${Item.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td><fmt:formatDate value="${Item.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/activity/specialActivity/update/${Item.id}" class="btn btn-mini">编辑</a>
												<a href="${ctx}/activity/specialActivity/delete/${Item.id}" class="btn btn-mini">删除</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty specialActivitys || specialActivitys.totalPages == 0 }">
								<tr>
		                            <td colspan="7" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty specialActivitys && specialActivitys.totalPages >1 }">
                        	<tags:pagination page="${specialActivitys}" paginationSize="10"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script type="text/javascript" >

 	
 	// 修改是否显示
	function changeDisplay(id, isDisplay){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/ad/changeDisplay?id='+id+'&isDisplay='+isDisplay,
	        async: false,
	        success: function(data) {
	        	location.reload();
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
</script>
</body>
</html>