<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp" %>
<script src="/bower_components/ckeditor/ckeditor.js"></script>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/left_menu.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        
	<h3>상품수정</h3>
  <form action="productModify" method="post" id="joinForm" enctype="multipart/form-data">
  <div class="form-row">
    <div class="col-md-6">
	    <label for="pro_num">상품코드</label>
	    <input type="hidden" name="pageNum" value="${cri.pageNum}">
	    <input type="hidden" name="amount" value="${cri.amount}">
	    <input type="hidden" name="type" value="${cri.type}">
	    <input type="hidden" name="keyword" value="${cri.keyword}">
	    <input type="text" class="form-control" id="pdt_num" name="pdt_num" value='<c:out value="${productVO.pdt_num}" />'>
	</div>
	<div class="col-md-6">
	    <label for="pdt_name">상품명</label>
	    <input type="text" class="form-control" id="pdt_name" name="pdt_name" value='<c:out value="${productVO.pdt_name}" />'>
	</div>
  </div>
  <div class="form-row">
    <div class="col-md-6">
	    <label for="cg_first_code">1차카테고리</label>
	    <select class="form-control" id="mainCategory" name="cg_first_code">
	      <option value="">1차 카테고리선택</option>
	      
	      <c:forEach items="${mainCategory}" var="categoryVO">
	      	<option value="${categoryVO.cg_code }" ${categoryVO.cg_code==productVO.cg_first_code ? 'selected':''} >
	      		${categoryVO.cg_name }
	      	</option>
	      </c:forEach>
	      
	    </select>
	</div>
	<div class="col-md-6">
		<label for="cg_code">2차카테고리</label>
	    <select class="form-control" id="subCategory" name="cg_code">
	      <c:forEach items="${subCategory}" var="categoryVO">
	      	<option value="${categoryVO.cg_code }" ${categoryVO.cg_code==productVO.cg_code ? 'selected':''} >
	      		${categoryVO.cg_name }
	      	</option>
	      </c:forEach>
	    </select>
    </div>
  </div>
  <div class="form-row">
    <div class="col-md-4">
		<label for="pdt_price">상품가격</label>
	    <input type="text" class="form-control" id="pdt_price" name="pdt_price" value='<c:out value="${productVO.pdt_price}" />'>
    </div>
    <div class="col-md-4">
	    <label for="pdt_discount">할인율</label>
	    <input type="text" class="form-control" id="pdt_discount" name="pdt_discount" value='<c:out value="${productVO.pdt_discount}" />'>
	</div>
	<div class="col-md-4">
		<label id="pdt_publisher">제조사</label>
	    <input type="text" class="form-control" id="pdt_publisher" name="pdt_publisher" value='<c:out value="${productVO.pdt_publisher}" />'>
    </div>
  </div>
   <!-- 상품설명 : CKeditor -->
   <div class="form-row">
    <div class="col-md-12">
      <label for="pdt_content">상품설명</label>
      <textarea id="pdt_content" name="pdt_content" rows="10" cols="80"><c:out value="${productVO.pdt_content}" /></textarea>
    </div>
  </div>
  <div class="form-row">
    <div class="col-md-4">
      <label for="upload">상품이미지</label>
      <input type="file" id="upload" name="upload">
      <!-- 이미지 변경시 기존이미지정보를 이용하여 기존이미지 삭제, 이미지 변경 안하면, 기존이미지 정보를 수정데이타로 사용 -->
      <input type="hidden" name="pdt_uploadpath" value="<c:out value="${productVO.pdt_uploadpath}" />">
      <input type="hidden" name="pdt_img" value="<c:out value="${productVO.pdt_img}" />">
    </div>
    <div class="col-md-4">
      <label for="upload">미리보기</label>
      <img name="productImage" id="previewImage" src="/admin/product/displayFile?fileName=<c:out value="${productVO.pdt_img }"></c:out>&uploadPath=<c:out value="${productVO.pdt_uploadpath }"></c:out>">
      <!--<div id="preview_image"></div>-->
    </div>
    <div class="col-md-4">
      <label for="upload"></label>
      
    </div>
  </div>
  
   <div class="form-row">
    <div class="col-md-4">
      <label for="pdt_amount">재고수량</label>
      <input type="text" class="form-control" id="pdt_amount" name="pdt_amount" value='<c:out value="${productVO.pdt_amount}" />'>
    </div>
    <div class="col-md-4">
      <label for="pdt_buy">판매여부</label>
      <select class="form-control" id="pdt_buy" name="pdt_buy">
	      <option>판매여부를 선택하세요</option>
	      <option value="Y" <c:out value="${productVO.pdt_buy == 'Y' ? 'selected' : ''}" />>판매함</option>
	      <option value="N" <c:out value="${productVO.pdt_buy == 'N' ? 'selected' : ''}" />>판매하지 않음</option>
	  </select>
      
    </div>
    <div class="col-md-4">
      <label for=""></label>
      <input type="hidden" class="form-control" id="" name="">
      
    </div>
    
   </div>
	<div class="form-row">
	<div class="col-md-5">
      <label for=""></label>
      <input type="hidden" class="form-control" id="" name="">
      
    </div>
    <div class="col-md-2">
      <button type="submit" id="btnProductInsert" class="form-control">상품수정</button>
    </div>
    <div class="col-md-5">
      <label for=""></label>
      <input type="hidden" class="form-control" id="" name="">
      
    </div>
   </div>
  
