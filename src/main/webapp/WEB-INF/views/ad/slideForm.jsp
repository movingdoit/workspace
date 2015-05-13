<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>添加轮播图</title>
</head>
<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 添加轮播图</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>添加轮播图</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="J_addForm" modelAttribute="siteSlide" action="#" method="post" class="form-horizontal form-validate"  enctype="multipart/form-data">
							<input type="hidden" name="id" value="${siteSlide.id}"/>
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  轮播图名称 :</label>
                                <div class="controls">
                                	<input type="text" id="title" name="title"  value="${siteSlide.slideTitle}" class="span2" data-rule-required="true" data-rule-maxlength="10" placeholder="最多10个字符"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">显示顺序 :</label>
                                <div class="controls">
                                	<input type="text" id="priority" name="paixu"  value="${siteSlide.priority}" class="span1" data-rule-required="true" data-rule-number="true"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">幻灯片封面 :</label>
                                <div class="controls">
                                    <img src="${ctx}${siteSlide.slidePic}" class="default-slider" />
                                    <input type="file" name="file" class="insertimage"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">是否显示 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="true" ${siteSlide.isDisplay ? 'checked' : ''}>显示</label>
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="false" ${!siteSlide.isDisplay ? 'checked' : ''}>隐藏</label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">类型 :</label>
                                <div class="controls">
                                    <select id="type" name="bindPath" class="input-medium">
                                        <option value="">选择类型</option>
                                    	<c:forEach var="item" items="${allBindType}">   
	                                        <option value="${item.key}" ${(fn:contains(siteSlide.bindPath, item.key)) ? 'selected' : ''}>${item.value}</option>
										</c:forEach>  
                                    </select>
                                    <span id="chooseCMS" class="help-inline ${(fn:contains(siteSlide.bindPath, 'bbs')) ? '' : 'hide'} "><a href="javascript:void(0)" class="btn btn-mini ed_choose red">请选择板块 <i class="icon-edit"></i></a></span>
                                </div>
                            </div>
                            
                            <input type="hidden" id="bindTxt" name="bindTxt" value="${siteSlide.bindTxt }" >
                            
                            <div id="r_bbs" class="control-group r-module ${(fn:contains(siteSlide.bindPath, 'bbs')) ? '' : 'hide'}">
                                <div class="control-group">
                                    <label class="control-label">已选板块 :</label>
                                    <div class="controls" id="articleResult">
                                        <span id="a_txt">${siteSlide.bindTxt }</span>
                                        <input type="hidden" name="acat_id" value="${(siteSlide.bindPath =='bbs/forum') ? siteSlide.bindValue : ''}">
                                        <input type="hidden" name="a_id" value="${(siteSlide.bindPath =='bbs/topic') ? siteSlide.bindValue : ''}">
                                    </div>
                                </div>
                            </div>
                            <div id="r_link" class="control-group r-module ${(siteSlide.bindPath =='link') ? '' : 'hide'}">
                                <div class="control-group">
                                    <label class="control-label" for="link"><i class="red">*</i> 外链地址:</label>
                                    <div class="controls">
                                        <input type="url" id="link" name="link" value="${(siteSlide.bindPath =='link') ? siteSlide.bindValue : ''}" class="input-xlarge" data-rule-required="true" data-rule-url="true">
                                        <span class="help-inline">（例如：http://www.duomi.me）</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="button" id="save" class="btn btn-primary">保存</button>
                                <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
                            </div>
                        </form>
                        <div id="cmsCatChoose" class="cat-choose hide">
                            <div class="modal-header">
                                <h4>板块列表</h4>
                            </div>
                            <div class="modal-body">
                                <p>您共有 <span class="red" id="categoryNum">${forumSize }</span> 个板块，（您还没有添加过板块，现在就去添加吧）<a href="${ctx}/forum/list" class="blue">板块管理</a></p>
                                <c:forEach items="${forums}" var="Item">
	                                <label class="radio"><input type="radio" name="category" value="${Item.id }" data-title="${Item.title }" >${Item.title }</label>
				            	</c:forEach>
                            </div>
                        </div>
                        
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
<script>
	// 选择板块
    $('#cmsCatChoose label').click(function(){
        var _value = '',_catId,_articleId;
        var $catChecked = $(this).find('input[type="radio"]:checked');
        _value += $catChecked.attr('data-title');
        _catId = $catChecked.val();
        $('#articleResult input[name="acat_id"]').val(_catId);
        // 异步加载板块列表
        var contentPage;
		if(typeof(_catId) != "undefined"){
			
		    jQuery.ajax({
			    url:'${ctx}/bbs/topic/choosePage?search_EQ_forum.id='+_catId,
			    cache:false,
			    async:false,
			    success:function(data) {
			    	contentPage =  data;
			    }
			});
		    
	        $('#articleChooseModal').html(contentPage);
	        $('#articleChooseModal').modal();
		}
        $('#chooseOK').click(function(){
            var $articleChecked = $('#articleChooseModal input[type="radio"][name="choose"]:checked');
            _articleId = $articleChecked.val();
            if(_articleId) {
                _value += '--'+$articleChecked.attr('data-title');
                $('#articleResult input[name="a_id"]').val(_articleId);
            } else {
                $('#articleResult input[name="a_id"]').val('');
            }
            $('#bindTxt').val(_value);
            $('#a_txt').html(_value);
            $('#cmsCatChoose').hide();
        });
    });
	
	// 异步分页请求处理成功回调方法
	function successCallBack(data){
		$('#articleChooseModal').html(data);
        $('#articleChooseModal').modal();
	}
	// 异步分页请求处理失败回调方法
	function errorCallBack(data){
		alert("请求数据异常，请重试！");
	}
	
	// ajax方式提交form
	$().ready(function() {
		$("#J_addForm").ajaxForm({
			dataType : "json"
			
		});
	});
	
	// 保存
	$('#save').click(function(){
		var bindTxt = $("#bindTxt").val();
		$("#J_addForm").attr("action","${ctx}/bbs/slide/${action}?bindTxt="+bindTxt);
		$("#J_addForm").ajaxSubmit(
				function(data) {
		        	if(data){
		        		if('0000' == data.code){
		        			// $('#message').text("保存成功");
			            	alert(data.msg);
			            	location.href = "${ctx}/bbs/slide/list";
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
