<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document1</title>
  <!-- Bootstrap -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

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

.warning-text {
    font-size: 12px;
    color: #ff6b6b;
    margin-top: 5px;
}

  </style>
</head>

<body>

    <div id="content" style="align-content: center;">
      
    	<article class="container" id="container">
	        <div class="page-header">
	              <h1 style="text-align:center;"><a onclick="location.reload()" style="cursor: pointer;"><b>비밀번호 재설정</b></a></h1>
	        </div>

	        <form id="form" action="findUpdatePwd.me" method="post" accept-charset="UTF-8" onsubmit="return validateForm()">
	            <div class="col-sm-6-col-md-offset-3">
	
	             <div class="form-group">
	              <label for="inputId">아이디</label>
	              <input type="text" class="form-control" name="memId" placeholder="아이디를 입력해 주세요" value="${ m.memId }" readonly>
	             </div>
	
	                <div class="form-group">
	                    <label for="Inputpassword">비밀번호</label>
	                    <input type="password" class="form-control" id="password" name="memPwd" placeholder="비밀번호를 입력해주세요" required>
	             	  </div>
	                <div class="form-group">
	                    <label for="Inputpassword">비밀번호 확인</label>
	                    <input type="password" class="form-control" id="password-confirm" placeholder="비밀번호를 입력해주세요" required>
	                	<p class="warning-text" id="pwd-warning" style="margin-left: 235px;">비밀번호가 일치하지 않습니다</p>
	                </div>
	
	                <div class="form-group text-center">
	                    <button type="submit" class="btn btn-primary btn-space">재설정<i class="fa fa-check spaceLeft"></i></button>
	                </div> 
	                
	                <input type="hidden" id="is-password-valid" value="false">
	          	</div>
			</form>
    	</article>
   		<hr>
   	</div>
   	
   	<script>
    // 비밀번호 확인 검증
    
    const password = document.getElementById('password');
    const passwordConfirm = document.getElementById('password-confirm');
    const warningText = document.getElementById('pwd-warning');
    const isPasswordValid = document.getElementById('is-password-valid');
    
    warningText.style.display = 'none';
    
    passwordConfirm.addEventListener('input', function() {
        if (password.value !== passwordConfirm.value) {
            warningText.style.display = 'block';
            warningText.style.color = '#ff6b6b';
            warningText.textContent = '비밀번호가 일치하지 않습니다';
            isPasswordValid.value = 'false';
        } else {
            warningText.style.display = 'block';
            warningText.style.color = '#4CAF50';
            warningText.textContent = '비밀번호가 일치합니다';
            isPasswordValid.value = 'true';
        }
    });
    
    window.validateForm = function() {
        // 비밀번호 일치 여부 확인
        if (password.value !== passwordConfirm.value) {
            alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
            passwordConfirm.focus();
            return false;
        }
    }
   	</script>
</body>

</html>