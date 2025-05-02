<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메시지 갤러리</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
    } */

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
    }

    .gallery-header {
        padding: 20px;
        border-bottom: 1px solid #e1e1e1;
        display: flex;
        align-items: center;
    }

    .gallery-profile {
        display: flex;
        align-items: center;
    }

    .gallery-profile-img {
        width: 20px;
        height: 20px;
        border-radius: 50%;
        margin-right: 15px;
        overflow: hidden;
    }

    .gallery-profile-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .gallery-tabs {
        display: flex;
        margin-left: 20px;
        border-bottom: 1px solid #e1e1e1;
    }

    .gallery-tab {
        padding: 10px 20px;
        cursor: pointer;
        margin-right: 10px;
        position: relative;
    }

    .gallery-tab.active::after {
        content: '';
        position: absolute;
        bottom: -1px;
        left: 0;
        width: 100%;
        height: 2px;
        background-color: #4a8cff;
    }

    .gallery-count {
        margin-left: auto;
        color: #888;
    }

    .gallery-date {
        padding: 10px 20px;
        color: #666;
        font-size: 14px;
        border-bottom: 1px solid #e1e1e1;
    }

    .gallery-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 50px;
        padding: 20px;
        overflow-y: auto;
    }

    .gallery-item {
        width: 400px;
        height: 200px;
        position: relative;
        aspect-ratio: 1 / 1;
        overflow: hidden;
        border-radius: 4px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .gallery-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .file-info {
        position: absolute;
        bottom: 0;
        right: 0;
        background-color: white;
        padding: 10px;
        border-top-left-radius: 4px;
        font-size: 12px;
        border: 1px solid #e1e1e1;
    }

    .file-title {
        font-weight: bold;
        margin-bottom: 3px;
    }

    .file-size {
        color: #666;
    }
</style>
</head>
<body>
    <!-- 왼쪽 사이드바 -->
   <jsp:include page="/WEB-INF/views/common/mainMenu.jsp"/>

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

    <!-- <div class="message-sidebar">
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
    </div> -->

    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <div class="gallery-header">
            <div class="gallery-profile">
                <div class="gallery-profile-img">
                    <img src="https://via.placeholder.com/50/4a8cff/ffffff?text=팀" alt="프로필">
                </div>
                <h2>집주인 첫째 딸</h2>
            </div>
        </div>
        <div class="gallery-tabs">
            <div class="gallery-tab active">전체</div>
            <div class="gallery-tab">사진 / 동영상</div>
            <div class="gallery-tab">파일</div>
            <div class="gallery-count">8개</div>
        </div>
        <div class="gallery-date">2025 - 04</div>
        <div class="gallery-grid">
            <!-- 갤러리 아이템 1 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/eeeeee/888888?text=Image" alt="이미지">
            </div>
            <!-- 갤러리 아이템 2 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/ffefef/888888?text=Image+2" alt="이미지">
                
            </div>
            <!-- 갤러리 아이템 3 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/eeeeee/888888?text=Image" alt="이미지">
                <div class="file-info">
                    <div class="file-title">파일명 프로젝트 기획 및 요구사항 보고서</div>
                    <div class="file-size">2.8MB</div>
                </div>
            </div>
            <!-- 갤러리 아이템 4 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/ffefef/888888?text=Image+2" alt="이미지">
                
            </div>
            <!-- 갤러리 아이템 5 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/eeeeee/888888?text=Image" alt="이미지">
            </div>
            <!-- 갤러리 아이템 6 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/ffefef/888888?text=Image+2" alt="이미지">
                <div class="file-info">
                    <div class="file-title">파일명 프로젝트 기획 및 요구사항 보고서</div>
                    <div class="file-size">2.8MB</div>            
                </div>
            </div>
            <!-- 갤러리 아이템 7 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/ddffee/888888?text=Image+3" alt="이미지">
            </div>
            <!-- 갤러리 아이템 8 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/f0e0ff/888888?text=Image+4" alt="이미지">
            </div>
            <!-- 갤러리 아이템 9 -->
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300/ffeedd/888888?text=Image+5" alt="이미지">
                <div class="file-info">
                    <div class="file-title">파일명 프로젝트 기획 및 요구사항 보고서</div>
                    <div class="file-size">2.8MB</div>
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

            const galleryTabs = document.querySelectorAll('.gallery-tab');
            galleryTabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    galleryTabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // 메시지 항목 클릭 이벤트
            const messageItems = document.querySelectorAll('.message-item');
            messageItems.forEach(item => {
                item.addEventListener('click', function() {
                    messageItems.forEach(i => i.classList.remove('active'));
                    this.classList.add('active');
                    
                    // 여기에 메시지 선택 시 갤러리 로드 기능을 추가할 수 있습니다
                    const name = this.querySelector('.message-name').textContent;
                    document.querySelector('.gallery-profile h2').textContent = name;
                });
            });
        });
    </script>
</body>
</html>