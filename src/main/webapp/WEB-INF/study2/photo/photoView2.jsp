<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>photoView2.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
    // 이미지 한장 미리보기
    /*
    function imgCheck(input) {
    	if(input.files && input.files[0]) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			document.getElementById("demo").src = e.target.result;
    		}
    		reader.readAsDataURL(input.files[0]);
    	}
    	else {
    		document.getElementById("demo").src = "";
    	}
    }
    */
    
    // 이미지 여러장 미리보기
    $(document).ready(function(){
    	
    	$("#fName").on("change", multiImageCheck);
    });
    
    function multiImageCheck(e) {
    	// 그림파일 체크
    	let files = e.target.files;
    	let filesArr = Array.prototype.slice.call(files);
    	
    	filesArr.forEach(function(f){
    		if(!f.type.match("image.*")) {
    			alert("업로드할 파일은 이미지파일만 가능합니다.");
    			//return false;
    		}
    	});
    	
    	// 멀티파일 이미지 미리보기
    	let i = e.target.files.length;
    	for(let image of e.target.files) {
    		let img = document.createElement("img");
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			img.setAttribute("src", e.target.result);
    			img.setAttribute("width", 200);
    		}
    		reader.readAsDataURL(e.target.files[--i]);
    		document.querySelector(".imgDemo").appendChild(img);
    	}
    }
    
    // 파일이 선택되었는지 체크후 파일이 있으면 전송처리한다.
    function fCheck() {
    	let fName = myform.fName.value;
    	if(fName.trim() == "") {
    		alert("파일을 선택하세요");
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <h2>업로드 사진 미리보기2</h2>
  <form name="myform" id="myform" method="post" action="${ctp}/" enctype="multipart/form-data">
  	<hr/>
  	<div>
  	  <input type="file" name="fName" id="fName" multiple class="form-control-file border mb-2" />
  	  <!-- <img id="demo" width="150px"/> -->
  	</div>
  	<div class="imgDemo"></div>
  	<br/>
  	<div>
  	  사진 설명
  	  <textarea rows="4" name="content" id="content" class="form-control mb-3" placeholder="사진설명을 입력하세요."></textarea>
  	</div>
  	<div class="row">
  	  <div class="col"><input type="button" value="전송" onclick="fCheck()" class="btn btn-success form-control mb-2"/></div>
  	  <div class="col"><input type="button" value="다시선택" onclick="location.reload()" class="btn btn-warning form-control mb-2"/></div>
  	  <div class="col">
  	    <input type="button" value="사진첩보기" onclick="photoView()" id="photoViewBtn" class="btn btn-primaray form-control mb-2"/>
  	    <input type="button" value="사진첩닫기" onclick="photoClose()" id="photoCloseBtn" class="btn btn-primaray form-control mb-2"/>
  	  </div>
  	</div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>