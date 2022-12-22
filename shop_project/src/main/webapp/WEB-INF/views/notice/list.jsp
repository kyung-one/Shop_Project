<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../includes/header.jsp"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container mt-3">
<h3>공지사항(${count })</h3>

<table class="table table-hover">
	<thead>
	  <tr>	  
	    <th class="text-center" width="150">번호</th>
		<th class="text-center">제목</th>
		<th class="text-center" width="100">작성자</th>
		<th class="text-center" width="150">작성시간</th>
		
	</tr>	
 </thead>
 <tbody>
		<c:forEach items="${list }" var="lists" varStatus="st">
			<tr>
			<td class="text-center">${lists.noticenum}</td>
			<td class="left"><a href="/view/${lists.noticenum }"> ${lists.title }</a></td>
			<td class="text-center">${lists.member.username }</td>
			<td class="text-center"><fmt:formatDate value="${lists.regdate}" pattern="yyyy-MM-dd" /> </td>
				
		</tr>
		
		</c:forEach>		
  </tbody>
</table>


<div class="d-flex justify-content-between mr-auto">
<!-- 		<ul class="pagination"> -->
<%-- 			<c:if test="${product.first==false }"> --%>
<!-- 				<li class="page-item"><a class="page-link" -->
<%-- 					href="?page=${product.number-1 }&field=${param.field}&word=${param.word}">이전</a></li> --%>
<%-- 			</c:if> --%>
<%-- 			<c:if test="${product.last==false }"> --%>
<!-- 				<li class="page-item"><a class="page-link" -->
<%-- 					href="?page=${product.number+1 }&field=${param.field}&word=${param.word}">다음</a></li> --%>
<%-- 			</c:if> --%>
<!-- 		</ul> -->
		<div>
			
  
  <form class="form-inline" action="/noticelist" method="get">
<div class="container" align="center">
   	<select name="field"  id="field" class="form-control mr-sm-1">
    		<option value="title"> 제목
    		<option value="content"> 내용
    </select>
    
      <script>
    $("#field option").each(function(){
    	if($(this).val()=="${param.field}"){
    		$(this).prop("selected",true);
    	}
    })
    </script>
    <input type="text" name="word" class="form-control" placeholder="검색">
				<button class="btn btn-secondary">검색</button>
  </div>
</form>
		</div>

</div>



</div>
<%@ include file="../includes/footer.jsp"%>