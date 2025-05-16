<%@page import="com.kh.tt.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    


<%
    com.kh.tt.member.model.vo.Member loginMember = (com.kh.tt.member.model.vo.Member) session.getAttribute("loginMember");
    String myNickname = loginMember.getMemName();   // 내 닉네임
    String targetNickname = (String) request.getAttribute("targetNickname"); // 상대방 닉네임
    
    String roomIdParam = request.getParameter("roomId");
    int roomId = roomIdParam != null ? Integer.parseInt(roomIdParam) : -1;
%>

<%
    List<Member> chatRoomMembers = (List<Member>) request.getAttribute("chatRoomMembers");
    int memberCount = chatRoomMembers != null ? chatRoomMembers.size() : 0;

%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
        }

        body {
            display: flex;
            background-color: #f9f9f9;
            min-height: 100vh;
        }


        /* 메인 콘텐츠 영역 */
		.main-content {
		    display: flex;
		    flex-direction: column;
		    flex-grow: 1;
		    height: 100vh;  /* 전체 높이 지정 */
		}
        .chat-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e1e1e1;
            display: flex;
            align-items: center;
            background-color: white;
        }

        .chat-profile {
            display: flex;
            align-items: center;
            flex-grow: 1;
        }

        .chat-profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 15px;
            overflow: hidden;
        }

        .chat-profile-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .chat-actions {
            display: flex;
            gap: 15px;
        }

        .chat-action-btn {
            background: none;
            border: none;
            font-size: 18px;
            color: #777;
            cursor: pointer;
        }

        .chat-action-btn.active {
            color: #4a8cff;
        }    
  
		.chat-messages {
		    flex-grow: 1;   /* 나머지 공간 다 채움 */
		    overflow-y: auto;
		    padding: 20px;
		    gap: 15px;
		    background-color: #f5f5f5;
		    display: flex;
		    flex-direction: column;
		}

        .message-bubble {
            max-width: 70%;
            padding: 12px 15px;
            border-radius: 18px;
            position: relative;
        }

        .message-bubble.received {
            align-self: flex-start;
            background-color: white;
            border: 1px solid #e1e1e1;
            border-bottom-left-radius: 4px;
        }

        .message-bubble.sent {
            align-self: flex-end;
            background-color: #4a8cff;
            color: white;
            border-bottom-right-radius: 4px;
        }

        .message-time {
            font-size: 12px;
            margin-top: 5px;
            color: #999;
        }

        .message-bubble.sent .message-time {
            color: rgba(255, 255, 255, 0.8);
        }

        .chat-attachment {
            max-width: 100%;
            border-radius: 12px;
            overflow: hidden;
            margin-top: 5px;
        }

        .chat-attachment img {
            max-width: 100%;
            display: block;
        }

        .chat-input-container {
            padding: 15px;
            background-color: white;
            border-top: 1px solid #e1e1e1;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .chat-input-actions {
            display: flex;
            gap: 15px;
        }

        .chat-input-btn {
            background: none;
            border: none;
            font-size: 20px;
            color: #777;
            cursor: pointer;
        }

        .chat-input {
            flex-grow: 1;
            border: 1px solid #e1e1e1;
            border-radius: 20px;
            padding: 10px 15px;
            resize: none;
            outline: none;
            max-height: 120px;
            overflow-y: auto;
        }

        .chat-send-btn {
            background-color: #4a8cff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-size: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        /* 우측 사이드바 */
        .right-sidebar {
            width: 300px;
            background-color: white;
            border-left: 1px solid #e1e1e1;
            display: none;
            flex-direction: column;
            overflow: hidden;
        }

        .right-sidebar.active {
            display: flex;
        }

        .right-sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid #e1e1e1;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .right-sidebar-title {
            font-weight: bold;
        }

        .close-sidebar {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
        }

        .right-sidebar-content {
            overflow-y: auto;
            flex-grow: 1;
        }

        .section-header {
            padding: 15px 20px;
            font-weight: bold;
            border-bottom: 1px solid #f1f1f1;
            background-color: #f9f9f9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .section-toggle {
            font-size: 18px;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .section-toggle.collapsed {
            transform: rotate(-90deg);
        }

        .member-list, .file-list {
            padding: 10px 0;
        }

        .member-item {
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .member-info {
            flex-grow: 1;
        }

        .member-name {
            font-weight: bold;
        }

        .member-status {
            font-size: 12px;
            color: #888;
        }

        .add-member {
            padding: 10px 20px;
            color: #4a8cff;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }
        
        .add-cal {
        	cursor: pointer;
        }

        .file-item {
            padding: 10px 20px;
            display: flex;
            gap: 10px;
            align-items: center;
            border-bottom: 1px solid #f1f1f1;
        }

        .file-icon {
            font-size: 20px;
            color: #4a8cff;
        }

        .file-info {
            flex-grow: 1;
        }

        .file-name {
            font-weight: bold;
            margin-bottom: 3px;
        }

        .file-meta {
            font-size: 12px;
            color: #888;
        }

        .file-download {
            color: #4a8cff;
            cursor: pointer;
        }

        .dropdown-menu {
            position: absolute;
            top: 40px;
            right: 10px;
            background-color: white;
            border: 1px solid #e1e1e1;
            border-radius: 4px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 100;
            display: none;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-item {
            padding: 12px 20px;
            cursor: pointer;
            white-space: nowrap;
        }

        .dropdown-item:hover {
            background-color: #f5f5f5;
        }

        .dropdown-divider {
            height: 1px;
            background-color: #e1e1e1;
        }
        
        
        
        /* 채팅 친구 리스트 등*/

		/* ✅ 왼쪽 모달 (새 채팅용) */
		#inviteModal {
		  position: fixed;
		  top: 120px;
		  left: 100px;
		  z-index: 9999;
		  background: white;
		  padding: 20px;
		  border-radius: 8px;
		  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
		  display: none;
		  min-width: 300px;
		}
		
		/* ✅ 왼쪽 닫기 버튼 */
		#closeModalBtn {
		  float: right;
		  font-size: 18px;
		  font-weight: bold;
		  cursor: pointer;
		  background: none;
		  border: none;
		  color: #888;
		}
		#closeModalBtn:hover {
		  color: #ff4444;
		}
		
		/* ✅ 왼쪽 친구 리스트 */
		#friend-list-left {
		  margin-top: 15px;
		  max-height: 300px;
		  overflow-y: auto;
		}
		
		/* ✅ 오른쪽 모달 (초대용) */
		#inviteModalRight {
		  position: fixed;
		  top: 120px;
		  right: 320px;
		  z-index: 9999;
		  background: white;
		  padding: 20px;
		  border-radius: 8px;
		  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
		  display: none;
		  min-width: 300px;
		}
		
		/* ✅ 오른쪽 닫기 버튼 */
		#inviteModalRight .close-modal {
		  float: right;
		  font-size: 18px;
		  font-weight: bold;
		  cursor: pointer;
		  background: none;
		  border: none;
		  color: #888;
		}
		#inviteModalRight .close-modal:hover {
		  color: #ff4444;
		}
		
		/* ✅ 오른쪽 친구 리스트 */
		#friend-list-right {
		  margin-top: 15px;
		  max-height: 300px;
		  overflow-y: auto;
		}
		
		/* ✅ 친구 항목 공통 */
		.friend-item {
		  padding: 10px;
		  border-radius: 5px;
		  margin-bottom: 6px;
		  background-color: #f8f9fa;
		  cursor: pointer;
		  transition: background-color 0.2s;
		}
		.friend-item:hover {
		  background-color: #e6f0ff;
		}
		
		/* ✅ 버튼: 공통 적용 가능 */
		#startChatBtnLeft,
		#startChatBtnRight {
		  display: block;
		  width: 100%;
		  padding: 12px 16px;
		  margin-top: 15px;
		  background-color: #4a8cff;
		  color: white;
		  font-size: 16px;
		  font-weight: bold;
		  border: none;
		  border-radius: 6px;
		  cursor: pointer;
		  transition: background-color 0.2s ease;
		  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		#startChatBtnLeft:hover,
		#startChatBtnRight:hover {
		  background-color: #367ee6 ;
		}
		#startChatBtnLeft:active,
		#startChatBtnRight:active {
		  background-color: #2c6dd9;
		}

		/* ✅ 공통 친구 리스트 스타일 */
		#friend-list-left,
		#friend-list-right {
		  margin-top: 15px;
		  max-height: 300px; /* 세로 길이 제한 */
		  overflow-y: auto;  /* 스크롤 */
		  display: flex;
		  flex-direction: column;
		  gap: 6px;
		}
		
		/* ✅ label 스타일 세로 정렬 + 카드 스타일 */
		#friend-list-left label,
		#friend-list-right label {
		  display: flex;
		  align-items: center;
		  padding: 10px;
		  background-color: #f8f9fa;
		  border-radius: 6px;
		  cursor: pointer;
		  transition: background-color 0.2s;
		}
		
		#friend-list-left label:hover,
		#friend-list-right label:hover {
		  background-color: #e6f0ff;
		}
		
		#friend-list-left input[type="checkbox"],
		#friend-list-right input[type="checkbox"] {
		  margin-right: 10px;
		}
				
		
		/* 메시지 삭제 */
		.message-wrapper {
		  display: flex;
		  align-items: center;
		  position: relative;
		  gap: 8px;
		}
		
		.message-wrapper.sent {
		  justify-content: flex-end;
		}
		
		.message-menu-wrapper {
		  position: relative;
		}
		
		.message-menu-btn {
		  background: none;
		  border: none;
		  font-size: 18px;
		  color: #777;
		  cursor: pointer;
		}
		
		.message-dropdown {
		  position: absolute;
		  top: 20px;
		  left: 0;
		  background: white;
		  border: 1px solid #ddd;
		  border-radius: 6px;
		  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
		  display: none;
		  min-width: 80px;
		  z-index: 1000;
		}
		
		.message-dropdown.show {
		  display: block;
		}
		
		.message-action {
		  padding: 8px 12px;
		  font-size: 14px;
		  cursor: pointer;
		}
		
		.message-action:hover {
		  background-color: #f5f5f5;
		}


		/*채팅방 이름 변경*/
		#editRoomNameBtn {
		    background: none;
		    border: none;
		    font-size: 16px;
		    margin-left: 8px;
		    cursor: pointer;
		    color: #888;
		    transition: color 0.2s ease;
		}
		
		#editRoomNameBtn:hover {
		    color: #4a8cff;
		    transform: scale(1.05);
		}
										
    </style>

