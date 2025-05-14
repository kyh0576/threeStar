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

       
        /* 메시지 목록 사이드바 */
        .message-sidebar {
            width: 320px; /* 기존 300px보다 살짝 넓게 */
            background-color: white;
            border-right: 1px solid #e1e1e1;
            display: flex;
            flex-direction: column;
            }

        .message-header {
            padding: 20px;
            border-bottom: 1px solid #e1e1e1;
            font-size: 18px;
            font-weight: bold;
        }

        .message-tabs {
            display: flex;
            border-bottom: 1px solid #e1e1e1;
        }

        .tab {
            flex: 1;
            padding: 10px;
            text-align: center;
            background-color: #f5f5f5;
            cursor: pointer;
        }

        .tab.active {
            background-color: #4a8cff;
            color: white;
        }

        .message-list {
            overflow-y: auto;
            flex-grow: 1;
        }

        .message-item {
            padding: 15px;
            border-bottom: 1px solid #f1f1f1;
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .message-item:hover {
            background-color: #f9f9f9;
        }

        .message-item.active {
            background-color: #f0f7ff;
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 20px;  /* 🔼 높이 늘림 (기존 16px → 20px) */
            font-size: 18px;
            font-weight: bold;
            border-bottom: 1px solid #e1e1e1;
            width: 100%;
            box-sizing: border-box;
            }
            
            .new-chat-btn {
            width: 36px;
            height: 36px;
            background-color: #4a8cff;
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: all 0.2s ease;
            }

            .new-chat-btn:hover {
            background-color: #367ee6;
            transform: scale(1.1);
            }

            .new-chat-btn svg {
            stroke: white;
            }




        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 15px;
            overflow: hidden;
        	border: 2px solid #4a8cff;
        }

        .profile-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .message-info {
            flex-grow: 1;
        }

        .message-name {
            font-weight: bold;
            width: 234px;
            margin-bottom: 5px;
        }

        .message-preview {
            color: #666;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 234px;
        }

        /* 메인 콘텐츠 영역 */
        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            position: relative;
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
            flex-grow: 1;
            overflow-y: auto;
            padding: 20px;
            background-color: #f5f5f5;
            display: flex;
            flex-direction: column;
            gap: 15px;
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
		  background-color: #367ee6;
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
				
				
				
				
    </style>

</head>
<body>
     <!-- 이쪽에 메뉴바 포함 할꺼임 -->
    <jsp:include page="../common/mainMenu.jsp"/>

    <!-- 메시지 목록 사이드바 -->
    <div class="message-sidebar">
        <div class="message-header">
            <span class="message-title">Messages</span>
            <button id="newChat" class="new-chat-btn" title="새 채팅 시작">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16">
                  <path d="M8 4v8M4 8h8" stroke="white" stroke-width="2" stroke-linecap="round"/>
                </svg>
              </button>           
          </div>
          
		<div id="inviteModal">
		  <button id="closeModalBtn">✕</button>
		  <h3>친구 목록</h3>
		  <div id="friend-list-left">여기에 친구 목록이 표시될 예정입니다.</div>
		  <button id="startChatBtnLeft" style="margin-top: 10px;">✅ 선택한 친구들과 채팅 시작</button>
		</div>

  
  <div class="message-tabs">
    <div class="tab active">All</div>
    <div class="tab">Group</div>
  </div>
        <div class="message-list">
            
        </div>
    </div>

    <!-- 메인 콘텐츠 - 채팅 부분 -->
    <div class="main-content">
        <div class="chat-header">
            <div class="chat-profile">
                <div class="chat-profile-img">
                    <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=팀" alt="프로필">
                </div>
               <h3 id="chatRoomTitle"><%= targetNickname == null ? "채팅방을 선택해주세요" : targetNickname %></h3>
				<span style="color: #888;"> &nbsp;
				    <%= memberCount %> participants
				    <%
					    System.out.println("✅ JSP에서 확인: chatRoomMembers = " + chatRoomMembers);
					%>
				</span>


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
    const bubble = document.createElement("div");
    bubble.classList.add("message-bubble", type);
    console.log("받은 데이터 확인", data);
    let content = "";

    if (type === 'received') {
        content += `<div><strong>\${data.sender}</strong></div>`;
    }

    const contextPath = "${pageContext.request.contextPath}";
    

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

    document.querySelector(".chat-messages").appendChild(bubble);
    document.querySelector(".chat-messages").scrollTop =
        document.querySelector(".chat-messages").scrollHeight;
}








