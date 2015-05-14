<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>${(null != custom && custom ==1) ? articleCategory.name : '文章管理' }</title>
<!-- Main Container -->
<div id="main">
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="box">
                    <div class="box-title">
                        <h3>
                            <i class="icon-table"></i>
                            ${(null != custom && custom ==1) ? articleCategory.name : '文章管理' }
                        </h3>
                    </div>
                    <div class="box-content padding20">
                        <div class="row-fluid">
                            <div class="span4 control-group">
                                <a href="/article/detail/create?custom=${custom }${null != articleCategory.id ? '&catId=' : '' }${null != articleCategory.id ? articleCategory.id : '' }" role="button" class="btn" data-toggle="modal"><i class="icon-plus"></i> 新增${(null != custom && custom ==1) ? articleCategory.name : '文章' }</a>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span12">
                                <table class="table table-hover table-nomargin table-bordered dataTable">
                                    <thead>
                                    <tr>
                                        <th class="with-checkbox"><input type="checkbox" name="check_all" class="check-all"></th>
                                        <th>文章标题</th>
                                        <th>发布时间</th>
                                        <th>排序</th>
                                        <th>显示</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${not empty articles && articles.size >0 }">
					                     <c:forEach items="${articles.content}" var="content">
										 <tr>
										 	<td><input type="checkbox" name="id" value="${content.id}"></td>
											<td>${content.title}</td>
											<td><fmt:formatDate value="${content.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td>
	                                            <a href="#" class="btn arrow-up" rel="tooltip" title="" data-original-title="上移"><i class="icon-arrow-up"></i></a>
	                                            <a href="#" class="btn arrow-down" rel="tooltip" title="" data-original-title="下移"><i class="icon-arrow-down"></i></a>
	                                        </td>
	                                        <td>
												<c:if test="${content.isDisplay }"><a href="#" onclick="changeDisplay(${content.id}, ${content.articleCategory.id}, false);" class="label label-success toggle-hide">显示</a></c:if>
												<c:if test="${!content.isDisplay }"><a href="#" onclick="changeDisplay(${content.id}, ${content.articleCategory.id}, true);" class="label toggle-show">隐藏</a></c:if>
											</td>
											<td>
												<shiro:hasPermission name="user:edit">
													<a href="#" class="btn" rel="tooltip" title="" data-original-title="复制链接"><i class="icon-copy"></i></a>
		                                            <a href="/article/detail/update/${content.id}/${custom }" class="btn" rel="tooltip" title="编辑" data-original-title="编辑"><i class="icon-edit"></i></a>
		                                            <a href="/article/detail/delete/${content.id}" class="btn" rel="tooltip" title="" data-original-title="删除"><i class="icon-remove"></i></a>
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
                                <div class="footbar">
                                    <label><input type="checkbox" class="check-all">全选</label><a href="#" onclick="batDelete()" class="btn"><i class="icon-trash"></i> 删除</a>
                                </div>
                                <c:if test="${not empty articles && articles.totalPages >1 }">
			                 		<tags:pagination page="${articles}" paginationSize="5"/>
			                 	</c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- // Main Container -->
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>
<!-- // Modal -->
<script>
 	// 新增文章
	function create(){
		$.ajax({
	        type: "GET",
	        url:'/article/detail/create?isAjax=1&custom=${custom }${null != articleCategory.id ? "&catId=" : "" }${null != articleCategory.id ? articleCategory.id : "" }',
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
 	
 	// 修改文章
	function update(id){
		$.ajax({
	        type: "GET",
	        url:'/article/detail/update/'+id+'/${custom }?isAjax=1',
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
	function changeDisplay(id, catId, isDisplay){
		$.ajax({
	        type: "GET",
	        url:'/article/detail/changeDisplay/?id='+id+'&catId='+catId+'&isDisplay='+isDisplay,
	        async: false,
	        success: function(data) {},
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
			window.location.href = '/article/detail/batDelete/'+chk_value;
        }
	}
</script>