</head>
<body>
     <!-- 이쪽에 메뉴바 포함 할꺼임 -->
    <jsp:include page="../common/mainMenu.jsp"/>
    
    
	<jsp:include page="../common/sidebar.jsp"/>


    <!-- 메인 콘텐츠 - 채팅 부분 -->
    <div class="main-content">
        <div class="chat-header">
            <div class="chat-profile">
                <div class="chat-profile-img">
                    <img src="../../../resources/asset/채팅방예시사진.png" alt="프로필">
                </div>
               <h3 id="chatRoomTitle"><%= targetNickname == null ? "채팅방을 선택해주세요" : targetNickname %></h3>
				<span  id="participantCount"> 
				</span>
				<button id="editRoomNameBtn" style="margin-left: 10px;">✏️</button>


            </div>
            
            <div class="chat-actions">
                <button class="chat-action-btn" id="leaveRoomBtn"> 🚪</button>
                <button class="chat-action-btn" id="toggleRightSidebar">👥</button>
                <button class="chat-action-btn" id="toggleMenu">⋮</button>
            </div>
        </div>

        <div class="chat-messages">
            
        </div>
        
        <div class="chat-input-container">
            <div class="chat-input-actions">
            
            	<input type="file" id="selectedFile" style="display: none;" />
				<button type="button" class="chat-input-btn" id="fileSelectBtn">📎</button>
                
            </div>
            <input type="text" class="chat-input" placeholder="Type a message...">
            <button class="chat-send-btn">➤</button>
        </div>
    </div>

    <!-- 우측 사이드바 - 참가자 및 파일 목록 -->
    <div class="right-sidebar" id="rightSidebar">
        <div class="right-sidebar-header">
            <div class="right-sidebar-title">PEOPLE</div>
            <button class="close-sidebar" id="closeRightSidebar">✕</button>
        </div>
        
        <div class="right-sidebar-content">
            <div class="section-header">
                <div>Member</div>
            </div>
            
            <div class="member-list">
                <div class="member-item">
                    <div class="profile-img">
                        <img src="https://via.placeholder.com/40/8c4aff/ffffff?text=서" alt="프로필">
                    </div>
                    <div class="member-info">
                        <div class="member-name"><%= myNickname %></div>
                    </div>
                </div>
                
                <div class="member-item">
                    <div class="profile-img">
                        <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=팀" alt="프로필">
                    </div>
                    <div class="member-info">
                        <div class="member-name" id="targetNicknameArea">상대방 닉네임 로딩중...</div>
                    </div>
                </div>
            </div>
            
                <div class="add-member" id ="addMem">
				  <div style="font-size: 20px;">+</div>
				  <div> Add </div>
				</div>
				
				<!-- 오른쪽: 그룹 채팅용 -->
				<div id="inviteModalRight" class="invite-modal">
				  <button class="close-modal">✕</button>
				  <h3>친구 목록</h3>
				  <div id="friend-list-right">여기에 친구 목록이 표시될 예정입니다.</div>
				  <button id="startChatBtnRight" style="margin-top: 10px;">선택한 친구 초대</button>
				</div>
            
            
            <div class="section-header">
                <div>티서랍</div>
            </div>
            
            <div class="file-list">
               
                </div>
                
            </div>
            
            <div class="section-header">
                <div>캘린더</div>
                <div class="add-cal" style="font-size: 20px;" onclick="addCal()">+</div>
            </div>
            
            <div style="padding: 15px 20px;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <div style="font-weight: bold;">4.16</div>
                    <div style="font-size: 12px; color: #ff8c4a;">오늘</div>
                </div>
                <div style="background-color: #f5f5f5; padding: 10px; border-radius: 4px; margin-bottom: 15px;">
                    <div style="font-weight: bold;">물리 중간고사</div>
                    <div style="font-size: 12px; color: #888;">KH정보교육원 강남실험 1관</div>
                </div>
                
                
                
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <div style="font-weight: bold;">4.16</div>
                    <div style="font-size: 12px; color: #ff8c4a;">오늘</div>
                </div>
                <div style="background-color: #f5f5f5; padding: 10px; border-radius: 4px;">
                    <div style="font-weight: bold;">화학 중간고사</div>
                    <div style="font-size: 12px; color: #888;">KH정보교육원 강남실험 1관</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 탭 전환 기능
            const tabs = document.querySelectorAll('.tab');
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    tabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // 메시지 항목 클릭 이벤트
            const messageItems = document.querySelectorAll('.message-item');
            messageItems.forEach(item => {
                item.addEventListener('click', function() {
                    messageItems.forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                    
                    // 메시지 선택 시 채팅 헤더 업데이트
                    const name = this.querySelector('.message-name').textContent;
                    document.querySelector('.chat-header h3').textContent = name;
                    
                    // 프로필 이미지도 업데이트
                    const profileImg = this.querySelector('.profile-img img').src;
                    document.querySelector('.chat-profile-img img').src = profileImg;
                });
            });

            // 우측 사이드바 토글
            const toggleRightSidebar = document.getElementById('toggleRightSidebar');
            const rightSidebar = document.getElementById('rightSidebar');
            const closeRightSidebar = document.getElementById('closeRightSidebar');
            
            toggleRightSidebar.addEventListener('click', function() {
                rightSidebar.classList.toggle('active');
                toggleRightSidebar.classList.toggle('active');
            });
            
            closeRightSidebar.addEventListener('click', function() {
                rightSidebar.classList.remove('active');
                toggleRightSidebar.classList.remove('active');
            });
            
            // 드롭다운 메뉴 토글
            const toggleMenu = document.getElementById('toggleMenu');
            
            toggleMenu.addEventListener('click', function(e) {
                e.stopPropagation();
                rightSidebar.classList.add('active');
            });
        });
    </script>
    
    <script>
