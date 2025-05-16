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
    font-family: 'Noto Sans KR', sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background-color: #d9f5f7;
}

.signup-container {
    background-color: white;
    border-radius: 16px;
    padding: 40px;
    width: 100%;
    max-width: 550px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.signup-container h1 {
    font-size: 24px;
    margin-bottom: 10px;
    color: #333;
    font-weight: bold;
}

.signup-container p {
    font-size: 14px;
    color: #666;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-size: 14px;
    margin-bottom: 8px;
    color: #333;
}

.form-group input {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    outline: none;
}

.form-group input:focus {
    border-color: #53a2dd;
    box-shadow: 0 0 0 2px rgba(83, 162, 221, 0.2);
}

.btn-group {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}

.btn {
    padding: 12px 0;
    border: none;
    border-radius: 4px;
    font-size: 15px;
    font-weight: 500;
    width: 48%;
    cursor: pointer;
}

.btn-primary {
    background-color: #53a2dd;
    color: white;
}

.btn-secondary {
    background-color: #ffd200;
    color: #333;
}

.btn:hover {
    opacity: 0.9;
}

.required {
    color: #f56c6c;
    margin-left: 2px;
}

.help-text {
    font-size: 12px;
    color: #999;
    margin-top: 5px;
}

.warning-text {
    font-size: 12px;
    color: #ff6b6b;
    margin-top: 5px;
}

.input-with-button {
    display: flex;
    gap: 10px;
}

.input-with-button input {
    flex: 7;
}

.check-btn {
    flex: 3;
    background-color: #53a2dd;
    color: white;
    padding: 12px 10px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    white-space: nowrap;
    min-width: 100px;
}
</style>
</head>
<body>
    <div class="signup-container">
        <h1>회원가입</h1>
        <p>회원이 되어 다양한 혜택을 경험해 보세요!</p>
        
        <form id="signup-form">
            <div class="form-group">
                <label for="userid">
                    아이디 <span class="required">*</span>
                </label>
                <div class="input-with-button">
                    <input type="text" id="userid" name="memId" placeholder="아이디 입력 (6~20자)" required>
                    <button type="button" class="check-btn">중복 확인</button>
                </div>
                <p class="help-text">사용할 수 없는 아이디입니다</p>
            </div>
            
            <div class="form-group">
                <label for="password">
                    비밀번호 <span class="required">*</span>
                </label>
                <input type="password" id="password" name="memPwd" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)" required>
                <p class="help-text">20자 이내의 비밀번호를 입력해주세요</p>
            </div>
            
            <div class="form-group">
                <label for="password-confirm">
                    비밀번호 확인 <span class="required">*</span>
                </label>
                <input type="password" id="password-confirm" placeholder="비밀번호 재입력" required>
                <p class="warning-text">비밀번호가 일치하지 않습니다</p>
            </div>
            
            <div class="form-group">
                <label for="name">
                    이름 <span class="required">*</span>
                </label>
                <input type="text" id="name" name="memName" placeholder="이름을 입력해주세요" required>
            </div>
            
            <div class="form-group">
                <label for="phone">
                    전화번호 <span class="required">*</span>
                </label>
                <input type="tel" id="phone" name="phone" placeholder="휴대폰 번호 입력 (- 제외 11자리 입력)" required>
            </div>
            
            <div class="form-group">
                <label for="email">
                    이메일 주소 <span class="required">*</span>
                </label>
                <div class="form-group">
                    <input type="text" id="email-id" name="email" placeholder="이메일 주소" required>
                </div>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">가입하기</button>
                <button type="button" class="btn btn-secondary">가입취소</button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const signupForm = document.getElementById('signup-form');
            const password = document.getElementById('password');
            const passwordConfirm = document.getElementById('password-confirm');
            const warningText = document.querySelector('.warning-text');
            
            // 초기에는 경고 메시지 숨기기
            warningText.style.display = 'none';
            
            // 비밀번호 확인 검증
            passwordConfirm.addEventListener('input', function() {
                if (password.value !== passwordConfirm.value) {
                    warningText.style.display = 'block';
                } else {
                    warningText.style.display = 'none';
                }
            });
            
            // 폼 제출 이벤트
            signupForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // 비밀번호 일치 여부 확인
                if (password.value !== passwordConfirm.value) {
                    alert('비밀번호가 일치하지 않습니다.');
                    return false;
                }
                
                alert('회원가입이 완료되었습니다!');
                // 여기에 실제 회원가입 처리 로직 추가
            });
            
            // 가입취소 버튼
            document.querySelector('.btn-secondary').addEventListener('click', function() {
                if (confirm('가입을 취소하시겠습니까?')) {
                    window.location.href = 'index.html'; // 메인 페이지로 이동
                }
            });
            
            // 아이디 중복 확인
            document.querySelector('.check-btn').addEventListener('click', function() {
                const userid = document.getElementById('userid').value;
                if (userid.length < 6 || userid.length > 20) {
                    alert('아이디는 6~20자 사이여야 합니다.');
                } else {
                    alert('사용 가능한 아이디입니다.');
                }
            });
        });
    </script>
</body>
</html>