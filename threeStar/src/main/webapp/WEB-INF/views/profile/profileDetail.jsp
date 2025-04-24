<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로필 편집</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    body {
        background-color: #f5f5f5;
        align-items: center;
    }
    
    .container {
    	align: center;
        max-width: 600px;
        margin: 0 auto;
        overflow: hidden;
    }
    
    .profile-header {
        background-color: #86e0f9;
        height: 150px;
        position: relative;
    }
    
    .profile-content {
        background-color: #9f9fd6;
        padding: 70px 20px 20px;
    }
    
    .profile-image {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        position: absolute;
        left: 50%;
        top: 120px;
        transform: translateX(-50%);
        border: 3px solid white;
        overflow: hidden;
    }
    
    .profile-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .profile-name {
        text-align: center;
        color: white;
        font-size: 24px;
        margin-top: 10px;
        margin-bottom: 20px;
    }
    
    .edit-form {
        background-color: white;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
    }
    
    .form-title {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        color: #333;
    }
    
    .form-title svg {
        margin-right: 10px;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        color: #666;
    }
    
    .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
    }
    
    .form-row {
        display: flex;
        gap: 10px;
    }
    
    .form-row .form-group {
        flex: 1;
    }
    
    .button-group {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }
    
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }
    
    .btn-primary {
        background-color: #02c8fa;
        color: white;
    }
    
    .btn-cancel {
        background-color: white;
        color: #333;
        border: 1px solid #ddd;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="profile-header"></div>
        <div class="profile-content">
            <div class="profile-image">
                <img src="/api/placeholder/100/100" alt="프로필 이미지">
            </div>
            <h1 class="profile-name">아이디</h1>
            
            <div class="edit-form">
                <div class="form-title">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" fill="#333"/>
                    </svg>
                    <h2>프로필 편집</h2>
                </div>
                
                <div class="form-group">
                    <label>이름</label>
                    <input type="text" class="form-control" placeholder="닉네임" id="name">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>연락처</label>
                        <input type="text" class="form-control" placeholder="010-1234-5678" id="contact">
                    </div>
                    <div class="form-group">
                        <label>이메일</label>
                        <input type="email" class="form-control" placeholder="example@email.com" id="email">
                    </div>
                </div>

                <div class="form-group">
                    <label>초대코드</label>
                    <input type="password" class="form-control" placeholder="클래스 초대코드" id="inviteCode">
                </div>
                
                <div class="form-group">
                    <label>비밀번호</label>
                    <input type="password" class="form-control" placeholder="" id="password">
                </div>
                
                <div class="form-group">
                    <label>비밀번호 확인</label>
                    <input type="password" class="form-control" placeholder="" id="passwordConfirm">
                </div>
                
                <div class="button-group">
                    <button type="button" class="btn btn-primary" id="saveBtn">수정</button>
                    <button type="reset" class="btn btn-cancel" id="cancelBtn">초기화</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // DOM 요소 가져오기
            const saveBtn = document.getElementById('saveBtn');
            const cancelBtn = document.getElementById('cancelBtn');
            const nameInput = document.getElementById('name');
            const contactInput = document.getElementById('contact');
            const emailInput = document.getElementById('email');
            const inviteCodeInput = document.getElementById('inviteCode');
            const passwordInput = document.getElementById('password');
            const passwordConfirmInput = document.getElementById('passwordConfirm');
            const statusInput = document.getElementById('status');
            
            // 프로필 데이터 로드 (예시)
            function loadProfileData() {
                // 실제 구현에서는 AJAX 요청을 통해 서버에서 데이터를 가져옵니다.
                $.ajax({
                    url:"detail.do",
                    data:{
                        name:$("name").val(),
                        contact:$("contact").val(),
                        email:$("email").val(),
                        inviteCode:$("intiveCode").val(),
                        password:$("password").val(),
                        passwordConfirm:$("passwordConfirm").val(),
                        status:$("status").val()
                    },
                    success:function(result){
						console.log(result)
                    },
                    error:function(){
                        console.log("Ajax 실패")
                    }
                })
                };
                
                // 폼에 데이터 설정
                nameInput.value = userData.name;
                contactInput.value = userData.contact;
                emailInput.value = userData.email;
                statusInput.value = userData.status;
            }
            
            // 초기 데이터 로드
            loadProfileData();
            
            // 저장 버튼 클릭 이벤트
            saveBtn.addEventListener('click', function() {
                if (validateForm()) {
                    saveProfileData();
                }
            });
            
            /*
            // 취소 버튼 클릭 이벤트
            cancelBtn.addEventListener('click', function() {
                if (confirm('변경사항을 취소하시겠습니까?')) {
                    window.history.back();
                }
            });
            */
            
            // 폼 유효성 검사
            function validateForm() {
                // 이름 검사
                if (nameInput.value.trim() === '') {
                    alert('이름을 입력해주세요.');
                    nameInput.focus();
                    return false;
                }
                
                // 이메일 형식 검사
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (emailInput.value.trim() !== '' && !emailRegex.test(emailInput.value)) {
                    alert('유효한 이메일 주소를 입력해주세요.');
                    emailInput.focus();
                    return false;
                }
                
                // 비밀번호 일치 검사
                if (passwordInput.value !== '' && passwordInput.value !== passwordConfirmInput.value) {
                    alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                    passwordConfirmInput.focus();
                    return false;
                }
                
                return true;
            }
            
            // 프로필 데이터 저장
            function saveProfileData() {
                // 저장할 데이터 객체 생성
                const profileData = {
                    name: nameInput.value.trim(),
                    contact: contactInput.value.trim(),
                    email: emailInput.value.trim(),
                    password: passwordInput.value,
                    status: statusInput.value.trim()
                };
                
                // 실제 구현에서는 AJAX를 사용하여 서버에 데이터를 전송합니다.
                console.log('저장할 프로필 데이터:', profileData);
                
                // 성공적으로 저장되었다고 가정
                alert('프로필이 성공적으로 수정되었습니다.');
                
                // 프로필 페이지로 이동 (JSP 환경에 따라 경로 조정 필요)
                location.href = "WEB-INF/views/index.jsp";
            }
        });
    </script>
</body>
</html>