document.addEventListener("DOMContentLoaded", function () {
  const logout = document.querySelector(".logout-icon");
  if (logout) {
    logout.addEventListener("click", function () {
      window.location.href = "/logout.me"; // ✅ 절대경로
    });
  }
});
</script>

<!-- ✅ 닉네임 설정: WebSocket 연결 전에! -->

<script>
    const nickname = "<%= ((com.kh.tt.member.model.vo.Member)session.getAttribute("loginMember")).getMemName() %>";
    const myMemNo = "<%= ((com.kh.tt.member.model.vo.Member)session.getAttribute("loginMember")).getMemNo() %>";
</script>

<script>
//✅ 전역에서 사용 가능하게
function isImageFile(filename) {
    return /\.(jpg|jpeg|png|gif)$/i.test(filename);
}

function appendMessage(data, type) {
    let content = "";
    
    const contextPath = "${pageContext.request.contextPath}";

    const wrapper = document.createElement("div");
    wrapper.classList.add("message-wrapper", type); // 감싸는 div
    wrapper.dataset.messageId = data.messageNo ?? "";

    const bubble = document.createElement("div");
    bubble.classList.add("message-bubble", type);

    
    // 발신자 표시 (받은 메시지일 경우)
    if (type === 'received') {
        content += `<div><strong>\${data.sender}</strong></div>`;
    }

    

 // ✅ 새로 보낸 파일 → 이미지 처리
    if (data.type === "file" && data.file && data.file.type.startsWith("image")) {
        const imageUrl = data.file.fileUrl;
        const fileName = data.file.name;

        content += `
            <a href="\${imageUrl}" download="\${fileName}" class="chat-attachment">
                <img src="\${imageUrl}" alt="\${fileName}" style="max-width: 200px; border-radius: 8px; margin-top: 5px;" />
            </a>`;
    }
    // ✅ 이전 메시지 → originName + changeName 둘다 있으면 이미지
    else if (data.changeName && isImageFile(data.changeName)) {
        const imageUrl = contextPath + "/resources/uploadFiles/" + data.changeName;
        const fileName = data.originName ?? "";

        content += `
            <a href="\${imageUrl}" download="\${fileName}" class="chat-attachment">
                <img src="\${imageUrl}" alt="\${fileName}" style="max-width: 200px; border-radius: 8px; margin-top: 5px;" />
            </a>`;
            
            
    }else if(data.type === "file" && data.file){
    	const fileUrl = data.file.fileUrl;
        const fileName = data.file.name;
        
        content += `
            <a href="\${fileUrl}" download="\${fileName}" class="chat-attachment"
               style="display: inline-block; background: #eaeaea; padding: 10px; border-radius: 10px; margin-top: 5px;">
                📄 \${fileName}
            </a>`;
            
            
    }else if(data.changeName && !isImageFile(data.changeName)){
    	const fileUrl = contextPath + "/resources/uploadFiles/" + data.changeName;
        const fileName = data.originName;
        
        content += `
            <a href="\${fileUrl}" download="\${fileName}" class="chat-attachment"
               style="display: inline-block; background: #eaeaea; padding: 10px; border-radius: 10px; margin-top: 5px;">
                📄 \${fileName}
            </a>`;
    }
 

    // ✅ 일반 텍스트
    else {
        const textContent = data.text ?? data.messageContent ?? '';
        content += `<div>\${textContent}</div>`;
    }

    content += `<div class="message-time">\${formatTime(data.time || data.sendTime)}</div>`;
    
    bubble.innerHTML = content;
    
    // 삭제 ⋮ 버튼 (보낸 메시지만)
    if (type === "sent") {
        const menuWrapper = document.createElement("div");
        menuWrapper.className = "message-menu-wrapper";

        menuWrapper.innerHTML = `
            <button class="message-menu-btn">⋮</button>
            <div class="message-dropdown hidden">
                <div class="message-action delete" style="font-size=9">삭제</div>
            </div>
        `;

        wrapper.appendChild(menuWrapper);  // 왼쪽
        
        const deleteBtn = menuWrapper.querySelector(".message-action.delete");
        deleteBtn.addEventListener("click", function () {
            if (confirm("정말 이 메시지를 삭제하시겠습니까?")) {

                const messageNo = data.messageNo;
                console.log("메segi넘버"+messageNo);

                if (!messageNo) {
                    console.warn("❌ messageNo 없음, 삭제 요청 생략");
                    return;
                }
                
                const formData = new URLSearchParams();
                console.log("formDate si ble" + formData);
                formData.append("messageNo", messageNo);

                fetch(`\${contextPath}/message/delete`, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: `messageNo=\${messageNo}`
                })
                .then(res => res.text())
                .then(result => {
                    if (result === "success") {
                        alert("메시지를 삭제했습니다.");
                        wrapper.remove();
                    } else {
                        alert("❌ 메시지 삭제 실패");
                    }
                })
                .catch(err => {
                    console.error("❌ 메시지 삭제 에러:", err);
                });
            }
        });

       
    }
    
    
    
    
    wrapper.appendChild(bubble); // 오른쪽
    document.querySelector(".chat-messages").appendChild(wrapper);
    scrollToBottom(); // ✅ 맨 아래로 이동
}



