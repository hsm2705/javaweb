<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jst1_Ex1.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<p><br/></p>
<div class="container">
	<p>
		콤보상자에 숫자 1~6까지를 기억시키고 화면에 보여준다.<br/>
		이 때 숫자를 선택하면 아래쪽(demo)으로 선택한 숫자의 그림파일을 출력한다.
	</p>
	<c:if test="${!empty testlist}">
		<select name="selectBox" id="selectBox" style="width:800px" class="bu">
			<c:forEach var="list" items="${testlist}" varStatus="/">
				<option value="${list.name}">${list.name}</option>
			</c:forEach>
		</select>
	</c:if>
</div>
<p><br/></p>
</body>
</html>