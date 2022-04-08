<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	  <h3>상품상세페이지</h3>
      <div class="row">
      	<div class="col-sm-6">
      		<img name="proudctImage" width="100%" height="300" src="/product/displayFile?fileName=<c:out value="${productVO.pdt_img }"></c:out>&uploadPath=<c:out value="${productVO.pdt_uploadpath }"></c:out>">
      	</div>
      	<div class="col-sm-2"></div>
      	
      	<div class="col-sm-2">
      		상품코드<br>
      		판매가격<br>
      		주문수량<br>
      	</div>
      	<div class="col-sm-2">
      		${productVO.pdt_num }<input type="hidden" name="pdt_num" id="pdt_num" value="${productVO.pdt_num }"><br>
      		${productVO.pdt_price }<br>
      		<input type="number" name="pdt_amount" id="pdt_amount" value="1"><br><br>
      		 <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" name="btnBuyAdd" class="btn btn-sm btn-outline-secondary">Buy</button>&nbsp;
                  <button type="button" name="btnCartAdd" class="btn btn-sm btn-outline-secondary">Cart</button>&nbsp;
                  <button type="button" name="btnProductist" class="btn btn-sm btn-outline-secondary">List</button>&nbsp;
                  
                </div>
               
             </div>
      	</div>
      </div>
      <div class="row">
      	<h4>상세설명</h4>
      	${productVO.pdt_content }
      </div>
      <form id="actionForm" action="" method="get">
        <!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
        
        <!-- Criteria클래스가 기본생성자에 의하여 기본값으로 파라미터가 사용 -->
        
        <c:if test="${type == 'Y' }">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">
        </c:if>
        
        <input type="hidden" name="cate_code" value="${cate_code}">
			  <!-- 상품코드 동적추가작업 -->
   	 </form>
   	 
   	 <!-- 상품후기 -->
   	 <div id="product_review" class="row">
   	 </div>
   	 
   	 
      <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    <script>

      //상품후기
      let getProductReview = function() {
          $("#product_review").load("/review/productReview?pdt_num=" + ${productVO.pdt_num });
      }
      getProductReview();

      // jquery ready()이벤트 구문.
      $(function(){

        let actionForm = $("#actionForm");
        
        //장바구니 담기
        $("button[name='btnCartAdd']").on("click", function(){
            
            let pdt_num = $(this).parents("div.card-body").find("input[name='pdt_num']").val();
            

           $.ajax({
              url: '/cart/cartAdd',
              type: 'post',
              dataType: 'text',
              data: {pdt_num: ${productVO.pdt_num }, cart_amount : $("#pdt_amount").val()},
              success: function(data) {
                if(data == "success") {
                  if(confirm("장바구니에 추가되었습니다.\n 지금 확인하겠습니까?")){
                    location.href = "/cart/cartList";
                  }
                }
              }
           });
        });

        $("button[name='btnBuyAdd']").on("click", function(){
            
            let pdt_num = $("#pdt_num").val();
            let pdt_amount = $("#pdt_amount").val();
            location.href = "/order/orderInfo?type=direct&pdt_num="+pdt_num+"&pdt_amount="+pdt_amount;
        });

        //리스트 클릭
        $("button[name='btnProductist']").on("click", function(){
          actionForm.attr("action", "/product/productList");
          actionForm.submit();
        });

        
        

        //상품 별점 클릭
        $("#product_review").on("click", "#star_grade a", function(e){
          e.preventDefault();
          console.log("별")
          $(this).parent().children("a").removeClass("on") // 기존선택되어 추가된 on선택자를 제거. 변경
          $(this).addClass("on").prevAll("a").addClass("on");
          
          scoreCount();
        });


        let scoreCount = function() {
          	let point = 0;

	        $("#star_grade a").each(function(){
	            if($(this).attr("class") == "on") {
	              point += 1
	            }
	          });  
	          
	          $("#reviewScore").val(point);
	        }


        //상품후기 클릭
        $("#product_review").on("click", "#btnReviewAdd", function() {
          console.log("상품후기 클릭");

            $.ajax({
            url: '/review/productReviewWrite',
            type:'post',
            dataType: 'text',
            data:  {
              pdt_num : ${productVO.pdt_num }, 
              rew_content : $("#reviewContent").val(), 
              rew_score : $("#reviewScore").val()
            },
            success: function(data){
              if(data == "success") {
                alert("상품후기가 등록됨");
                getProductReview();
              }
            }
          });
        });

        //상품후기 수정
        $("#product_review").on("click", "#btnReviewEdit", function() {
          //console.log("상품후기 클릭");

          $("#btnReviewAdd").show(); // 상품후기등록버튼 보이기
          $("#btnReviewEdit").hide(); // 상품후기수정버튼 숨기기

          console.log($("#reviewContent").val());
          
            $.ajax({
            url: '/review/productReviewEdit',
            type:'post',
            dataType: 'text',
            data:  {
              rew_num : $("#reviewNum").val(),
              pdt_num : ${productVO.pdt_num }, 
              rew_content : $("#reviewContent").val(), 
              rew_score : $("#reviewScore").val()
            },
            success: function(data){
              if(data == "success") {
                alert("상품후기가 수정됨");
                reviewLoad();
              }
            }
          });
        });

        // 리뷰목록수정버튼 "btnReviewModal"
        $("#product_review").on("click", "button[name='btnReviewEditModal']", function(){
          


          $("#btnReviewAdd").hide(); // 상품후기등록버튼 숨기기
          $("#btnReviewEdit").show(); // 상품후기수정버튼 보이기

          //리뷰 번호
          let rew_num = $(this).parent().parent().find("[name='rew_num']").val();
          $("#reviewNum").val(rew_num);
          //리뷰 별점
          let rew_score = $(this).parent().parent().find("[name='rew_score']").val();
          $("#reviewScore").val(rew_score);



          console.log("스코어" + rew_score);
          //리뷰 내용
          let rew_content = $(this).parent().parent().find("[name='rew_content']").val();
          $("#reviewContent").val(rew_content);
          $("#btnReview").text("상품후기 수정");

          // a태그가 5개
          $("#star_grade a").each(function(index, item) {
            if(index<rew_score) {
              $(item).addClass("on");
            }else {
              $(item).removeClass("on");
            }
          });


        });

        //상품후기 삭제클릭   btnReviewDelModal
        $("#product_review").on("click", "button[name='btnReviewDelModal']", function(){
          
          //$("#reviewModal").modal("show");

          if(!confirm("상품후기를 삭제하겠습니까?")) return;
         
          //리뷰 번호
          let rew_num = $(this).parent().parent().find("[name='rew_num']").val();
          $("#reviewNum").val(rew_num);


          $.ajax({
            url: '/review/productReviewDel',
            type:'post',
            dataType: 'text',
            data:  {
              rew_num : $("#reviewNum").val()  
            },
            success: function(data){
              if(data == "success") {
                alert("상품후기가 삭제됨");
                //getProductReview();
                pageNum = 1;
                reviewLoad();
              }
            }
          });

        });

        //상품후기목록 페이지번호 클릭
        let pageNum, pdt_num;
        $("#product_review").on("click", "ul.pagination a.page-link", function(e){
          e.preventDefault();
          pdt_num = $("#pdt_num").val();
          pageNum = $(this).attr("href");
          
          reviewLoad();
          
        });


        let reviewLoad = function() {
          let reviewForm = $("#reviewForm");
          let amount = reviewForm.find("input[name=amount]").val();
          
          // 상품코드, 페이징정보
          $("#product_review").load("/review/productReview?pdt_num="+pdt_num+"&pageNum="+pageNum+"&amount="+ amount);
        }
     		
      });

		
      
    </script>

<div id="reviewModal">
  test
</div>
  </body>
</html>