function scrollToBottom() {
    const chatBox = document.querySelector(".chat-messages");
    chatBox.scrollTop = chatBox.scrollHeight;
}




function formatTime(isoString) {
    const date = new Date(isoString);
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}


//메시지 삭제
document.addEventListener("click", function (e) {
  // 메뉴 열기
  if (e.target.matches(".message-menu-btn")) {
    const dropdown = e.target.nextElementSibling;
    dropdown.classList.toggle("show");
  }

  // 삭제 처리
  if (e.target.classList.contains("delete")) {
    const bubble = e.target.closest(".message-bubble");
    if (bubble) bubble.remove(); // 👉 필요 시 DB 삭제 요청 추가
  }

  // 드롭다운 외부 클릭 시 닫기
  if (!e.target.closest(".message-menu-wrapper")) {
    document.querySelectorAll(".message-dropdown").forEach(el => el.classList.remove("show"));
  }
});




</script>


<!-- ================웹소켓====================== -->
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>

<script>
window.isNotificationOn = true;// 🔔 기본 ON 상태
let socket;

document.addEventListener("DOMContentLoaded", function () {
    const contextPath = '${pageContext.request.contextPath}';
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");
    const token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbmEiLCJtZW1ObyI6MSwibWVtTmFtZSI6Iuq0gOumrOyekCJ9.GrFjymLAjAiEyIZYnRX7uSU5TRSu6bcs9GvBgHxCOX4"; // JWT 토큰 (생략 가능)

    if (!roomId) return;

    const ip = location.hostname;
    const encodedToken = encodeURIComponent(token);

    //const wsUrl = `ws://\${ip}:8333\${contextPath}/chat/\${roomId}?token=\${encodedToken}`;
    const wsUrl = `wss://threestar.r-e.kr/threeStar/chat/\${roomId}?token=\${encodedToken}`;
    

    socket = new WebSocket(wsUrl);

    socket.onopen = () => console.log("✅ WebSocket 연결 성공");
    socket.onerror = (error) => console.error("❌ WebSocket 에러", error);
    socket.onclose = () => console.log("🔌 WebSocket 종료됨");
    

    const chatInput = document.querySelector(".chat-input");
    const chatSendBtn = document.querySelector(".chat-send-btn");

    chatSendBtn.addEventListener("click", sendMessage);
    chatInput.addEventListener("keydown", (e) => {
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    });

    
    
    // 🔔 종 아이콘 클릭 → 알림 on/off 토글
    const savedNotificationState = localStorage.getItem("isNotificationOn");
    window.isNotificationOn = savedNotificationState !== null ? savedNotificationState === "true" : true;
    
    const alarmIcon = document.querySelector(".alarm-icon");
    if (alarmIcon) {
        // ✅ 상태 반영 (새로고침 직후 아이콘 모양 변경)
        alarmIcon.classList.toggle("muted", !window.isNotificationOn);
        
        // ✅ 클릭 시 상태 토글 + 저장
       alarmIcon.addEventListener("click", () => {
           window.isNotificationOn = !window.isNotificationOn;
           localStorage.setItem("isNotificationOn", window.isNotificationOn); // ✅ 이 줄 추가!
           alarmIcon.classList.toggle("muted", !window.isNotificationOn);
       });
    }

    socket.onmessage = (event) => {
        const data = JSON.parse(event.data);
        const type = data.sender === nickname ? "sent" : "received";
        appendMessage(data, type);

        if (window.isNotificationOn && data.sender !== nickname && !document.hasFocus()) {
            showNotification(data.sender, data.text || data.messageContent || "📎 파일이 도착했어요!");
        }
    };

    function showNotification(sender, message) {
        if (Notification.permission !== "granted") {
            Notification.requestPermission().then(permission => {
                if (permission === "granted") {
                    createNotification(sender, message);
                }
            });
        } else {
            createNotification(sender, message);
        }
    }

    function createNotification(sender, message) {
        const notification = new Notification(`💬 \${sender}님이 보낸 메시지`, {
            body: message,
            icon: contextPath + '/resources/images/chat-icon.png'
        });

        notification.onclick = () => window.focus();
    }



    
    
    
    

    function sendMessage() { 
        const msg = chatInput.value.trim();
        if (!msg) return;

        const payload = {
            sender: nickname,
            text: msg,
            time: new Date().toISOString(),
            type: "chat"
        };

        socket.send(JSON.stringify(payload));
        chatInput.value = "";
        
     // 채팅방 preview 갱신
        const previewSelector = `.message-item .message-name`;
        document.querySelectorAll(previewSelector).forEach(nameEl => {
          if (nameEl.textContent === document.querySelector("#chatRoomTitle").textContent) {
            const previewEl = nameEl.parentElement.querySelector(".message-preview");
            if (previewEl) previewEl.textContent = msg;
          }
        });
    }
});





