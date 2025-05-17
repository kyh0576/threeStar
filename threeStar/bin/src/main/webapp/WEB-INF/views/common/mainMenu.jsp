<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThreeStar</title>
 <style>
	.sidebar {
	    width: 95px;
	    background-color: white;
	    border-right: 1px solid #e1e1e1;
	    display: flex;
	    flex-direction: column;
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

</style>
</head>
<body>

 <!-- 왼쪽 사이드바 -->
        <div class="sidebar">
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
                    <div class="menu-icon">👥</div>
                    <div>팀</div>
                </a>
                <a href="#" class="menu-item">
                    <div class="menu-icon">📅</div>
                    <div>캘린더</div>
                </a>
                <a href="#" class="menu-item">
                    <div class="menu-icon">🔔</div>
                    <div>알림</div>
                </a>
            </div>
        </div>


</body>
</html>