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
                            <li class="active"><a href="/ams/vote/rule/${actId}">规则设置</a></li>
                            <li><a href="/ams/vote/module/${actId}">自定义模块</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" class="tab-pane">
                        </div>
                        <div id="tab2" class="tab-pane p20">
                        </div>
                        <div id="tab3" class="tab-pane active">
                            <form action="save" method="post" class="form-horizontal form-validate" novalidate="novalidate">
                            	<input type="hidden" class="span1" name="id" value="${voteRule.id }">
                            	<input type="hidden" class="span1" name="voteActivity.id" value="${ null != voteRule ? voteRule.voteActivity.id : actId }">
                            	<input type="hidden" class="span1" name="title" >
                                <div class="control-group">
                                    <label class="control-label">用户类型 :</label>
                                    <div class="controls">
                                        <select name="needSubscribe">
                                            <option value="1" ${voteRule.needSubscribe ? 'selected' : '' }>会员投票</option>
                                            <option value="0" ${voteRule.needSubscribe ? '' : 'selected' }>所有人均可投票</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">限制用户 :</label>
                                    <div class="controls">
                                        <label class="radio inline"><input type="radio" name="userMark" value="1" ${voteRule.userMark ? 'checked' : '' }>是</label>
                                        <label class="radio inline"><input type="radio" name="userMark" value="0" ${voteRule.userMark ? '' : 'checked' }>否</label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">用户投票周期设置 :</label>
                                    <div class="controls">
                                        <input type="text" class="span1" name="userTime" value="${voteRule.userTime }" data-rule-digits="true"> 小时
                                        <span class="help-inline">不设置则认为不限制</span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">周期内投票数设置 :</label>
                                    <div class="controls">
                                        <input type="text" class="span1" name="userLimit" value="${voteRule.userLimit }" data-rule-digits="true"> 张
                                        <span class="help-inline">不设置则认为不限制</span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">规则说明 :</label>
                                    <div class="controls">
                                        <textarea name="description">${voteRule.description }</textarea>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <button type="reset" class="btn">取消</button>
                                    <button type="submit" class="btn btn-success">保存</button>
                                </div>
                            </form>
                        </div>
                        <div id="tab4" class="tab-pane p20">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->

<!-- Modal -->
<div id="cmsChooseModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4>文章一级分类名称</h4>
    </div>
    <div class="modal-body">
        <h5>选择该分类</h5>
        <p class="label-inline"><input type="radio" name="choose" id="cat1" value="" title="文章分类1"><label for="cat1">文章分类1</label></p>
        <h5>选择单篇文章</h5>
        <p class="label-inline"><input type="radio" name="choose" id="cms1" value="0" title="珠宝鉴赏沙龙0" checked><label for="cms1">珠宝鉴赏沙龙0</label></p>
        <p class="label-inline"><input type="radio" name="choose" id="cms2" value="1" title="珠宝鉴赏沙龙1"><label for="cms2">珠宝鉴赏沙龙1</label></p>
        <p class="label-inline"><input type="radio" name="choose" id="cms3" value="2" title="珠宝鉴赏沙龙2"><label for="cms3">珠宝鉴赏沙龙2</label></p>
        <p class="label-inline"><input type="radio" name="choose" id="cms4" value="3" title="珠宝鉴赏沙龙3"><label for="cms4">珠宝鉴赏沙龙3</label></p>
        <p class="label-inline"><input type="radio" name="choose" id="cms5" value="4" title="珠宝鉴赏沙龙4"><label for="cms5">珠宝鉴赏沙龙4</label></p>
        <p>
            <button type="button" class="btn btn-mini" id="p_page"><strong>上一页</strong></button>
            <span id="p_page_str">第1页/共1页</span>
            <button type="button" class="btn btn-mini" id="n_page"><strong>下一页</strong></button>
        </p>
    </div>
    <div class="modal-footer">
        <span class="pull-left"><a class="blue" href="#">管理该文章分类</a>(点击关闭浮层并新窗口打开至该文章分类)</span>
        <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
        <button type="button" class="btn btn-primary" id="chooseOK">确定</button>
    </div>
</div>
<!-- // Modal -->
<!-- Add Vote Option Modal -->
<div id="addVoteOptionModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4>新增投票选项</h4>
    </div>
    <form id="J_addVoteOptFrom" class="form-horizontal form-validate" novalidate="novalidate">
        <div class="modal-body">
            <div class="control-group">
                <label class="control-label"><i class="red">*</i> 选项标题 :</label>
                <div class="controls">
                    <input type="text" name="title" class="span3" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">选项封面 :</label>
                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="assets/img/noimage.gif" /></div>
                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                        <div>
                            <span class="btn btn-file"><span class="fileupload-new">选择图片</span><span class="fileupload-exists">更换</span><input type="file" name='imagefile' /></span>
                            <a href="#" class="btn btn-file fileupload-exists" data-dismiss="fileupload">删除</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">详细介绍 :</label>
                <div class="controls">
                    <textarea name="intro"></textarea>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
            <button type="submit" class="btn btn-primary">保存</button>
        </div>
    </form>
</div>
<!-- // Add Vote Option Modal -->
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
