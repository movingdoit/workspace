<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>投票管理</title>
	
	<link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
    <link rel="stylesheet" href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-fileupload.css">
    
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
	
	<script src="${ctx}/static/plug-in/KindEditor/kindeditor.js" type="text/javascript"></script>
	<script src="${ctx}/static/plug-in/KindEditor/lang/zh_CN.js" type="text/javascript"></script>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 投票管理</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <ul class="nav nav-tabs">
                            <li><a href="/ams/vote/activity/update/${actId}"">基础内容设置</a></li>
                            <li><a href="/ams/vote/item/${actId}">选项设置</a></li>
                            <li><a href="/ams/vote/rule/${actId}">规则设置</a></li>
                            <li class="active"><a href="/ams/vote/module/${actId}">自定义模块</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" class="tab-pane">
                        </div>
                        <div id="tab2" class="tab-pane p20">
                        </div>
                        <div id="tab3" class="tab-pane">
                        </div>
                        <div id="tab4" class="tab-pane p20 active">
                            <form action="save" method="post" class="form-horizontal form-validate" novalidate="novalidate">
                                <!-- <a href="#" class="btn btn-primary ml120" id="J_addVoteModule"><i class="icon-plus"></i> 新增模块</a>
                                <span class="help-inline">(最多增加两个自定义模块)</span> -->
                                <input type="hidden" name="id" class="span3" value="${voteActivity.id }" data-rule-required="true" data-rule-maxlength="5">
                                <div id="J_module_1" class="module-wrap" moduleid="1">
                                    <div class="control-group">
                                        <label class="control-label">模块名称1 :</label>
                                        <div class="controls">
                                            <input type="text" name="bindTxt1" value="${voteActivity.bindTxt1 }" class="span3" data-rule-required="true" data-rule-maxlength="20">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">模块指向1 :</label>
                                        <div class="controls">
                                            <select name="bindType1" class="input-medium J_directType">
                                                <option value="">选择类型</option>
                                                <option value="cms" ${voteActivity.bindType1 == 'cms' ? 'selected' : '' }>文章</option>
                                                <option value="link" ${voteActivity.bindType1 == 'link' ? 'selected' : '' }>链接</option>
                                            </select>
                                        </div>
                                        
                                         <div class="controls">
                                            <input type="text" name="bindValue1" value="${voteActivity.bindValue1 }" class="span3" data-rule-required="true" data-rule-maxlength="200">
                                        </div>
                                    </div>
                                </div>
                                
                                <div id="J_module_2" class="module-wrap" moduleid="1">
                                    <div class="control-group">
                                        <label class="control-label">模块名称2 :</label>
                                        <div class="controls">
                                            <input type="text" name="bindTxt2" value="${voteActivity.bindTxt2 }" class="span3" data-rule-required="true" data-rule-maxlength="20">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">模块指向2 :</label>
                                        <div class="controls">
                                            <select name="bindType2" class="input-medium J_directType">
                                                <option value="">选择类型</option>
                                                <option value="cms" ${voteActivity.bindType2 == 'cms' ? 'selected' : '' }>文章</option>
                                                <option value="link" ${voteActivity.bindType2 == 'link' ? 'selected' : '' }>链接</option>
                                            </select>
                                        </div>
                                        <div class="controls">
                                            <input type="text" name="bindValue2" value="${voteActivity.bindValue2 }" class="span3" data-rule-required="true" data-rule-maxlength="200">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="reset" class="btn">取消</button>
                                    <button type="submit" class="btn btn-success">保存</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
<%--     <script src="${ctx}/static/assets/js/jquery.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap.min.js"></script>
	<script src="${ctx}/static/assets/js/matrix.js"></script>
	<script src="${ctx}/static/assets/js/matrix.tables.js"></script>
	<script src="${ctx}/static/assets/plugins/jquery_validate_min.js"></script>
	<script src="${ctx}/static/assets/plugins/jquery_validate_methods.js"></script>
	<script src="${ctx}/static/assets/js/application.js"></script>
	
	 --%>
<script src="${ctx}/static/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/static/assets/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/static/assets/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${ctx}/static/assets/js/matrix.form_common.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.js"></script>
<script src="${ctx}/static/assets/plugins/wizard/jquery.form.wizard.js"></script>
<script src="${ctx}/static/assets/plugins/fileupload/bootstrap-fileupload.min.js"></script>
<script src="${ctx}/static/assets/js/form-wizard.js"></script>
<script src="${ctx}/static/assets/js/pages/vote.js"></script>

<script type="text/javascript">  
	var editor;
	var editorItems = ['source', '|', 'justifyleft', 'justifycenter', 'justifyright',
	                      'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'clearhtml', '|',
	                      'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
	                      'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
	                      'table', 'hr', 'emoticons', 'link', 'unlink'
	                  ];
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="detail"]', {
			allowFileManager : true,
			items : editorItems,
			imageUploadJson:'${ctx}/component/kindeditor/uploadImage'
		});
	});


	// ajax方式提交form
	$().ready(function() {
		$("#addActiityForm").ajaxForm({
			dataType : "json"
		});
	});
	
	// 保存
	$('#next').click(function(){
		$("#addActiityForm").attr("action","/ams/vote/activity/${action}");

		$("#addActiityForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert("保存成功");
		        		}else if('0001' == data.code){
		        			// $('#message').text("您的操作超时，请重试！");
			            	alert("您的操作超时，请重试！");
		        		}else {
		        			// $('#message').text(data.msg);
			            	alert(data.msg);
		        		}
		        	}else{
		            	alert("操作异常，请重试。");
		        	}
		        });
	});
	
	$(function() {
		//全选 /全不选 
		$("#CheckedAll").click(function() {
			var chooseState = $("#chooseState").val();
			if ('0' == chooseState) {
				$('[name=chooseProduct]:checkbox').attr('checked', true);
				$("#chooseState").val('1');
			} else if ('1' == chooseState) {
				$('[name=chooseProduct]:checkbox').attr('checked', false);
				$("#chooseState").val('0');
			}

		});

		// 可选择产品  
		$("#chooseYes").click(function() {
			$("#CheckedAll").attr('disabled', false);
			$('[name=chooseProduct]:checkbox').attr('disabled', false);
		});

		//不选择产品  
		$("#chooseNo").click(function() {
			$('[name=chooseProduct]:checkbox').attr('checked', false);
			$("#CheckedAll").attr('checked', false);
			$("#chooseState").val('0');
			$("#CheckedAll").attr('disabled', true);
			$('[name=chooseProduct]:checkbox').attr('disabled', true);
		});

	})

	// 模拟处理非选中效果传值到后台 
	function checked_Y(checked_Y) {
		var $this = $(checked_Y);
		if (!$this.attr('checked')) {
			$this.parents('label').find('.checked_N').attr('checked', true);
			$this.parents('label').find('.checked_Y').attr('checked', false);
		} else {
			$this.parents('label').find('.checked_N').attr('checked', false);
			$this.parents('label').find('.checked_Y').attr('checked', true);
		}
	}
</script>
</body>
</html>
