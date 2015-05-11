<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
	<title>站点配置</title>
	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
</head>

<body>
<!-- Main Container -->
<div id="content">
    <!-- Breadcrumbs -->
    <div id="content-header">
        <h1>站点配置</h1>
    </div>
    <!-- // Breadcrumbs -->
    <!-- Action Boxes -->
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                        <h5>站点配置</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="inputForm" modelAttribute="siteConfig" action="${ctx}/site/config" method="post" class="form-horizontal form-validate" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${siteConfig.id}"/>
						<input type="hidden" name="domain" value="${siteConfig.domain}"/>
						<input type="hidden" name="bgPic" value="${siteConfig.bgPic}"/>
                            <div class="control-group">
                                <label class="control-label"> 访问路径 :</label>
                                <div class="controls">
                                    <input type="text" id="siteConfig_sitePath" name="sitePath"  value="${siteConfig.sitePath}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符">
                                	<c:if test="${null != siteConfig && null != siteConfig.sitePath && '' != siteConfig.sitePath }">
                                		<a href="http://v.duomi.me/${siteConfig.sitePath}" target="_blank">微站预览</a>（修改后需要先保存）
                                	</c:if>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"> 站点名称 :</label>
                                <div class="controls">
                                    <input type="text" id="siteConfig_siteName" name="siteName"  value="${siteConfig.siteName}" class="span3" data-rule-required="true" data-rule-maxlength="20" placeholder="最多20个字符">
                                </div>
                            </div>
                            <div class="control-group" style="display: none">
                                <label class="control-label">站点简称 :</label>
                                <div class="controls">
                                    <input type="text" class="span3" id="siteConfig_shortName" name="shortName"  value="${siteConfig.shortName}" >
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">站点简介 :</label>
                                <div class="controls">
                                    <textarea  id="siteConfig_summary" name="summary" rows="2" class="span10">${siteConfig.summary}</textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">首页背景 :</label>
                                <div class="controls">
                                    <img src="${ctx}${siteConfig.bgPic}" class="default-slider" />
                                    <input type="file" name="file" class="insertimage"/>
                                </div>
                            </div>
                            <div class="control-group" style="display: none">
                                <label class="control-label">版权信息 :</label>
                                <div class="controls">
                                    <textarea  id="siteConfig_copyright" name="copyright" rows="2" class="span10">${(null != siteConfig.copyright && '' != siteConfig.copyright) ? siteConfig.copyright : '<p>Copyright 2013 - 2014 Hangguan.<br>All Rights Reserved.</p><p>航冠科技 版权所有</p>'}</textarea>
                                </div>
                            </div>

                            <div class="control-group">
                            	<label class="control-label">站点模板 :</label>
                                <div class="controls">
		                            <ul class="tpl-list unstyled clearfix" id="tplChoose">
		                            	<c:if test="${not empty siteTempletlist && fn:length(siteTempletlist) >0 }">
		                    				<c:forEach items="${siteTempletlist}" var="siteTemplet" varStatus="status">
							                    <li ${(((null == siteConfig.siteTemplet || siteConfig.siteTemplet.id == null) && status.index == 0 ) || (siteConfig.siteTemplet.id == siteTemplet.id))? 'class="active"' : '' }>
							                        <label>
							                            <i class="cover"></i>
							                            <img src="${ctx}${siteTemplet.thumbnail }">
							                            <input type="radio" name="siteTemplet.id" value="${siteTemplet.id }" ${(((null == siteConfig.siteTemplet || siteConfig.siteTemplet.id == null) && status.index == 0 ) || (siteConfig.siteTemplet.id == siteTemplet.id))? 'checked' : '' }>${siteTemplet.name }
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
