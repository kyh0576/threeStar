<%@page import="com.kh.tt.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
           width: 320px; /* 기존 300px보다 살짝 넓게 */
           background-color: white;
           border-right: 1px solid #e1e1e1;
           display: flex;
           flex-direction: column;
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
    

	/* 메인 콘텐츠 영역 */
	.main-content {
		flex-grow: 1;
		display: flex;
		flex-direction: column;
		overflow: hidden;
	    position: relative;
	}
	
	/* 갤러리 헤더 */
	.gallery-header {
		display: flex;
		padding: 8px 20px 8px 20px;
		border-bottom: 1px solid #e1e1e1;
		align-items: center;
		background-color: white;
	}
	
	.gallery-profile {
	    display: flex;
	    align-items: center;
	}
	
	.gallery-profile-img {
	    width: 50px;
	    height: 50px;
	    border-radius: 50%;
	    overflow: hidden;
	    margin-right: 15px;
	}
	
	.gallery-profile-img img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	
	.gallery-profile h3 {
		display: block;
	    font-size: 1.17em;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    font-weight: bold;
	    unicode-bidi: isolate;
	}
	
	/* 갤러리 탭 */
	.gallery-tabs {
	    display: flex;
	    margin-bottom: 20px;
	    border-bottom: 1px solid #e0e0e0;
	    position: relative;
	}
	
	.gallery-tab {
	    padding: 10px 20px;
	    margin-right: 10px;
	    cursor: pointer;
	    font-weight: 500;
	    color: #777;
	    transition: all 0.3s ease;
	}
	
	.gallery-tab.active {
	    color: #4a8cff;
	    border-bottom: 2px solid #4a8cff;
	}
	
	.gallery-count {
	    position: absolute;
	    right: 0;
	    padding: 10px;
	    color: #777;
	}
	
	/* 날짜 구분선 */
	.gallery-date {
	    font-size: 14px;
	    color: #777;
	    margin: 20px 0 10px;
	    padding-bottom: 5px;
	    border-bottom: 1px solid #eee;
	}
	
	/* 갤러리 그리드 */
	.gallery-grid {
	    display: grid;
	    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	    gap: 20px;
	    padding-bottom: 40px;
	}
	
	/* 갤러리 아이템 */
	.gallery-item {
	    background-color: #fff;
	    border-radius: 8px;
	    overflow: hidden;
	    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
	    cursor: pointer;
	    transition: transform 0.2s ease, box-shadow 0.2s ease;
	}
	
	.gallery-item:hover {
	    transform: translateY(-5px);
	    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
	}
	
	.gallery-item img {
	    width: 100%;
	    height: 150px;
	    object-fit: cover;
	}
	
	.gallery-thumbnail {
	    width: 100%;
	    height: 120px;
	    object-fit: cover;
	    border-radius: 8px;
	    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
	}
	
	.file-icon {
	    width: 100%;
	    height: 120px;
	    background-color: #f4f4f4;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    font-size: 48px;
	    color: #777;
	    border-radius: 8px;
	}
	
	.file-info {
	    padding: 10px;
	}
	
	.file-title {
	    font-size: 14px;
	    font-weight: 500;
	    color: #333;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	}
	
	.file-size, .file-date {
	    font-size: 12px;
	    color: #999;
	    margin-top: 5px;
	}
	
	/* 이미지 미리보기 모달 */
	.image-preview-modal {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.7);
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    z-index: 1000;
	}
	
	.image-preview-container {
	    position: relative;
	    max-width: 90%;
	    max-height: 90%;
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 8px;
	}
	
	.preview-close {
	    position: absolute;
	    top: 10px;
	    right: 10px;
	    background: none;
	    border: none;
	    font-size: 24px;
	    cursor: pointer;
	    color: #333;
	}
	
	.preview-title {
	    margin-top: 0;
	    margin-bottom: 15px;
	    padding-bottom: 10px;
	    border-bottom: 1px solid #eee;
	}
	
	.preview-image {
	    max-width: 100%;
	    max-height: 70vh;
	    display: block;
	    margin: 0 auto;
	}
	
	/* 파일이 없을 때 메시지 */
	.no-files {
	    grid-column: 1 / -1;
	    text-align: center;
	    padding: 50px;
	    color: #999;
	}
