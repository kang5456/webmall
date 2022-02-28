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


  <div class="row">
    <h3>로그인 폼</h3>
    <div class="container">
      <form>
        <div class="form-group row">
          <label for="cus_id" class="col-sm-2 col-form-label">ID</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="cus_id" name="cus_id" placeholder="ID">
          </div>
        </div>
        <div class="form-group row">
          <label for="cus_pw" class="col-sm-2 col-form-label">Password</label>
          <div class="col-sm-10">
            <input type="password" class="form-control" id="cus_pw" name="cus_pw" placeholder="Password">
          </div>
        </div>
		 
        <div class="form-group row">
          <label class="col-sm-2"></label>
          <div class="col-sm-10">
          	<button type="button" class="btn btn-link" id="btnSearchPw">Search Pw</button>
          </div>
        </div>
        
        <div class="form-group row">
          <div class="offset-sm-2 col-sm-10">
            <button type="button" id="btnLogin" class="btn btn-primary">Sign in</button>
          </div>
        </div>
      </form>
    </div>
  </div>



<%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>

  <script>

    $(document).ready(function(){

          $("#btnLogin").on("click", function(){

          let cus_id = $("#cus_id");
          let cus_pw = $("#cus_pw");

          if(cus_id.val() == "" || cus_id.val() == null){
            alert("ID를 입력하세요");
            cus_id.focus();
            return;
          }

          if(cus_pw.val() == "" || cus_pw.val() == null){
            alert("PW를 입력하세요");
            cus_pw.focus();
            return;
          }

          $.ajax({
            url: '/customer/login',
            type: 'post',
            dataType: 'text',
            data: { cus_id : cus_id.val(), cus_pw : cus_pw.val() },
            success: function(data){
              
            
            if(data == "success"){
              alert("로그인 성공.");
              location.href = "/";
            }else if(data == "idfail"){
              alert("ID를 확인해주세요.")
              cus_id.focus();
            }else if(data == "pwFail"){
              alert("비밀번호를 확인해주세요.");
              cus_id.focus();
            }
          }
        });
      });

    });

  </script>

      
  </body>
</html>
