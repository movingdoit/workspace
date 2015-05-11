<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true"%>
<%@ attribute name="paginationSize" type="java.lang.Integer" required="true"%>
<%@ attribute name="async" type="java.lang.Boolean"%>
<%@ attribute name="baseURl" type="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
int current =  page.getNumber() + 1;
int begin = Math.max(1, current - paginationSize/2);
int end = Math.min(begin + (paginationSize - 1), page.getTotalPages());

request.setAttribute("current", current);
request.setAttribute("begin", begin);
request.setAttribute("end", end);
%>

<div class="pagination alternate text-left pull-left mt0">
	<ul>
		 <% if (page.hasPreviousPage()){%>
               	<li><a href="javascript:go('?page=1&sortType=${sortType}&${searchParams}')">&lt;&lt;</a></li>
                <li><a href="javascript:go('?page=${current-1}&sortType=${sortType}&${searchParams}')">&lt;</a></li>
         <%}else{%>
                <li class="disabled"><a href="#">&lt;&lt;</a></li>
                <li class="disabled"><a href="#">&lt;</a></li>
         <%} %>
 
		<c:forEach var="i" begin="${begin}" end="${end}">
            <c:choose>
                <c:when test="${i == current}">
                    <li class="active"><a href="javascript:go('?page=${i}&sortType=${sortType}&${searchParams}')">${i}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="javascript:go('?page=${i}&sortType=${sortType}&${searchParams}')">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
	  
	  	 <% if (page.hasNextPage()){%>
               	<li><a href="javascript:go('?page=${current+1}&sortType=${sortType}&${searchParams}')">&gt;</a></li>
                <li><a href="javascript:go('?page=${page.totalPages}&sortType=${sortType}&${searchParams}')">&gt;&gt;</a></li>
         <%}else{%>
                <li class="disabled"><a href="#">&gt;</a></li>
                <li class="disabled"><a href="#">&gt;&gt;</a></li>
         <%} %>

	</ul>
</div>

<script type="text/javascript" language="javaScript">
	function go(action){
		var async = '${async }';
		if('true' == async){
			// 异步分页处理
			var url = '${baseURl}';
			if(url.indexOf("?") > 0){
				url = url + action.replace('?', '&');
			}else{
				url = url + '&' + action;
			}
			jQuery.ajax({
			    url: url,
			    cache:false,
			    async:false,
			    error: function(request) {
			    	errorCallBack(request); // 异步请求失败的回调方法（需要在引用分页标签的页面实现）
			    },
			    success:function(data) {
			    	successCallBack(data); // 异步请求成功的回调方法（需要在引用分页标签的页面实现）
			    }
			});
		}else{
			// 同步分页处理
			document.location.href = action;
		}
	}
</script>
