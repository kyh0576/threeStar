<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>ThreeStar</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href='${pageContext.request.contextPath}/resources/fullcalendar-5.11.2/lib/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/fullcalendar-5.11.2/lib/main.js'></script>
<script type='text/javascript'>
document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    googleCalendarApiKey: '',
	    eventSources: [
	    	{
	          googleCalendarId: '',
	          className: '',
	          color: '#be5683', //rgb,#ffffff 등의 형식으로 할 수 있어요.
	          //textColor: 'black' 
	        },
	      	{
	          googleCalendarId: '36ad56166746205d9569611709811b82c8bd37e4c7f6651924505c694531e4fd@group.calendar.google.com',
	          className: '',
	            color: '#204051',
	            //textColor: 'black'
	        }
	    ]
	  });
	  calendar.render();
	});
	</script>
<!-- JS: 알림 토글 -->
<script>
    function toggleAlert(el) {
        const icon = el.querySelector('i');
        const isOn = icon.classList.contains('fa-bell');
        icon.classList.toggle('fa-bell');
        icon.classList.toggle('fa-bell-slash');

       
    }
</script>

<!-- modal 1 -->
<script>
	// 부모 페이지의 JavaScript
	function openProfileModal(memId) {
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
	    modalIframe.src = "/tt/profileCheck.do";
	    modalIframe.style.cssText = `
	        width: 600px;
	        height: 666px;
	        border: none;
	        border-radius: 10px;
	        // background: transparent;
	    `;
	    
	    // 모달 컨테이너에 iframe 추가
	    modalContainer.append(modalIframe);
	    
	    // body에 모달 컨테이너 추가
	    document.body.append(modalContainer);
	    
	    // 모달 외부 클릭 시 닫기
	    modalContainer.addEventListener('click', function(event) {
	    	const closeButton = document.getElementById('cancelBtn');
	        if (event.target === modalContainer || event.target === closeButton) {
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
	
	// 프로필 요소에 클릭 이벤트 추가
	document.addEventListener('DOMContentLoaded', function() {
	    const profileElements = document.querySelectorAll('.modalId');
	    .0
	    profileElements.forEach(function(element) {
	        element.addEventListener('click', function() {
	            const memId = this.getAttribute('MEM_ID');
	            openProfileModal(memId);
	        });
	    });
	});
</script> 	
<style>
.sidebar {
    width: 95px;
    height: 100vh;
    background-color: white;
    border-right: 1px solid #e1e1e1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    padding: 20px 0;
}

.sidebar-logo {
  display: flex;
    flex-direction: column;
    align-items: center;
    gap: 25px;
    width: 100%;
}


.sidebar-menu {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 25px;
    width: 100%;
}

.menu-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    padding: 10px 0;
    color: #888;
    font-size: 12px;
    text-decoration: none;
}

.menu-item.active {
    color: #4a8cff;
}

.menu-icon {
    font-size: 24px;
    margin-bottom: 5px;
}

.sidebar-footer {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 15px;
    padding-bottom: 20px;
}

.sidebar-footer .modalId{
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 15px;
    padding-bottom: 20px;
    text-decoration: none;
    cursor: pointer;
}

.profile-img-me {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #4a8cff;
}

.logout-icon,
.alert-icon {
    color: #555;
    transition: transform 0.2s ease, color 0.2s ease;
    cursor: pointer;
}

.logout-icon:hover,
.alert-icon:hover {
    color: #4a8cff;
    transform: scale(1.2);
}

#calendar{
   width:60%;
   margin:20px auto;
}
</style>
  </head>
  <body>
  	<div style="display: flex;">
  		<jsp:include page="/WEB-INF/views/calendar/googleMain.jsp" />
  		
  		<div style="flex-grow: 1;">
    		<div id='calendar'></div>
    	</div>
    </div>
  </body>  
</html>
