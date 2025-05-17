<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThreeStar</title>
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
         margin-bottom: 30px;
         transition: background-color 0.3s;
     }
     
     .login-btn:hover {
         background-color: #4590c7;
     }
     
     .social-login {
         text-align: center;
     }
     
     .social-login p {
         color: #777;
         margin-bottom: 20px;
         font-size: 14px;
     }
     
     .social-icons {
         display: flex;
         justify-content: center;
         gap: 15px;
     }
     
     .social-icon {
         width: 40px;
         height: 40px;
         border-radius: 50%;
         display: flex;
         align-items: center;
         justify-content: center;
         color: white;
         cursor: pointer;
         transition: transform 0.3s ease;
     }
     
     .social-icon:hover {
         transform: scale(1.1);
     }
     
     .facebook {
         background-color: #3b5998;
     }
     
     .twitter {
         background-color: #1da1f2;
     }
     
     .google {
         background-color: #ea4335;
     }
     
     .apple {
         background-color: #53a2dd;
     }
 </style>
</head>
<body>
    <form class="login-container" action="login.me" method="GET">
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
            <a href="#" id="find-id">아이디 찾기</a>
            <a href="#" id="find-password">비밀번호 찾기</a>
        </div>
        
        <button class="login-btn">LOGIN</button>
        
        <div class="social-login">
            <p>Or Sign Up Using</p>
            <div class="social-icons">
                <div class="social-icon facebook"></div>
                <div class="social-icon twitter"></div>
                <div class="social-icon google"></div>
                <div class="social-icon apple"></div>
            </div>
        </div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginBtn = document.querySelector('.login-btn');
            const usernameInput = document.querySelector('input[type="text"]');
            const passwordInput = document.querySelector('input[type="password"]');
            const findIdLink = document.getElementById('find-id');
            const findPasswordLink = document.getElementById('find-password');
            
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
        });
    </script>
</body>
</html>