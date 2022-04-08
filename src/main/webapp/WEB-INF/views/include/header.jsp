<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/plugin_js.jsp" %>
    
<!--  
<nav class="site-header sticky-top py-1">
  <div class="container d-flex flex-column flex-md-row justify-content-between">
    <a class="py-2" href="#" aria-label="Product">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="d-block mx-auto" role="img" viewBox="0 0 24 24" focusable="false"><title>Webmall</title><circle cx="12" cy="12" r="10"></circle><path d="M14.31 8l5.74 9.94M9.69 8h11.48M7.38 12l5.74-9.94M9.69 16L3.95 6.06M14.31 16H2.83m13.79-4l-5.74 9.94"></path></svg>
    </a>
    
    <c:if test="${sessionScope.loginStatus == null }">
    
    <a class="p-2 text-dark" href="/customer/login">LOGIN</a>
    <a class="p-2 text-dark"href="/customer/join">JOIN</a>
    
    </c:if>
    
    <c:if test="${sessionScope.loginStatus != null }">
    
    <a class="p-2 text-dark" href="/customer/logout">LOGOUT</a>
    <a class="p-2 text-dark" href="/customer/modify">MODIFY</a>
    
    </c:if>
    
    
    <a class="py-2 d-none d-md-inline-block" href="/customer/mypage">MYPAGE</a>
    <a class="py-2 d-none d-md-inline-block" href="#">ORDER</a>
    <a class="py-2 d-none d-md-inline-block" href="#">CART</a>
    
  </div>
  
  
  
</nav>
-->


<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-lg-5">
        <a class="navbar-brand" href="#!">Webmall</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>


			    <c:if test="${sessionScope.loginStatus == null }">
			    
			    <a class="py-2 d-none d-md-inline-block" href="/customer/login">LOGIN</a>
			    <a class="py-2 d-none d-md-inline-block"href="/customer/join">JOIN</a>
			    
			    </c:if>
			    
			    <c:if test="${sessionScope.loginStatus != null }">
			    
			    <a class="ppy-2 d-none d-md-inline-block" href="/customer/logout">LOGOUT</a>
			    <a class="py-2 d-none d-md-inline-block" href="/customer/modify">MODIFY</a>
			    
			    </c:if>
			    
			    
			    <a class="py-2 d-none d-md-inline-block" href="/customer/mypage">MYPAGE</a>
			    <a class="py-2 d-none d-md-inline-block" href="#">ORDER</a>
			    <a class="py-2 d-none d-md-inline-block" href="/cart/cartList">CART</a>

        </div>
</nav>
<div class="container">
	<ul class="nav nav-tabs">
		<!-- 
	  <li class="nav-item">
	    <a class="nav-link active" href="#">Active</a>
	  </li>
	   -->
	  <%--
	  <c:forEach items="${userCategory}" var="categoryVO">
		  <li class="nav-item dropdown">
		    <a class="nav-link" data-toggle="dropdown" href="${categoryVO.cg_code }" role="button" aria-expanded="false">${categoryVO.cg_name }</a>
		    <div class="dropdown-menu" id="subCategory_${categoryVO.cg_code }">
		    </div>
		  </li>
	  </c:forEach>
	   --%>
	   
	  <c:forEach items="${userCategory}" var="categoryVO">
		  <li class="nav-item dropdown">
		    <a class="nav-link" data-toggle="dropdown" href="${categoryVO.cg_code }" role="button">${categoryVO.cg_name }</a>
		    <div class="subCategory" id="subCategory_${categoryVO.cg_code }"></div>
		  </li>
	  </c:forEach>
	 </ul>
</div>

<script>
	$(function(){
	  
	  //1차카테고리 클릭시
	  $(".nav .nav-item a.nav-link").on("click", function(){
		console.log("1차카테고리");

		let url = "/product/subCategory/" + $(this).attr("href");
		let curAnchor = $(this); // ajax메서드 호출전에 선택자 this를 전역변수로 받아야 한다.

	      $.getJSON(url, function(data){
			
			// 2차카테고리 정보를 모두 삭제해라.(기존제거)
			$(".nav .nav-item div.subCategory").each(function(){
				
				$(this).empty();
			});

			let subCategoryStr = "";
			for(let i=0; i<data.length; i++) {

				let selector = "#subCategory_" + data[i].cg_first_code;

				subCategoryStr = "<a class='sub_cg' href='" + data[i].cg_code + "'>" + data[i].cg_name + "</a>";
				$(selector).append(subCategoryStr);
			}
			
	      });
	  });

	  $("div.subCategory").on("click", "a.sub_cg", function(e){
		e.preventDefault();

		location.href = "/product/productList?cg_code=" + $(this).attr("href");
	  });
	});
  </script>


