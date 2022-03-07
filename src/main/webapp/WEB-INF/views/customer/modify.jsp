<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
    
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Product example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/product/">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="product.css" rel="stylesheet">
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

	
<div class="container">
  
  <h3>회원수정 폼</h3>
  <form action="/customer/modify" method="post" id="modifyForm">
  <div class="form-row">
    <div class="col-md-12">
	    <label for="cus_id">ID</label>
	    <input type="text" class="form-control" id="cus_id" name="cus_id" value='<c:out value="${customerVO.cus_id }"/>' readonly>
	</div>
  </div>
  
  <div class="form-group">
    <label for="cus_name">Name</label>
    <input type="text" class="form-control" id="cus_name" name="cus_name" value='<c:out value="${customerVO.cus_name }"/>'  readonly>
  </div>
  
  <div class="form-group">
    <label for="cus_pw">Password</label>
    <input type="password" class="form-control" id="cus_pw" name="cus_pw" >
  </div>
  
  <div class="form-group">
    <label for="exampleInputEmail1">Password Check</label>
    <input type="text" class="form-control" id="cus_repw">
  </div>
  
   <div class="form-group">
    <label for="cus_phone">Phone</label>
    <input type="text" class="form-control" id="cus_phone" name="cus_phone" value='<c:out value="${customerVO.cus_phone }"/>' >
  </div> 
  
  <div class="form-row">
    <div class="col-md-12">
	    <label for="cus_mail">Email address</label>
	    <input type="text" class="form-control" id="cus_mail" name="cus_mail" value='<c:out value="${customerVO.cus_mail }"/>' >
	</div>
  </div>
   

  <div class="form-group form-check">
    <input type="checkbox" class="form-check-input" id="cus_receive" name="cus_receive" value='<c:out value="${customerVO.cus_receive }"/>' <c:out value="${customerVO.cus_receive == 'Y' ? 'checked': '' }"/> >
    <label class="form-check-label" for="mbsp_receive">메일수신여부</label>
  </div>
  <button type="button" id="btnModify" class="btn btn-primary">Modify</button>
</form>
  
  

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<script>

  $(document).ready(function(){



    $("#btnModify").on("click", function(){

      let cus_pw = $("#cus_pw");
      let cus_repw = $("#cus_repw");

      if(cus_pw.val() == "" && cus_repw.val() == ""){
        alert("비밀번호를 입력하세요");
        return;
      }


      if(cus_pw.val() != cus_repw.val()){
        alert("비밀번호가 일치하지 않습니다.");
        return;
      }

      $("#modifyForm").submit();

    });
    

  });


</script>

      
  </body>
</html>
