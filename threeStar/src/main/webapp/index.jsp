<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<button onclick="location.href='loginForm.me'">로그인</button>
	<button onclick="location.href='signinForm.me'">회원가입</button>
	
	<jsp:forward page="WEB-INF/views/common/mainMenu.jsp" />
</body>
</html>