<!-- 이전채팅가져오기 -->
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");

    console.log("내 번호:", myMemNo);

    fetch(`${pageContext.request.contextPath}/message/history?roomId=\${roomId}`)  // ✅ 백틱 사용 → 템플릿 리터럴
        .then(response => response.json())
        .then(messages => {
            console.log("가져온 이전 메시지들:", messages);

            messages.forEach(msg => {
                console.log("메시지 보낸 사람:", msg.msMemNo, "내 회원번호:", myMemNo);

                // ✅ 회원번호로 보낸 사람 판별
                const type = parseInt(msg.msMemNo) === parseInt(myMemNo) ? "sent" : "received";

                appendMessage(msg, type);
            });
            scrollToBottom(); // ✅ 로딩 끝나고 아래로 이동
        })
        .catch(err => {
            console.error("❌ 이전 메시지 불러오기 실패:", err);
        });
});



<!-- ------------------------------------------------------------------ -->
<!-- 채팅방 이름 채팅방 內 사용자 이름 변경 -->
document.addEventListener("DOMContentLoaded", function () {
    const roomId = new URLSearchParams(window.location.search).get("roomId");
    if (!roomId) return;

    // 채팅방 이름 설정
    fetch(`\${contextPath}/chattingRoom/roomName?roomId=\${roomId}`)
        .then(res => res.text())
        .then(name => {
            document.querySelector("#chatRoomTitle").textContent = name;
        });

    
    // 채팅방 참여자 목록 표시
    fetch(`\${contextPath}/chattingRoom/members?roomId=\${roomId}`)
    .then(response => response.json() )
    .then(data => {
      const memberList = document.querySelector(".member-list");
      memberList.innerHTML = ""; // 초기화

      data.forEach(member => {
        const memberItem = document.createElement("div");
        memberItem.className = "member-item";

        memberItem.innerHTML = `
          <div class="profile-img">
            <img src="\${member.profileUrl || '/tt/resources/images/profile-default.png'}" alt="프로필">
          </div>
          <div class="member-info">
            <div class="member-name">\${member.memName}</div>
          </div>
        `;

        memberList.appendChild(memberItem);
      });
    })
    .catch(err => {
      console.error("❌ 채팅방 멤버 목록 가져오기 실패:", err);
    });
});



