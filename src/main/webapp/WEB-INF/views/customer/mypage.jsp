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
  
  <h3>Mypage</h3>
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
    <label for="cus_phone">Phone</label>
    <input type="text" class="form-control" id="cus_phone" name="cus_phone" value='<c:out value="${customerVO.cus_phone }"/>' readonly>
  </div>
  
  <div class="form-row">
    <div class="col-md-12">
	    <label for="cus_mail">Email address</label>
	    <input type="text" class="form-control" id="cus_mail" name="cus_mail" value='<c:out value="${customerVO.cus_mail }"/>' readonly>
	</div>
  </div>
   
   <div class="form-row">
    <div class="col-md-6">
      <label for="">메일수신여부</label>
      <input type="text" class="form-control" id="" name="" value='<c:out value="${customerVO.cus_receive == 'Y' ? '가능': '불가능' }"/>' readonly>
    </div>
    
  <div class="form-row">
    <div class="col-md-5">
	    <label for="cur_cus_pw">현재 비밀번호</label>
	    <input type="password" class="form-control" id="cur_cus_pw" name="cur_cus_pw">
	</div>
	<div class="col-md-5">
	    <label for="change_cus_pw">변경 비밀번호</label>
	    <input type="password" class="form-control" id="change_cus_pw" name="change_cus_pw">
  	</div>
  	<div class="col-md-2">
  		<label for="cur_mbsp_password">&nbsp;</label>
   		<button type="button" id="btnChangePw" class="form-control">비밀번호 변경</button>
    </div>
  </div> 
  
  <div class="form-row">
    <div class="col-md-5">
	    <label for="cus_pw">현재 비밀번호</label>
	    <input type="password" class="form-control" id="cus_pw" name="cus_pw">
	</div>
	
  	<div class="col-md-2">
  		<label for="btnRegDelete">&nbsp;</label>
   		<button type="button" id="btnRegDelete" class="form-control">회원탈퇴</button>
    </div>
  </div> 
  
    
</div>


  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<script>

  $(document).ready(function(){

	  // 비번 변경
  	$("#btnChangePw").on("click", function(){

      let cur_cus_pw = $("#cur_cus_pw");
      let change_cus_pw = $("#change_cus_pw");

      if(cur_cus_pw.val() == "" || cur_cus_pw.val() == null){
        alert("현재비밀번호를 입력하세요");
        cur_cus_pw.focus();
        return;
      }
      
      if(change_cus_pw.val() == "" || change_cus_pw.val() == null){
        alert("변경할 비밀번호를 입력하세요");
        change_cus_pw.focus();
        return;
      }

      $.ajax({
        url: '/customer/changePw',
        type: 'post',
        dataType: 'text',
        data: { cur_cus_pw : cur_cus_pw.val(), change_cus_pw : change_cus_pw.val() },
        success: function(data){
          
        
        if(data == "success"){
          alert("비밀번호 변경 성공.");
        }else if(data == "fail"){
          alert("현재 비밀번호가 다릅니다.")
          cur_cus_pw.val("");
          cur_cus_pw.focus();
        }
      }
    });
  });
  	
	  // 회원탈퇴
  	$("#btnRegDelete").on("click", function(){

        let cus_pw = $("#cus_pw");

        if(cus_pw.val() == "" || cus_pw.val() == null){
          alert("현재비밀번호를 입력하세요");
          cus_pw.focus();
          return;
        }      

        $.ajax({
          url: '/customer/regDelete',
          type: 'post',
          dataType: 'text',
          data: { cus_pw : cus_pw.val()},
          success: function(data){
            
          
          if(data == "1"){
            alert("탈퇴 성공.");
            location.href = "/";
          }else if(data == "0"){
            alert("현재 비밀번호가 다릅니다.")
            cus_pw.val("");
            cus_pw.focus();
          }
        }
      });
    });
  	
 });


</script>

      
  </body>
</html>
