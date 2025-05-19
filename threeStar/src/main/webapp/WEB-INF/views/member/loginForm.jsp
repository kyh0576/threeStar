<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThreeStar</title>
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
        
        <div
	      id="g_id_onload"
	      data-auto_prompt="false"
	      data-callback="handleCredentialResponse"
	      data-client_id="988243476840-8gjc4u9a1aahr0uvhubcc8aosff07nk1.apps.googleusercontent.com"
	    ></div>
		
    	<div class="g_id_signin"
	        data-type="standard"
	        data-size="large"
            data-text="signin"
            data-theme="filled_blue"
	        data-shape="rectangular"
            data-width=368.79
            ></div>
		
		<input type="hidden" id="memName" name="memName" value="${ memName }">
		<input type="hidden" id="email" name="email" value="${ email }">
		<input type="hidden" id="snsKey" name="snsKey" value="${ snsKey }">	
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
    <!-- <script type="text/javascript" src="js/loginGoogleAPI.js" defer></script>  -->
    
    <script>
		function handleCredentialResponse(response) {
			// decodeJwtResponse() is a custom function defined by you
			// to decode the credential response.
			const id_token = response.credential;
			console.log("토큰값 : " + id_token);
			
			const responsePayload = decodeJwtResponse(id_token);
			
			console.log("unique identifier: " + responsePayload.jti)
			console.log("ID: " + responsePayload.sub);
			console.log('Full Name: ' + responsePayload.name);
			console.log('Given Name: ' + responsePayload.given_name);
			console.log('Family Name: ' + responsePayload.family_name);
			console.log("Image URL: " + responsePayload.picture);
			console.log("Email: " + responsePayload.email);
			
			sendforwardGooglelogin(id_token, responsePayload.name, responsePayload.email)
		}
		
		// 디코딩 함수
		function decodeJwtResponse(id_token) {
			console.log('decodeJwtResponse 호출');
			// 받아온 토큰 값을 디코딩하여 정보 전송
			// id_token을 '.'으로 나누어 중간에 있는 payload 부분(base64Url)을 추출
			const base64Url = id_token.split('.')[1];
			// URL-safe Base64 형식에서 표준 Base64 형식으로 변환 ('-' -> '+', '_' -> '/')
			const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
			// Base64로 인코딩된 문자열을 디코딩하고 각 문자의 유니코드 값을 %인코딩된 형식으로 변환한 후, 이를 다시 문자열로 조합하여 JSON 형식의 payload로 만듦
			const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
				// 각 문자의 유니코드 값을 %XX 형식으로 변환
				return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
			}).join('')); //변환된 값을 하나의 문자열로 조합
			// 최종적으로 JSON 타입으로 변환해 반환
			return JSON.parse(jsonPayload);
		}
	    
		// 받아온 값을 보내는 함수
		function sendforwardGooglelogin(snsKey, fullname, email) {
		    // 새로운 폼 요소 생성합니다.
		    let googleloginForm = document.createElement("form");
			googleloginForm.style.display = "none";
		    googleloginForm.method = "POST"; // POST 요청 방식
		    // googleloginForm.action = "signinForm.me"; // 요청을 보낼 URL
		   	googleloginForm.action = "googleLogin.do";

			// 토큰 값을 보낼 input태그 만들기
		    let snsKeyField = document.createElement("input");
		    snsKeyField.type = "hidden"; // 폼에 표시되지 않도록 숨김 필드로 설정
		    snsKeyField.name = "snsKey"; // 서버에서 받을 변수 이름
		    snsKeyField.value = snsKey; // 보낼 데이터
		    
		    // 이름 값을 보낼 input태그 만들기
		    let nameField = document.createElement("input");
		    nameField.type = "hidden"; // 폼에 표시되지 않도록 숨김 필드로 설정
		    nameField.name = "memName"; // 서버에서 받을 변수 이름
		    nameField.value = fullname; // 보낼 데이터

		    // 이메일값을 보낼 input태그 만들기
		    let emailField = document.createElement("input");
		    emailField.type = "hidden";
		    emailField.name = "email";
		    emailField.value = email;
			
		    // 구글 로그인임을 알려줄 input태그 만들기
		    let typeField = document.createElement("input");
		    typeField.type = "hidden";
		    typeField.name = "type";
		    typeField.value = "googleLogin";

			// 만든 input태그를 form에 추가합니다.
			googleloginForm.appendChild(snsKeyField);
		    googleloginForm.appendChild(nameField);
		    googleloginForm.appendChild(emailField);
		    googleloginForm.appendChild(typeField);
		    
		    // 폼을 현재 페이지에 추가한 후 전송합니다.
		    document.body.appendChild(googleloginForm);
		    googleloginForm.submit();
		    
		}
	</script>
    
</body>
</html>
