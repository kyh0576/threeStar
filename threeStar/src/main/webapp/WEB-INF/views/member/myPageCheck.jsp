<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    .profile-content {
        background-color: #9f9fd6;
        padding: 20px;
        margin-top: 145px;
    }
    
    .profile-image {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        position: absolute;
        left: 50%;
        top: 120px;
        transform: translateX(-50%);
        /* border: 3px solid white; */
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
        <div class="profile-content">
        <form id="profileUpdate" action="" method="POST">
            <div class="profile-image">

            </div>
            <h1 class="profile-name">
                <input type="hidden" class="form-control" id="memId" name="memId" value="${ loginMember.memId }">
            </h1>
            
            
	            <div class="edit-form">
	                <div class="form-title">
	                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
	                        <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" fill="#333"/>
	                    </svg>
	                    <h2>비밀번호 확인</h2>
	                </div>
	                
	                <div class="form-group">
	                    <label></label>
	                    <input type="hidden" class="form-control" placeholder="닉네임" id="memName" name="memName" value="${ loginMember.memName }" readonly>
	                </div>
	                
	                <div class="form-row">
	                    <div class="form-group">
	                        <label></label>
	                        <input type="hidden" class="form-control" placeholder="010-1234-5678" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" id="phone" name="phone" value="${ loginMember.phone }" readonly>
	                    </div>
	                    <div class="form-group">
	                        <label></label>
	                        <input type="hidden" class="form-control" placeholder="example@email.com" id="email" name="email" value="${ loginMember.email }" readonly>
	                    </div>
	                </div>
	
	                <c:if test="${ loginMember.adminYN == 'Y' }">
	                    <div class="form-group">
                            <label></label>
                            <input type="hidden" class="form-control" placeholder="클래스 초대코드" id="memClassCode" name="memClassCode" value="${ loginMember.memClassCode }" readonly>
	                    </div>
	                </c:if>
	                
	                <div class="form-group">
	                    <label></label>
	                    <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" id="memPwd" name="memPwd" value="" required>
	                </div>
	                
	                <div class="button-group">
	                	<a class="btn btn-primary" id="deleteBtn" onclick="profileUpdate(1)">회원탈퇴</a>
	                	<a class="btn btn-secondary" id="deleteBtn" onclick="profileUpdate(2)">수정</a>
	                    <a class="btn btn-cancel" id="cancelBtn">닫기</a>
	                </div>
	            </div>
	    	</form>  
        </div>
    </div>
    <script>
	
    
    </script>
    
    <script>
    // 모달 외부 클릭 시 닫기
	    document.addEventListener('DOMContentLoaded', function () {
	        const cancelBtn = document.getElementById('cancelBtn');
	        cancelBtn.addEventListener('click', function () {
	            if (parent && typeof parent.closeModal === 'function') {
	                parent.closeModal();
	            }
	        });
	    });
    </script>
    
    <script>
    	function profileUpdate(num){
    		if(num === 1){
    			$("#profileUpdate").attr("action","deleteProfile.do").submit();
    		}else{
    			$("#profileUpdate").attr("action","detailProfile.do").submit();
    		}
    	}
    </script>
    
</body>
</html>