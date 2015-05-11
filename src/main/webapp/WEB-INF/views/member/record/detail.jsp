<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员详细页</title>
<link href="${ctx}/static/assets/css/jquery-webox.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${ctx}/static/assets/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/assets/js/jquery-webox.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){

		//内嵌弹出层调用
		$('#inside').click(function(){
			$.webox({
				height:250,
				width:300,
				bgvisibel:true,
				title:'等级编辑',
				html:$("#box").html()
			});
		});
	})
	</script>
</head>
<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>用户信息</h1>
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
                            <li id="_tab1" ${dataMember!=null ? 'class="active"' : '' }><a href="${ctx}${detail =='detail' ? '/member/data/' : ''}${id}">基本资料</a></li>
                            <li id="_tab2" ${infoMember!=null ? 'class="active"' : '' }><a href="${ctx}${detail =='detail' ? '/member/info/' : ''}${id}">基本信息</a></li>
                            <li id="_tab3" ${addressMember!=null ? 'class="active"' : '' }><a href="${ctx}${detail =='detail' ? '/member/address/' : ''}${id}">地址信息</a></li>
                        </ul>
                    </div>
                    <div class="widget-content tab-content nopadding">
                        <div id="tab1" ${dataMember!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                            <div class="pro-box" style="position: relative;left: -110px;">
		                        <form action="#" method="post" class="form-horizontal form-validate" novalidate="novalidate" >
                                <div class="control-group">
                                    <label class="control-label"> 用户名:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.name }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 姓名:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.realName }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 职务:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.position }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 邮箱:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.email }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 手机号码:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.phone }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 性别:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.sex==1 ? '男' : '女' }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 生日:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="<fmt:formatDate value="${dataMember.brithday}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 企业单位:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.enterprise.name }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 企业网址:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.enterprise.webSite }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 企业地址:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${dataMember.enterprise.address }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                            </form>
                            </div>
                        </div>
                        <div id="tab2" ${infoMember!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                        	<div class="pro-box" style="position: relative;left: -80px;">
                        		<form action="#" method="post" class="form-horizontal form-validate" novalidate="novalidate" >
                                <div class="control-group">
                                    <label class="control-label"> 用户等级:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${infoMember.memberGrade.id==1 ? '会员' : '非会员' }" class="span3" disabled="disabled">
                                        <a class="btn btn-mini" href="javascript:void(0);" id="inside"><strong>编辑</strong></a>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 好友数:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="111" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 购买商品数:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="12" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 发表话题数:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${topicSize}" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 设置:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${infoMember.status == true ? '开启' : '关闭' }" class="span3" disabled="disabled">
                                        <c:if test="${infoMember.status }"><a href="/member/updateStatus?id=${infoMember.id }&status=false" class="btn btn-mini"><strong>设置为禁用</strong></a></c:if>
                                        <c:if test="${!infoMember.status }"><a href="/member/updateStatus?id=${infoMember.id }&status=true" class="btn btn-mini"><strong>设置为开启</strong></a></c:if>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 状态:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${infoMember.status == true ? '正常' : '关闭' }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 注册日期:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${infoMember.registerTime }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 注册IP:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="192.168.1.1" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 最后登陆日期:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="${infoMember.lastLoginTime }" class="span3" disabled="disabled">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label"> 最后登陆IP:</label>
                                    <div class="controls">
                                        <input type="text" name="description" value="192.168.1.2" class="span3" disabled="disabled">
                                    </div>
                                </div>
                              </form>
		                	</div>
                        </div>
                        <div id="tab3" ${addressMember!=null ? 'class="tab-pane active"' : 'class="tab-pane p20"' }>
                        	<div class="pro-box" >
		                        <table class="table table-bordered table-striped">
		                            <thead>
		                            <tr>
		                                <th class="per10">收货人</th>
				                        <th class="per10">所在地区</th>
				                        <th class="per5">详细地址</th>
				                        <th class="per10">邮编</th>
				                        <th class="per5">手机</th>
				                        <th class="per5">是否默认地址</th>
				                        <th class="per5">操作</th>
		                            </tr>
		                            </thead>
		                            <tbody id="proList">
		                            <c:if test="${not empty addressMember.addressList }">
			                            <c:forEach items="${addressMember.addressList}" var="Item">
											<tr>
												<td>${Item.name}</td>
												<td>${Item.province} ${Item.city} ${Item.district}</td>
												<td>${Item.detailInfo}</td>
												<td>${Item.postCode}</td>
												<td>${Item.number}</td>
												<td>${Item.isDefault==true ? '是' : '否'}</td>
												<td>
													<shiro:hasPermission name="user:edit">
														<%-- <a href="/member/checkMember/${notItem.id}" class="btn btn-mini"  >默认地址</a> --%>
														<input type="checkbox" onclick="updateAddress(${Item.id},${addressMember.id})" id="updateAddress" name="isDefault" ${Item.isDefault==true ? 'checked' : ''}> 
													</shiro:hasPermission>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty addressMember.addressList}">
										<tr>
				                            <td colspan="7" class="text-center"><strong>没有任何信息 *_*</strong></td>
				                        </tr>
									</c:if>
		                            </tbody>
		                        </table>
		                        
		                	</div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    <!-- // Action Boxes -->
