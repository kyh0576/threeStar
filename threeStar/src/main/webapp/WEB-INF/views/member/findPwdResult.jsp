<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = (String)request.getParameter("id");
//response.sendRedirect()로 넘긴 값은 쿼리 스트링에 포함되므로, JSP에서 getParameter사용.
%>



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
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/Chosunilbo_myungjo.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

    body *{
      font-family: 'Chosunilbo_myungjo';
    }
    
    /* div {box-sizing: border-box;border: 1px solid red;} */
/* -------------------------------------------------- */
.btn-space {
    margin-right: 5px;
}

#content{
  
  height: 700px;

}
.container {
        width: 1000px !important;
}

.form-group>label{
  margin-left: 240px;
}

.form-group>input{
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

        <article class="container" id="container">
            <div class="page-header">
                  <center><h1><a onclick="location.reload()" style="cursor: pointer;"><b>비밀번호 재설정</b></a></h1></center>
            <div class="col-md-6 col-md-offset-3">
                </div>
            </div>

          <form id="form" action="<%= contextPath %>/updatePwd.me" method="post" accept-charset="UTF-8">
              <div class="col-sm-6-col-md-offset-3">

                  <div class="form-group">
                      <label for="inputId">아이디</label>
                      <input type="text" class="form-control" name="id" placeholder="아이디를 입력해 주세요" value="<%=id %>" readonly>
                  </div>

                  <div class="form-group">
                    <label for="Inputpassword">비밀번호</label>
                    <input type="password" class="form-control" name="newPwd" placeholder="비밀번호를 입력해주세요">
                </div>
                <div class="form-group">
                    <label for="Inputpassword">비밀번호 확인</label>
                    <input type="password" class="form-control" placeholder="비밀번호를 입력해주세요">
                </div>

                  <div class="form-group text-center">
                      <center> <button type="submit" id="" class="btn btn-primary btn-space">재설정<i class="fa fa-check spaceLeft"></i></center>
                       

    </form>
    </div>
    </article>
    <hr>
  </div>
    

  <!-- -------------------------------------------------------------------- -->
  <%@ include file="../common/footerbar.jsp" %>
</body>

</html>