</form>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer (기타 footer태그밑에 소스포함)-->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp" %>

<!-- 상품이미지 미리보기 -->
<script>
  
    function readImage(input) {
      if (input.files && input.files[0]) {
          
        //let imgPath = input.files[0].value;
        let imgPath = $("#upload").val();
        alert(imgPath);
        //return;
        let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();
        alert(ext);
        if(typeof(FileReader) == "undefined") {
          alert("브라우저가 작업을 지원안합니다.");
          return;
        }

        if(ext == "gif" || ext == "png" || ext == "jpg" || ext == "jpeg" ) {
          
          const reader = new FileReader();
          

          //이벤트 설정. reader객체가 이미지파일을 성공적으로 읽어들였을 때 발생하는 이벤트
          reader.onload = (e) => {
              //alert("onload");
              const previewImage = document.getElementById('previewImage');
              previewImage.src = e.target.result;
          }

          // reader객체가 파일을 읽어들이는 작업
          reader.readAsDataURL(input.files[0]);
        }else{
          $("#upload").val("");
          alert("이미지 파일을 선택하세요.");
        }
      }
    }
    // 이벤트 리스너
    document.getElementById('upload').addEventListener('change', (e) => {
        readImage(e.target);
    })

</script>

<script>
	$(document).ready(function(){
		
		let ckeditor_config = {
			resize_enabled : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			toolbarCanCollapse : true,
			removePlugins : "elementspath",
			
			filebrowserUploadUrl : "editor/imageUpload"  // /editor/imageUpload. 이미지 업로드시 업로드탭 보기
				
		};
		
		CKEDITOR.replace('pdt_content', ckeditor_config);
		
		// 4.8.0 (Standard)
		// alert(CKEDITOR.version);  
		
	});
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="subCategoryTemplate" type="text/x-handlebars-template">
  
  <option>2차카테고리 선택</option>
  {{#each .}}
  
	<option value="{{cate_code}}">{{cate_name}}</option>
  
  {{/each}}
</script>

<script>
  $(document).ready(function(){

    $("#mainCategory").on("change", function(){

      if($(this).val() == "") {alert("카테고리 선택하세요."); return;}

      let url = "/admin/product/subCategory/" + $(this).val()

      $.getJSON(url, function(data){

        subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate"));

      });

    });

  });


</script>
<script>
  // subCategory: 2차카테고리 데이타
  // target : 2차카테고리 바인딩 결과가 출력될 위치
  // template : 2차카테고리 핸들바템플릿
  let subCategoryBindingView = function(subCategory, target, template) {

    let templateObj = Handlebars.compile(template.html());
    let subCateOptionsResult = templateObj(subCategory);


    //누적되는 증상발생. 처리..
    $("#subCategory option").remove();
    target.append(subCateOptionsResult);

  }

</script>
</body>
</html>
