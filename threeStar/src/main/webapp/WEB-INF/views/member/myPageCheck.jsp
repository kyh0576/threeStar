<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Arial', sans-serif;
    }
    
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f5f5f5;
    }
    
    .profile-container {
        width: 100%;
        max-width: 500px;
        padding: 30px;
        background-color: #7dd3ed;
        border-radius: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    
    .profile-picture-container {
        display: flex;
        justify-content: center;
        margin-bottom: 30px;
    }
    
    .profile-picture img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .progress-container {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        margin-bottom: 20px;
    }
    
    .progress-text {
        font-size: 16px;
        color: #333;
        margin-right: 10px;
    }
    
    .edit-icon {
        margin-left: 15px;
        cursor: pointer;
    }
    
    .input-container {
        margin-bottom: 20px;
        display: flex;
    }
    
    .input-field {
        width: 100%;
        padding: 12px 0;
        border: none;
        border-bottom: 1px solid #ccc;
        background-color: transparent;
        font-size: 16px;
        outline: none;
        transition: border-color 0.3s;
    }
    
    .input-field:focus {
        border-bottom: 2px solid #007bff;
    }
    
    .button-container {
        display: flex;
        justify-content: space-between;
        margin-top: 40px;
    }
    
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }
    
    .btn-confirm {
        background-color: #3498db;
        color: white;
    }
    
    .btn:hover {
        opacity: 0.9;
    }
    
    #fileInput {
        display: none;
    }

    .button-group {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }

    .btn-cancel {
        background-color: white;
        color: #333;
        border: 1px solid #ddd;
    }

    #detailInput{
        display: flex;
    }
</style>
</head>
<body>
	<form id="" action="detailProfile.do" method="POST">
	    <div class="profile-container">
	        <div class="profile-picture-container">
	            <div class="profile-picture" id="profilePicture">
	
	            </div>
	
	        </div>
	        
	        <div class="progress-container">
				<input type="hidden" class="" id="memId" name="memId" value="${ loginMember.memId }">
	        </div>
	        
	        <div class="input-container">
	            <input type="password" class="input-field" id="memPwd" name="memPwd" placeholder="비밀번호 확인" value="">
	            <svg class="edit-icon" width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16.5 3.5C16.8978 3.10217 17.4374 2.87868 18 2.87868C18.2786 2.87868 18.5544 2.93355 18.8118 3.04015C19.0692 3.14676 19.303 3.30301 19.5 3.5C19.697 3.69698 19.8532 3.93083 19.9598 4.18822C20.0665 4.4456 20.1213 4.72142 20.1213 5C20.1213 5.27858 20.0665 5.5544 19.9598 5.81178C19.8532 6.06917 19.697 6.30302 19.5 6.5L7 19L3 20L4 16L16.5 3.5Z" stroke="#333333" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
	        </div>
	
	        <div class="button-group">
	            <button type="submit" class="btn btn-primary" id="confirmBtn">확인</button>
	            <button type="button" class="btn btn-cancel" id="cancelBtn">닫기</button>
	        </div>
	    </div>
    </form>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
	        const cancelBtn = document.getElementById('cancelBtn');
	        cancelBtn.addEventListener('click', function () {
	            if (parent && typeof parent.closeModal === 'function') {
	                parent.closeModal();
	            }
	        });
	    });
    </script>

</body>
</html>