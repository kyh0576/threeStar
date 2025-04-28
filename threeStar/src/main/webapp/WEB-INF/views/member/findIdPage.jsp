<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document1</title>
<!-- <link rel="stylesheet" href="header.css">
  <link rel="stylesheet" href="content.css">
  <link rel="stylesheet" href="footer.css"> -->

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
<%@ include file="../common/menubar.jsp" %>
	
		<!-- -------------------------------------------------------------------- -->

		<div id="content" style="align-content: center;">

			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1">

			<!-- Bootstrap -->
			<link rel="stylesheet"
				href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

			<article class="container" id="container">
				<div class="page-header">
					<center>
						<h1>
							<a onclick="location.reload()" style="cursor: pointer;"><b>아이디
									찾기</b></a>
						</h1>
					</center>
					<div class="col-md-6 col-md-offset-3"></div>
				</div>

				<form id="form" action="<%= contextPath %>/findIdPage.me" method="post">
					<div class="col-sm-6-col-md-offset-3">

						<div class="form-group">
							<label for="inputName">이름</label> <input type="text"
								class="form-control" name="name" placeholder="이름을 입력해 주세요">
						</div>

						<div class="form-group">
							<label for="InputEmail">이메일 주소</label> <input type="email"
								class="form-control" name="email" placeholder="이메일 주소를 입력해주세요">
						</div>


						<div class="form-group text-center">
							<button type="submit" id="" class="btn btn-primary btn-space">
								<i class="fa fa-check spaceLeft">아이디 찾기</i>
							</button>
				</form>
		</div>
		</article>
	</div>
	<!-- -------------------------------------------------------------------- -->
	

	

	<!-- -------------------------------------------------------------------- -->
	<%@ include file="../common/footerbar.jsp" %>
</body>
</html>