</style>
</head>
<body>
    <!-- 왼쪽 사이드바 -->
   <jsp:include page="/WEB-INF/views/common/mainMenu.jsp"/>

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

    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <div class="gallery-header">
            <div class="gallery-profile">
                <div class="gallery-profile-img">
                    <img src="https://via.placeholder.com/50/4a8cff/ffffff?text=파일" alt="프로필">
                </div>
                <h3>파일 보관함</h3>
            </div>
        </div>
        <div class="gallery-tabs">
            <div class="gallery-tab active" data-type="all">전체</div>
            <div class="gallery-tab" data-type="image">사진 / 동영상</div>
            <div class="gallery-tab" data-type="document">파일</div>
            <div class="gallery-count"><c:out value="${list.size()}"/>개</div>
        </div>
        
        <div class="gallery-grid">
            <c:if test="${empty list}">
                <div class="no-files">
                    <p>등록된 파일이 없습니다.</p>
                </div>
            </c:if>
            
            <c:if test="${not empty list}">
                <c:forEach var="file" items="${list}">
                    <div class="gallery-item" data-file-type="${file.fileType}">
                        <c:choose>
                            <c:when test="${file.fileType.startsWith('image/')}">
                                <img class="gallery-thumbnail" src="${pageContext.request.contextPath}/resources/uploadFiles/${file.changeName}" alt="${file.originName}">
                            </c:when>
                            <c:otherwise>
                                <div class="file-icon">
                                    <i class="fas fa-file"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="file-info">
                            <div class="file-title">${file.originName}</div>
                            <div class="file-date"><fmt:formatDate value="${file.sendTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/js/drawer.js"></script>
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
	
	<script>
	<!-- 채팅방 목록 -->
	document.addEventListener("DOMContentLoaded", function () {
	    fetch("${pageContext.request.contextPath}/chattingRoom/rooms")  // 🔁 백엔드에서 참여중인 채팅방 목록 호출
	        .then(response => response.json())
	        .then(rooms => {
	            const list = document.querySelector(".message-list");
	
	            list.innerHTML = rooms.map(room => `
	            <div class="message-item" onclick="location.href='${pageContext.request.contextPath}/drawerSelect.do?roomId=\${room.chatId}'">
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
</body>
    
	<script>
		$(document).ready(function() {
		    // 탭 전환 기능
		    $('.gallery-tab').click(function() {
		        // 활성 탭 변경
		        $('.gallery-tab').removeClass('active');
		        $(this).addClass('active');
		        
		        const fileType = $(this).data('type');
		        
		        // 탭에 따른 파일 필터링
		        if (fileType === 'all') {
		            // 모든 아이템 표시
		            $('.gallery-item').show();
		        } else if (fileType === 'image') {
		            // 이미지/동영상만 표시
		            $('.gallery-item').hide();
		            $('.gallery-item[data-file-type^="image/"], .gallery-item[data-file-type^="video/"]').show();
		        } else if (fileType === 'document') {
		            // 문서 파일만 표시
		            $('.gallery-item').hide();
		            $('.gallery-item:not([data-file-type^="image/"]):not([data-file-type^="video/"])').show();
		        }
		        
		        // 카운트 업데이트
		        updateFileCount();
		    });
		    
		    // 파일 아이템 클릭 시 상세 보기
		    $('.gallery-item').click(function() {
		        const fileName = $(this).find('.file-title').text();
		        const fileType = $(this).data('file-type');
		        const filePath = $(this).find('img').attr('src');
		        
		        if (fileType && fileType.startsWith('image/')) {
		            // 이미지 파일 미리보기
		            openImagePreview(filePath, fileName);
		        } else {
		            // 파일 다운로드
		            window.location.href = 'fileDownload.do?fileName=' + encodeURIComponent($(this).find('.file-title').text());
		        }
		    });
		    
		    // 이미지 미리보기 모달 닫기
		    $(document).on('click', '.preview-close', function() {
		        $('#imagePreviewModal').remove();
		    });
		    
		    // 초기 파일 개수 설정
		    updateFileCount();
		    
		    // 새 채팅 버튼 기능
		    $('#newChat').click(function() {
		        $('#inviteModal').toggle();
		    });
		    
		    // 모달 닫기 버튼
		    $('#closeModalBtn').click(function() {
		        $('#inviteModal').hide();
		    });
		});
		
		// 파일 개수 업데이트 함수
		function updateFileCount() {
		    const visibleFiles = $('.gallery-item:visible').length;
		    $('.gallery-count').text(visibleFiles + '개');
		}
		
		// 이미지 미리보기 함수
		function openImagePreview(imageSrc, imageTitle) {
		    // 기존 모달 제거
		    $('#imagePreviewModal').remove();
		    
		    // 새 모달 생성
		    const modal = $('<div id="imagePreviewModal" class="image-preview-modal"></div>');
		    const container = $('<div class="image-preview-container"></div>');
		    
		    // 닫기 버튼
		    const closeBtn = $('<button class="preview-close">✕</button>');
		    
		    // 이미지 제목
		    const title = $('<h3 class="preview-title"></h3>').text(imageTitle);
		    
		    // 이미지
		    const image = $('<img class="preview-image">').attr('src', imageSrc);
		    
		    // 모달에 요소 추가
		    container.append(closeBtn, title, image);
		    modal.append(container);
		    
		    // 모달을 body에 추가
		    $('body').append(modal);
		}
	</script>

</html>