//==============채팅방 나가기=============================
document.addEventListener("DOMContentLoaded", function () {
    const leaveBtn = document.getElementById("leaveRoomBtn");
    

    leaveBtn.addEventListener("click", function () {
        if (confirm("정말 이 채팅방에서 나가시겠습니까?")) {
            const roomId = new URLSearchParams(window.location.search).get("roomId");
            const memNo = myMemNo;

            fetch("${pageContext.request.contextPath}/chattingRoom/exit", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `chatId=\${roomId}&memNo=\${memNo}`
            })
            .then(res => {
                console.log("응답 상태:", res.status);
                return res.text();
            })
            .then(data => {
                console.log("결과:", data);
                if (data === "success") {
                    alert("채팅방에서 나갔습니다.");
                    window.location.href = contextPath + "/message/mainForm";
                } else {
                    alert("채팅방 나가기 실패");
                }
            })
            .catch(err => {
                console.error("❌ 채팅방 나가기 에러:", err);
            });
        }
    });
});


//==이미지 업로드 時====
	
const fileInput = document.getElementById("selectedFile");
const fileSelectBtn = document.getElementById("fileSelectBtn");
const roomId = new URLSearchParams(window.location.search).get("roomId");


// 📎 버튼 클릭 → 파일 선택창 열기
fileSelectBtn.addEventListener("click", () => {
    fileInput.click();
});

