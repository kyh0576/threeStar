<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sidebar with Toggle Alert</title>

<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: Arial, sans-serif;
    }

    .sidebar {
        width: 95px;
        height: 100vh;
        background-color: white;
        border-right: 1px solid #e1e1e1;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        padding: 20px 0;
    }

    .sidebar-logo {
        width: 50px;
        height: 50px;
        margin-bottom: 20px;
    }

    .sidebar-menu {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 25px;
        width: 100%;
    }

    .menu-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 100%;
        padding: 10px 0;
        color: #888;
        font-size: 12px;
        text-decoration: none;
    }

    .menu-item.active {
        color: #4a8cff;
    }

    .menu-icon {
        font-size: 24px;
        margin-bottom: 5px;
    }

    .sidebar-footer {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 15px;
        padding-bottom: 20px;
    }

    .profile-img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #4a8cff;
    }

    .logout-icon,
    .alert-icon {
        color: #555;
        transition: transform 0.2s ease, color 0.2s ease;
        cursor: pointer;
    }

    .logout-icon:hover,
    .alert-icon:hover {
        color: #4a8cff;
        transform: scale(1.2);
    }
</style>
</head>
<body>

<div class="sidebar">
    <!-- 상단 로고 + 메뉴 -->
    <div>
        <div class="sidebar-logo">
            <svg viewBox="0 0 24 24" fill="#4a8cff">
                <path d="M12,2C6.486,2,2,6.486,2,12s4.486,10,10,10s10-4.486,10-10S17.514,2,12,2z M12,20c-4.411,0-8-3.589-8-8s3.589-8,8-8 s8,3.589,8,8S16.411,20,12,20z"/>
                <path d="M13,7h-2v6h2V7z"/>
                <path d="M12,17L12,17c0.552,0,1-0.448,1-1v0c0-0.552-0.448-1-1-1h0c-0.552,0-1,0.448-1,1v0C11,16.552,11.448,17,12,17z"/>
            </svg>
        </div>
        <div class="sidebar-menu">
            <a href="#" class="menu-item">
                <div class="menu-icon">🏠</div>
                <div>홈</div>
            </a>
            <a href="#" class="menu-item active">
                <div class="menu-icon">💬</div>
                <div>채팅</div>
            </a>
            <a href="#" class="menu-item">
                <div class="menu-icon">📚</div>
                <div>티서랍</div>
            </a>
            <a href="#" class="menu-item">
                <div class="menu-icon">📅</div>
                <div>캘린더</div>
            </a>
        </div>
    </div>

    <!-- 하단: 알림 + 로그아웃 + 프로필 -->
    <div class="sidebar-footer">
        <div class="alert-icon" onclick="toggleAlert(this)">
            <i class="fas fa-bell fa-lg"></i>
        </div>
        <div class="logout-icon" onclick="location.href='logout.me'">
            <i class="fas fa-right-from-bracket fa-lg"></i>
        </div>
        <img src="59dc3eec-fd50-4286-b086-11fc490dec87.png" alt="프로필" class="profile-img">
    </div>
</div>

<!-- JS: 알림 토글 -->
<script>
    function toggleAlert(el) {
        const icon = el.querySelector('i');
        const isOn = icon.classList.contains('fa-bell');
        icon.classList.toggle('fa-bell');
        icon.classList.toggle('fa-bell-slash');

       
    }
</script>

</body>
</html>
