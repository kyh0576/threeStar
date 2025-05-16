<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThreeStar</title>
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
            width: 300px;
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

        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 15px;
            overflow: hidden;
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
            padding: 15px 20px;
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
            padding: 15px 20px;
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
    <div class="message-sidebar" >
        <div class="message-header">Messages</div>
        <div class="message-tabs">
            <div class="tab active">All</div>
            <div class="tab">Group</div>
        </div>
        <div class="message-list">
            <div class="message-item active">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=팀" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">집주인 첫째 딸</div>
                    <div class="message-preview">아 어디야</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/ff4a8c/ffffff?text=여" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">여자친구❤</div>
                    <div class="message-preview">어디야</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/8cff4a/000000?text=집" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">집주인</div>
                    <div class="message-preview">일마 오늘 맛있는거 사와</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/ff8c4a/ffffff?text=F" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">fire egg friend</div>
                    <div class="message-preview">야 근일님 ㄷㄷ ㄹㅇ</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/4aff8c/000000?text=GD" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">고명훈</div>
                    <div class="message-preview">일마 포샵 GD네 ㅋㅋ</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/8c4aff/ffffff?text=AI" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">스승님</div>
                    <div class="message-preview">아? 뭐 아? 하면 되는데 그걸 못해?</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=간" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">간성훈</div>
                    <div class="message-preview">내 위에 바보</div>
                </div>
            </div>
            <div class="message-item">
                <div class="profile-img">
                    <img src="https://via.placeholder.com/40/ffd700/000000?text=새" alt="프로필">
                </div>
                <div class="message-info">
                    <div class="message-name">세미 프로젝트 조</div>
                    <div class="message-preview">이효석 : 나는 원래 잘생겼...</div>
                </div>
            </div>
        </div>
    </div>

    <!-- 메인 콘텐츠 - 채팅 부분 -->
    <div class="main-content">
        <div class="chat-header">
            <div class="chat-profile">
                <div class="chat-profile-img">
                    <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=팀" alt="프로필">
                </div>
                <h3>집주인 첫째 딸</h3>
                <span style="margin-left: 10px; color: #888; font-size: 14px;">2 participants</span>
            </div>
            <div class="chat-actions">
                <button class="chat-action-btn">🔍</button>
                <button class="chat-action-btn" id="toggleRightSidebar">👥</button>
                <button class="chat-action-btn" id="toggleMenu">⋮</button>
            </div>
        </div>

        <div class="chat-messages">
            <div class="message-bubble received">
                <div>아 어디야</div>
                <div class="message-time">08:00</div>
            </div>
            
            <div class="message-bubble sent">
                <div>이거 어때? 밑에 브라켓과 담장 툴리 왜 망가남</div>
                <div class="chat-attachment">
                    <img src="https://via.placeholder.com/400x300/eee/888?text=가구+이미지" alt="가구 이미지">
                </div>
                <div class="message-time">1:12 PM</div>
            </div>
            
            <div class="message-bubble received">
                <div>너 연습돼 더 해야겠다. 저소스 혹시 못써니?</div>
                <div class="message-time">2:12 PM</div>
            </div>
            
            <div class="message-bubble sent">
                <div>그냥 갤러리 나눠지 괜찮, 이거나 고쳐봐봐</div>
                <div class="message-time">1:17 PM</div>
            </div>
            
            <div class="message-bubble received">
                <div>맞음레도 쉬버서 해야지 작식이 힘거니니아</div>
                <div class="message-time">2:12 PM</div>
            </div>
        </div>
        
        <div class="chat-input-container">
            <div class="chat-input-actions">
                <button class="chat-input-btn">➕</button>
                <button class="chat-input-btn">📎</button>
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
                <div>Member <span>2</span></div>
                <div class="section-toggle">^</div>
            </div>
            
            <div class="member-list">
                <div class="member-item">
                    <div class="profile-img">
                        <img src="https://via.placeholder.com/40/8c4aff/ffffff?text=서" alt="프로필">
                    </div>
                    <div class="member-info">
                        <div class="member-name">서동진</div>
                        <div class="member-status">온라인</div>
                    </div>
                </div>
                
                <div class="member-item">
                    <div class="profile-img">
                        <img src="https://via.placeholder.com/40/4a8cff/ffffff?text=팀" alt="프로필">
                    </div>
                    <div class="member-info">
                        <div class="member-name">집주인 첫째 딸</div>
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
                <div class="section-toggle">^</div>
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
                <div class="section-toggle">^</div>
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

</body>
</html>