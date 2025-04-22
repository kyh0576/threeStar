<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>채팅 메신저</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Noto Sans KR', sans-serif;
    }
    
    body {
      display: flex;
      height: 100vh;
      background-color: #f9f9f9;
    }
    
    /* 왼쪽 사이드바 */
    .left-sidebar {
      width: 210px;
      background-color: white;
      border-right: 1px solid #e0e0e0;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
      position: relative;
    }
    
    .sidebar-top {
      padding-bottom: 15px;
      display: flex;
      align-items: center;
    }
    
    .sidebar-logo {
      width: 30px;
      height: 30px;
      margin-right: 10px;
      background-color: #5bc7f8;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .sidebar-logo img {
      width: 18px;
      height: 18px;
    }
    
    .sidebar-title {
      font-size: 16px;
      font-weight: 600;
    }
    
    .hclass-section {
      padding: 10px 0;
      border-bottom: 1px solid #e0e0e0;
    }
    
    .hclass-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 5px 20px;
      font-size: 14px;
      color: #444;
    }
    
    .hclass-list {
      list-style: none;
    }
    
    .hclass-item {
      display: flex;
      align-items: center;
      padding: 6px 20px;
      cursor: pointer;
    }
    
    .hclass-item:hover {
      background-color: #f5f5f5;
    }
    
    .avatar {
      width: 24px;
      height: 24px;
      border-radius: 50%;
      margin-right: 10px;
      object-fit: cover;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 12px;
      font-weight: 500;
    }
    
    .avatar-purple {
      background-color: #7b68ee;
    }
    
    .avatar-red {
      background-color: #ff4c4c;
    }
    
    .avatar-orange {
      background-color: #ff7f50;
    }
    
    .member-name {
      font-size: 13px;
      color: #333;
    }
    
    .class-dropdown {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 12px 20px;
      font-size: 14px;
      color: #333;
      cursor: pointer;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .class-dropdown:hover {
      background-color: #f5f5f5;
    }
    
    .dropdown-arrow {
      font-size: 12px;
      color: #999;
    }
    
    .weather-section {
      margin-top: auto;
      padding: 15px;
      text-align: center;
      border-top: 1px solid #e0e0e0;
    }
    
    .weather-icon {
      font-size: 38px;
      margin-bottom: 5px;
    }
    
    .temperature {
      font-size: 26px;
      font-weight: 500;
      color: #333;
    }
    
    .weather-info {
      font-size: 12px;
      color: #666;
      margin-top: 5px;
    }
    
    
    .profile-avatar {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      background-color: #f0f0f0;
      overflow: hidden;
    }
    
    .profile-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    /* 메인 컨텐츠 */
    .main-content {
      flex: 1;
      padding: 20px;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
    }
    
    .search-container {
      width: 100%;
      max-width: 520px;
      margin-bottom: 20px;
    }
    
    .search-box {
      width: 100%;
      padding: 10px 15px;
      border: 1px solid #e0e0e0;
      border-radius: 6px;
      font-size: 14px;
      background-image: url('/api/placeholder/16/16');
      background-repeat: no-repeat;
      background-position: 10px center;
      padding-left: 30px;
    }
    
    .chat-list-container {
      width: 100%;
      max-width: 520px;
      background-color: white;
      border: 1px solid #e6e6e6;
      border-radius: 8px;
      overflow: hidden;
    }
    
    .chat-item {
      display: flex;
      align-items: center;
      padding: 12px 15px;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .chat-item:last-child {
      border-bottom: none;
    }
    
    .chat-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 16px;
      font-weight: 500;
      margin-right: 15px;
    }
    
    .chat-info {
      flex: 1;
    }
    
    .chat-name {
      font-size: 14px;
      color: #333;
      margin-bottom: 2px;
    }
    
    .chat-actions {
      display: flex;
      align-items: center;
    }
    
    .chat-message-icon {
      width: 24px;
      height: 24px;
      margin-right: 15px;
      color: #5aaafa;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .chat-menu-icon {
      width: 20px;
      height: 20px;
      color: #bbb;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    /* 오른쪽 사이드바 */
    .right-sidebar {
      width: 500px;
      background-color: white;
      border-left: 1px solid #e0e0e0;
      padding: 20px;
      overflow-y: auto;
    }
    
    .today-header {
      padding-bottom: 10px;
      border-bottom: 1px solid #e0e0e0;
      font-size: 13px;
      color: #666;
      margin-bottom: 15px;
    }
    
    .today-members {
      margin-bottom: 25px;
    }
    
    .member-item {
      display: flex;
      align-items: center;
      padding: 8px 0;
    }
    
    .member-avatar {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      margin-right: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 13px;
    }
    
    .hclass-info-title {
      font-size: 14px;
      color: #333;
      margin-bottom: 10px;
      font-weight: 500;
    }
    
    .hclass-info-list {
      list-style: none;
    }
    
    .info-item {
      font-size: 12px;
      color: #666;
      padding: 7px 0;
    }
    
    .nav-icon {
      width: 24px;
      height: 24px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 15px;
    }

    .sidebar-inner {
      margin-left: 40px;
      width: calc(100% - 40px);
    }
    
    .chat-bubble-icon {
      width: 24px;
      height: 24px;
      color: #7b68ee;
    }
    
    /* 추가적인 아이콘 스타일 */
    .menu-icon {
      font-size: 18px;
      color: #999;
    }
    
    /* 반응형 스타일 */
    @media (max-width: 992px) {
      .right-sidebar {
        display: none;
      }
    }
    
    @media (max-width: 768px) {
      .left-sidebar {
        width: 60px;
      }
      
      .sidebar-inner {
        display: none;
      }
    }

    .border{
      background-color: #f8f9fa;
      padding: 16px;
      border-radius: 10px;
    }
  </style>
</head>
<body>
  <!-- 이쪽에 메뉴바 포함 할꺼임 -->
  <jsp:include page="../common/mainMenu.jsp"/>

  <!-- 왼쪽 사이드바 -->
  <div class="left-sidebar">
    <div class="sidebar-inner">
      <div class="sidebar-top">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
          </svg>
        </div>
        <div class="sidebar-title">KH - Class</div>
      </div>
      
      <div class="hclass-section">
        <div class="hclass-header">
          <span>H - Class</span>
        </div>
        <ul class="hclass-list">
          <li class="hclass-item">
            <div class="avatar avatar-red">김</div>
            <span class="member-name">김시연</span>
          </li>
          <li class="hclass-item">
            <div class="avatar avatar-purple">동</div>
            <span class="member-name">동진이 형</span>
          </li>
          <li class="hclass-item">
            <div class="avatar avatar-purple">고</div>
            <span class="member-name">고조장</span>
          </li>
          <li class="hclass-item">
            <div class="avatar avatar-purple">용</div>
            <span class="member-name">용훈 형님</span>
          </li>
          <li class="hclass-item">
            <div class="avatar avatar-orange">전</div>
            <span class="member-name">전창용</span>
          </li>
          <li class="hclass-item">
            <div class="avatar avatar-orange">김</div>
            <span class="member-name">김준서</span>
          </li>
        </ul>
      </div>
      
      <div class="class-dropdown">
        <span>A - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>B - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>C - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>D - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>E - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>F - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>G - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>I - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>J - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="class-dropdown">
        <span>K - Class</span>
        <span class="dropdown-arrow">▼</span>
      </div>
      
      <div class="weather-section">
        <div class="weather-icon">☀️</div>
        <div class="temperature">21.8°</div>
        <div class="weather-info">어제보다 2도켜 높음</div>
      </div>
      
    </div>
  </div>
  
  <!-- 메인 컨텐츠 -->
  <div class="main-content">
    <div class="search-container">
      <input type="text" class="search-box" placeholder="Search...">
    </div>
    
    <div class="chat-list-container">
      <div class="chat-item">
        <div class="chat-avatar avatar-red">김</div>
        <div class="chat-info">
          <div class="chat-name">김시연</div>
        </div>
        <div class="chat-actions">
          <div class="chat-message-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="chat-menu-icon">⋯</div>
        </div>
      </div>
      
      <div class="chat-item">
        <div class="chat-avatar avatar-purple">동</div>
        <div class="chat-info">
          <div class="chat-name">동진이 형</div>
        </div>
        <div class="chat-actions">
          <div class="chat-message-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="chat-menu-icon">⋯</div>
        </div>
      </div>
      
      <div class="chat-item">
        <div class="chat-avatar avatar-purple">고</div>
        <div class="chat-info">
          <div class="chat-name">고조장</div>
        </div>
        <div class="chat-actions">
          <div class="chat-message-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="chat-menu-icon">⋯</div>
        </div>
      </div>
      
      <div class="chat-item">
        <div class="chat-avatar avatar-purple">용</div>
        <div class="chat-info">
          <div class="chat-name">용훈 형님</div>
        </div>
        <div class="chat-actions">
          <div class="chat-message-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="chat-menu-icon">⋯</div>
        </div>
      </div>
      
      <div class="chat-item">
        <div class="chat-avatar avatar-orange">전</div>
        <div class="chat-info">
          <div class="chat-name">전창용</div>
        </div>
        <div class="chat-actions">
          <div class="chat-message-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="chat-menu-icon">⋯</div>
        </div>
      </div>
      
      <div class="chat-item">
        <div class="chat-avatar avatar-purple">현</div>
        <div class="chat-info">
          <div class="chat-name">현정 누나</div>
        </div>
        <div class="chat-actions">
          <div class="chat-message-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
          </div>
          <div class="chat-menu-icon">⋯</div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- 오른쪽 사이드바 -->
  <div class="right-sidebar">
    <div style="border: 1px solid f8f9fa; "  class="border">
      <div class="today-header">온라인 - 3명</div>
      
      <div class="today-members">
        <div class="member-item">
          <div class="member-avatar avatar-red">김</div>
          <span class="member-name">김시연</span>
        </div>
        
        <div class="member-item">
          <div class="member-avatar avatar-purple">동</div>
          <span class="member-name">동진이 형</span>
        </div>
        
        <div class="member-item">
          <div class="member-avatar avatar-purple">현</div>
          <span class="member-name">현정 누나</span>
        </div>
      </div>
    </div>
    
    <br>
    <br>


      <div style="border: 1px solid f8f9fa;" class="border">
        <div class="hclass-info-title">H class 일정</div>
        
        <div class="hclass-info-list">
          <div class="info-item">D - 5 : 프로젝트 기반 공공 데이터 활용</div>
          <div class="info-item">D - 16 : 프로젝트 기반 공공데이터 아키텍처 설계</div>
          <div class="info-item">D - 39 : 애플리케이션 테스트 수행</div>
          <div class="info-item">D - 52 : 애플리케이션 배포</div>
          <div class="info-item">D - 61 : 파이널 프로젝트 발표</div>
          <div class="info-item">D - 70 : 수료</div>
        </div>
    </div>
  </div>
</body>
</html>