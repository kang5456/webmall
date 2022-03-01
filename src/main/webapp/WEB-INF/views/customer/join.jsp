<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<!-- 회원가입 작업 -->

	<h3>회원가입 폼</h3>
	
<form action="/customer/join" method="post" id="joinForm">
  <div class="form-row">
  	<div class="col-md-3">
	    <label for="cus_id">ID</label>
	    <input type="text" class="form-control" id="cus_id" name="cus_id">
    </div>    
    
    <div class="col-md-2">
    	<label for="idStatus">&nbsp;</label>
    	<button type="button" class="form-control" id="btnIDCHK">Id duplicate check</button>
    </div>
  </div>
  
  
  <div class="form-group">
    <label for="cus_name">Name</label>
    <input type="text" class="form-control" id="cus_name" name="cus_name">
  </div>
  
  <div class="form-group">
    <label for="cus_pw">Password</label>
    <input type="password" class="form-control" id="cus_pw" name="cus_pw">
  </div>
  
   <div class="form-group">
    <label for="exampleInputEmail1">Password Check</label>
    <input type="text" class="form-control" id="exampleInputEmail1">
  </div>
  
  
  <div class="form-row">
  	<div class="col-md-6">
    	<label for="cus_mail">Email address</label>
    	<input type="text" class="form-control" id="cus_mail" name="cus_mail">
    </div>
  
    <div class="col-md-2">
    	<label for="btnMailAuthReq">메일확인바랍니다.</label>
    	<button type="button" class="form-control" id="btnMailAuthReq">메일인증요청</button>
    </div>
    
  <div class="form-group">
    <label for="cus_phone">Phone</label>
    <input type="text" class="form-control" id="cus_phone" name="cus_phone">
  </div>
    <div class="col-md-2">
    	<label for="cus_mail">인증코드입력</label>
    	<input type="text" class="form-control" id="auth_mail" name="auth_mail">
    </div>
  
    <div class="col-md-2">
    	<label for="authMailState">&nbsp;</label>
    	<button type="button" class="form-control" id="btnMailAuthConfirm">인증확인</button>
    </div>
  </div>
  
  <div class="form-group form-check">
    <input type="checkbox" class="form-check-input" id="cus_receive" name="cus_receive" value="Y">
    <label class="form-check-label" for="cus_receive">메일수신여부</label>
  </div>
  
  <button type="submit" id="btnJoin" class="btn btn-primary">Sign Up</button>
</form>




<%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>
    
<script>

  $(document).ready(function(){

    let isCheckID = false;

    let isMailAuthConfirm = false;

    $("#joinForm").on("submit", function(){


      if(isCheckID == fasle){
        alert("아이디 중복 확인 바랍니다.");
        $("#cus_id").focus();
        return false;
      }

      if(isMailAuthConfirm == fasle){
        alert("메일 인증 확인 바랍니다.");
        $("#btnMailAuthReq").focus();
        return false;
      }

    });



	// 아이디 중복
    $("#btnIDCHK").on("click", function(){

    	isCheckID = false;
      
      let cus_id = $("#cus_id");

      if(cus_id.val() == "" || cus_id.val() == null){
        alert("아이디를 입력하세요");
        cus_id.focus();
        return;
      }

      $.ajax({
        url: '/customer/checkID',
        type: 'get',
        dataType: 'text',
        data: { cus_id : cus_id.val() },
        success: function(data){
        	
 	  	 $("#idStatus").css("color","red");
         if(data == "Y"){
        	 isCheckID = true;
           $("#idStatus").html("아이디 사용가능");
         }else if(data == "N"){
           cus_id.val("");
           $("#idStatus").html("아이디 사용불가능");
         }
       }
     });
   });


	// 메일 인증요청
    $("#btnMailAuthReq").on("click", function(){

      isMailAuthConfirm = false;

      let cus_mail = $("#cus_mail");

      if(cus_mail.val() == "" || cus_mail.val() == null){
        alert("메일주소를 입력하세요");
        cus_mail.focus();
        return;
      }

      $.ajax({
        url: '/customer/sendMailAuth',
        type: 'get',
        dataType: 'text',
        data: { cus_mail : cus_mail.val() },
        success: function(data){
          
        
        if(data == "success"){
          isMailAuthConfirm = true;
          alert("인증 메일발송됨.");
        }else if(data == "fail"){
        	alert("메일발송 실패")
        }
      }
    });
  });


  	// 메일 인증확인
    $("#btnMailAuthConfirm").on("click", function(){

      let auth_mail = $("#auth_mail");

      if(auth_mail.val() == "" || auth_mail.val() == null){
        alert("인증코드를 입력하세요");
        auth_mail.focus();
        return;
      }

      $.ajax({
        url: '/customer/mailAuthConfirm',
        type: 'get',
        dataType: 'text',
        data: { uAuthCode : auth_mail.val() },
        success: function(data){
          
        
        if(data == "success"){
          alert("인증 성공.");
        }else if(data == "fail"){
          alert("인증 실패 \n 인증코드를 확인해주세요")
          auth_mail.val("");
        }
      }
    });
  });

});

</script>

      
  </body>
</html>
