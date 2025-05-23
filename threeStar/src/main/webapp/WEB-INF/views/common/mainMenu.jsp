<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThreeStar</title>

<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
 
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
      display: flex;
        flex-direction: column;
        align-items: center;
        gap: 25px;
        width: 100%;
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

    .sidebar-footer .modalId{
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 15px;
        padding-bottom: 20px;
        text-decoration: none;
        cursor: pointer;
    }

    .profile-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: #f0f5ff;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 2px solid #4a8cff;
        color: #4a8cff;
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
        	<a href="${pageContext.request.contextPath}/main.me" class="menu-item">
              <img src="${pageContext.request.contextPath}/resources/asset/smalllogo.png" alt="팀로고">
        	</a>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/main.me" class="menu-item ${page eq 'home' ? 'active' : ''}">
                <div class="menu-icon">🏠</div>
                <div>홈</div>
            </a>
            <a href="${pageContext.request.contextPath}/message/mainForm"  class="menu-item ${page eq 'chat' ? 'active' : ''}">
                <div class="menu-icon">💬</div>
                <div>채팅</div>
            </a>
            <a href="${pageContext.request.contextPath}/drawerSelect.do" class="menu-item ${page eq 'tdrawer' ? 'active' : ''}">
                <div class="menu-icon">📚</div>
                <div>티서랍</div>
            </a>
            <a href="${pageContext.request.contextPath}/calendarDetail.do?email=${loginMember.email}" class="menu-item ${page eq 'calendar' ? 'active' : ''}">
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
		<a href="${pageContext.request.contextPath}/logout.me?memId=${loginMember.memId}" class="logout-icon">
		    <i class="fas fa-right-from-bracket fa-lg"></i>
		</a>
		<div class="modalId" MEM_ID="${ loginMember.memId }">
        	<div class="profile-icon">
                <i class="fas fa-user"></i>
            </div>
    	</div>
    </div>
</div>

<!-- JS: 알림 토글 -->
<script>
// 알람 아이콘 눌렀을때 새로고침해도 유지
document.addEventListener("DOMContentLoaded", () => {
	  const el = document.querySelector(".alert-icon");  // ✅ 여기를 수정
	  const icon = el?.querySelector("i");
	  const saved = localStorage.getItem("isNotificationOn");

	  window.isNotificationOn = saved !== null ? saved === "true" : true;

	  // ✅ 초기 상태 아이콘 모양 반영
	  if (icon) {
	    icon.classList.toggle("fa-bell", window.isNotificationOn);
	    icon.classList.toggle("fa-bell-slash", !window.isNotificationOn);
	  }
	});

</script>

<script>
    function toggleAlert(el) {
        const icon = el.querySelector('i');
        const isOn = icon.classList.contains('fa-bell');
        icon.classList.toggle('fa-bell');
        icon.classList.toggle('fa-bell-slash');
        
        // ✅ 알림 전역 상태도 함께 변경
        window.isNotificationOn = !isOn;
        localStorage.setItem("isNotificationOn", window.isNotificationOn); // ✅ 상태 저장
        console.log("🔔 알림 상태 변경됨 →", window.isNotificationOn);

       
    }
</script>

<!-- modal 1 -->
<script>
	// 부모 페이지의 JavaScript
	function openProfileModal(memId) {
	    // 모달 컨테이너 생성
	    const modalContainer = document.createElement('div');
	    
	    modalContainer.id = 'modalContainer';
	    modalContainer.style.cssText = `
	        position: fixed;
	        top: 0;
	        left: 0;
	        width: 100%;
	        height: 100%;
	        background-color: rgba(0, 0, 0, 0.5);
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        z-index: 1000;
	    `;
	    
	    // iframe 생성
	    const modalIframe = document.createElement('iframe');
	    modalIframe.src = "${pageContext.request.contextPath}/profileCheck.do";
	    modalIframe.style.cssText = `
	        width: 600px;
	        height: 600px;
	        border: none;
	        border-radius: 10px;
	        background: transparent;
	    `;
	    
	    // 모달 컨테이너에 iframe 추가
	    modalContainer.append(modalIframe);
	    
	    // body에 모달 컨테이너 추가
	    document.body.append(modalContainer);
	    
	    // 모달 외부 클릭 시 닫기
	    modalContainer.addEventListener('click', function(event) {
	    	const closeButton = document.getElementById('cancelBtn');
	        if (event.target === modalContainer || event.target === closeButton) {
	            closeModal();
	        }
	    });
	    
	    // 스크롤 방지
	    document.body.style.overflow = 'hidden';
	}
	
	// 모달 닫기 함수 (iframe에서도 접근 가능하도록 전역 함수로 선언)
	function closeModal() {
	    const modalContainer = document.getElementById('modalContainer');
	    if (modalContainer) {
	        document.body.removeChild(modalContainer);
	        document.body.style.overflow = 'auto';
	    }
	}
	
	// 프로필 요소에 클릭 이벤트 추가
	document.addEventListener('DOMContentLoaded', function() {
	    const profileElements = document.querySelectorAll('.modalId');
	    
	    profileElements.forEach(function(element) {
	        element.addEventListener('click', function() {
	            const memId = this.getAttribute('MEM_ID');
	            openProfileModal(memId);
	        });
	    });
	});
</script>

</body>
</html>