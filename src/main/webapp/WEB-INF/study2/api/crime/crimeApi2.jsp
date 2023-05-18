<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>crimeApi.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
    'use strict';
    
    const API_KEY = 'V0sC01r5SrGj8fQpV6rU7gjEAA%2F%2F7PhasyuGhxJcwPQL%2Bq86d2Vp7E2be%2FOc4Z%2F4MiB%2FVcpv5dbMENEIQWVs7Q%3D%3D';
    
    // 외부 데이터를 가져오는 방식? fetch방식 -> JSON형식
    
    // 경찰청에서 제공해주는 api 이용한 자료 검색(화면출력)
    async function getCrimeData() {
    	let year = $("#year").val();
    	let apiYear = "";
    	
    	if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
    	else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
    	else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
    	else if(year == 2018) apiYear = "/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7";
    	else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
    	else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
    	else if(year == 2021) apiYear = "/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2";
    	
    	let url = "https://api.odcloud.kr/api" + apiYear;
    	url += "?serviceKey="+API_KEY;
    	url += "&page=1&perPage=200";
    	
    	const response = await fetch(url);
    	
    	const res = await response.json();
    	
    	console.log("res : ", res);
    	
    	/*
    	let str = "";
    	for(let i=0; i<res.data.length; i++) {
    		str += res.data[i] + "<br/>";
    	}
    	*/
    	
    	let str = res.data.map((item, i) => [
    		(i+1) + "." 
    		+ "발생년도: " + item.발생년도 + "년"
    		+ ",경찰서: " + item.경찰서
    		+ ", 강도 " + item.강도 + "건"
    		+ ", 살인 " + item.살인 + "건"
    		+ ", 절도 " + item.절도 + "건"
    		+ ", 폭력 " + item.폭력 + "건"
    		+ "<br/>"
    	]);
    	
    	$("#demo").html(str);
    }
    
    // 검색된 자료를 DB에 저장하기
    async function saveCrimeData() {
    	let year = $("#year").val();
    	let apiYear = "";
    	
    	if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
    	else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
    	else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
    	else if(year == 2018) apiYear = "/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7";
    	else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
    	else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
    	else if(year == 2021) apiYear = "/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2";
    	
    	let url = "https://api.odcloud.kr/api" + apiYear;
    	url += "?serviceKey="+API_KEY;
    	url += "&page=1&perPage=200";
    	
    	const response = await fetch(url);
    	
    	const res = await response.json();
    	
    	console.log("res : ", res);
    	
    	let str = res.data.map((item, i) => [
    		(i+1) + "." 
    		+ "발생년도: " + item.발생년도 + "년"
    		+ ",경찰서: " + item.경찰서
    		+ ", 강도 " + item.강도 + "건"
    		+ ", 살인 " + item.살인 + "건"
    		+ ", 절도 " + item.절도 + "건"
    		+ ", 폭력 " + item.폭력 + "건"
    		+ "<br/>"
    	]);
    	
    	$("#demo").html(str);
    	
    	// aJax를 이용하여 DB에 자료를 저장한다.
    	let query = "";
    	for(let i=0; i<res.data.length; i++) {
    		if(res.data[i].경찰서 != null) {
    			query = {
    					year    : year,
    					police  : res.data[i].경찰서,
    					robbery : res.data[i].강도,
    					murder  : res.data[i].살인,
    					theft   : res.data[i].절도,
    					violence: res.data[i].폭력
    			}
    			
    			$.ajax({
    				type  : "post",
    				url   : "${ctp}/SaveCrimeData.st",
    				data  : query,
    				error : function() {
    					alert("전송오류!");
    				}
    			});
    		}
    	}
    	alert(year + "년도 자료가 DB에 저장되었습니다.");
    }
    
    // DB에 저장된 자료 삭제처리
    function deleteCrimeData() {
    	let year = $("#year").val();
    	let ans = confirm(year + "년도의 자료를 삭제 하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/DeleteCrimeData.st",
    		data  : {year : year},
    		success:function(res) {
    			if(res == "1") {
    				alert(year + "년도 자료 삭제 완료!");
    				location.reload();
    			}
    			else {
    				alert(res);
    			}
    		},
    		error: function() {
    			alert("전송 오류!");
    		}
    	});
    }
    


  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform">
	  <h2>경찰청_전국 경찰서별 강력범죄 발생 현황</h2>
	  <hr/>
	  <p>
	    <select name="year" id="year">
	      <c:forEach var="i" begin="2015" end="2021">
	        <option>${i}</option>
	      </c:forEach>
	    </select>
	    <input type="button" value="강력범죄자료조회" onclick="getCrimeData()" class="btn btn-success"/>
	    <input type="button" value="조회자료DB저장" onclick="saveCrimeData()" class="btn btn-success"/>
	    <input type="button" value="DB자료삭제" onclick="deleteCrimeData()" class="btn btn-success"/>
	    <input type="button" value="DB자료출력" onclick="listCrimeData()" class="btn btn-primary"/>
	  </p>
	  <p>
	    정렬순서 :
	    <input type="radio" name="crimeOrder" value="asc" checked />오름차순 &nbsp;
	    <input type="radio" name="crimeOrder" value="desc" />내림차순 &nbsp;
	    <input type="button" value="경찰서순서조회" onclick="policeSearch()" class="btn btn-secondary"/>
	  </p>
	  <p>
	    <input type="button" value="돌아가기" onclick="location.href='${ctp}/ApiTest.st';" class="btn btn-warning"/>
	  </p>
  </form>
  <hr/>
  <div id="demo"></div>
  <hr/>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>