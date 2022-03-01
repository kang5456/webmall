<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
   
<%@ include file="/WEB-INF/views/include/plugin_js.jsp" %>  
    
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