// 파일 선택 후 이벤트
fileInput.addEventListener("change", () => {
    const file = fileInput.files[0];
    if (!file) return;
    
    const originName = file.name;
    const formData = new FormData();
    formData.append("file", file);

    // ✅ 안정화 위한 딜레이 (UI 렌더링 고려)
    setTimeout(() => {
        fetch(`\${contextPath}/message/upload`, {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (!data.imageUrl) {
                console.error("❌ 이미지 업로드 실패");
                return;
            }

            const fileUrl = data.imageUrl;
            const changeName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);

            // ✅ WebSocket으로 실시간 전송
            const payload = {
                sender: nickname,
                text: file.name,
                time: new Date().toISOString(),
                type: "file",
                file: {
                    name: changeName,
                    type: file.type,
                    fileUrl: fileUrl
                }
            };

            socket.send(JSON.stringify(payload));
            
            console.log("아씨발진짜"+contextPath)
            
                console.log("🎯 저장 요청 전송 직전");
                console.log("originName:", file.name);
                console.log("changeName:", changeName);

            // ✅ DB 저장용 요청 (Message 테이블용)
            fetch(`\${contextPath}/message/save`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
               
                
                body: JSON.stringify({
                    sender: nickname,
                    messageContent: originName,
                    originName: originName,
                    changeName: changeName,
                    fileType: file.type,
                    type: "file",
                    msChatId: roomId,
                    msMemNo: myMemNo
                })
            })
            .then(res => res.text())
            .then(result => {
                if (result !== "success") {
                    console.error("❌ DB 저장 실패");
                }
            });

        })
        .catch(err => {
            console.error("❌ 업로드 또는 전송 실패:", err);
        });
    }, 100);
});


//티 서랍==============================================================
document.addEventListener("DOMContentLoaded", function () {
    const roomId = <%= roomId %>;
    const contextPath = "<%= request.getContextPath() %>";

    console.log("roomId:", roomId);
    console.log("contextPath:", contextPath);

    fetch(`\${contextPath}/message/download/files?roomId=\${roomId}`)
        .then(response => {
            if (!response.ok) throw new Error("404 or server error");
            return response.json();
        })
        .then(files => {
            const fileListDiv = document.querySelector(".file-list");
            fileListDiv.innerHTML = "";

            files.forEach(file => {
                const isImage = /\.(jpg|jpeg|png|gif)$/i.test(file.originName);
                const fileSizeKb = file.fileSize ? Math.round(file.fileSize / 1024) : "?";
                const downloadUrl = `\${contextPath}/message/download?fileName=\${encodeURIComponent(file.changeName)}`;

                const html = `
                    <div class="file-item">
                        <div class="file-icon">${isImage ? "🖼️" : "📄"}</div>
                        <div class="file-info">
                            <div class="file-name">\${file.originName}</div>
                        </div>
                        <a class="file-download" 
                           href="\${downloadUrl}" 
                           download="\${file.originName}" 
                           target="_blank">⬇️</a>
                    </div>
                `;
                fileListDiv.innerHTML += html;
            });
        })
        .catch(err => {
            console.error("❌ 파일 목록 불러오기 실패:", err);
        });
});

