<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>团购推荐列表</title>
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
        <h1>团购推荐列表</h1>
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
                            	<th>团购活动名称</th>
                            	<th>报名人数</th>
                            	<th>人数上限</th>
                            	<th>开始时间</th>
                            	<th>结束时间</th>
                            	<th>排序号</th>
		                        <th>排序</th>
		                        <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty groupRecommends && groupRecommends.size>0}">
	                            <c:forEach items="${groupRecommends.content}" var="Item">
									<tr>
										<td>${Item.groupActivity.title}</td>
										<td>${Item.groupActivity.joinCount}</td>
										<td>${Item.groupActivity.joinLimit}</td>
										<td>${Item.groupActivity.beginDate}</td>
										<td>${Item.groupActivity.endDate}</td>
										<td>${Item.priority}</td>
										<td>
											<a href="#" onclick="movePriority(${Item.id},'top')" class="btn btn-link arrow-first">置顶</a>
	                                        <a href="#" onclick="movePriority(${Item.id},'down')" class="btn btn-link arrow-last">置底</a>
	                                        <a href="#" onclick="movePriority(${Item.id},'up')" class="btn btn-link arrow-up">上移</a>
	                                        <a href="#" onclick="movePriority(${Item.id},'dn')" class="btn btn-link arrow-down">下移</a>
										</td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="#" onclick="del(${Item.id})" class="btn btn-mini">删除</a>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty groupRecommends || groupRecommends.totalPages == 0 }">
								<tr>
		                            <td colspan="10" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                         <c:if test="${not empty groupRecommends && groupRecommends.totalPages >1 }">
                        	<tags:pagination page="${groupRecommends}" paginationSize="10"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script type="text/javascript">

	//上移，下移
	function movePriority(id, type){
		$.ajax({
	        type: "POST",
	        url:'${ctx}/activity/groupRecommend/move?id='+id+'&type='+type,
	        async: false,
	        success: function(data) {
	        		location.reload();
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
	
	function del(id){
		if(confirm("确定删除吗?")){
			$.ajax({
		        type: "get",
		        url:'${ctx}/activity/groupRecommend/delete/'+id,
		        async: false,
		        success: function(data) {
		        	alert(data.message);
		        	location.reload();
		        },
		        error: function(request) {
		            alert("网络连接超时，请重试！");
		        }
		    });
		}
	}
	
	
	 /*
     * table排序上移下移
     * */
        // 上移
        $('.arrow-up').click(function(e){
            e.preventDefault();
            var $this = $(this)
                ,$tr = $this.parents('tr')
                ,$trIndex = $tr.index()
                ,$tbody = $this.parents('tbody')
                ,$trLast = $tbody.children('tr:last-child');
            if ($trIndex == 0) {
                alert('第一条，不能再上移！');
                //$trLast.after($tr);
            }else {
                $tr.prev().before($tr);
            }
        });
        //下移
        $('.arrow-down').click(function(e){
            e.preventDefault();
            var $this = $(this)
                ,$tr = $this.parents('tr')
                ,$trIndex = $tr.index()
                ,$tbody = $this.parents('tbody')
                ,$trFirst = $tbody.children('tr:first-child');
            if ($trIndex == $tbody.find('tr').length - 1 ) {
                alert('最后一条，不能再下移！');
                //$trFirst.before($tr);
            }else {
                $tr.next().after($tr);
            }
        });
        //置顶
        $('.arrow-first').click(function(e){
            e.preventDefault();
            var $this = $(this)
                ,$tr = $this.parents('tr')
                ,$trIndex = $tr.index()
                ,$tbody = $this.parents('tbody')
                ,$trFirst = $tbody.children('tr:first-child');
            if ($trIndex == 0) {
                alert('已在最顶部');
            }else {
                $trFirst.before($tr);
            }
        });
        //置底
        $('.arrow-last').click(function(e){
            e.preventDefault();
            var $this = $(this)
                ,$tr = $this.parents('tr')
                ,$trIndex = $tr.index()
                ,$tbody = $this.parents('tbody')
                ,$trLast = $tbody.children('tr:last-child');
            if ($trIndex == $tbody.find('tr').length - 1 ) {
                alert('已在最底部');
            }else {
                $trLast.after($tr);
            }
        });
	
</script>
</body>
</html>