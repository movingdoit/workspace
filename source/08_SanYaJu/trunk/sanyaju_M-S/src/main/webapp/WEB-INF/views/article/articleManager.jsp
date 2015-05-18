<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>新闻管理</title>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>新闻管理</h1>
    </div>
	
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
		    <!-- <div class="row-fluid">
				<div class="span4 control-group">
					<a href="/article/detail/create" class="btn"><i class="icon-plus"></i> 添加新新闻</a>
					<a href="/article/category" class="btn"><i class="icon-plus"></i> 分类管理</a>
					
				</div>
			</div> -->
            <div class="span12">
                 <div class="span6">
                 <form class="form-inline pt15 pb15"
						action="${ctx}/article/manager/search" method="get"
						style="position: relative; top: 0px; left: 0px; width: 90%; height: 100%;">
						<div class="form-group ml10">
							<select name="search_EQ_type" class="input-medium"
								id="type" data-rule-required="true">
								<option value=""></option>
								<c:forEach items="${articleCategorys}" var="type">
									<c:choose>
										<c:when test="${search.EQ_type == type.id }">
											<option value="${type.id}" selected="selected">${type.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${type.id}">${type.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select> <input type="text" name="search_EQ_name"
								value="${search.EQ_name }" class="form-control"
								placeholder="请输入楼盘名搜索" style="width: 190px;">
							<button type="submit" class="btn btn-success ml10">搜索</button>
						</div>
				 </form>
				 </div>
                 <table class="table table-bordered table-striped">
                     <thead>
                     <tr>
                        <th>所属分类</th>
                        <th>所属楼盘</th>
                        <th>新闻标题</th>
						<th>发布时间</th>
						<th>排序</th>
						<th>显示</th>
						<th>操作</th>
                     </tr>
                     </thead>
                     <tbody id="proList">
                     <c:if test="${not empty articles && articles.size > 0 }">
					 <c:forEach items="${articles.content}" var="article">
						<tr>
						    <td>${article.articleCategory.name}</td>
						    <td>${article.houseInfo.name}</td>
							<td class='table-fixed-medium' style="width: 110px">${article.title}</td>
							<td><fmt:formatDate value="${article.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${article.priority}</td>
							<td>
								<c:if test="${article.isDisplay}"><a href="javascript:void(0)" onclick="changeDisplay(false,${article.id},${article.articleCategory.id});" class="label label-success toggle-hide">显示</a></c:if>
								<c:if test="${!article.isDisplay}"><a href="javascript:void(0)" onclick="changeDisplay(true, ${article.id},${article.articleCategory.id});" class="label toggle-show">隐藏</a></c:if>
							</td>
							<td>
								<shiro:hasPermission name="user:edit">
									<a href="/article/detail/update/${article.id}/0" class="btn" rel="tooltip" title="" data-original-title="编辑"><i class="icon-edit"></i></a>
									<a href="javascript:void(0)" onclick="doDelete(${article.id});" class="btn" rel="tooltip" title="" data-original-title="删除"><i class="icon-remove"></i></a>
								</shiro:hasPermission>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty articles || articles.size ==0 }">
						<tr>
							<td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
						</tr>
					</c:if>
					</tbody>
				</table>
				<c:if test="${not empty articles && articles.totalPages > 0 }">
					<tags:pagination page="${articles}" paginationSize="5"/>
				</c:if>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script>
 	// 新增新闻分类
	function createCategory(){
		$.get("/article/category/create",function(data){
			if(data){
        		$('#labelModal').html(data);
       			$('#labelModal').modal();
        	}else{
            	alert("操作失败,请联系管理员");
        	}
		})
	}
 	
 	// 修改是否显示
	function changeDisplay(isDisplay, id, cateId){
		$.post("/article/detail/changeDisplay",{'isDisplay':isDisplay, 'id':id, 'cateId':cateId},function(data){
			data == true ? location.reload() : alert("操作失败,请联系管理员");
		})
	}
 	
	//删除
	function doDelete(id){
		if(confirm("您确定要删除这些记录吗？删除后，无法恢复。")){
			$.post("/article/detail/delete/"+id, function(data){
				data == true ? location.reload() : alert("操作失败,请联系管理员");
			})
        }
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
			$.post("/article/detail/batDelete/"+ chk_value,function(data){
				data == true ? location.reload() : alert("操作失败,请联系管理员");
			})
        }
	}
	
</script>
</body>
</html>