</script>


<script>



//=================오른쪽 +add 눌렀을 때 동작====================
document.addEventListener('DOMContentLoaded', function () {
	  const addMemBtn = document.getElementById('addMem');
	  const inviteModalRight = document.getElementById('inviteModalRight');
	  const closeModalRight = inviteModalRight.querySelector('.close-modal');

	  addMemBtn.addEventListener('click', () => {
	    inviteModalRight.style.display = 'block';
	    loadFriendListForInvite();
	  });

	  closeModalRight.addEventListener('click', () => {
	    inviteModalRight.style.display = 'none';
	  });

	  function loadFriendListForInvite() {
	    const container = document.getElementById('friend-list-right');
	    container.innerHTML = '';

	    fetch(`\${contextPath}/friends/list?memNo=\${myMemNo}`)
	      .then(response => response.json())
	      .then(data => {
	        data.forEach(friend => {
	          const label = document.createElement('label');
	          label.classList.add('friend-item');
	          label.innerHTML = `
	            <input type="checkbox" class="invite-select" value="\${friend.toMem}">
	            \${friend.toNickname}
	          `;
	          container.appendChild(label);
	        });
	      });
	  }

	  
	  document.getElementById("startChatBtnRight").addEventListener("click", () => {
	    const checked = [...document.querySelectorAll(".invite-select:checked")];
	    const selectedIds = checked.map(cb => parseInt(cb.value));

	    if (selectedIds.length === 0) {
	      alert("초대할 친구를 선택하세요.");
	      return;
	    }

	    const roomId = new URLSearchParams(window.location.search).get("roomId");

	    fetch(`\${contextPath}/chattingRoom/invite`, {
	      method: "POST",
	      headers: { "Content-Type": "application/json" },
	      body: JSON.stringify({
	        chatId: roomId,
	        members: selectedIds
	      })
	    })
	      .then(result => result.text())
	      .then(result => {
	        if (result === "success") {
	          alert("✅ 초대 완료");
	          location.reload(); //현재 페이지 리로드하기
	        } else {
	          alert("❌ 초대 실패");
	        }
	      });
	  });
	});




	document.addEventListener("DOMContentLoaded", function () {
		  const roomId = new URLSearchParams(window.location.search).get("roomId");
		  if (!roomId) return;
	
		  fetch(`\${contextPath}/chattingRoom/members?roomId=\${roomId}`)
		    .then(res => res.json())
		    .then(data => {
		    	document.querySelector("#chatRoomTitle + span").innerHTML = `&nbsp;\${data.length} participants`;

		    })
		    .catch(err => {
		      console.error("❌ 참여자 수 갱신 실패:", err);
		    });
		});

	
	
	
//========================채팅창 이름 변경 ========================
document.getElementById("editRoomNameBtn").addEventListener("click", () => {
    const oldName = document.getElementById("chatRoomTitle").textContent;  // ✅ 이전 이름 저장
    const newName = prompt("채팅방 이름을 입력하세요:", oldName); // 🔁 기존 이름 보여주기
    console.log("새로운방이름: " + newName);
    if (!newName || newName === oldName) return;

    const roomId = new URLSearchParams(window.location.search).get("roomId");

    fetch(`\${contextPath}/chattingRoom/rename`, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `roomId=\${roomId}&newName=\${encodeURIComponent(newName)}`
    })
    .then(res => res.text())
    .then(result => {
        if (result === "success") {
            document.getElementById("chatRoomTitle").textContent = newName;

            // ✅ 왼쪽 메시지 목록 이름도 동기화
            document.querySelectorAll(".message-item").forEach(item => {
                const nameEl = item.querySelector(".message-name");
                if (nameEl && nameEl.textContent === oldName) {
                    nameEl.textContent = newName;
                }
            });

            alert("채팅방 이름이 변경되었습니다.");
        } else {
            alert("❌ 채팅방 이름 변경 실패");
        }
    });
});


</script>





<!-- ------------------------------------------------------------------ -->

</body>
</html>