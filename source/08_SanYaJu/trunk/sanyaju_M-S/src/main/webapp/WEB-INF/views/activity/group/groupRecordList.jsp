<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>团购报名列表</title>
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
        <h1>团购报名列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="pro-box">
                		<form class="form-inline pt15 pb15"
							action="${ctx}/activity/groupRecord/search" method="get"
							style="position: relative; top: 0px; left: 0px; width: 100%; height: 100%;">
							<div class="form-group ml10">
								<input type="text" name="search_EQ_name" value="${search.EQ_name }" class="form-control"
									placeholder="请输入用户名" style="width: 190px;">
								<input type="text" name="search_EQ_title" value="${search.EQ_title }" class="form-control"
									placeholder="请输入活动标题" style="width: 190px;">
								<button type="submit" class="btn btn-success ml10">搜索</button>
							</div>
						</form>
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                            	<th>用户姓名</th>
                                <th>手机号码</th>
		                        <th>登记时间</th>
		                        <th>参加的团购活动</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty groupRecords && groupRecords.size>0}">
	                            <c:forEach items="${groupRecords.content}" var="Item">
									<tr>
										<td>${Item.name}</td>
										<td>${Item.mobile}</td>
										<td><fmt:formatDate value="${Item.joinDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${Item.groupActivity.title}</td>
										<td>
											<shiro:hasPermission name="user:edit">
												<%-- <a href="${ctx}/activity/groupRecord/update/${Item.id}" class="btn btn-mini">编辑</a> --%>
												<a href="#" onclick="del(${Item.id})" class="btn btn-mini">删除</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty groupRecords || groupRecords.totalPages == 0 }">
								<tr>
		                            <td colspan="5" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty groupRecords && groupRecords.totalPages >1 }">
                        	<tags:pagination page="${groupRecords}" paginationSize="10"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

<script type="text/javascript">
function del(id){
	 if(confirm("确认删除吗？")){
		 $.post("${ctx}/activity/groupRecord/delete/"+id,function(data){
			alert(data.message);
			location.href = "${ctx}/activity/groupRecord/search";
		});
	 }
}
</script>

</body>
</html>