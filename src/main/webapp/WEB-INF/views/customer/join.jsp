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

    

    <!-- Bootstrap core CSS -->
    <!--  <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css"> -->
	<!--  <link rel="stylesheet" href="https://getbootstrap.com/docs/4.6/dist/css/bootstrap.min.css"> -->
	<link rel="stylesheet" href="/resources/css/bootstrap.min2.css">



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
	
<form action="/customer/join" method="post">
  <div class="form-row">
  	<div class="col-md-3">
	    <label for="cus_id">ID</label>
	    <input type="text" class="form-control" id="cus_id" name="cus_id">
    </div>    
    
    <div class="col-md-2">
    	<label for="exampleInputEmail1">&nbsp;</label>
    	<button type="button" class="form-control">Id duplicate check</button>
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
    <label for="cus_phone">Phone</label>
    <input type="text" class="form-control" id="cus_phone" name="cus_phone">
  </div>
  
  <div class="form-group">
    <label for="cus_mail">Email address</label>
    <input type="text" class="form-control" id="cus_mail" name="cus_mail">
  </div>
  
  <div class="form-group form-check">
   	<input type="checkbox" class="form-check-input" id="cus_receive" name="cus_receive" value="Y">
   	<label class="form-check-label" for="cus_receive">receive mail</label>
  </div>
  
  <button type="submit" class="btn btn-primary">Sign Up</button>
</form>




<%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script>window.jQuery || document.write('<script src="/docs/4.6/assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="/docs/4.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

      
  </body>
</html>
