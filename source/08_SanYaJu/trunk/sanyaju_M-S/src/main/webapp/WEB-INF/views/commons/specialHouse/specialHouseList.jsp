<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>特价楼盘列表</title>
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
        <h1>特价楼盘列表</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <%-- <p><a class="btn" href="${ctx}/bbs/slide/create"><i class="icon-plus"></i> 新增轮播图</a> --%>
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                            	<th>楼盘名称</th>
                            	<th>楼盘户型</th>
                            	<th>楼盘地址</th>
                            	<th>开发商</th>
                            	<th>售楼电话</th>
                            	<th>创建时间</th>
                                <th>折扣信息</th>
		                        <th>折扣</th>
		                        <th>排序</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty siteSlides && siteSlides.size>0}">
	                            <c:forEach items="${siteSlides.content}" var="Item">
									<tr>
										<td>${Item.houseInfo.name}</td>
										<td>${Item.houseInfo.houseType}</td>
										<td>${Item.houseInfo.houseAddr}</td>
										<td>${Item.houseInfo.developer}</td>
										<td>${Item.houseInfo.saleMobile}</td>
										<td>${Item.createTime}</td>
										<td>${Item.discountInfo}</td>
										<td>${Item.discount}</td>
										<td>${Item.priority}</td>
										<%-- <td>
											<c:if test="${Item.isDisplay }"><a onclick="changeDisplay(${Item.id}, false)" class="label mr10 mb10 label-success toggle-hide">显示</a></c:if>
											<c:if test="${!Item.isDisplay }"><a onclick="changeDisplay(${Item.id}, true)" class="label mr10 mb10 label-default toggle-show">隐藏</a></c:if>
										</td> --%>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/bbs/slide/update/${Item.id}" class="btn btn-mini">编辑</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty siteSlides || siteSlides.totalPages == 0 }">
								<tr>
		                            <td colspan="10" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty siteSlides && siteSlides.totalPages >1 }">
                        	<tags:pagination page="${siteSlides}" paginationSize="5"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script type="text/javascript" >

 	// 新增轮播图
	function create(){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/bbs/slide/create',
	        async: false,
	        success: function(data) {
	        	if(data){
	        		$('#addSlideModal').html(data);
	        	}else{
	            	alert("操作异常，请重试。");
	        	}
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
 	// 修改轮播图
	function update(id){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/bbs/slide/update/'+id,
	        async: false,
	        success: function(data) {
	        	if(data){
	        		$('#myModal').html(data);
	       			$('#myModal').modal();
	        	}else{
	            	alert("操作异常，请重试。");
	        	}
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
 	// 修改是否显示
	function changeDisplay(id, isDisplay){
		$.ajax({
	        type: "GET",
	        url:'${ctx}/bbs/slide/changeDisplay?id='+id+'&isDisplay='+isDisplay,
	        async: false,
	        success: function(data) {
	        	location.reload();
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
 	
	//批量删除
	function batDelete(){
		var chk_value =[];    
		$('input[name="id"]:checked').each(function(){    
		   chk_value.push($(this).val());    
		});    
		
		if(chk_value==null||chk_value==''||chk_value.length==0){
		 	alert("请选择要删除的数据！");
		    return false;
		}
		if(confirm("您确定要删除这些记录吗？删除后，无法恢复。")){
			window.location.href = '${ctx}/bbs/slide/batDelete/'+chk_value;
        }
	}
	
</script>
</body>
</html>