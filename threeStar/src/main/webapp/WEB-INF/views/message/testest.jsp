<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ThreeStar</title>
    <style>
        #chatBox { height: 300px; border: 1px solid #ccc; overflow-y: auto; margin-bottom: 10px; padding: 10px; }
        #messageInput { width: 80%; padding: 5px; }
        #sendButton { padding: 5px 10px; }
    </style>
</head>
<body>
    <h2>WebSocket 채팅 테스트</h2>
    <div id="chatBox"></div>
    <input type="text" id="messageInput" placeholder="메시지 입력...">
    <button id="sendButton">전송</button>

   <script>
document.addEventListener("DOMContentLoaded", function() {
    // URL에서 roomId 파라미터 가져오기 (없으면 기본값 사용)
    const urlParams = new URLSearchParams(window.location.search);
    const roomId = urlParams.get("roomId") || "default";
    
    // 서버 정보 설정
    const serverIP = "192.168.20.49";
    const serverPort = "8333";
    const token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbmEiLCJtZW1ObyI6MSwibWVtTmFtZSI6Iuq0gOumrOyekCJ9.GrFjymLAjAiEyIZYnRX7uSU5TRSu6bcs9GvBgHxCOX4";
    const encodedToken = encodeURIComponent(token);
    
    // 웹소켓 URL 구성
    const wsUrl = `ws://${serverIP}:${serverPort}/tt/chat/${roomId}?token=${encodedToken}`;
    console.log("연결 시도 URL:", wsUrl);
    
    // 웹소켓 연결
    let socket = new WebSocket(wsUrl);
    
    // 연결 이벤트 처리
    socket.onopen = function() {
        console.log("✅ 웹소켓 연결 성공!");
        displayStatus("서버에 연결되었습니다", "success");
        
        // 연결 확인 메시지 전송
        const connectMsg = {
            type: "connect",
            sender: "사용자",
            text: "채팅방에 입장했습니다.",
            time: new Date().toISOString()
        };
        socket.send(JSON.stringify(connectMsg));
    };
    
    // 에러 처리
    socket.onerror = function(error) {
        console.error("❌ 웹소켓 에러:", error);
        displayStatus("연결 중 오류가 발생했습니다", "error");
    };
    
    // 연결 종료 처리
    socket.onclose = function(event) {
        console.log("🔌 웹소켓 연결 종료:", event.code, event.reason);
        displayStatus("서버와의 연결이 종료되었습니다", "warning");
    };
    
    // 메시지 수신 처리
    socket.onmessage = function(event) {
        console.log("📩 메시지 수신:", event.data);
        try {
            const data = JSON.parse(event.data);
            displayMessage(data);
        } catch (e) {
            console.error("메시지 처리 오류:", e);
            displayStatus("메시지 처리 중 오류가 발생했습니다", "error");
        }
    };
    
    // 메시지 전송 버튼 이벤트 연결
    const sendButton = document.querySelector(".chat-send-btn");
    if (sendButton) {
        sendButton.addEventListener("click", sendMessage);
    }
    
    // 입력창 엔터키 이벤트 연결
    const chatInput = document.querySelector(".chat-input");
    if (chatInput) {
        chatInput.addEventListener("keydown", function(e) {
            if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    }
    
    // 메시지 전송 함수
    function sendMessage() {
        const chatInput = document.querySelector(".chat-input");
        if (!chatInput) return;
        
        const message = chatInput.value.trim();
        if (!message) return;
        
        if (socket.readyState === WebSocket.OPEN) {
            const payload = {
                type: "chat",
                sender: "사용자", // 실제 사용자 이름이나 닉네임으로 변경
                text: message,
                time: new Date().toISOString()
            };
            
            socket.send(JSON.stringify(payload));
            chatInput.value = "";
            
            // 내가 보낸 메시지 즉시 표시 (선택사항)
            displayMessage({
                sender: "사용자",
                text: message,
                time: new Date().toISOString(),
                isSelf: true
            });
        } else {
            displayStatus("서버에 연결되어 있지 않습니다. 페이지를 새로고침해 주세요.", "error");
        }
    }
    
    // 메시지 화면에 표시 함수
    function displayMessage(data) {
        const chatContainer = document.querySelector(".chat-messages");
        if (!chatContainer) {
            console.error("메시지를 표시할 컨테이너를 찾을 수 없습니다.");
            return;
        }
        
        const messageDiv = document.createElement("div");
        messageDiv.className = data.isSelf || data.sender === "사용자" ? "chat-message sent" : "chat-message received";
        
        const senderSpan = document.createElement("span");
        senderSpan.className = "message-sender";
        senderSpan.textContent = data.sender;
        
        const contentDiv = document.createElement("div");
        contentDiv.className = "message-content";
        contentDiv.textContent = data.text;
        
        const timeDiv = document.createElement("div");
        timeDiv.className = "message-time";
        timeDiv.textContent = new Date(data.time).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        
        messageDiv.appendChild(senderSpan);
        messageDiv.appendChild(contentDiv);
        messageDiv.appendChild(timeDiv);
        
        chatContainer.appendChild(messageDiv);
        chatContainer.scrollTop = chatContainer.scrollHeight;
    }
    
    // 상태 메시지 표시 함수
    function displayStatus(message, type) {
        const chatContainer = document.querySelector(".chat-messages");
        if (!chatContainer) return;
        
        const statusDiv = document.createElement("div");
        statusDiv.className = `chat-status ${type}`;
        statusDiv.textContent = message;
        
        chatContainer.appendChild(statusDiv);
        chatContainer.scrollTop = chatContainer.scrollHeight;
    }
});
</script>

</body>
</html>
