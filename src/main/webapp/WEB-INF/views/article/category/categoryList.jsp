<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>分类管理</title>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>新闻管理</h1>
    </div>
	
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>${message}</div>
	</c:if>
	
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
		    <div class="row-fluid">
				<div class="span4 control-group">
					<a href="javascript:void(0)" onclick="create()" role="button" class="btn" data-toggle="modal"><i class="icon-plus"></i> 新增分类</a>
				</div>
			</div>
            <div class="span12">
                 <table class="table table-bordered table-striped">
                     <thead>
                     <tr>
                        <th class="with-checkbox"><input type="checkbox" name="check_all" class="check-all"></th>
						<th>分类名称</th>
						<th>分类图标</th>
						<th>排序</th>
						<th>是否显示</th>
						<th>操作</th>
                     </tr>
                     </thead>
                     <tbody id="proList">
                     <c:if test="${not empty articleCategorys && articleCategorys.size >0 }">
					 <c:forEach items="${articleCategorys.content}" var="category">
						<tr>
							<td><input type="checkbox" name="id" value="${category.id}"></td>
							<td>${category.name}</td>
							<td><img alt="" src="${ctx}${category.coversPic}" style="width: 60px; height: 60px"/></td>
							<td>${category.priority}&nbsp;</td>
							<td>
								<c:if test="${category.isDisplay }"><a href="#" onclick="changeDisplay(${category.id}, false);" class="label label-success toggle-hide">显示</a></c:if>
								<c:if test="${!category.isDisplay}"><a href="#" onclick="changeDisplay(${category.id}, true);" class="label toggle-show">隐藏</a></c:if>
							</td>
							<td>
								<shiro:hasPermission name="user:edit">
									<a href="javascript:void(0)" onclick="update(${category.id});" class="btn" rel="tooltip" title="" data-original-title="编辑"><i class="icon-edit"></i></a>
									<a href="javascript:void(0)" onclick="doDelete(${category.id})" class="btn" rel="tooltip" title="" data-original-title="删除"><i class="icon-remove"></i></a>
								</shiro:hasPermission>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty articleCategorys || articleCategorys.size ==0 }">
						<tr>
						   <td colspan="8" class="text-center"><strong>没有任何分类 *_*</strong></td>
					   </tr>
					</c:if>
				</tbody>
				</table>
				<div class="footbar">
				<label><input type="checkbox" class="check-all">全选</label><a href="javascript:void(0)" 	class="btn" onclick="batDelete()"><i class="icon-trash"></i> 删除</a>
			    </div>
				<c:if test="${not empty articleCategorys && articleCategorys.totalPages > 0}">
					<tags:pagination page="${articleCategorys}" paginationSize="5"/>
				</c:if>
             </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>
<!-- // Main Container -->
<script>
 	// 新增新闻分类
	function create(){
 		
		location.href = "${ctx}/article/category/create";
		/* $.get("/article/category/create",function(data){
			if(data){
        		$('#myModal').html(data);
       			$('#myModal').modal();
        	}else{
            	alert("操作失败,请联系管理员");
        	}
		}) */
	}
 	
 	// 修改新闻分类
	function update(id){
 		
		location.href = "/article/category/update/"+id;
 		
		/* $.get("/article/category/update/"+id,function(data){
			if(data){
        		$('#myModal').html(data);
       			$('#myModal').modal();
        	}else{
            	alert("操作失败,请联系管理员");
        	}
		}); */
	}
 	
 	
 	// 修改是否显示
	function changeDisplay(id, isDisplay){
		$.post("/article/category/changeDisplay",{'id':id,'isDisplay':isDisplay},function(data){
			data == true ? location.reload() : alert("操作失败,请联系管理员");
		})
	}
 	
	//删除
	function doDelete(id){
		if(confirm("您确定要删除这些记录吗？删除后，无法恢复。")){
			$.post("/article/category/delete/"+id, function(data){
				data == true ? location.reload() : alert("操作失败,请联系管理员");
			})
        }
	}
 	
	//批量删除
	function batDelete(id){
		var chk_value =[];    
		$('input[name="id"]:checked').each(function(){    
		   chk_value.push($(this).val());    
		});    
		
		if(chk_value==null||chk_value==''||chk_value.length==0){
		 	alert("请选择要删除的数据！");
		    return false;
		}
		if(confirm("您确定要删除这些记录吗？删除后，无法恢复。")){
			$.post("/article/category/batDelete/"+ chk_value,function(data){
				data == true ? location.reload() : alert("操作失败,请联系管理员");
			})
        }
	}
	
</script>

</body>
</html>
