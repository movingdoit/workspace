<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${(member.num!=null)? '编辑会员' : '新增会员'}</title>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> ${(member.num!=null)? '编辑会员' : '新增会员'}</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${(member.id!=null)? '编辑会员' : '新增会员'}</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" modelAttribute="member" action="#" method="post" class="form-horizontal form-validate">
							<input type="hidden" name="id" value="${member.id}"/>
                            <%-- <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 会员号 :</label>
                                <div class="controls">
                                    <input type="text" id="num" name="num" value="${member.num}" ${(member.num==null) ? 'readonly': '' }readonly class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多15个字符">
                                </div>
                            </div> --%>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 姓名 :</label>
                                <div class="controls">
                                    <input type="text" id="name" name="name" value="${member.name}" ${(member.name==null) ? 'readonly': '' }readonly class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">性别 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="sex" value="男" ${(member.id == null || member.sex==0) ? 'checked' : ''}>男</label>
                                    <label class="radio inline"><input type="radio" name="sex" value="女" ${(member.id != null && member.sex==1) ? 'checked' : ''}>女</label>
                                    <label class="radio inline"><input type="radio" name="sex" value="保密" ${(member.id != null && member.sex==1) ? 'checked' : ''}>保密</label>
                                </div>
                            </div>
                             <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 联系电话 :</label>
                                <div class="controls">
                                    <input type="text" id="phone" name="phoneNumber" value="${member.phone}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多11个字符">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 会员等级 :</label>
                                <div class="controls">
                                   <select name="memberGradeId" class="input-medium" id="memberGradeId" data-rule-required="true" >
                                        <option value="">选择会员等级</option>
                                        <c:if test="${not empty memberGradeList }">
						            		<c:forEach items="${memberGradeList}" var="Item">
								         		<option value="${Item.id }" ${member.memberGrade.id == Item.id ?  'selected' :'' }>${Item.gradeName }</option>
							            	</c:forEach>
						            	</c:if>
						           </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 是否激活 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="status" value="true" ${member.status ? 'checked' : ''}>激活</label>
                                    <label class="radio inline"><input type="radio" name="status" value="false"  ${!member.status ? 'checked' : ''}>封号</label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="button" id="save" class="btn btn-primary" >保存</button>
                                <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<script src="/static/assets/js/jquery.min.js"></script>
<script src="/static/assets/js/jquery.form.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//聚焦第一个输入框
		$("#num").focus();
		//为inputForm注册validate函数
		//$("#inputForm").validate();
	});
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	
	// 保存
	$('#save').click(function(){
		/* var action = "${action}"; */
		$("#J_addForm").attr("action","${ctx}/member/${action}");
		
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            	
			            	location.href = "${ctx}/member/list";
			            	/* if(action=="create"){
			            	}else{
			            		window.history.go(-1);
			            		location.reload();
			            	} */
		        		}else if('1111' == data.code){
		        			// $('#message').text("您的操作超时，请重试！");
			            	alert(data.msg);
		        		}else {
		        			// $('#message').text(data.msg);
			            	alert(data.msg);
		        		}
		        	}else{
		            	alert("操作异常，请重试。");
		        	}
		        });
	});
</script>
</body>
</html>
