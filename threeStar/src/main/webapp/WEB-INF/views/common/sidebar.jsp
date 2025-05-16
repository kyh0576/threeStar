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
    
    
    <script>
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
  	      // =========1:1 채팅==========
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
  	      // =========그룹 채팅========
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
    </script>

</body>
</html>