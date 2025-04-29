<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
     * {
         margin: 0;
         padding: 0;
         box-sizing: border-box;
         font-family: Arial, sans-serif;
     }
     
     body {
         display: flex;
         justify-content: center;
         align-items: center;
         min-height: 100vh;
         background-color: #f5f8fa;
     }
     
     .login-container {
         background-color: white;
         border-radius: 16px;
         padding: 40px;
         width: 100%;
         max-width: 450px;
         box-shadow: 0 10px 25px rgba(83, 162, 221, 0.2);
         border: 1px solid rgba(83, 162, 221, 0.1);
     }
     
     .login-container h1 {
         text-align: center;
         font-size: 32px;
         margin-bottom: 40px;
         color: #333;
     }
     
     .input-group {
         position: relative;
         margin-bottom: 30px;
     }
     
     .input-group input {
         width: 100%;
         padding: 12px 12px 12px 40px;
         border: none;
         border-bottom: 1px solid #ddd;
         font-size: 16px;
         outline: none;
         transition: all 0.3s ease;
     }
     
     .input-group input:focus {
         border-bottom-color: #53a2dd;
     }
     
     .input-group i {
         position: absolute;
         left: 12px;
         top: 15px;
         color: #777;
     }
     
     .help-links {
         display: flex;
         justify-content: flex-end;
         margin-bottom: 25px;
         font-size: 14px;
     }
     
     .help-links a {
         color: #53a2dd;
         text-decoration: none;
         margin-left: 15px;
     }
     
     .help-links a:hover {
         text-decoration: underline;
     }
     
     .login-btn {
         width: 100%;
         padding: 15px;
         border: none;
         border-radius: 50px;
         font-size: 16px;
         font-weight: bold;
         color: white;
         background-color: #53a2dd;
         cursor: pointer;
         margin-bottom: 20px;
         transition: background-color 0.3s;
     }
     
     .login-btn:hover {
         background-color: #4590c7;
     }
     
     .signup-btn {
         width: 100%;
         padding: 15px;
         border: none;
         border-radius: 50px;
         font-size: 16px;
         font-weight: bold;
         color: #53a2dd;
         background-color: white;
         cursor: pointer;
         margin-bottom: 30px;
         transition: all 0.3s;
         border: 2px solid #53a2dd;
     }
     
     .signup-btn:hover {
         background-color: #f0f7fc;
     }
     
     .social-login {
         text-align: center;
         margin-top: 20px;
     }
     
     .social-login p {
         color: #777;
         margin-bottom: 20px;
         font-size: 14px;
     }
     
     .social-icon {
         width: 100%;
         height: 45px;
         border-radius: 50px;
         display: flex;
         align-items: center;
         justify-content: center;
         color: white;
         cursor: pointer;
         transition: transform 0.3s ease;
         background-color: #ea4335;
         font-weight: bold;
         font-size: 16px;
     }
     
     .social-icon:hover {
         transform: scale(1.03);
     }
     
     .google {
         background-color: #ea4335;
     }
     
     .divider {
         display: flex;
         align-items: center;
         text-align: center;
         margin: 30px 0;
     }
     
     .divider::before,
     .divider::after {
         content: '';
         flex: 1;
         border-bottom: 1px solid #ddd;
     }
     
     .divider span {
         padding: 0 10px;
         color: #777;
         font-size: 14px;
     }
</style>
</head>
<body>

	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session"/> <!-- scope 생략시 모든 scope의 있는 alertMsg를 지움 -->
	</c:if>
	
    <form class="login-container" action="login.me" method="POST">
        <h1>Login</h1>
        
        <div class="input-group">
            <i>👤</i>
            <input type="text" name="memId" placeholder="Type your username" required>
        </div>
        
        <div class="input-group">
            <i>🔒</i>
            <input type="password" name="memPwd" placeholder="Type your password" required>
        </div>
        
        <div class="help-links">
            <a href="findIdPage.me" id="find-id">아이디 찾기</a>
            <a href="findPwdPage.me" id="find-password">비밀번호 찾기</a>
        </div>
        
        <button type="submit" class="login-btn">LOGIN</button>
        <button type="button" id="signup-btn" class="signup-btn">회원가입</button>
        
        <div class="divider">
            <span>OR</span>
        </div>
        
		<div id="g_id_onload"
		     data-client_id="939670547310-mjuf549e4q081qu90jtle7uk7fvhcplr.apps.googleusercontent.com"
		     data-context="signin"
		     data-ux_mode="popup"
		     data-login_uri="http://localhost:8333/tt/main.me"
		     data-auto_prompt="false">
		</div>
		
		<div class="g_id_signin"
		     data-type="standard"
		     data-shape="rectangular"
		     data-theme="outline"
		     data-text="signin_with"
		     data-size="large"
		     data-logo_alignment="left">
		</div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginBtn = document.querySelector('.login-btn');
            const signupBtn = document.getElementById('signup-btn');
            const usernameInput = document.querySelector('input[type="text"]');
            const passwordInput = document.querySelector('input[type="password"]');
            const findIdLink = document.getElementById('find-id');
            const findPasswordLink = document.getElementById('find-password');
            const googleLogin = document.getElementById('google-login');
            
            /*
            findIdLink.addEventListener('click', function(e) {
                e.preventDefault();
                alert('아이디 찾기 페이지로 이동합니다.');
                // 아이디 찾기 페이지로 이동하는 로직
            });
            
            findPasswordLink.addEventListener('click', function(e) {
                e.preventDefault();
                alert('비밀번호 찾기 페이지로 이동합니다.');
                // 비밀번호 찾기 페이지로 이동하는 로직
            });
            */
            
            signupBtn.addEventListener('click', function(e) {
                e.preventDefault();
                // 회원가입 페이지로 이동하는 로직
                window.location.href = 'signinForm.me';
            });
            
            googleLogin.addEventListener('click', function(e) {
                e.preventDefault();
                alert('구글 로그인으로 진행합니다.');
                // 구글 로그인 로직 실행
                // OAuth 연동 코드 필요
            });
        });
    </script>
    
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script type="text/javascript" src="js/loginGoogleAPI.js" defer></script>
    
    <script>
    //전역 함수로 설정
	window.handleCredentialResponse = function (response) {
		console.log('handleCredentialResponse 호출');
		//토큰 값을 디코딩해서 JSON으로 반환
		//decodeJwtResponse <- 디코딩하는 함수
		const responsePayload = decodeJwtResponse(response.credential);
		
		//디코딩한 정보를 콘솔창에 출력
		console.log('Full Name: ' + responsePayload.name);
		console.log('Email: ' + responsePayload.email);
		
		//값 전송
		sendforwardGooglelogin(responsePayload.name, responsePayload.email)
	}
	</script>
    
</body>
</html>