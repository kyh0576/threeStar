<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    .profile-picture {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        overflow: hidden;
        background-color: #2b2b2b;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
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
        padding: 10px 0;
        width: 48%;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .btn-confirm {
        background-color: #3498db;
        color: white;
    }
    
    .btn-cancel {
        background-color: #f1f1f1;
        color: #333;
    }
    
    .btn:hover {
        opacity: 0.9;
    }
    
    #fileInput {
        display: none;
    }
</style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-picture-container">
            <div class="profile-picture" id="profilePicture">
                <img id="profileImage" src="/api/placeholder/120/120" alt="프로필 이미지">
                <input type="file" id="fileInput" accept="image/*">
            </div>
        </div>
        
        <div class="progress-container" onclick="location.href='detailProfile.do'">
            <span class="progress-text"></span>
            <svg class="edit-icon" width="25" height="25" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M16.5 3.5C16.8978 3.10217 17.4374 2.87868 18 2.87868C18.2786 2.87868 18.5544 2.93355 18.8118 3.04015C19.0692 3.14676 19.303 3.30301 19.5 3.5C19.697 3.69698 19.8532 3.93083 19.9598 4.18822C20.0665 4.4456 20.1213 4.72142 20.1213 5C20.1213 5.27858 20.0665 5.5544 19.9598 5.81178C19.8532 6.06917 19.697 6.30302 19.5 6.5L7 19L3 20L4 16L16.5 3.5Z" stroke="#333333" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
        
        <div class="input-container">
            <input type="text" class="input-field" id="nameInput" placeholder="아이디" value="">
        </div>
        
        <div class="input-container">
            <input type="text" class="input-field" id="detailInput" placeholder="닉네임" value="">
        </div>
    </div>
    
   	<!--
    <script>
        // 프로필 사진 변경 기능
        const profilePicture = document.getElementById('profilePicture');
        const fileInput = document.getElementById('fileInput');
        const profileImage = document.getElementById('profileImage');
        const confirmBtn = document.getElementById('confirmBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const nameInput = document.getElementById('nameInput');
        const detailInput = document.getElementById('detailInput');
        
        // 프로필 사진 클릭 시 파일 선택 창 열기
        profilePicture.addEventListener('click', () => {
            fileInput.click();
        });
        
        // 파일 선택 시 이미지 미리보기
        fileInput.addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    profileImage.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
     -->

</body>
</html>