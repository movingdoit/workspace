<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/static/assets/css/style.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="/static/assets/js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="/static/assets/js/popup_layer.js"></script>
	<script type="text/javascript">
		
</script>
</head>
<body>


<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>会员申请记录</h1>
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
                            <li ${members!=null ? 'class="active"' : '' }><a href="${handle =='handle' ? '${ctx}/member/record/list' : ''}">待处理</a></li>
                            <li ${handleMembers!=null ? 'class="active"' : '' }><a href="${handle =='handle' ? '${ctx}/member/handle/record' : ''}">已处理</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" ${members!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                        	<button type="button" class="tigger" onclick="tanchu()">点击</button>
                        
						    <div id="emample9" class="example">
						        <div id="ele9" class="tigger">编辑</div>
						        <div id="blk9" class="blk" style="display:none;">
						            <div class="head"></div>
						            <div class="main" style="width: 400px;">
						            	<form action="#" method="post" class="form-horizontal form-validate" >
							                <h2 style="color: blue;">等级编辑</h2>
								                <a href="javascript:void(0)" id="close9" class="closeBtn">关闭</a>
								                <div class="control-group" style="margin-left: 20px;">
				                                     <select name="gradeMember.id">
											        	<option value="1">会员</option>
											        	<option value="2">非会员</option>
												     </select>
				                                </div>
				                                <div class="form-actions">
					                                <button type="submit" id="save" class="btn btn-primary" >保存</button>
					                                <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
					                            </div>
						                </form>
						            </div>
						        </div>
						    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>
<!-- // Main Container -->
s<script type="text/javascript">
	function tanchu(){
		//示例9，综合效果
		var t9 = new PopupLayer({
			trigger:"#ele9",
			popupBlk:"#blk9",
			closeBtn:"#close9",
			useOverlay:true,
			useFx:true,
			offsets:{
				x:0,
				y:-41
			}
		});
		t9.doEffects = function(way){
			if(way == "open"){
				this.popupLayer.css({opacity:0.3}).show(300,function(){
					this.popupLayer.animate({
						left:($(document).width() - this.popupLayer.width())/2,
						top:(document.documentElement.clientHeight - this.popupLayer.height())/2 + $(document).scrollTop(),
						opacity:0.8
					},300,function(){this.popupLayer.css("opacity",1)}.binding(this));
				}.binding(this));
			}
			else{
				this.popupLayer.animate({
					left:this.trigger.offset().left,
					top:this.trigger.offset().top,
					opacity:0.1
				},{duration:200,complete:function(){this.popupLayer.css("opacity",1);this.popupLayer.hide()}.binding(this)});
			}
		}
	}
</script>

</body>
</html>