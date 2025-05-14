<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>달력 및 일정 관리</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

/* 메인 콘텐츠 영역 */
.main-content {
    flex-glow: 1;
    padding: 30px;
    overflow: auto;
    width: calc(100% - 280px); /* 사이드바 폭뺀만큼 */
}

/* 헤더 스타일 */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 20px;
    border-bottom: 1px solid #e0e0e0;
    margin-bottom: 20px;
}

.logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.logo-icon {
    margin-right: 10px;
}

.search-bar {
    display: flex;
    align-items: center;
    background-color: white;
    border-radius: 20px;
    padding: 5px 15px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.search-icon {
    margin-right: 10px;
}

.search-bar input {
    border: none;
    outline: none;
    padding: 8px;
    font-size: 14px;
}

/* 캘린더 헤더 */      
.calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.year-month {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.calendar-nav {
    display: flex;
    gap: 10px;
}

.nav-button {
    background-color: #f0f0f0;
    border: none;
    border-radius: 5px;
    padding: 5px 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.nav-button:hover {
    background-color: #e0e0e0;
}

.today-button {
    background-color: #4a89dc;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 5px 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.today-button:hover {
    background-color: #3a70c0;
}

/* 캘린더 그리드 */
.calendar-grid {
    flex: 1;
    display: flex;
    flex-direction: column;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    overflow: hidden;
}

.weekdays {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    background-color: #f0f0f0;
    border-bottom: 1px solid #e0e0e0;
}

.weekday {
    padding: 10px;
    text-align: center;
    font-weight: bold;
    color: #555;
}

.weekday:nth-child(7) {  /* 토요일 */
    color: blue;
}

.weekday:nth-child(1) {  /* 일요일 */
    color: red;
}

/* 날짜 셀 내 숫자 색상 */
.calendar-days .day-cell:nth-child(7n) .day-number {  /* 토요일 */
    color: blue;
}

.calendar-days .day-cell:nth-child(7n+1) .day-number {  /* 일요일 */
    color: red;
}

.calendar-days {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    grid-template-rows: repeat(6, 1fr);
    flex: 1;
}

.day-cell {
    border: 1px solid #e0e0e0;
    padding: 8px;
    min-weight: 120px;
    min-height: 120px;
    position: relative;
    cursor: pointer;
    transition: background-color 0.2s;
}

.day-cell:hover {
    background-color: #f5f5f5;
}

.day-number {
    font-weight: bold;
    margin-bottom: 5px;
}

.other-month {
    color: #aaa;
    background-color: #f9f9f9;
}

.today {
    background-color: #e6f0fd;
    border-radius: 10%;
}

.current-day {
    background-color: #4a89dc;
    font-weight: bold;
    color: white;
    border-radius: 50%;
    width: 25px;
    height: 25px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 이벤트 스타일 */
.events-container {
    display: flex;
    flex-direction: column;
    gap: 2px;
    margin-top: 5px;
}

.event-item {
    font-size: 11px;
    padding: 2px 4px;
    background-color: #4a89dc;
    color: white;
    border-radius: 3px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* 모달 */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0,0,0,0.5);
    z-index: 1000;
    justify-content: center;
    align-items: center;
}

.modal-content {
    background-color: white;
    border-radius: 10px;
    width: 500px;
    max-width: 90%;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    border-bottom: 1px solid #e0e0e0;
}

.modal-title {
    font-size: 18px;
    font-weight: bold;
}

.close-button {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #555;
}

.modal-form {
    padding: 20px;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

.form-group input, .form-group textarea {
    width: 90%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.form-group textarea {
    height: 100px;
    resize: vertical;
}

.button-group {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
}

.button {
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}

.button-primary {
    background-color: #4a89dc;
    color: white;
}

.button-secondary {
    background-color: #f0f0f0;
    color: #333;
}

/* DB 이벤트와 기본 이벤트 스타일 구분 */
.event-item.from-db {
    background-color: #4a89dc;
    color: white;
}

/* 기존 스타일은 그대로 유지 */

.button-danger {
    background-color: #ff3b30;
    color: white;
}

.button-danger:hover {
    background-color: #ff453a;
}

</style>
</head>
<body>
    <!-- 사이드바 -->
	<jsp:include page="/WEB-INF/views/common/mainMenu.jsp"/>
        
    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <!-- 헤더 -->
        <div class="header">
            <div class="logo">
                <span class="logo-icon">📅</span> 티캘린더
            </div>
        </div>
        
        <!-- 캘린더 헤더 -->
        <div class="calendar-header">
            <div class="year-month" id="calendarYearMonth"></div>
            <div class="calendar-nav">
                <button class="nav-button" id="prevMonth">◀</button>
                <button class="nav-button" id="nextMonth">▶</button>
                <button class="today-button" id="todayButton">오늘</button>
            </div>
        </div>
        
        <!-- 캘린더 그리드 -->
        <div class="calendar-grid">
            <div class="weekdays">
                <div class="weekday">일</div>
                <div class="weekday">월</div>
                <div class="weekday">화</div>
                <div class="weekday">수</div>
                <div class="weekday">목</div>
                <div class="weekday">금</div>
                <div class="weekday">토</div>
            </div>
            <div class="calendar-days" id="calendarDays">
                <!-- 여기에 JavaScript로 날짜가 생성됩니다 -->
            </div>
        </div>
    </div>
    
    <!-- 일정 추가 모달 -->
    <div class="modal" id="eventModal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">일정 추가</div>
                <button class="close-button" id="closeModal">&times;</button>
            </div>
            <form action="" class="modal-form" id="eventForm" method="POST">
            	<div>
            		<input type="hidden" id="eventCalId" name="calId" value="${ calendar.calId }">
            	</div>
                <div class="form-group">
                    <label for="eventTitle">일정 제목</label>
                    <input type="text" id="eventTitle" name="calTitle" required>
                </div>
                <div class="form-group">
				    <label for="eventStartDate">시작 날짜</label>
				    <input type="date" id="eventStartDate" name="calStart" required>
				</div>
				<div class="form-group">
				    <label for="eventEndDate">종료 날짜</label>
				    <input type="date" id="eventEndDate" name="calEnd" required>
				</div>
                <div class="form-group">
                    <label for="eventDesc">설명</label>
                    <input type="text" id="eventDesc" name="calContent" required>
                </div>
                <div class="button-group">
                	<button type="submit" class="button button-primary">저장</button>
                    <button type="button" class="button button-secondary" id="cancelButton">취소</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
 // 현재 날짜 정보 - 전역 변수로 분명하게 설정
    let today = new Date();
    let calendarMonth = today.getMonth();
    let calendarYear = today.getFullYear();

    // 디버깅용 - 전역 변수 확인
    console.log("🌍 전역 변수 초기화 - 현재 연도:", calendarYear, "현재 월:", calendarMonth);

    // 모든 일정을 저장할 객체
    let events = {};

    // 월 이름
    const monthNames = ["1월", "2월", "3월", "4월", "5월", "6월",
                       "7월", "8월", "9월", "10월", "11월", "12월"];

    // 요일 이름
    const weekdays = ["일", "월", "화", "수", "목", "금", "토"];

    // DOM 요소를 위한 전역 변수
    let calendarDays, calendarYearMonthElement, prevMonthButton, nextMonthButton, todayButton;
    let eventModal, closeModalButton, cancelButton, eventForm, eventStartDateInput, eventEndDateInput;

    // 윤년 확인 함수
    function isLeapYear(year) {
        return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
    }

    // 월별 일수 계산 함수
    function getDaysInMonth(year, month) {
        // 31일인 월: 1, 3, 5, 7, 8, 10, 12
        if ([0, 2, 4, 6, 7, 9, 11].includes(month)) {
            return 31;
        } 
        // 30일인 월: 4, 6, 9, 11
        else if ([3, 5, 8, 10].includes(month)) {
            return 30;
        } 
        // 2월: 윤년이면 29일, 아니면 28일
        else {
            return isLeapYear(year) ? 29 : 28;
        }
    }

 // 날짜 형식 변환 함수 (yyyy-mm-dd)
	function formatDate(date) {
	  if (!date) return '';
	  const yyyy = date.getFullYear();
	  const mm = String(date.getMonth() + 1).padStart(2, '0');
	  const dd = String(date.getDate()).padStart(2, '0');
	  return `${yyyy}-${mm}-${dd}`;
	}

 // 두 날짜 사이의 모든 날짜를 배열로 반환하는 함수
	function getDatesInRange(start, end) {
	  console.log("📅 getDatesInRange 호출됨 - start:", start, "end:", end);
	
	  const date = new Date(start);
	  const dates = [];
	
	  while (date <= end) {
	    const formatted = formatDate(date);
	    console.log("📆 formatDate 결과:", formatted);
	    dates.push(formatted);
	    date.setDate(date.getDate() + 1);
	  }
	
	  return dates;
	}

    // 캘린더 렌더링 함수
    function renderCalendar() {
        // DOM 요소가 있는지 확인
        if (!calendarDays || !calendarYearMonthElement) {
            console.error("캘린더 DOM 요소를 찾을 수 없습니다!");
            return;
        }
        
        // 현재 연도와 월 표시 - 명시적 문자열 변환 추가
        try {
            let yearStr = String(calendarYear);
            let monthStr = monthNames[calendarMonth];
            console.log("렌더링 시도: ", yearStr, monthStr);
            calendarYearMonthElement.textContent = yearStr + "년 " + monthStr;
        } catch (e) {
            console.error("연도/월 표시 오류:", e);
        }
        
        // 캘린더 초기화
        calendarDays.innerHTML = '';
        
        console.log("🧩 renderCalendar", calendarYear, calendarMonth);

        // 해당 월의 첫 날
        const firstDay = new Date(calendarYear, calendarMonth, 1);
        // 해당 월의 마지막 날
        const lastDay = new Date(calendarYear, calendarMonth, getDaysInMonth(calendarYear, calendarMonth));
        
        // 이전 달의 날짜 표시
        const firstDayOfWeek = firstDay.getDay();
        if (firstDayOfWeek > 0) {
            const prevMonthLastDate = new Date(calendarYear, calendarMonth, 0).getDate();
            for (let i = 0; i < firstDayOfWeek; i++) {
                const dayNumber = prevMonthLastDate - firstDayOfWeek + i + 1;
                const prevMonthYear = calendarMonth === 0 ? calendarYear - 1 : calendarYear;
                const prevMonth = calendarMonth === 0 ? 11 : calendarMonth - 1;
                const dateString = prevMonthYear + '-' + 
                                  (prevMonth + 1 < 10 ? '0' + (prevMonth + 1) : prevMonth + 1) + '-' + 
                                  (dayNumber < 10 ? '0' + dayNumber : dayNumber);
                const dayCell = createDayCell(dayNumber, true, dateString);
                calendarDays.appendChild(dayCell);  // append 대신 appendChild 사용
                
                console.log("📌 이전 달 날짜 셀 생성 - dayNumber:", dayNumber, "→ dateString:", dateString);
            }
        }
        
         // 현재 달의 날짜 표시
        for (let i = 1; i <= getDaysInMonth(calendarYear, calendarMonth); i++) {
            const dateString = calendarYear + '-' + 
                              (calendarMonth + 1 < 10 ? '0' + (calendarMonth + 1) : calendarMonth + 1) + '-' + 
                              (i < 10 ? '0' + i : i);
            const isToday = i === today.getDate() && calendarMonth === today.getMonth() && calendarYear === today.getFullYear();
            const dayCell = createDayCell(i, false, dateString, isToday);
            calendarDays.appendChild(dayCell);  // append 대신 appendChild 사용
        }

        // 다음 달의 날짜 표시
        const lastDayOfWeek = lastDay.getDay();
        if (lastDayOfWeek < 6) {
            for (let i = 1; i <= 6 - lastDayOfWeek; i++) {
                const nextMonthYear = calendarMonth === 11 ? calendarYear + 1 : calendarYear;
                const nextMonth = calendarMonth === 11 ? 0 : calendarMonth + 1;
                const dateString = nextMonthYear + '-' + 
                                 (nextMonth + 1 < 10 ? '0' + (nextMonth + 1) : nextMonth + 1) + '-' + 
                                 (i < 10 ? '0' + i : i);
                const dayCell = createDayCell(i, true, dateString);
                calendarDays.appendChild(dayCell);  // append 대신 appendChild 사용
            }
        }
        
        // 기본 일정 추가
        addDefaultEvents();
        
        // 날짜 이동 후 이벤트 다시 표시
        displayEvents();
    }

 // 날짜 셀 생성 함수
    function createDayCell(day, isOtherMonth, dateString, isToday = false) {
        const dayCell = document.createElement('div');
        dayCell.className = 'day-cell';
        if (isOtherMonth) {
            dayCell.classList.add('other-month');
        }
        if (isToday) {
            dayCell.classList.add('today');
        }
        
        const dayNumber = document.createElement('div');
        dayNumber.className = 'day-number';
        dayNumber.textContent = day;
        
        if (isToday) {
            dayNumber.classList.add('current-day');
        }
        
        dayCell.appendChild(dayNumber);  // append 대신 appendChild 사용
        
        // 이벤트 컨테이너 추가
        const eventsContainer = document.createElement('div');
        eventsContainer.className = 'events-container';
        
        // 날짜 문자열이 유효한지 확인
        if (dateString && dateString !== 'undefined') {
        	console.log("✔️ 유효한 날짜 문자열:", dateString);
            eventsContainer.dataset.date = dateString;
        } else {
            console.error("❌ 잘못된 날짜 문자열:", dateString);
        }
        
        dayCell.appendChild(eventsContainer);  // append 대신 appendChild 사용
        
        // 클릭 이벤트 처리
        dayCell.addEventListener('click', function() {
            // 날짜 문자열 확인
            if (dateString && dateString !== 'undefined') {
                showAddEventModal(dateString);
                console.log("🆑 유효한 클릭 이벤트 문자열: ", dateString);
            } else {
                console.error("클릭된 셀에 유효한 날짜가 없습니다");
            }
        });
        
        return dayCell;
    }

 // 1. 먼저 기존 displayEvents 함수를 수정하여 event-item에 클릭 이벤트를 추가합니다
    function displayEvents() {
        // 현재 이벤트 상태 로깅
        console.log("🧾 displayEvents에서 모든 이벤트 상태:", JSON.stringify(events, null, 2));
        
        // 모든 날짜별 이벤트 컨테이너 가져오기
        const eventContainers = document.querySelectorAll('.events-container');
        console.log(`🔍 이벤트 컨테이너 수: ${eventContainers.length}`);
        
        // 각 컨테이너에 해당 날짜의 이벤트 표시
        eventContainers.forEach(container => {
            const dateString = container.dataset.date;
            console.log(`🔎 컨테이너 날짜 확인: "${dateString}"`);
            
            if (!dateString || dateString === "undefined") {
                console.error("❌ 날짜 문자열이 없거나 undefined:", container);
                return;
            }
            
            // 해당 날짜의 이벤트 가져오기
            const dateEvents = events[dateString] || [];
            
            console.log(`📆 "${dateString}" → 이벤트 수: ${dateEvents.length}`);
            
            // 컨테이너 초기화
            container.innerHTML = '';
            
            // 이벤트 표시
            dateEvents.forEach(event => {
                const eventElement = document.createElement('div');
                eventElement.className = 'event-item';
                
                // DB에서 온 이벤트인 경우 추가 클래스 적용
                if (event.fromDB) {
                    eventElement.classList.add('from-db');
                }
                
                // 다중 날짜 이벤트 표시 스타일 적용
                if (event.isMultiDay) {
                    eventElement.classList.add('multi-day-event');
                    
                    // 시작일, 종료일에 특별 클래스 추가
                    if (dateString === event.startDate) {
                        eventElement.classList.add('event-start');
                    } else if (dateString === event.endDate) {
                        eventElement.classList.add('event-end');
                    } else {
                        eventElement.classList.add('event-middle');
                    }
                }
                
                eventElement.textContent = event.title;
                eventElement.title = `${event.title}\n${event.startDate}${event.endDate !== event.startDate ? ' ~ ' + event.endDate : ''}\n${event.description || ''}`;
                
                // 여기에 클릭 이벤트 추가 - 수정 모달을 열기 위한 부분
                eventElement.addEventListener('click', function(e) {
                    e.stopPropagation(); // 부모 요소(날짜 셀)의 클릭 이벤트가 발생하지 않도록 함
                    showEditEventModal(event);
                });
                
                container.appendChild(eventElement);
                
                // 디버깅: 추가된 이벤트 표시
                console.log("이벤트 추가됨 (DOM):", dateString, event.title);
            });
        });

        // 이벤트 키값 확인을 위한 추가 로깅
        console.log("💫 events 객체의 모든 키:");
        for (const dateKey in events) {
            console.log(`- "${dateKey}" (${typeof dateKey}): ${events[dateKey].length}개 이벤트`);
        }
    }

 // 2. 일정 수정 모달을 표시하는 함수 추가
    function showEditEventModal(event) {
        // 모달 오픈
        
        // 수정 모드 플래그 설정
        eventForm.dataset.mode = 'edit';
        
        // 모달이 존재하는지 확인
        if (!eventModal || !eventStartDateInput || !eventEndDateInput) {
            console.error("모달 DOM 요소를 찾을 수 없습니다!");
            return;
        }
        
        // 모달 타이틀 변경
        document.querySelector('.modal-title').textContent = '일정 수정';
        
        // 모달 열기
        eventModal.style.display = 'flex';
        
        // 이벤트 데이터로 폼 필드 채우기
        document.getElementById('eventTitle').value = event.title || '';
        document.getElementById('eventStartDate').value = event.startDate || '';
        document.getElementById('eventEndDate').value = event.endDate || event.startDate || '';
        document.getElementById('eventDesc').value = event.description || '';
        document.getElementById('eventCalId').value = event.calId || '';
        
        // calId가 있으면 hidden 필드에 저장 (폼 제출 시 사용)
        if (!document.getElementById('eventCalId')) {
            const hiddenField = document.createElement('input');
            hiddenField.type = 'hidden';
            hiddenField.id = 'eventCalId';
            hiddenField.name = 'calId';
            eventForm.appendChild(hiddenField);
        }
        document.getElementById('eventCalId').value = event.calId || '';
        
        // 삭제 버튼 추가 (없으면)
        if (!document.getElementById('deleteButton')) {
            const deleteBtn = document.createElement('button');
            deleteBtn.type = 'button';
            deleteBtn.id = 'deleteButton';
            deleteBtn.className = 'button button-danger';
            deleteBtn.textContent = '삭제';
            document.querySelector('.button-group').appendChild(deleteBtn);
            
            // 삭제 버튼 이벤트 리스너
            deleteBtn.addEventListener('click', function() {
                if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
                    deleteEvent(event);
                }
            });
        } else {
            // 이미 버튼이 있으면 보이게 설정
            document.getElementById('deleteButton').style.display = 'inline-block';
        }
    }
 
 // 3. 일정 추가 모달 표시 함수 수정 (모드 구분 추가)
    function showAddEventModal(dateString) {
        // 추가 모드 플래그 설정
        eventForm.dataset.mode = 'add';
	 	
        // 모달이 존재하는지 확인
        if (!eventModal || !eventStartDateInput || !eventEndDateInput) {
            console.error("모달 DOM 요소를 찾을 수 없습니다!");
            return;
        }
        
        // 모달 타이틀 변경
        document.querySelector('.modal-title').textContent = '일정 추가';
        
        // 모달 열기
        eventModal.style.display = 'flex';
        
        // 날짜 필드 설정 (시작일과 종료일을 클릭한 날짜로 초기화)
        eventStartDateInput.value = dateString;
        eventEndDateInput.value = dateString;
        
        // 이벤트 객체 데이터 초기화
        document.getElementById('eventTitle').value = '';
        document.getElementById('eventDesc').value = '';
        
        // calId 초기화
        if (document.getElementById('eventCalId')) {
            document.getElementById('eventCalId').value = '';
        }
        
        // 삭제 버튼 숨기기 (있으면)
        if (document.getElementById('deleteButton')) {
            document.getElementById('deleteButton').style.display = 'none';
        }
    }
    
    function addEvent(event) {
        console.log("📂 현재 events 상태:", JSON.stringify(events, null, 2));

        const startDate = event.startDate;
        const endDate = event.endDate ? event.endDate : event.startDate;

        if (!/^\d{4}-\d{2}-\d{2}$/.test(startDate) || !/^\d{4}-\d{2}-\d{2}$/.test(endDate)) {
            console.error("날짜 형식이 올바르지 않습니다:", startDate, endDate);
            return;
        }

        const start = new Date(startDate);
        const end = new Date(endDate);

        // 🔁 복사본을 써야 원본이 안 망가짐
        const loopDate = new Date(start);

        while (loopDate <= end) {
            const dateString = formatDate(loopDate);
            const container = document.querySelector(`.events-container[data-date="${dateString}"]`);
            if (container) {
                const eventDiv = document.createElement("div");
                eventDiv.classList.add("event");
                eventDiv.textContent = event.title;

                eventDiv.addEventListener("click", function () {
                    openEventModal(dateString, event);
                });

                container.appendChild(eventDiv);
                console.log("✅ 이벤트 추가됨 (DOM):", dateString, event.title);
            }
            loopDate.setDate(loopDate.getDate() + 1); // 🔁 복사본만 수정
        }

        // ✅ 원본 start, end를 그대로 사용 가능
        const rangeDates = getDatesInRange(start, end);
        rangeDates.forEach(date => {
            if (!events[date]) events[date] = [];
            events[date].push({ ...event, isMultiDay: startDate !== endDate });
        });

        displayEvents();
    }
    
    // 기본 일정 데이터 추가
    function addDefaultEvents() {
        // 디버깅: calendarYear 값 확인
        console.log("🔍 addDefaultEvents 내부 - calendarYear:", calendarYear, "calendarMonth:", calendarMonth);
        // 현재 월의 공휴일 또는 특별한 날 추가
        console.log("📌 addDefaultEvents:", calendarYear, calendarMonth);    

        if (typeof calendarYear === 'undefined' || calendarYear === null) {
            console.error("⚠️ calendarYear가 정의되지 않았습니다. 현재 날짜를 사용합니다.");
            calendarYear = new Date().getFullYear();
        }

        // 중복 방지를 위한 기본 이벤트 목록
        const defaultEvents = [
            "신정", "임시공휴일", "설날", "삼일절", "삼일절(대체공휴일)", "어린이날", "부처님오신날(대체공휴일)",
            "현충일", "대통령 선거날", "광복절", "개천절", "한글날", "추석", "성탄절"
        ];

        // 기존 기본 이벤트 제거
        for (const dateKey in events) {
            events[dateKey] = events[dateKey].filter(event => !defaultEvents.includes(event.title));
        }

        const yearStr = String(calendarYear);

        // 각 월별로 공휴일 조건에 따라 추가
        if (calendarMonth === 0) { // 1월
            const dateString = yearStr + "-01-01";
            const dateString0 = "2025-01-27";
            const dateString1 = "2025-01-28";
            const dateString2 = "2025-01-29";
            const dateString3 = "2025-01-30";
            addEvent({ title: "신정", startDate: dateString, description: "신정" });
            addEvent({ title: "임시공휴일", startDate: dateString0, description: "임시공휴일" });
            addEvent({ 
                title: "설날", 
                startDate: dateString1, 
                endDate: dateString3, 
                description: "설날" 
            });
        }

        if (calendarMonth === 2) { // 3월
            const dateString = yearStr + "-03-01";
            const dateString1 = "2025-03-03";
            addEvent({ title: "삼일절", startDate: dateString, description: "삼일절" });
            addEvent({ title: "삼일절(대체공휴일)", startDate: dateString1, description: "삼일절(대체공휴일)" });
        }

        if (calendarMonth === 4) { // 5월
            const dateString = yearStr + "-05-05";
            const dateString1 = "2025-05-06";
            addEvent({ title: "어린이날", startDate: dateString, description: "어린이날" });
            addEvent({ title: "부처님오신날(대체공휴일)", startDate: dateString1, description: "부처님오신날(대체공휴일)" });
        }

        if (calendarMonth === 5) { // 6월
            const dateString = yearStr + "-06-06";
            const dateString1 = "2025-06-03";
            addEvent({ title: "현충일", startDate: dateString, description: "현충일" });
            addEvent({ title: "대통령 선거날", startDate: dateString1, description: "대통령 선거날" });
        }

        if (calendarMonth === 7) { // 8월
            const dateString = yearStr + "-08-15";
            addEvent({ title: "광복절", startDate: dateString, description: "광복절" });
        }

        if (calendarMonth === 9) { // 10월
            const dateString1 = yearStr + "-10-03";
            const dateString2 = yearStr + "-10-09";
            const dateString3 = "2025-10-05";
            const dateString5 = "2025-10-07";
            addEvent({ title: "개천절", startDate: dateString1, description: "개천절" });
            addEvent({ title: "한글날", startDate: dateString2, description: "한글날" });
            addEvent({ 
                title: "추석", 
                startDate: dateString3, 
                endDate: dateString5,
                description: "추석" 
            });
        }

        if (calendarMonth === 11) { // 12월
            const dateString = yearStr + "-12-25";
            addEvent({ title: "성탄절", startDate: dateString, description: "성탄절" });
        }
    }

    // 이벤트 리스너 설정
    function setupEventListeners() {
        // DOM 요소가 있는지 확인
        if (!prevMonthButton || !nextMonthButton || !todayButton || 
            !closeModalButton || !cancelButton || !eventForm) {
            console.error("버튼 또는 폼 DOM 요소를 찾을 수 없습니다!");
            return;
        }
        
        // 이전 달 버튼
        prevMonthButton.addEventListener('click', function() {
            calendarMonth--;
            if (calendarMonth < 0) {
                calendarMonth = 11;
                calendarYear--;
            }
            renderCalendar();
        });
        
        // 다음 달 버튼
        nextMonthButton.addEventListener('click', function() {
            calendarMonth++;
            if (calendarMonth > 11) {
                calendarMonth = 0;
                calendarYear++;
            }
            renderCalendar();
        });
        
        // 오늘 버튼
        todayButton.addEventListener('click', function() {
            calendarMonth = today.getMonth();
            calendarYear = today.getFullYear();
            renderCalendar();
        });
        
        // 모달 닫기 버튼
        closeModalButton.addEventListener('click', function() {
            eventModal.style.display = 'none';
        });
        
        // 취소 버튼
        cancelButton.addEventListener('click', function() {
            eventModal.style.display = 'none';
        });
        
        // 배경 클릭시 모달 닫기
        //window.addEventListener('click', function(event) {
        //    if (event.target === eventModal) {
        //        eventModal.style.display = 'none';
        //    }
        //});
        
	     // 4. 폼 제출 이벤트 핸들러 수정
	     // 이벤트 리스너 설정 함수 내의 eventForm.addEventListener 부분을 대체
	     eventForm.addEventListener('submit', function(e) {
	         e.preventDefault(); // 기본 제출 동작 방지
	         
	         // 폼 데이터 가져오기
	         const title = document.getElementById('eventTitle').value.trim();
	         const startDate = document.getElementById('eventStartDate').value.trim();
	         const endDate = document.getElementById('eventEndDate').value.trim();
	         const description = document.getElementById('eventDesc').value.trim();
	         const calId = document.getElementById('eventCalId') ? document.getElementById('eventCalId').value : '';
	         
	         // 입력값 검증
	         if (title === '' || startDate === '') {
	             alert('제목과 날짜는 필수 입력 항목입니다.');
	             return;
	         }
	         
	         // 새 이벤트 객체 생성
	         const eventData = {
	             title: title,
	             startDate: startDate,
	             endDate: endDate || startDate,
	             description: description
	         };
	         
	         // 추가 또는 수정 모드 확인
	         const isEditMode = eventForm.dataset.mode === 'edit' && calId;
	         
	         if (isEditMode) {
	             // 기존 이벤트 제거
	             removeEventFromCalendar(calId);
	             
	             // 수정된 이벤트 추가 (서버 전송 전에 로컬에 먼저 반영)
	             eventData.calId = calId;
	             eventData.fromDB = true;
	             addEvent(eventData);
	             
	             // 서버로 수정 요청 전송
	             $.ajax({
	                 url: '/threeStar/calendar/update.do',
	                 method: 'POST',
	                 data: {
	                     calId: calId,
	                     calTitle: title,
	                     calStart: startDate,
	                     calEnd: endDate || startDate,
	                     calContent: description
	                 },
	                 success: function(response) {
	                     console.log("일정이 성공적으로 수정되었습니다:", response);
	                     alert('일정이 수정되었습니다.');
	                     location.reload();
	                 },
	                 error: function(xhr, status, error) {
	                     console.error("일정 수정 실패:", error);
	                     alert('일정 수정에 실패했습니다. 다시 시도해주세요.');
	                 }
	             });
	         } else {
	             // 로컬 캘린더에 추가
	             addEvent(eventData);
	             
	             // 서버로 추가 요청 전송
	             $.ajax({
	                 url: '/threeStar/calendar.do',
	                 method: 'POST',
	                 data: {
	                     calTitle: title,
	                     calStart: startDate,
	                     calEnd: endDate || startDate,
	                     calContent: description
	                 },
	                 success: function(response) {
	                     console.log("이벤트가 DB에 성공적으로 저장되었습니다:", response);
	                     alert('일정이 저장되었습니다.');
	                     location.reload();
	                 },
	                 error: function(xhr, status, error) {
	                     console.error("일정 저장 실패:", error);
	                     alert('일정 저장에 실패했습니다. 다시 시도해주세요.');
	                 }
	             });
	         }
	         
	         // 모달 닫기
	         eventModal.style.display = 'none';
	     });
        
        // 시작일 변경 시 종료일 최소 날짜 설정
        document.getElementById('eventStartDate').addEventListener('change', function() {
            document.getElementById('eventEndDate').min = this.value;
            // 만약 현재 종료일이 시작일보다 이전이라면 종료일을 시작일과 같게 설정
            if (document.getElementById('eventEndDate').value < this.value) {
                document.getElementById('eventEndDate').value = this.value;
            }
        });
    }
    
 // 5. 일정 삭제 함수 추가
    function deleteEvent(event) {
        if (!event || !event.calId) {
            console.error("삭제할 일정 정보가 유효하지 않습니다.");
            return;
        }
        
        // 로컬 캘린더에서 이벤트 제거
        removeEventFromCalendar(event.calId);
        
        // 서버에 삭제 요청 전송
        $.ajax({
            url: '/threeStar/calendar/delete.do',
            method: 'POST',
            data: { calId: event.calId },
            success: function(response) {
                console.log("일정이 성공적으로 삭제되었습니다:", response);
                alert('일정이 삭제되었습니다.');
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("일정 삭제 실패:", error);
                alert('일정 삭제에 실패했습니다. 다시 시도해주세요.');
            }
        });
        
        // 모달 닫기
        eventModal.style.display = 'none';
    }
 
 // 6. 캘린더에서 이벤트 제거 함수
    function removeEventFromCalendar(calId) {
        // calId로 events 객체에서 해당 이벤트 찾아 제거
        for (const dateKey in events) {
            events[dateKey] = events[dateKey].filter(event => {
                return !(event.calId && event.calId == calId);
            });
        }
        
        // 캘린더 표시 갱신
        displayEvents();
    }

    // 페이지 초기화 함수
    function init() {
        console.log("🌟 init 실행됨!");
        
        try {
            // 전역 변수 초기화 확인
            console.log("init 내부 - calendarYear:", calendarYear, "calendarMonth:", calendarMonth);
            
            // DOM 참조
            calendarDays = document.getElementById('calendarDays');
            calendarYearMonthElement = document.getElementById('calendarYearMonth');
            prevMonthButton = document.getElementById('prevMonth');
            nextMonthButton = document.getElementById('nextMonth');
            todayButton = document.getElementById('todayButton');
            eventModal = document.getElementById('eventModal');
            closeModalButton = document.getElementById('closeModal');
            cancelButton = document.getElementById('cancelButton');
            eventForm = document.getElementById('eventForm');
            eventStartDateInput = document.getElementById('eventStartDate');
            eventEndDateInput = document.getElementById('eventEndDate');
              
            // DOM 요소 확인 및 디버깅
            console.log("calendarDays:", calendarDays ? "OK" : "Missing");
            console.log("calendarYearMonthElement:", calendarYearMonthElement ? "OK" : "Missing");
            
            // DOM 요소가 모두 있는지 확인
            if (!calendarDays || !calendarYearMonthElement) {
                console.error("캘린더 필수 DOM 요소를 찾을 수 없습니다!");
                return;
            }
            
            // 이벤트 리스너 설정
            setupEventListeners();
            
            // 캘린더 렌더링
            renderCalendar();
            
            // DB 데이터가 이미 페이지에 있다면 사용
            if (typeof dbEvents !== 'undefined' && dbEvents) {
                console.log("JSP에서 전달받은 일정 데이터 활용");
                addEventsFromDB(dbEvents);
            } else {
                // 없으면 서버에서 데이터 불러오기
                console.log("서버에서 일정 데이터 불러오기");
                loadEventsFromServer();
            }
            
        } catch (e) {
            console.error("초기화 중 오류 발생:", e);
        }
    }

    // 페이지 로드 완료 후 초기화
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        // DOMContentLoaded가 이미 발생했다면 바로 초기화
        init();
    }
    </script>
    

    <script>
    javascript// 서버에서 일정 데이터를 불러오는 Ajax 함수
    function loadEventsFromServer() {
        fetch('/threeStar/calendar/getEvents.do')
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 응답 오류: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log("서버에서 불러온 일정 데이터:", data);
                addEventsFromDB(data);
            })
            .catch(error => {
                console.error("일정을 불러오는 중 오류 발생:", error);
            });
    }
    
    // DB에서 가져온 일정 데이터를 캘린더에 추가하는 함수
    function addEventsFromDB(eventsData) {
        if (!eventsData || !Array.isArray(eventsData)) {
            console.error("유효한 일정 데이터가 아닙니다:", eventsData);
            return;
        }
        
        // 기존 DB 이벤트를 제거 (중복 방지)
        for (const dateKey in events) {
            events[dateKey] = events[dateKey].filter(event => !event.fromDB);
        }
        
        // 새 DB 이벤트 추가
        eventsData.forEach(event => {
            // DB 형식에 맞게 데이터 구조 변환
            const formattedEvent = {
                title: event.calTitle || '제목 없음',
                startDate: formatDateFromDB(event.calStart),
                endDate: formatDateFromDB(event.calEnd),
                description: event.calContent || '',
                fromDB: true, // DB에서 온 이벤트 표시
                calId: event.calId // DB ID 저장 (수정/삭제 위함)
            };
            
            // 유효성 검사
            if (!formattedEvent.startDate) {
                console.error("일정의 시작일이 유효하지 않습니다:", event);
                return;
            }
            
            // 이벤트 추가
            try {
                addEvent(formattedEvent);
                console.log("DB 일정 추가됨:", formattedEvent.title, formattedEvent.startDate);
            } catch (e) {
                console.error("DB 일정 추가 중 오류:", e);
            }
        });
        
        // 캘린더에 일정 표시 갱신
        displayEvents();
    }
	
    // DB에서 가져온 날짜 형식을 'YYYY-MM-DD' 형식으로 변환
    function formatDateFromDB(dateStr) {
        if (!dateStr) return '';
        
        // DB에서 가져온 날짜가 어떤 형식인지에 따라 처리
        try {
            if (typeof dateStr === 'string') {
                // ISO 형식(예: "2025-05-15T00:00:00.000Z") 또는 다른 문자열 형식 처리
                const date = new Date(dateStr);
                if (isNaN(date.getTime())) {
                    throw new Error("유효하지 않은 날짜");
                }
                return formatDate(date);
            } else if (dateStr instanceof Date) {
                return formatDate(dateStr);
            }
        } catch (e) {
            console.error("날짜 변환 오류:", e, dateStr);
        }
        return '';
    }
	</script>

</body>
</html>