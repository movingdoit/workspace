<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>${(action=='create')? '添加' : '编辑'}团购活动</title>
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
	<link rel="stylesheet"
	href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
	
	<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-datetimepicker.css">
	<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-fileupload.css">
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	
	<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
	<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
	<script
		src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
	<script src="${ctx}/static/assets/js/form-wizard.js"></script>
	
</head>
<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> ${(action=='create')? '添加' : '编辑'}团购活动</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>${(action=='create')? '添加' : '编辑'}团购活动</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" action="#" method="post" class="form-horizontal form-validate"  enctype="multipart/form-data">
							<input type="hidden" name="id" value="${group.id}" />
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 活动标题 :</label>
                                <div class="controls">
                                	<input type="text" id="title" name="title"  value="${group.title}" class="span2" required="required" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符"/>
                                </div>
                            </div>
                            
                            <div class="control-group">
							    <c:if test="${action == 'create'}">
									<label class="control-label"><i class="red">*</i>  楼盘类别 :</label>
	                                <div class="controls">
	                                   <select name="recommendType" onchange="getHouse()" class="input-medium" id="recommendType" data-rule-required="true" >
	                                        <option value="0" ></option>
	                                        <c:forEach items="${recommendType}" var="type">
                                                <option value="${type.key}" >${type.value}</option>
	                                        </c:forEach>
							           </select>
	                                </div>
                                <label class="control-label"><i class="red">*</i>  选择楼盘 :</label>
                                <div class="controls">
                                   <select name="houseId"  class="input-medium" id="houseId" data-rule-required="true" >
						           </select>
                                </div>
                                </c:if>
                                <c:if test="${not empty group.houseInfo}">
                                	<input type="hidden" name="houseId" value="${group.houseInfo.id}">
                                	<label class="control-label"><span class="red">*</span>楼盘名称:</label>
									<div class="controls">
										<input type="text" id="name" name="name" disabled="disabled" value="${group.houseInfo.name}" class="span3">
									</div>	
                                </c:if>
							</div>
							
							
							<div class="control-group">
                                <label class="control-label"><i class="red">*</i> 人数上限 :</label>
                                <div class="controls">
                                	<input type="text" id="joinLimit" name="joinLimit"  value="${group.joinLimit}" class="span2" required="required" data-rule-required="true" data-rule-number="true" data-rule-maxlength="10" placeholder="最多10个字符"/>
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 原价格 :</label>
                                <div class="controls">
                                	<input type="text" id="oldSale" name="oldSale"  value="${group.oldSale}" class="span2" required="required" data-rule-required="true"  data-rule-maxlength="50" />
                                </div>
                            </div>
                            
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i> 新价格 :</label>
                                <div class="controls">
                                	<input type="text" id="newSale" name="newSale"  value="${group.newSale}" class="span2" required="required" data-rule-required="true"  data-rule-maxlength="50" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 折扣信息:</label>
                                <div class="controls">
                                	<input type="text" id="discount" name="discount"  value="${group.discount}" class="span6" required="required" data-rule-required="true" placeholder="多条折扣信息请以逗号隔开"  data-rule-maxlength="255" />
                                </div>
                            </div>
                            
                            
                            <div class="control-group">
								<label class="control-label"> 活动开始时间 :</label>
								<div class="controls">
									<div data-date="2012-12-02 12:00"
										class="input-append date datepicker">
										<input type="text"
											value="<fmt:formatDate value="${group.beginDate}" pattern="yyyy-MM-dd HH:mm"/>"
											name="startDate" id="startDate"
											data-date-format="yyyy-mm-dd hh:mm" class="span11"
											data-rule-required="true"> <span class="add-on"><i
											class="icon-th"></i></span>
									</div>
								</div>

								<label class="control-label"> 活动结束时间:</label>
								<div class="controls">
									<div data-date="2012-12-02 12:00"
										class="input-append date datepicker">
										<input type="text"
											value="<fmt:formatDate value="${group.endDate}" pattern="yyyy-MM-dd HH:mm"/>"
											name="overDate" id="overDate"
											data-date-format="yyyy-mm-dd hh:mm" class="span11"
											data-rule-required="true"> <span class="add-on"><i
											class="icon-th"></i></span>
									</div>
								</div>
							</div>  
                            
                            <div class="control-group">
						        <label class="control-label">上传封面</label>
						        <div class="controls">
						            <div class="fileupload fileupload-new" data-provides="fileupload">
						                <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${(null != group && group.activityImage != null && group.activityImage != '') ? group.activityImage : '/static/assets/img/noimage.gif'}" /></div>
						                <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
						                <div>
						                    <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='file' /></span>
						                    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>
						                </div>
						            </div>
						        </div>
						    </div>
                            <%-- <div class="control-group">
                                <label class="control-label"> 活动封面 :</label>
                                <div class="controls">
                                    <img src="${ctx}${group.activityImage}" class="default-slider" />
                                    <input type="file" name="file" class="insertimage"/>
                                </div>
                            </div> --%>
                            <div class="control-group">
                                <label class="control-label"> 摘要:</label>
                                <div class="controls">
                                	<input type="text" id="summary" name="summary"  value="${group.summary}" class="span2" required="required" data-rule-required="true"  data-rule-maxlength="50" />
                                </div>
                            </div>
                            
                            
                            <div class="control-group">
                                <label class="control-label"> 活动内容 :</label>
                                <div class="controls">
                                    <!-- 加载编辑器的容器 -->
							    	<script id="container" name="content" style="width:830px;height:300px" type="text/plain">${null != group.content && 'null' != group.content ? group.content : ''}</script>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="button" id="save" class="btn btn-primary">保存</button>
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


<!-- Modal -->
<div id="articleChooseModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"></div>
<!-- // Modal -->

<script src="${ctx}/static/assets/js/jquery.form.min.js"></script>
<!-- 配置文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/static/plug-in/ueditor/ueditor.all.js"></script>
<script>

	var ue = UE.getEditor('container');
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#save').click(function(){
		$("#J_addForm").attr("action","${ctx}/activity/group/${action}");
		if($("#J_addForm").valid()){
			$("#J_addForm").ajaxSubmit(
					function(data) {
			        	if(data){
			        		if('0000' == data.code){
			        			// $('#message').text("保存成功");
				            	alert(data.message);
				            	location.href = "${ctx}/activity/group/search";
			        		}else if('1111' == data.code){
			        			// $('#message').text("您的操作超时，请重试！");
				            	alert(data.message);
			        		}else {
			        			// $('#message').text(data.msg);
				            	alert(data.message);
			        		}
			        	}else{
			            	alert("操作异常，请重试。");
			        	}
			        });
		}
	});
    
	
	function getHouse(){
		$("#houseId").empty();
		var id = $("#recommendType  option:selected").val();
		$.post("${ctx}/activity/group/gethouse/"+id,function(data){
			if(data){
				$(data).each(function(index) {
					var house = data[index];
					$("#houseId").append("<option value="+house.id+" >"+(index+1)+"-"+house.name+"</option>");
				});
			}
		});
	}
	
</script>
	
</body>
</html>
