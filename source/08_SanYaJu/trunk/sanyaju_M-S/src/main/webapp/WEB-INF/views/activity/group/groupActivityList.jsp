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
                <p><a class="btn" href="${ctx}/activity/group/create"><i class="icon-plus"></i> 新增团购信息</a>
                <div class="pro-box">
                		<form class="form-inline pt15 pb15"
							action="${ctx}/activity/group/search" method="get"
							style="position: relative; top: 0px; left: 0px; width: 100%; height: 100%;">
							<div class="form-group ml10">
								<input type="text" name="search_EQ_title" value="${search.EQ_title }" class="form-control"
									placeholder="请输入楼盘标题" style="width: 190px;">
								<button type="submit" class="btn btn-success ml10">搜索</button>
							</div>
						</form>
                
                
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>活动标题</th>
		                        <th>活动封面</th>
		                        <th>报名人数</th>
		                        <th>人数上限</th>
		                        <th>原价格</th>
		                        <th>新价格</th>
		                        <th>摘要</th>
		                        <th>开始时间</th>
		                        <th>结束时间</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty groups && groups.size>0}">
	                            <c:forEach items="${groups.content}" var="Item">
									<tr>
										<td>${Item.title}</td>
										<td>
											<c:if test="${null != Item.activityImage && Item.activityImage != '' }">
													<img width="60px" height="50px"  alt="" src="${Item.activityImage}"/>
											</c:if>
										</td>
										<td>${Item.joinCount}</td>
										<td>${Item.joinLimit}</td>
										<td>${Item.oldSale}</td>
										<td>${Item.newSale}</td>
										<td>${Item.summary}</td>
										<td><fmt:formatDate value="${Item.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td><fmt:formatDate value="${Item.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/activity/group/update/${Item.id}" class="btn btn-mini">编辑</a>
												<a href="${ctx}/activity/group/delete/${Item.id}" class="btn btn-mini">删除</a>
												<a href="#" onclick="recommend(${Item.id})" class="btn btn-mini">推荐</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty groups || groups.totalPages == 0 }">
								<tr>
		                            <td colspan="7" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty groups && groups.totalPages >1 }">
                        	<tags:pagination page="${groups}" paginationSize="10"/>
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
	function recommend(id){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/activity/groupRecommend/recommend/'+id,
	        async: false,
	        success: function(data) {
	        	alert(data.message);
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
</script>
</body>
</html>