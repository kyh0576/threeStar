<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>달력 및 일정 관리</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* 전체 컨테이너 */
.container {
    display: flex;
    height: 100vh;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 메인 콘텐츠 영역 */
.main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: 20px;
    background-color: #f9f9f9;
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
    min-height: 80px;
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
    width: 400px;
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
    width: 100%;
    padding: 8px;
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
</style>
</head>
<body>
    <div class="container">
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
    </div>
    
    <!-- 일정 추가 모달 -->
    <div class="modal" id="eventModal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">일정 추가</div>
                <button class="close-button" id="closeModal">&times;</button>
            </div>
            <form action="" class="modal-form" id="eventForm">
                <input type="hidden" id="calId" name="calId" value="${ calId }">
                <input type="hidden" id="calWriter" name="calWriter" value="${ memNo }">
                <div class="form-group">
                    <label for="eventTitle">일정 제목</label>
                    <input type="text" id="eventTitle" required>
                </div>
                <div class="form-group">
                    <label for="eventDate">날짜</label>
                    <input type="date" id="eventDate" required>
                </div>
                <div class="form-group">
                    <label for="eventDesc">설명</label>
                    <textarea id="eventDesc"></textarea>
                </div>
                <div class="button-group">
                    <button type="button" class="button button-secondary" id="cancelButton">취소</button>
                    <button type="submit" class="button button-primary">저장</button>
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
    let eventModal, closeModalButton, cancelButton, eventForm, eventDateInput;

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
        eventsContainer.dataset.date = dateString;
        dayCell.appendChild(eventsContainer);  // append 대신 appendChild 사용
        
        // 디버깅: 날짜 문자열 표시
        console.log("셀 생성:", dateString);
        
        // 클릭 이벤트 처리
        dayCell.addEventListener('click', function() {
            showAddEventModal(dateString);
        });
        
        return dayCell;
    }

    // 일정 표시 함수
    function displayEvents() {
        // 현재 이벤트 상태 로깅
        console.log("🧾 displayEvents에서 모든 이벤트 상태:", JSON.stringify(events));
        
        // 모든 날짜별 이벤트 컨테이너 가져오기
        const eventContainers = document.querySelectorAll('.events-container');
        
        // 각 컨테이너에 해당 날짜의 이벤트 표시
        eventContainers.forEach(container => {
            const dateString = container.dataset.date;
            const dateEvents = events[dateString] || [];
            
            console.log("📆", dateString, "→ 이벤트 수 :", dateEvents.length);
            
            // 컨테이너 초기화
            container.innerHTML = '';
            
            // 이벤트 표시
            dateEvents.forEach(event => {
                const eventElement = document.createElement('div');
                eventElement.className = 'event-item';
                eventElement.textContent = event.title;
                eventElement.title = event.description || event.title;
                container.appendChild(eventElement);  // append 대신 appendChild 사용
                
                // 디버깅: 추가된 이벤트 표시
                console.log("이벤트 추가됨 (DOM):", dateString, event.title);
            });
        });
    }

    // 일정 추가 모달 표시 함수
    function showAddEventModal(dateString) {
        // 모달이 존재하는지 확인
        if (!eventModal || !eventDateInput) {
            console.error("모달 DOM 요소를 찾을 수 없습니다!");
            return;
        }
        
        // 모달 열기
        eventModal.style.display = 'flex';
        
        // 날짜 필드 설정
        eventDateInput.value = dateString;
        
        // 이벤트 객체 데이터 초기화
        document.getElementById('eventTitle').value = '';
        document.getElementById('eventDesc').value = '';
    }

    // 일정 추가 함수
    function addEvent(event) {
        const dateString = event.date;

        // 날짜 문자열이 제대로 되어 있는지 확인
        if (!/^\d{4}-\d{2}-\d{2}$/.test(dateString)) {
            console.error("잘못된 날짜 형식입니다 (yyyy-mm-dd 이어야 함):", dateString);
            return;
        }

        // 유효한 날짜 객체인지 확인
        const dateObj = new Date(dateString);
        if (isNaN(dateObj.getTime())) {
            console.error("유효하지 않은 날짜입니다:", dateString);
            return;
        }

        // 올바른 yyyy-mm-dd 형식으로 변환
        const validDateString = dateObj.toISOString().slice(0, 10);

        // 이벤트 저장
        if (!events[validDateString]) {
            events[validDateString] = [];
        }
        events[validDateString].push({
            title: event.title,
            date: validDateString,
            description: event.description,
        });

        console.log("➕ 이벤트 추가됨:", validDateString, event.title);
        console.log("🧾 현재 이벤트 상태:", JSON.stringify(events));
        
        // 이벤트 표시 업데이트
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
            addEvent({ title: "신정", date: dateString, description: "신정" });
            addEvent({ title: "임시공휴일", date: dateString0, description: "임시공휴일" });
            addEvent({ title: "설날", date: dateString1, description: "설날" }); // 고정된 음력 날짜 예시
            addEvent({ title: "설날", date: dateString2, description: "설날" });
            addEvent({ title: "설날", date: dateString3, description: "설날" });
        }

        if (calendarMonth === 2) { // 3월
        	const dateString = yearStr + "-03-01";
        	const dateString1 = "2025-03-03";
            addEvent({ title: "삼일절", date: dateString, description: "삼일절" });
            addEvent({ title: "삼일절(대체공휴일)", date: dateString1, description: "삼일절(대체공휴일)" });
        }

        if (calendarMonth === 4) { // 5월
        	const dateString = yearStr + "-05-05";
        	const dateString1 = "2025-05-06";
            addEvent({ title: "어린이날", date: dateString, description: "어린이날" });
            addEvent({ title: "부처님오신날(대체공휴일)", date: dateString1, description: "부처님오신날(대체공휴일)" });
        }

        if (calendarMonth === 5) { // 6월
        	const dateString = yearStr + "-06-06";
        	const dateString1 = "2025-06-03";
            addEvent({ title: "현충일", date: dateString, description: "현충일" });
            addEvent({ title: "대통령 선거날", date: dateString1, description: "대통령 선거날" });
        }

        if (calendarMonth === 7) { // 8월
        	const dateString = yearStr + "-08-15";
            addEvent({ title: "광복절", date: dateString, description: "광복절" });
        }

        if (calendarMonth === 9) { // 10월
        	const dateString1 = yearStr + "-10-03";
        	const dateString2 = yearStr + "-10-09";
        	const dateString3 = "2025-10-05";
        	const dateString4 = "2025-10-06";
        	const dateString5 = "2025-10-07";
            addEvent({ title: "개천절", date: dateString1, description: "개천절" });
            addEvent({ title: "한글날", date: dateString2, description: "한글날" });
            addEvent({ title: "추석", date: dateString3, description: "추석" });
            addEvent({ title: "추석", date: dateString4, description: "추석" });
            addEvent({ title: "추석", date: dateString5, description: "추석" });
        }

        if (calendarMonth === 11) { // 12월
        	const dateString = yearStr + "-12-25";
            addEvent({ title: "성탄절", date: dateString, description: "성탄절" });
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
        window.addEventListener('click', function(event) {
            if (event.target === eventModal) {
                eventModal.style.display = 'none';
            }
        });
        
        // 이벤트 폼 제출
        eventForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const title = document.getElementById('eventTitle').value;
            const date = document.getElementById('eventDate').value;
            const description = document.getElementById('eventDesc').value;
            
            addEvent({
                title,
                date,
                description
            });
            
            eventModal.style.display = 'none';
        });
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
            eventDateInput = document.getElementById('eventDate');
            
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
  
</body>
</html>