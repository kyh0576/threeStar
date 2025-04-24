<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>달력 및 일정 관리</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        
        .container {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .sidebar {
            width: 250px;
            background-color: #f9f9f9;
            border-right: 1px solid #eaeaea;
            padding: 20px;
        }
        
        .main-content {
            flex: 1;
            padding: 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px 0;
            border-bottom: 1px solid #eaeaea;
        }
        
        .logo {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
        
        .logo-icon {
            margin-right: 8px;
            color: #007bff;
            font-size: 28px;
        }
        
        .search-bar {
            display: flex;
            align-items: center;
            background: #f5f5f5;
            border-radius: 20px;
            padding: 5px 15px;
            width: 300px;
            border: 1px solid #ddd;
        }
        
        .search-bar input {
            border: none;
            background: transparent;
            flex: 1;
            padding: 8px;
            outline: none;
        }
        
        .search-icon {
            margin-right: 8px;
            color: #777;
        }
        
        .user-profile {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #ddd;
            overflow: hidden;
        }
        
        .user-profile img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .year-month {
            font-size: 28px;
            font-weight: bold;
        }
        
        .calendar-nav {
            display: flex;
            align-items: center;
        }
        
        .nav-button {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            margin: 0 5px;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }
        
        .nav-button:hover {
            background-color: #f0f0f0;
        }
        
        .today-button {
            background-color: #f0f0f0;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
        }
        
        .today-button:hover {
            background-color: #e0e0e0;
        }
        
        .calendar-view-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .tab-button {
            background: none;
            border: 1px solid #ddd;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .tab-button.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        
        .calendar-grid {
            width: 100%;
        }
        
        .weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            text-align: center;
            font-weight: bold;
            margin-bottom: 10px;
            color: #666;
        }
        
        .weekday {
            padding: 10px;
            font-size: 14px;
        }
        
        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 10px;
        }
        
        .day-cell {
            border: 1px solid #eaeaea;
            min-height: 100px;
            padding: 8px;
            position: relative;
        }
        
        .day-cell.other-month {
            background-color: #f9f9f9;
            color: #aaa;
        }
        
        .day-number {
            position: absolute;
            top: 8px;
            left: 8px;
            width: 25px;
            height: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            border-radius: 50%;
        }
        
        .current-day .day-number {
            background-color: #007bff;
            color: white;
        }
        
        .today {
            background-color: #e6f7ff;
        }
        
        .events-container {
            margin-top: 30px;
        }
        
        .event {
            background-color: #e6f7ff;
            border-left: 3px solid #007bff;
            padding: 5px 8px;
            margin-bottom: 5px;
            font-size: 12px;
            border-radius: 3px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            cursor: pointer;
        }
        
        .event.holiday {
            background-color: #d4edda;
            border-left-color: #28a745;
        }
        
        .event.important {
            background-color: #f8d7da;
            border-left-color: #dc3545;
        }
        
        .sidebar-section {
            margin-bottom: 20px;
        }
        
        .sidebar-title {
            font-weight: bold;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        
        .sidebar-icon {
            margin-right: 8px;
            width: 16px;
            height: 16px;
        }
        
        .sidebar-list {
            list-style-type: none;
        }
        
        .sidebar-list li {
            padding: 8px 0;
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        
        .sidebar-list li:hover {
            color: #007bff;
        }
        
        .sidebar-list li:before {
            content: "●";
            margin-right: 10px;
            font-size: 8px;
            color: #777;
        }
        
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .modal-title {
            font-size: 18px;
            font-weight: bold;
        }
        
        .close-button {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: #777;
        }
        
        .modal-form {
            display: flex;
            flex-direction: column;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        
        .color-options {
            display: flex;
            gap: 10px;
        }
        
        .color-option {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .color-option.selected {
            border-color: #333;
        }
        
        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }
        
        .button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .button-primary {
            background-color: #007bff;
            color: white;
        }
        
        .button-secondary {
            background-color: #f0f0f0;
            color: #333;
        }
        
        .button-danger {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 사이드바 -->
        <div class="sidebar">
            <div class="sidebar-section">
                <div class="sidebar-title">
                    <span class="sidebar-icon">📅</span> 캘린더
                </div>
                <ul class="sidebar-list">
                    <li>월별 일정표</li>
                    <li>할 일 일정표</li>
                </ul>
            </div>
            
            <div class="sidebar-section">
                <div class="sidebar-title">
                    <span class="sidebar-icon">🔖</span> 일정 선택 목록
                </div>
                <ul class="sidebar-list">
                    <li>내 일정</li>
                    <li>가족일정</li>
                    <li>직장일정1 일정</li>
                    <li>직장일정2 일정</li>
                    <li>직장일정3 일정</li>
                </ul>
            </div>
            
            <div class="sidebar-section">
                <div class="sidebar-title">
                    <span class="sidebar-icon">👥</span> 기념일
                </div>
                <ul class="sidebar-list">
                    <li>대한민국 기념일</li>
                    <li>내 기념일</li>
                    <li>친구 기념일</li>
                    <li>직장일정1 기념일</li>
                </ul>
            </div>
            
            <div class="sidebar-section">
                <div class="sidebar-title">
                    <span class="sidebar-icon">⚙️</span> 설정
                </div>
            </div>
        </div>
        
        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <!-- 헤더 -->
            <div class="header">
                <div class="logo">
                    <span class="logo-icon">📅</span> 티캘린더
                </div>
                <div class="search-bar">
                    <span class="search-icon">🔍</span>
                    <input type="text" placeholder="일정 검색">
                </div>
                <div class="user-profile">
                    <img src="/api/placeholder/40/40" alt="사용자 프로필">
                </div>
            </div>
            
            <!-- 캘린더 탭 -->
            <div class="calendar-view-tabs">
                <button class="tab-button">일별 일정표</button>
                <button class="tab-button active">월별 일정표</button>
            </div>
            
            <!-- 캘린더 헤더 -->
            <div class="calendar-header">
                <div class="year-month" id="currentYearMonth"></div>
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
            <form class="modal-form" id="eventForm">
                <div class="form-group">
                    <label for="eventTitle">일정 제목</label>
                    <input type="text" id="eventTitle" required>
                </div>
                <div class="form-group">
                    <label for="eventDate">날짜</label>
                    <input type="date" id="eventDate" required>
                </div>
                <div class="form-group">
                    <label for="eventCategory">카테고리</label>
                    <select id="eventCategory">
                        <option value="default">기본 일정</option>
                        <option value="holiday">휴일</option>
                        <option value="important">중요 일정</option>
                    </select>
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
        // 현재 날짜 정보
        let today = new Date();
        let currentMonth = today.getMonth();
        let currentYear = today.getFullYear();
        
        // 모든 일정을 저장할 객체
        let events = {};
        
        // 월 이름
        const monthNames = ["1월", "2월", "3월", "4월", "5월", "6월",
                           "7월", "8월", "9월", "10월", "11월", "12월"];
        
        // 요일 이름
        const weekdays = ["일", "월", "화", "수", "목", "금", "토"];
        
        // DOM 요소
        const calendarDays = document.getElementById('calendarDays');
        const currentYearMonthElement = document.getElementById('currentYearMonth');
        const prevMonthButton = document.getElementById('prevMonth');
        const nextMonthButton = document.getElementById('nextMonth');
        const todayButton = document.getElementById('todayButton');
        const eventModal = document.getElementById('eventModal');
        const closeModalButton = document.getElementById('closeModal');
        const cancelButton = document.getElementById('cancelButton');
        const eventForm = document.getElementById('eventForm');
        const eventDateInput = document.getElementById('eventDate');
        
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
            // 현재 연도와 월 표시
            currentYearMonthElement.textContent = `${currentYear}년 ${monthNames[currentMonth]}`;
            
            // 캘린더 초기화
            calendarDays.innerHTML = '';
            
            // 해당 월의 첫 날
            const firstDay = new Date(currentYear, currentMonth, 1);
            // 해당 월의 마지막 날
            const lastDay = new Date(currentYear, currentMonth, getDaysInMonth(currentYear, currentMonth));
            
            // 이전 달의 날짜 표시
            const firstDayOfWeek = firstDay.getDay();
            if (firstDayOfWeek > 0) {
                const prevMonthLastDate = new Date(currentYear, currentMonth, 0).getDate();
                for (let i = 0; i < firstDayOfWeek; i++) {
                    const dayNumber = prevMonthLastDate - firstDayOfWeek + i + 1;
                    const prevMonthYear = currentMonth === 0 ? currentYear - 1 : currentYear;
                    const prevMonth = currentMonth === 0 ? 11 : currentMonth - 1;
                    const dateString = `${prevMonthYear}-${String(prevMonth + 1).padStart(2, '0')}-${String(dayNumber).padStart(2, '0')}`;
                    const dayCell = createDayCell(dayNumber, true, `${prevMonthYear}-${String(prevMonth + 1).padStart(2, '0')}-${String(dayNumber).padStart(2, '0')}`);
                    calendarDays.appendChild(dayCell);
                }
            }
            
            // 현재 달의 날짜 표시
            for (let i = 1; i <= getDaysInMonth(currentYear, currentMonth); i++) {
                const dateString = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(i).padStart(2, '0')}`;
                const isToday = i === today.getDate() && currentMonth === today.getMonth() && currentYear === today.getFullYear();
                const dayCell = createDayCell(i, false, dateString, isToday);
                calendarDays.appendChild(dayCell);
            }
            
            // 다음 달의 날짜 표시
            const lastDayOfWeek = lastDay.getDay();
            if (lastDayOfWeek < 6) {
                for (let i = 1; i <= 6 - lastDayOfWeek; i++) {
                    const nextMonthYear = currentMonth === 11 ? currentYear + 1 : currentYear;
                    const nextMonth = currentMonth === 11 ? 0 : currentMonth + 1;
                    const dateString = `${nextMonthYear}-${String(nextMonth + 1).padStart(2, '0')}-${String(i).padStart(2, '0')}`;
                    const dayCell = createDayCell(i, true, dateString);
                    calendarDays.appendChild(dayCell);
                }
            }
            
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
            
            dayCell.appendChild(dayNumber);
            
            // 이벤트 컨테이너 추가
            const eventsContainer = document.createElement('div');
            eventsContainer.className = 'events-container';
            eventsContainer.dataset.date = dateString;
            dayCell.appendChild(eventsContainer);
            
            // 클릭 이벤트 처리
            dayCell.addEventListener('click', function() {
                showAddEventModal(dateString);
            });
            
            return dayCell;
        }
        
        // 일정 표시 함수
        function displayEvents() {
            // 모든 날짜별 이벤트 컨테이너 가져오기
            const eventContainers = document.querySelectorAll('.events-container');
            
            // 각 컨테이너에 해당 날짜의 이벤트 표시
            eventContainers.forEach(container => {
                const dateString = container.dataset.date;
                const dateEvents = events[dateString] || [];
                
                // 컨테이너 초기화
                container.innerHTML = '';
                
                // 이벤트 표시
                dateEvents.forEach(event => {
                    const eventElement = document.createElement('div');
                    eventElement.className = `event ${event.category}`;
                    eventElement.textContent = event.title;
                    eventElement.title = event.description || event.title;
                    container.appendChild(eventElement);
                });
            });
        }
        
        // 일정 추가 모달 표시 함수
        function showAddEventModal(dateString) {
            // 모달 열기
            eventModal.style.display = 'flex';
            
            // 날짜 필드 설정
            eventDateInput.value = dateString;
            
            // 이벤트 객체 데이터 초기화
            document.getElementById('eventTitle').value = '';
            document.getElementById('eventCategory').value = 'default';
            document.getElementById('eventDesc').value = '';
        }
        
        // 일정 추가 함수
        function addEvent(event) {
            const dateString = event.date;
            
            // 해당 날짜의 이벤트 배열이 없으면 생성
            if (!events[dateString]) {
                events[dateString] = [];
            }
            
            // 이벤트 추가
            events[dateString].push(event);
            
            // 이벤트 표시 업데이트
            displayEvents();
        }
        
        // 기본 일정 데이터 추가
        function addDefaultEvents() {
            // 현재 월의 공휴일 또는 특별한 날 추가
            const thisYear = today.getFullYear();
            const thisMonth = today.getMonth();
            
            // 어린이날
            if (thisMonth === 4) { // 5월
                addEvent({
                    title: "어린이날",
                    date: `${thisYear}-05-05`,
                    category: "holiday",
                    description: "어린이날 공휴일"
                });
            }
            
            // 설날 (음력 기준이라 실제로는 더 복잡)
            // 이 예제에서는 간단히 처리
            if (thisMonth === 1) { // 2월
                addEvent({
                    title: "설날",
                    date: `${thisYear}-02-10`, // 예시: 2월 10일이라고 가정
                    category: "holiday",
                    description: "설날 연휴"
                });
            }
            
            // 추석 (음력 기준)
            if (thisMonth === 8) { // 9월
                addEvent({
                    title: "추석",
                    date: `${thisYear}-09-15`, // 예시: 9월 15일이라고 가정
                    category: "holiday",
                    description: "추석 연휴"
                });
            }
            
            // 더미 일정 몇 개 추가
            const currentMonthStr = String(currentMonth + 1).padStart(2, '0');
            
            // 더미 회의 일정
            addEvent({
                title: "팀 회의",
                date: `${currentYear}-${currentMonthStr}-09`,
                category: "default",
                description: "주간 팀 회의"
            });
            
            // 더미 생일 일정
            addEvent({
                title: "성태 생일",
                date: `${currentYear}-${currentMonthStr}-12`,
                category: "important",
                description: "생일 축하 파티"
            });
            
            // 더미 데드라인 일정
            addEvent({
                title: "프로젝트 데드라인",
                date: `${currentYear}-${currentMonthStr}-16`,
                category: "important",
                description: "프로젝트 최종 제출일"
            });
            
            // 더미 정기 일정
            addEvent({
                title: "네트워크 점검",
                date: `${currentYear}-${currentMonthStr}-25`,
                category: "default",
                description: "월간 네트워크 점검"
            });
        }
        
        // 이벤트 리스너 설정
        function setupEventListeners() {
            // 이전 달 버튼
            prevMonthButton.addEventListener('click', function() {
                currentMonth--;
                if (currentMonth < 0) {
                    currentMonth = 11;
                    currentYear--;
                }
                renderCalendar();
            });
            
            // 다음 달 버튼
            nextMonthButton.addEventListener('click', function() {
                currentMonth++;
                if (currentMonth > 11) {
                    currentMonth = 0;
                    currentYear++;
                }
                renderCalendar();
            });
            
            // 오늘 버튼
            todayButton.addEventListener('click', function() {
                currentMonth = today.getMonth();
                currentYear = today.getFullYear();
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
                const category = document.getElementById('eventCategory').value;
                const description = document.getElementById('eventDesc').value;
                
                addEvent({
                    title,
                    date,
                    category,
                    description
                });
                
                eventModal.style.display = 'none';
            });
        }
        
        // 초기화 함수
        function init() {
            renderCalendar();
            setupEventListeners();
            addDefaultEvents();
        }
        
        // 페이지 로드시 초기화
        window.addEventListener('DOMContentLoaded', init);
    </script>
</body>
</html>