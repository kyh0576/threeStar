<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document1</title>
<!-- Bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<style>
@font-face {
	font-family: 'Chosunilbo_myungjo';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Chosunilbo_myungjo.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body * {
	font-family: 'Chosunilbo_myungjo';
}

/* div {box-sizing: border-box;border: 1px solid red;} */

/* -------------------------------------------------- */
.btn-space {
	margin-right: 5px;
}

#content {
	height: 700px;
}

.container {
	width: 1000px !important;
}

.form-group>label {
	margin-left: 240px;
}

.form-group>input {
	width: 500px;
	margin: auto;
}
</style>
</head>
<meta charset="UTF-8">
<!-- ------------------------------------------------------------------ -->

<body>

	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
	</c:if>

	<div id="content" style="align-content: center;">

		<article class="container" id="container">
			<div class="page-header">
					<h1 style="text-align:center;">
						<a onclick="location.reload()" style="cursor: pointer;"><b>비밀번호
								찾기</b></a>
					</h1>
				<div class="col-md-6 col-md-offset-3"></div>
			</div>

			<form id="form" action="findPwdResultPage.me" method="post">
				<div class="col-sm-6-col-md-offset-3">

					<div class="form-group">
						<label for="inputName">이름</label> 
						<input type="text"
							class="form-control" name="memName" placeholder="이름을 입력해 주세요" required>
					</div>

					<div class="form-group">
						<label for="inputName">아이디</label> 
						<input type="text"
							class="form-control" name="memId" placeholder="아이디를 입력해 주세요" required>
					</div>

					<div class="form-group">
						<label for="InputEmail">이메일 주소</label> 
						<input type="email"
							class="form-control" name="email" placeholder="이메일 주소를 입력해주세요" required>
					</div>

					<div class="form-group text-center">
						<button type="submit" class="btn btn-primary btn-space">
							비밀번호 찾기<i class="fa fa-check spaceLeft"></i></button>
					</div>
				</div>
			</form>
			
		</article>
		
		<hr>
		
	</div>

</body>

</html>