<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>채팅 메신저</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
      width: 300px;
      background-color: white;
      border-right: 1px solid #e0e0e0;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
      position: relative;
    }
    
    .sidebar-top {
      padding-top: 16px;
      padding-bottom: 15px;
      display: flex;
      align-items: center;
    }
    
    .sidebar-title {
      font-size: 16px;
      font-weight: 600;
    }
    
    /* 클래스 섹션 스타일 - 토글 기능 추가 */
    .class-section {
      padding: 0;
      border-bottom: 1px solid #e0e0e0;
    }
    
    .class-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 12px 20px;
      font-size: 14px;
      color: #333;
      cursor: pointer;
    }
    
    .class-header:hover {
      background-color: #f5f5f5;
    }
    
    .class-list {
      list-style: none;
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.3s ease-out;
    }
    
    .class-list.active {
      max-height: 500px;
    }
    
    .class-item {
      display: flex;
      align-items: center;
      padding: 6px 20px;
      cursor: pointer;
    }
    
    .class-item:hover {
      background-color: #f5f5f5;
    }
    
    /* 기존 H-Class 스타일과 통합 */
    .hclass-section {
      padding: 0;
      border-bottom: 1px solid #e0e0e0;
    }
    
    .hclass-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 12px 20px;
      font-size: 14px;
      color: #444;
      cursor: pointer;
    }
    
    .hclass-header:hover {
      background-color: #f5f5f5;
    }
    
    .hclass-list {
      list-style: none;
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.3s ease-out;
    }
    
    .hclass-list.active {
      max-height: 500px;
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
    
    .dropdown-arrow {
      font-size: 12px;
      color: #999;
      transition: transform 0.3s;
    }
    
    .class-header.active .dropdown-arrow {
      transform: rotate(180deg);
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
     display: block; /* ✅ 명확히 표시 */
     visibility: visible; /* ✅ 혹시라도 감춰졌을 경우 대비 */
     min-height: 30px;     /* ✅ 공간 확보 */
     line-height: 1.4;     /* ✅ 텍스트 렌더링 보완 */
   }
   .weather-temp {
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
      max-width: 1000px;
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
    
    .chat-list-container, .chat-list-container-wait {
      width: 100%;
      max-width: 1000px;
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
      cursor: pointer;
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
      font-size: 13px;
      color: #666;
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
      margin-left: 20px;
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
      border-radius: 10px;
    }
  </style>

</head>
<body>
  <!-- 이쪽에 메뉴바 포함 할꺼임 -->
  <jsp:include page="../common/mainMenu.jsp"/>
  
    <c:if test="${ not empty alertMsg }">
      <script>
         alert("${ alertMsg }");
      </script>
      <c:remove var="alertMsg" scope="session"/> <!-- scope 생략시 모든 scope의 있는 alertMsg를 지움 -->
   </c:if>
  

  <!-- 왼쪽 사이드바 -->
  <div style="border: 1px solid #f8f9fa; padding-left:0px" class="border">
    <div class="left-sidebar">
      <div class="sidebar-inner">
      
        <div class="sidebar-top">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
          <div class="sidebar-title" style="padding-left: 16px;">KH - Class</div>
        </div>
        
        <c:set var="myClassCode" value="${loginMember.memClassCode}" />
      
      <!-- 본인 클래스 먼저 출력 -->
      <c:forEach var="c" items="${cList}">
        <c:if test="${c.classCode == myClassCode}">
          <div class="class-section">
            <div class="class-header active" 
                 onclick="toggleClass(this)" 
                 data-classcode="${c.classCode}">
              <span>${c.className} - Class</span>
              <span class="dropdown-arrow">▼</span>
              <input type="hidden" id="classCode" name="classCode" value="${c.classCode}">
            </div>
            <ul class="class-list active">
            <!-- 예시 
              <li class="class-item">
                <div class="avatar avatar-red" id="profile-item">김</div>
                <span class="member-name">김시연1</span>
              </li>
              -->
            </ul>
          </div>
        </c:if>
      </c:forEach>
      
      <!-- 나머지 클래스 출력 -->
      <c:forEach var="c" items="${cList}">
        <c:if test="${c.classCode != myClassCode}">
          <div class="class-section">
            <div class="class-header" 
                 onclick="toggleClass(this)" 
                 data-classcode="${c.classCode}">
              <span>${c.className} - Class</span>
              <span class="dropdown-arrow">▼</span>
            </div>
            <ul class="class-list">
            
            <!-- 
              <li class="class-item">
                <div class="avatar avatar-red" id="profile-item">김</div>
                <span class="member-name">김시연2</span>
              </li>
              -->
              
            </ul>
          </div>
        </c:if>
      </c:forEach>
    
      </div>
      
        <div class="weather-section">
        <div class="weather-icon" id="weatherIcon">🌤</div>
        <div class="temperature" id="weatherTemp"></div>
        <div class="weather-info">날씨 로딩 중...</div>
      </div>
    </div>
  </div>
  
  <!-- 메인 컨텐츠 -->
  <div class="main-content">
    <div class="search-container">
      <input type="text" class="search-box" placeholder="Search...">
    </div>

    <div><b>&nbsp;친구 목록</b></div><br>
    
    <div class="chat-list-container">
    
    </div>


    <br><br><br><br><br>

    <!-- ==========친추 대기중 목록============== -->

    <div><b>&nbsp;대기중</b></div><br>

    <div class="chat-list-container-wait">
    
    </div>
    
  </div>
  
  <!-- 오른쪽 사이드바 -->
  <div class="right-sidebar">
    <div style="border: 1px solid #f8f9fa;" class="border">
      <div class="today-header">온라인 - 3명</div>
      <hr>
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

    <div style="border: 1px solid #f8f9fa;" class="border">
      <div class="hclass-info-title">H class 일정</div>
      <hr>
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
  
  <!-- 스크립트 -->
  <script>
  let globalFriendList = [];  // 모든 친구 리스트 저장
  
    // 모달 관련 기능
    function openProfileModal2(memNo) {
	  
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
      modalIframe.src = 'profile.do' + (memNo ? '?memNo=' + memNo : '');
      modalIframe.style.cssText = `
        width: 500px;
        height: 430px;
        align-items : center;
        border: none;
        border-radius: 20px;
        background: transparent;
      `;
      
      // 모달 컨테이너에 iframe 추가
      modalContainer.append(modalIframe);
      
      // body에 모달 컨테이너 추가
      document.body.append(modalContainer);
      
      // 모달 외부 클릭 시 닫기
      modalContainer.addEventListener('click', function(event) {
        if (event.target === modalContainer) {
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
    
   // 토글 열고 닫는 함수 (여러 개 열릴 수 있음)
   function toggleClass(header) {
     const list = header.nextElementSibling;
     header.classList.toggle('active');
     list.classList.toggle('active');
     
     const isOpen = header.classList.contains('active');
     const classCode = header.getAttribute('data-classcode'); // ⭐ 여기서 classCode 가져옴!

     if (isOpen) {
       fetchClassMembers(classCode, list); // 열렸을 때만 멤버 조회!
     }
   }
   
   // 멤버 조회 Ajax 함수
   function fetchClassMembers(classCode, listElement) {
     $.ajax({
       url: 'selectMemberList.me',  
       method: 'GET',
       data: { classCode: classCode },
       success: function(response) {
         // 리스트 초기화
         listElement.innerHTML = '';

         // 받아온 멤버들 화면에 뿌리기
         response.forEach(member => {
           const memName = member.memName || "이름없음";  // null, undefined 방지
           const memId = member.memId;
           const memNo = member.memNo;
           
           
           
           // ✅ 친구 리스트에서 해당 멤버를 찾음
           const friendData = globalFriendList.find(f => f.memNo === memNo);

           // ✅ 표시할 이름 결정
           const displayName = friendData && friendData.toNickname 
                               ? friendData.toNickname 
                               : (member.memName || "이름없음");
           
           const li = document.createElement('li');
           li.className = 'class-item';
           li.innerHTML = `
               <div class="avatar avatar-red">\${displayName.charAt(0)}</div>
               <span class="member-name">\${displayName}</span>
           `;
           
            // 👉 클릭 이벤트 추가
	        li.addEventListener('click', function() {
	          openProfileModal2(memNo);
	
	        });
            
           listElement.appendChild(li);
         });
       },
       error: function() {
         alert('멤버 조회 실패!');
       }
     });
     
     
   }
   
   


   
   
   // ⭐ 추가: 기본으로 열어주는 함수 (닫는 건 안 건드림)
   function openClass(header) {
     const list = header.nextElementSibling;
     header.classList.add('active');
     list.classList.add('active');
   }
    
    // 프로필 요소에 클릭 이벤트 추가 및 H-Class 기본 열림 설정
    document.addEventListener('DOMContentLoaded', function() {
      // 프로필 모달 이벤트
      const profileElements = document.querySelectorAll('#profile-item');
      
      profileElements.forEach(function(element) {
        element.addEventListener('click', function() {
          const memId = this.getAttribute('MEM_ID');
          openProfileModal2(memNo);
        });
      });
      
      // H-Class 기본 열림 설정
      const activeHeader = document.querySelector('.class-header.active');
     if (activeHeader) {
        openClass(activeHeader); // 이걸로 바꾸기!
     }
     
     // ⭐ 2. 그 다음 Ajax도 호출 (멤버 조회)
     if (activeHeader) {
       const classCode = activeHeader.getAttribute('data-classcode');
       const listElement = activeHeader.nextElementSibling;
       fetchClassMembers(classCode, listElement);
     }
    });
    
    

    
    document.addEventListener("DOMContentLoaded", function () {
  	  fetch('/tt/weather/today')
  	    .then(res => res.json())
  	    .then(data => {
  	      const items = data?.response?.body?.items?.item;
  	      if (!items) throw new Error("예보 데이터 없음");
  	
  	      const tempObj = items.find(i => i.category === "TMP");
  	      const skyObj = items.find(i => i.category === "SKY");
  	      const ptyObj = items.find(i => i.category === "PTY");
  	
  	      const temp = tempObj?.fcstValue ?? "N/A";
  	      const sky = skyObj?.fcstValue;
  	      const pty = ptyObj?.fcstValue;
  	      const fcstTime = tempObj?.fcstTime ?? "1200";
  	      const hour = parseInt(fcstTime.substring(0, 2));
  	      const isNight = hour >= 18 || hour < 6;
  	
  	      // 날씨 아이콘 결정
  	      let icon = "🌤️";
  	      if (pty === "1") icon = "🌧️";
  	      else if (pty === "2" || pty === "6") icon = "🌦️";
  	      else if (pty === "3" || pty === "7") icon = "❄️";
  	      else {
  	        if (sky === "1") icon = isNight ? "🌕" : "☀️";
  	        else if (sky === "3") icon = isNight ? "🌙☁️" : "⛅";
  	        else if (sky === "4") icon = "☁️";
  	      }
  	
  	      // 삽입
  	      document.getElementById("weatherTemp").textContent = `\${temp}°C`;
  	      document.getElementById("weatherIcon").textContent = icon;
  	      document.querySelector(".weather-info").textContent = "기상청 기준 단기예보";
  	    })
  	    .catch(err => {
  	      console.error("🌩️ 날씨 정보 로딩 실패:", err);
  	      document.querySelector(".weather-info").textContent = "날씨 불러오기 실패";
  	    });
  	   
  	  
  	
  	});

	   // 친구목록 리스트 조회
	   const myMemNo = ${loginMember.memNo};  // JSP에서 세션 정보 넘겨줘야 함!
	   loadFriendList(myMemNo);
	   loadWaitingList(myMemNo);
	   
	   function loadFriendList(memNo) {
	        $.ajax({
	          url: 'selectFriendList.me',
	          method: 'GET',
	          data: { memNo: memNo },  // 본인 번호 넘김
	          success: function(response) {
      	 	 	globalFriendList = response;  // ✅ 전역에 저장
      	 	 	
	            renderFriendList(response);
	          },
	          error: function() {
	            alert('친구 리스트 불러오기 실패');
	          }
	        });
	      }
	   
		// 대기중 목록
	   function loadWaitingList(memNo) {
	     $.ajax({
	       url: 'selectWaitingList.me',
	       method: 'GET',
	       data: { memNo: memNo },
	       success: function(response) {
	         renderWaitingList(response); // 대기중만
	       },
	       error: function() {
	         alert('대기중 리스트 불러오기 실패');
	       }
	     });
	   }
	     
	   function renderFriendList(friendList) {
	        const container = document.querySelector('.chat-list-container'); // 친구목록을 넣을 곳
	        container.innerHTML = '';  // 기존 비우기
	
	        if (friendList.length === 0) {
	             container.innerHTML = '<div class="chat-item">친구가 없습니다.</div>';
	             return;
	           }
	        
	        friendList.forEach(friend => {   
	        	
	        	const displayName = friend.toNickname ? friend.toNickname : friend.memName;
	        	const firstChar = displayName.charAt(0);
	        	
	          const friendItem = document.createElement('div');
	          friendItem.className = 'chat-item';
	          friendItem.innerHTML = `
	        	  <div class="chat-avatar avatar-red">\${firstChar}</div>
	        	  <div class="chat-info">
	        	    <div class="chat-name">\${displayName}</div>
	        	  </div>
	            <div class="chat-actions">
	              <div class="chat-message-icon" data-target-user-id="\${friend.memNo}">
	                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#5aaafa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
	                  <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
	                </svg>
	              </div>
	              <div class="chat-message-icon">
	              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#dc3545" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
	            	  onclick="rejectFriend(${loginMember.memNo}, \${friend.memNo}, '친구를 삭제하시겠습니까?')">
	              <path d="M18 6L6 18M6 6l12 12"></path>
	              </div>
	            </svg>
	            </div>
	          `;
	          container.appendChild(friendItem);
	        });
	      }
	   
	   function renderWaitingList(friendList) {
	       const container = document.querySelector('.chat-list-container-wait'); // 친구목록을 넣을 곳
	       container.innerHTML = '';  // 기존 비우기
	
	       if (friendList.length === 0) {
	            container.innerHTML = '<div class="chat-item">대기중인 친구 요청이 없습니다.</div>';
	            return;
	          }
	       
	       friendList.forEach(friend => {
	         const friendItem = document.createElement('div');
	         friendItem.className = 'chat-item';
	         friendItem.innerHTML = `
	           <div class="chat-avatar avatar-red">\${friend.memName.charAt(0)}</div>
	           <div class="chat-info">
	             <div class="chat-name">\${friend.memName}</div>
	           </div>
	           <div class="chat-actions">
	           <div class="chat-message-icon">
		           <!-- 친구수락 아이콘 -->
		           <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
		                fill="none" stroke="#28a745" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
		                style="cursor: pointer;"
		                	onclick="acceptFriend(${loginMember.memNo}, \${friend.memNo})">
		             <path d="M20 6L9 17l-5-5"></path>
		           </svg>
	           </div>
	           <div class="chat-menu-icon">
		           <!-- 친구요청 거절 (X 아이콘) -->
		           <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
		                fill="none" stroke="#dc3545" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
		                style="cursor: pointer;"
		                onclick="rejectFriend(${loginMember.memNo}, \${friend.memNo}, '친구 요청을 거절하시겠습니까?')">
		             <path d="M18 6L6 18M6 6l12 12"></path>
		           </svg>
	           </div>
	         </div>
	
	         `;
	         container.appendChild(friendItem);
	       });
	     }
	   
	   
	   
	   
    
  	function acceptFriend(fromMem, toMem) {
  		   if (confirm("친구신청을 수락하시겠습니까?")) {
  		     location.href = "acceptFriend.do?fromMem=" + encodeURIComponent(fromMem) + "&toMem=" + encodeURIComponent(toMem);
  		   }
  		 }
  		 
  	function rejectFriend(fromMem, toMem, msg) {
  		  if (confirm(msg)) {
  		    location.href = "rejectFriend.do?fromMem=" + encodeURIComponent(fromMem) + "&toMem=" + encodeURIComponent(toMem);
  		  }
  		}


  	//================= 채팅 이모지 클릭 시 =================
  	
  	document.addEventListener('click', function(e) {
  	    const chatIcon = e.target.closest('.chat-message-icon');
  	    if (chatIcon && chatIcon.dataset.targetUserId) {
  	        const targetUserId = chatIcon.dataset.targetUserId;
  	
  	        // 서버로 채팅방 생성 요청
  	        fetch('/tt/chattingRoom/startChat', {
  	            method: 'POST',
  	            headers: {
  	                'Content-Type': 'application/json'
  	            },
  	            body: JSON.stringify({ targetUserId })
  	        })
  	        .then(response => response.json())
  	        .then(data => {
  	            if (data.success) {
  	                const roomId = data.roomId;
  	                location.href = `/tt/message/messageForm?roomId=\${roomId}`;
  	            } else {
  	                alert('❌ 채팅방 생성 실패');
  	            }
  	        })
  	        .catch(error => {
  	            console.error('❌ 채팅방 생성 오류', error);
  	        });
  	    }
  	});
  	
  	
  	
  	//================= 채팅 이모지 클릭 시 startChat 함수 실행 =================
  	function startChat(targetUserId) {
  	  fetch('/tt/chattingRoom/startChat', {  // ✅ URL도 실제 컨트롤러 매핑에 맞게 /tt/message/startChat 등으로 수정
  	    method: 'POST',
  	    headers: {
  	      'Content-Type': 'application/json' 
  	    },
  	    body: JSON.stringify({ targetUserId })
  	  })
  	  .then(response => response.json())
  	  .then(data => {
  	    if (data.success) {
  	      const roomId = data.roomId;
  	      location.href = `/tt/message/messageForm?roomId=\${roomId}`;  // ✅ 백틱(`) 사용
  	    } else {
  	      alert('❌ 채팅방 생성에 실패했습니다.');
  	    }
  	  })
  	  .catch(error => {
  	    console.error('❌ 채팅방 생성 오류', error);
  	  });
  	}

  	

    
  	
  </script>
  
</body>
</html>