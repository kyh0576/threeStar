<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Font Awesome CDN -->

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
            <a href="${pageContext.request.contextPath}/drawerAll/main" class="menu-item ${page eq 'tdrawer' ? 'active' : ''}">
                <div class="menu-icon">📚</div>
                <div>티서랍</div>
            </a>
            <a href="${pageContext.request.contextPath}/calendarDetail.do" class="menu-item ${page eq 'calendar' ? 'active' : ''}">
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
        	<img src="59dc3eec-fd50-4286-b086-11fc490dec87.png" alt="프로필" class="profile-img-me">
    	</div>
    </div>
</div>


