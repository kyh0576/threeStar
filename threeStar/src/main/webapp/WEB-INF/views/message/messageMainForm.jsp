<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    


<%
    com.kh.tt.member.model.vo.Member loginMember = (com.kh.tt.member.model.vo.Member) session.getAttribute("loginMember");
    String myNickname = loginMember.getMemName();   // 내 닉네임
    String targetNickname = (String) request.getAttribute("targetNickname"); // 상대방 닉네임
    int roomId = (Integer) request.getAttribute("roomId");
%>


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
            margin-bottom: 5px;
        }

        .message-preview {
            color: #666;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
                <h3 id="chatRoomTitle"><%= targetNickname == null ? "이름없음" : targetNickname %></h3>
                <span style="margin-left: 10px; color: #888; font-size: 14px;">2 participants</span>
            </div>
            <div class="chat-actions">
                <button class="chat-action-btn">🔍</button>
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
                        <div class="member-status">온라인</div>
                    </div>
                </div>
                
                <div class="member-item">
                    <div class="profile-img">
                        <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=팀" alt="프로필">
                    </div>
                    <div class="member-info">
                        <div class="member-name" id="targetNicknameArea">상대방 닉네임 로딩중...</div>
                        <div class="member-status">온라인</div>
                    </div>
                </div>
                
                <div class="add-member">
                    <div style="font-size: 20px;">+</div>
                    <div>Add</div>
                </div>
            </div>
            
            <div class="section-header">
                <div>디서함</div>
            </div>
            
            <div class="file-list">
                <div class="file-item">
                    <div class="file-icon">📄</div>
                    <div class="file-info">
                        <div class="file-name">자소서.pdf</div>
                        <div class="file-meta">120 kB</div>
                    </div>
                    <div class="file-download">⬇️</div>
                </div>
                
                <div class="file-item">
                    <div class="file-icon">📄</div>
                    <div class="file-info">
                        <div class="file-name">수정본.pdf</div>
                        <div class="file-meta">150 kB</div>
                    </div>
                    <div class="file-download">⬇️</div>
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

    const contextPath = "/tt";

    // ✅ 새로 보낸 파일 → 이미지 처리
    if (data.type === "file" && data.file && data.file.type.startsWith("image")) {
        const imageUrl = contextPath + data.file.fileUrl;

        content += `<div class="chat-attachment">
            <img src="\${imageUrl}" alt="\${data.file.name}" style="max-width: 200px; border-radius: 8px; margin-top: 5px;" />
        </div>`;
    }
    // ✅ 이전 메시지 → originName + changeName 둘다 있으면 이미지
else if (data.changeName && isImageFile(data.changeName)) {
    const contextPath = "/tt";
    const imageUrl = contextPath + "/resources/uploadFiles/" + data.changeName;

    content += `<div class="chat-attachment">
        <img src="\${imageUrl}" alt="\${data.originName ?? ''}" style="max-width: 200px; border-radius: 8px; margin-top: 5px;" />
    </div>`;
}



    // ✅ 이전 메시지 → originName만 있고 changeName이 없으면 그냥 파일명 출력
    else if (data.originName && !data.changeName) {
        content += `<div>\${data.originName}</div>`;
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

let socket;  // ✅ 전역으로 뺌

document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");

    if (!roomId) {
        console.warn("ℹ️ roomId가 없으므로 WebSocket 연결 없이 목록만 표시합니다.");
        return;
    }

    console.log("📌 roomId:", roomId);
    socket = new WebSocket('ws://localhost:8333/tt/chat/' + roomId);   // ✅ 여기에 할당
    //socket = new WebSocket('ws://192.168.20.49:8333/tt/chat/' + roomId);   // ✅ 여기에 할당

    socket.onopen = function () {
        console.log('✅ WebSocket 연결 성공 roomId:', roomId);
    };

    socket.onerror = function (error) {
        console.error("❌ WebSocket 연결 실패", error);
    };

    
    const chatInput = document.querySelector(".chat-input");
    const chatSendBtn = document.querySelector(".chat-send-btn");
    const chatMessages = document.querySelector(".chat-messages");

    chatSendBtn.addEventListener("click", function () {
        const msg = chatInput.value.trim();
        if (msg !== "") {
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

    chatInput.addEventListener("keydown", function (e) {
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault();
            chatSendBtn.click();
        }
    });

    socket.onmessage = function (event) {
        const data = JSON.parse(event.data);
        const type = data.sender === nickname ? "sent" : "received";
        appendMessage(data, type);
    };

    socket.onclose = function () {
        console.log('🔌 WebSocket 연결 종료됨');
    };
});

</script>

<!-- 채팅방 목록 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    fetch("/tt/chattingRoom/rooms")  // 🔁 백엔드에서 참여중인 채팅방 목록 호출
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



</script>

<!-- 이전채팅가져오기 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");

    console.log("내 번호:", myMemNo);

    fetch(`/tt/message/history?roomId=\${roomId}`)  // ✅ 백틱 사용 → 템플릿 리터럴
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


</script>

<!-- ------------------------------------------------------------------ -->
<!-- 채팅방 이름 채팅방 內 사용자 이름 변경 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");

    if (!roomId) return;

    fetch("/tt/chattingRoom/roomName?roomId=" + roomId)
        .then(response => response.text())
        .then(name => {
            document.querySelector("#chatRoomTitle").textContent = name;
        })
        .catch(err => {
            console.error("❌ 채팅방 이름 가져오기 실패:", err);
        });
});


document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId");

    fetch("/tt/chattingRoom/roomName?roomId=" + roomId)
        .then(response => response.text())
        .then(name => {
            const targetNameDom = document.querySelector("#targetNicknameArea");
            if (targetNameDom) {
                targetNameDom.textContent = name;
            }
        })
        .catch(err => {
            console.error("❌ People 상대방 닉네임 가져오기 실패", err);
        });
});


//==============================================================
	
const fileInput = document.getElementById("selectedFile");   // ✅ 이거 추가 필요
const fileSelectBtn = document.getElementById("fileSelectBtn");
	
fileSelectBtn.addEventListener("click", () => {
    fileInput.click();
});
	
fileInput.addEventListener("change", () => {
    const file = fileInput.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append("file", file);

    // ⭐ 선택 후 바로 fetch 하지 말고 → 살짝 딜레이 주기 (UI 안정화)
    setTimeout(() => {
        fetch('upload', {
            method: 'POST',
            body: formData
        })
        .then(result => result.json())
.then(data => {
    if (!data.imageUrl) {
        console.error("❌ 이미지 업로드 실패");
        return;
    }

    const fileUrl = data.imageUrl;
    const changeName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);

    const payload = {
        sender: nickname,
        text: file.name,          // ✅ 원본 파일명으로
        time: new Date().toISOString(),
        type: "file",
        file: {
            name: changeName,     // ✅ 변경된 파일명으로
            type: file.type,
            fileUrl: fileUrl
        }
    };

    console.log("보낼 데이터:", payload);
    socket.send(JSON.stringify(payload));
})
        .catch(err => {
            console.error("❌ 업로드 또는 전송 실패:", err);
        });
    }, 100);  // ⭐ 100ms 정도 딜레이 주면 UI 완전 안정화됨
});



</script>
<!-- ------------------------------------------------------------------ -->

</body>
</html>