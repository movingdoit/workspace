<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>新增分类</title>
</head>

<body>

<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1><i class="icon-edit"></i> 添加分类</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>添加分类</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="${ctx}/cms/channel/${action}" method="post" class="form-horizontal form-validate">
                        	<input type="hidden" name="id" value="${cmsChannel.id}"/>
							<input type="hidden" name="parent.id" value="${cmsChannel.parent.id}"/>
							<input type="hidden" name="isCustom" value="false">
                            <div class="control-group">
                                <label class="control-label"><i class="red">*</i>  分类标题 :</label>
                                <div class="controls">
                                    <input type="text" id="cmsChannel_channelTitle" name="channelTitle"  value="${cmsChannel.channelTitle}"  class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">显示顺序 :</label>
                                <div class="controls">
                                    <input type="text" class="span1" id="cmsChannel_priority" name="priority"  value="${cmsChannel.priority}" value="0" data-rule-required="true" data-rule-number="true">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">是否显示 :</label>
                                <div class="controls">
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="true" ${cmsChannel.isDisplay ? 'checked' : ''}>显示</label>
                                    <label class="radio inline"><input type="radio" name="isDisplay" value="false" ${!cmsChannel.isDisplay ? 'checked' : ''}>隐藏</label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">展现模板 :</label>
                                <div class="controls">
                                   <ul class="tpl-list unstyled clearfix" id="tplChoose">
		                            	<c:if test="${not empty siteTempletlist && fn:length(siteTempletlist) >0 }">
		                    				<c:forEach items="${siteTempletlist}" var="siteTemplet" varStatus="status">
							                    <li ${(((null == cmsChannel.siteTemplet || cmsChannel.siteTemplet.id == null) && status.index == 0 ) || (cmsChannel.siteTemplet.id == siteTemplet.id))? 'class="active"' : '' }>
							                        <label>
							                            <i class="cover"></i>
							                            <img src="${ctx}${siteTemplet.thumbnail }">
							                            <input type="radio" name="siteTemplet.id" value="${siteTemplet.id }" ${(((null == cmsChannel.siteTemplet || cmsChannel.siteTemplet.id == null) && status.index == 0 ) || (cmsChannel.siteTemplet.id == siteTemplet.id))? 'checked' : '' }>${siteTemplet.name }
							                        	</br>${siteTemplet.summary }
							                        </label>
							                    </li>
		                    				</c:forEach>
	                    				</c:if>
					                </ul>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">保存</button>
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

</body>
</html>
