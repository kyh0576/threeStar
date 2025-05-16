<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

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


    </style>

</head>
<body>

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


        <div class="message-list">
            
        </div>
    </div>

</body>
</html>