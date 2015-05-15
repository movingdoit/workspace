<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>广告列表</title>
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
        <h1>广告列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/ad/create"><i class="icon-plus"></i> 新增广告</a>
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>广告名称</th>
		                        <th>广告封面</th>
		                        <th>链接地址</th>
		                        <th>广告类型</th>
		                        <th>广告位置</th>
		                        <th>是否显示</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty ads && ads.size>0}">
	                            <c:forEach items="${ads.content}" var="Item">
									<tr>
										<td>${Item.title}</td>
										<td>
											<c:if test="${null != Item.imageAddr && Item.imageAddr != '' }">
													<img width="60px" height="50px"  alt="" src="${Item.imageAddr}"/>
											</c:if>
										</td>
										<td>${Item.forwardAddr}</td>
										<td>
											<c:if test="${Item.adType == 1 }">首页广告</c:if>
											<c:if test="${Item.adType == 2 }">楼盘展示页广告</c:if>
											<c:if test="${Item.adType == 3 }">特价楼盘广告 </c:if>
											<c:if test="${Item.adType == 4 }">搜索页广告</c:if>
											<c:if test="${Item.adType == 5 }">新闻资讯广告</c:if>
										</td>
										<td>
											<c:if test="${Item.position==1}">横条广告</c:if>
											<c:if test="${Item.position==2}">竖条广告</c:if>
											<c:if test="${Item.position==3}">左边轮播图广告</c:if>
											<c:if test="${Item.position==4}">顶部横条广告</c:if>
											<c:if test="${Item.position==5}">右边广告</c:if>
											<c:if test="${Item.position==6}">顶部横条广告</c:if>
											<c:if test="${Item.position==7}">新闻列表页广告</c:if>
											<c:if test="${Item.position==8}">新闻详情页广告</c:if>
										</td>
										<td>
											<c:if test="${Item.isDisplay }"><a onclick="changeDisplay(${Item.id}, false)" class="label mr10 mb10 label-success toggle-hide">显示</a></c:if>
											<c:if test="${!Item.isDisplay }"><a onclick="changeDisplay(${Item.id}, true)" class="label mr10 mb10 label-default toggle-show">隐藏</a></c:if>
										</td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/ad/update/${Item.id}" class="btn btn-mini">编辑</a>
												<a href="${ctx}/ad/delete/${Item.id}" class="btn btn-mini">删除</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty ads || ads.totalPages == 0 }">
								<tr>
		                            <td colspan="7" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty ads && ads.totalPages >1 }">
                        	<tags:pagination page="${ads}" paginationSize="5"/>
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