<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
    <title>航冠微站:<sitemesh:title/></title>
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-style.css">
    <link rel="stylesheet" href="${ctx}/static/assets/css/matrix-media.css">
    <link rel="stylesheet" href="${ctx}/static/assets/font-awesome/css/font-awesome.css">
    
    <link rel="icon" href="http://duomi.me/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="http://duomi.me/favicon.ico" type="image/x-icon"> 

    <script src="${ctx}/static/assets/js/jquery.min.js"></script>
	<script src="${ctx}/static/assets/js/bootstrap.min.js"></script>
	<script src="${ctx}/static/assets/js/matrix.js"></script>
	<script src="${ctx}/static/assets/js/matrix.tables.js"></script>
	<script src="${ctx}/static/assets/plugins/jquery_validate_min.js"></script>
	<script src="${ctx}/static/assets/plugins/jquery_validate_methods.js"></script>
	<script src="${ctx}/static/assets/js/application.js"></script>
    <sitemesh:head />
</head>

<body>

	<%@ include file="/WEB-INF/layouts/header.jsp"%>
	<%@ include file="/WEB-INF/layouts/left.jsp"%>
	<sitemesh:body />
	<%@ include file="/WEB-INF/layouts/footer.jsp"%>
	
	<script type="text/javascript">
		if(document.domain == "a.duomi.me"){
			var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5bce2900c4ad28996a087899ee8c94fe' type='text/javascript'%3E%3C/script%3E"));
		}
	</script>
</body>
</html>