</div>

//弹框表单代码
<div id="box" >
	<div class="mainlist">
			<br>
			<form id="gradeMemberForm" action="/member/update/grade" method="post"  >
			   <input type="hidden" name="id" value="${infoMember.id}"/>
			   <div class="control-group" style="margin-left: 20px;">
				    <select name="memberGradeId">
					  	<option value="1">会员</option>
					  	<option value="2">非会员</option>
					</select>
               </div>
               <br>
               <br>
               <br>
                <div class="form-actions">
                   <button type="submit" class="btn btn-primary" >保存</button>
                   <button type="button" class="btn" onclick="window.history.go(-1);">取消</button>
               </div>
 			</form>
	</div>
</div>
<script src="/static/assets/js/jquery.form.min.js"></script>
s<script type="text/javascript">

	/* function gainTab (dom){
		var _href = dom.getAttribute("href");
		if(_href=="#tab1"){
			$("#_tab2").attr("class","");
			$("#_tab3").attr("class","");
			$("#_tab1").attr("class","active");
			
			$("#tab3").attr("class","tab-pane p20");
			$("#tab2").attr("class","tab-pane p20");
			$("#tab1").attr("class","tab-pane active");
		}else if(_href=="#tab2"){
			$("#_tab1").attr("class","");
			$("#_tab3").attr("class","");
			$("#_tab2").attr("class","active");
			
			$("#tab3").attr("class","tab-pane p20");
			$("#tab1").attr("class","tab-pane p20");
			$("#tab2").attr("class","tab-pane active");
		}else if(_href=="#tab3"){
			$("#_tab1").attr("class","");
			$("#_tab2").attr("class","");		//设置选中页签
			$("#_tab3").attr("class","active");
			
			$("#tab2").attr("class","tab-pane p20");
			$("#tab1").attr("class","tab-pane p20");  //设置选中页签对应的页面
			$("#tab3").attr("class","tab-pane active");
		}
		
	} */
	
	function updateAddress (addressId,memberId){
		$.ajax({
	        type: "GET",
	        url:'/member/update/address?addressId='+addressId+"&memberId="+memberId,
	        async: false,
	        success: function(data) {
	        	if(data){
	        		if('0000' == data.code){
	        			// $('#message').text("保存成功");
		            	alert(data.msg);
		    			location.href = "/member/address/"+memberId;
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
	        },
	        error: function(request) {
	            alert("网络连接超时，请重试！");
	        }
	    });
	}
	
	

</script>
	

</body>
</html>