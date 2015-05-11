<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>会员管理</title>
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
        <h1>会员管理</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid"> 
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <p><a class="btn" href="${ctx}/member/create"><i class="icon-plus"></i> 新增会员</a>
                <form class="form-inline pt15 pb15" action="${ctx}/member/list" method="get" >
                	<div class="control-group">
			            <select name="search_EQ_gradeId" id="search_EQ_gradeId" class="input-medium" data-msg-required="请选择会员等级">
								<option value="" selected >所有会员</option>
								<c:forEach items="${memberGradeList}" var="memberGradeItem">
									<option value="${memberGradeItem.id }" ${(search.EQ_gradeId==memberGradeItem.id) ? 'selected' : '' }>${memberGradeItem.gradeName}</option>
								</c:forEach>
						</select>&nbsp;&nbsp;
						<label class="control-label" for="daterangepick">入会日期</label>
		                <input type="text" name="search_EQ_buyDate"  value="${(search.EQ_buyDate!=null) ? search.EQ_buyDate : '' }" class="form-control" id="daterangepick" placeholder="起始日期-结束日期" style="width: 190px;">
		                <button type="submit" class="btn btn-success ml10">查询</button>
		            	<button type="button" class="btn btn-danger ml10">导出</button>
		            </div>
				 </form>
				 <form class="form-inline pt15 pb15" action="${ctx}/member/list" method="get" style="position: relative;top: -40px;left: 600px;width:100%;height:100%;">
			        	<div class="form-group ml10">
				           	<label class="control-label" for="phoneNumber">手机号码</label>
				            <input type="text" name="search_EQ_phone"  value="${(search.EQ_phone!=null) ? search.EQ_phone : '' }" class="form-control" placeholder="请输入手机号码" style="width: 190px;">
				            <input type="submit" class="btn btn-success ml10"/>
			       		</div>
				 </form>
                <div class="pro-box">
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <!-- <th class="per10">会员号</th> -->
		                        <th class="per10">姓名</th>
		                        <th class="per5">性别</th>
		                        <th class="per10">会员等级</th>
		                        <!-- <th class="per5">积分</th> -->
		                        <th class="per15">入会时间</th>
		                        <th class="per10">联系电话</th>
		                        <th class="per30">操作</th>
                            </tr>
                            </thead>
                            <tbody id="proList">
                            <c:if test="${not empty members && members.size >0 }">
	                            <c:forEach items="${members.content}" var="memberItem">
									<tr>
										<%-- <td>${memberItem.num}</td> --%>
										<td>${memberItem.name}</td>
										<td>${(memberItem.id == null || memberItem.sex==0) ? '男' : ''}${(memberItem.id != null && memberItem.sex==1) ? '女' : ''}${(memberItem.id != null && memberItem.sex==2) ? '保密' : ''}</td>
										<td>
											<c:forEach items="${memberGradeList}" var="memberGradeItem">
											   <span>${(memberItem.memberGrade.id==memberGradeItem.id) ? memberItem.memberGrade.gradeName : ''}</span>
										    </c:forEach>
										</td>
										<%-- <td>${memberItem.integralAccount.remain}</td> --%>
		                                <td><fmt:formatDate value="${memberItem.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                                <td>${memberItem.phone}</td>
										<td>
											<shiro:hasPermission name="user:edit">
												<a href="${ctx}/member/checkMember/${memberItem.id}" class="btn btn-mini"  >查看详情</a>
												<a href="${ctx}/member/update/${memberItem.id}" class="btn btn-mini" >编辑</a>
												<c:if test="${memberItem.status }"><a href="${ctx}/member/changeStatus/?id=${memberItem.id }&status=${memberItem.status }"  class="btn btn-mini">封号</a></c:if>
												<c:if test="${!memberItem.status }"><a href="${ctx}/member/changeStatus/?id=${memberItem.id }&status=${memberItem.status }"  class="btn btn-mini">激活</a></c:if>
											</shiro:hasPermission>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty members || members.totalPages ==0 }">
								<tr>
		                            <td colspan="8" class="text-center"><strong>没有任何信息 *_*</strong></td>
		                        </tr>
							</c:if>
                            </tbody>
                        </table>
                        <c:if test="${not empty members && members.totalPages >1 }">
                        	<tags:pagination page="${members}" paginationSize="5"/>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script>
 	
 	// 修改是否   封号  或  激活
	function changeStatus(id, status){
		$.ajax({
	        type: "GET",
	        url:'/member/changeStatus/?id='+id+'&status='+status,
	        async: false,
	        success: function(data) {},
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
 	
</script>



</body>
</html>