function formatTime(isoString) {
    const date = new Date(isoString);
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

</script>


<!-- ================웹소켓====================== -->
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>

<script>
let socket;

document.addEventListener("DOMContentLoaded", function () {
   let path = '${pageContext.request.contextPath}';
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");
    const token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbmEiLCJtZW1ObyI6MSwibWVtTmFtZSI6Iuq0gOumrOyekCJ9.GrFjymLAjAiEyIZYnRX7uSU5TRSu6bcs9GvBgHxCOX4"; // JWT 토큰

    if (!roomId) return;

    const ip = location.hostname;
    const encodedToken = encodeURIComponent(token);

    //const wsUrl = `wss://\${ip}:8333\${contextPath}/chat/\${roomId}?token=\${encodedToken}`;
    const wsUrl = `wss://threestar.r-e.kr/threeStar/chat/\${roomId}?token=\${encodedToken}`;
    
    console.log("WebSocket 연결 URL:", wsUrl);

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

    socket.onmessage = (event) => {
    	  const data = JSON.parse(event.data);
    	  const type = data.sender === nickname ? "sent" : "received";
    	  appendMessage(data, type);

    	  // 🔔 상대방 메시지일 때만 알림
    	  if (data.sender !== nickname && !document.hasFocus()) {
    	    showNotification(data.sender, data.text || data.messageContent || "📎 파일이 도착했어요!");
    	  }
    	};

    
    
    
 // 🔔 알림 권한 요청 + 알림 출력 함수
    function showNotification(sender, message) {
        if (Notification.permission !== "granted") {
            Notification.requestPermission().then(permission => {
                if (permission === "granted") {
                    createNotification(sender, message);
                    console.log("센더ㅓㅓㅓㅓㅓ"+sender)
                }
            });
        } else {
            createNotification(sender, message);
        }
    }

    function createNotification(sender, message) {
    	  const notification = new Notification(`💬 \${sender}님이 보낸 메시지`, {
    	    body: message,
    	    icon: '/tt/resources/images/chat-icon.png'
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
    }
});

<!-- 채팅방 목록 -->
document.addEventListener("DOMContentLoaded", function () {
    fetch("${pageContext.request.contextPath}/chattingRoom/rooms")  // 🔁 백엔드에서 참여중인 채팅방 목록 호출
        .then(response => response.json())
        .then(rooms => {
            const list = document.querySelector(".message-list");
            if (!rooms || rooms.length === 0) {
                list.innerHTML = "<p style='padding: 20px; color: gray;'>채팅방이 없습니다</p>";
                return;
            }

            list.innerHTML = rooms.map(room => `
            <div class="message-item" onclick="location.href='${pageContext.request.contextPath}/message/mainForm?roomId=\${room.chatId}'">
                <div class="profile-img"><img src="/resources/images/default-profile.png" alt="프로필"></div>
                <div class="message-info">
                    <div class="message-name">\${room.chatName}</div> <!-- ✅ 여기 수정 -->
                    <div class="message-preview">\${room.lastMessage || '대화를 시작하세요'}</div>
                </div>
            </div>
        `).join('');
        })
        .catch(err => {
            console.error("❌ 채팅방 목록 불러오기 실패:", err);
        });
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
    .then(response => response.json())
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

// 📎 버튼 클릭 → 파일 선택창 열기
fileSelectBtn.addEventListener("click", () => {
    fileInput.click();
});

// 파일 선택 후 이벤트
fileInput.addEventListener("change", () => {
    const file = fileInput.files[0];
    if (!file) return;

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

            // ✅ DB 저장용 요청 (Message 테이블용)
            fetch(`\${contextPath}/message/save`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    sender: nickname,
                    messageContent: file.name,
                    originName: file.name,
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


<!-- +버튼 눌렀을 때 채팅방 생성 -->
<script>
document.addEventListener('DOMContentLoaded', function () {
	  const newChatBtn = document.getElementById('newChat');
	  const inviteModalLeft = document.getElementById('inviteModal');
	  const closeModalBtn = document.getElementById('closeModalBtn');

	  newChatBtn.addEventListener('click', function () {
	    inviteModalLeft.style.display = 'block';
	    loadFriendListForNewChat();
	  });

	  closeModalBtn.addEventListener('click', function () {
	    inviteModalLeft.style.display = 'none';
	  });

	  function loadFriendListForNewChat() {
	    const container = document.getElementById('friend-list-left');
	    container.innerHTML = '';

	    fetch(`\${contextPath}/friends/list?memNo=\${myMemNo}`)
	      .then(response => response.json())
	      .then(data => {
	        if (data.length === 0) {
	          container.innerHTML = '<p>친구가 없습니다.</p>';
	        } else {
	          data.forEach(friend => {
	            const label = document.createElement('label');
	            label.classList.add('friend-item');
	            label.innerHTML = `
	              <input type="checkbox" class="chat-select" value="\${friend.toMem}">
	              \${friend.toNickname}
	            `;
	            container.appendChild(label);
	          });
	        }
	      })
	      .catch(err => {
	        console.error("❌ 친구 목록 로딩 실패", err);
	      });
	  }

	  
	  
	  
	  document.getElementById("startChatBtnLeft").addEventListener("click", () => {
	    const checked = [...document.querySelectorAll(".chat-select:checked")];
	    const selectedIds = checked.map(cb => parseInt(cb.value));

	    if (selectedIds.length === 0) {
	      alert("최소 한 명 이상 선택하세요.");
	      return;
	    }

	    if (selectedIds.length === 1) {
	      // 1:1 채팅
	      fetch(`\${contextPath}/chattingRoom/startChat`, {
	        method: "POST",
	        headers: { "Content-Type": "application/json" },
	        body: JSON.stringify({ targetUserId: selectedIds[0] })
	      })
	        .then(res => res.json())
	        .then(result => {
	          if (result.success && result.roomId) {
	            location.href = `\${contextPath}/message/messageForm?roomId=\${result.roomId}`;
	          } else {
	            alert("❌ 채팅방 생성 실패");
	          }
	        });
	    
	    } else {
	      // 그룹 채팅
	      fetch(`\${contextPath}/chattingRoom/startGroupChat`, {
	        method: "POST",
	        headers: { "Content-Type": "application/json" },
	        body: JSON.stringify({
	          initiator: myMemNo,
	          members: selectedIds
	        })
	      })
	        .then(response => response.json())
	        .then(result => {
	          if (result.success && result.roomId) {
	            location.href = `\${contextPath}/message/messageForm?roomId=\${result.roomId}`;
	          } else {
	            alert("❌ 그룹 채팅 생성 실패");
	          }
	        });
	    }
	  });
	});


//오른쪽 +add 눌렀을 때 동작
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



</script>





<!-- ------------------------------------------------------------------ -->

</body>
</html>