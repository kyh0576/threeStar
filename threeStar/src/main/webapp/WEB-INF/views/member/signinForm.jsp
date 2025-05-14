<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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

.success-text {
    font-size: 12px;
    color: #4CAF50;
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


.radio-group {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
    margin-left: 5px;
}

.radio-label {
    display: inline-block;
    cursor: pointer;
    font-size: 14px;
    margin-left: 5px;
}

.form-select {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    outline: none;
    background-color: white;
    cursor: pointer;
}

.form-select:focus {
    border-color: #53a2dd;
    box-shadow: 0 0 0 2px rgba(83, 162, 221, 0.2);
}
</style>
</head>
<body>

	<c:if test="${ not empty alertMsg }">
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session"/> <!-- scope 생략시 모든 scope의 있는 alertMsg를 지움 -->
	</c:if>
	
    <div class="signup-container">
        <h1>회원가입</h1>
        <p>회원이 되어 다양한 혜택을 경험해 보세요!</p>
        
        <form id="signup-form" action="insert.me" method="POST" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="userid">
                    아이디 <span class="required">*</span>
                </label>
                <div class="input-with-button">
                    <input type="text" id="userid" name="memId" placeholder="아이디 입력 (6~20자)" required>
                    <button type="button" class="check-btn" id="checkId">중복 확인</button>
                </div>
                <p class="help-text" id="id-message">사용할 수 없는 아이디입니다</p>
            </div>
            
            <div class="form-group">
                <label for="password">
                    비밀번호 <span class="required">*</span>
                </label>
                <input type="password" id="password" name="memPwd" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)" required>
                <p class="help-text" id="pwd-guide">문자, 숫자, 특수문자 포함 8~20자</p>
                <p class="warning-text" id="pwd-format-warning">비밀번호 형식이 올바르지 않습니다</p>
            </div>
            
            <div class="form-group">
                <label for="password-confirm">
                    비밀번호 확인 <span class="required">*</span>
                </label>
                <input type="password" id="password-confirm" placeholder="비밀번호 재입력" required>
                <p class="warning-text" id="pwd-match-warning">비밀번호가 일치하지 않습니다</p>
            </div>
            
            <div class="form-group">
                <label for="name">
                    이름 <span class="required">*</span>
                </label>
                <input type="text" id="name" name="memName" placeholder="이름을 입력해주세요" value="${ memName }" required>
            </div>
            
            <div class="form-group">
                <label for="phone">
                    전화번호 <span class="required">*</span>
                </label>
                <input type="tel" id="phone" name="phone" placeholder="휴대폰 번호 입력 (예: 010-1234-5678)" maxlength="13" required>
                <p class="help-text">하이픈(-)은 자동으로 입력됩니다</p>
            </div>
            
            <div class="form-group">
                <label for="email">
                    이메일 주소 <span class="required">*</span>
                </label>
                <div class="form-group">
                    <input type="email" id="email-id" name="email" placeholder="이메일 주소" value="${ email }" required>
                </div>
            </div>
            
             <div class="form-group">
			    <label for="user_type">
			        회원 유형 <span class="required">*</span>
			    </label>
			 </div>
			   <div class="radio-group">
				    <input type="radio" id="admin-type" name="userType" value="admin">
				    <label for="admin-type" class="radio-label">관리자</label>
				    
				    <input type="radio" id="member-type" name="userType" value="member" checked>
				    <label for="member-type" class="radio-label">일반회원</label>
				</div>
				
				<div class="form-group" id="admin-class-container" style="display:none;">
				    <label for="admin_class">
				        클래스 선택 <span class="required">*</span>
				    </label>
				    <select id="admin_class" name="memClassCode" class="form-select">
				        <option value="" disabled selected>클래스를 선택해주세요</option>
				        <option value="asd123">A-Class</option>
				        <option value="qzd915">B-Class</option>
				        <option value="zxc178">C-Class</option>
				        <option value="juh518">D-Class</option>
				        <option value="evb517">E-Class</option>
				        <option value="aju811">F-Class</option>
				        <option value="vgh881">G-Class</option>
				        <option value="qwe246">H-Class</option>
				        <option value="dfe145">I-Class</option>
				        <option value="pdf567">J-Class</option>
				        <option value="odn356">K-Class</option>
				        <option value="lon466">L-Class</option>
				    </select>
				    
				    <div id="admin-class-container">
				        <input type="hidden" id="adminYN" name="adminYN" value="N">
				    </div>
				</div>
			
			<div class="form-group" id="member-code-container">
			    <label for="class_code">
			        초대코드 <span class="required">*</span>
			    </label>
			    <input type="text" id="class_code" name="memClassCode" placeholder="초대코드를 입력해주세요" required>
			</div>
            
            
            <input type="hidden" id="snsKey" name="snsKey" value="${ snsKey }">
            <input type="hidden" id="is-password-valid" value="false">
            <input type="hidden" id="is-password-format-valid" value="false">
            <input type="hidden" id="is-id-valid" value="false">
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">가입하기</button>
                <button type="button" class="btn btn-secondary" id="cancel-btn">가입취소</button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const signupForm = document.getElementById('signup-form');
            const password = document.getElementById('password');
            const passwordConfirm = document.getElementById('password-confirm');
            const pwdMatchWarning = document.getElementById('pwd-match-warning');
            const pwdFormatWarning = document.getElementById('pwd-format-warning');
            const pwdGuide = document.getElementById('pwd-guide');
            const idMessage = document.getElementById('id-message');
            const isPasswordValid = document.getElementById('is-password-valid');
            const isPasswordFormatValid = document.getElementById('is-password-format-valid');
            const isIdValid = document.getElementById('is-id-valid');
            const phoneInput = document.getElementById('phone');
            
            // 초기에는 경고 메시지 숨기기
            pwdMatchWarning.style.display = 'none';
            pwdFormatWarning.style.display = 'none';
            idMessage.style.display = 'none';
            
            // 전화번호 입력 시 하이픈 자동 추가
            phoneInput.addEventListener('input', function(e) {
                let number = e.target.value.replace(/[^0-9]/g, '');
                
                if (number.length <= 3) {
                    // 입력된 값이 3자리 이하일 경우
                    phoneInput.value = number;
                } else if (number.length <= 7) {
                    // 입력된 값이 4자리~7자리일 경우
                    phoneInput.value = number.substring(0, 3) + '-' + number.substring(3);
                } else {
                    // 입력된 값이 8자리 이상일 경우
                    phoneInput.value = number.substring(0, 3) + '-' + 
                                      number.substring(3, 7) + '-' + 
                                      number.substring(7, 11);
                }
            });
            
            // 비밀번호 형식 검증
            password.addEventListener('input', function() {
                const pwd = password.value;
                // 비밀번호 형식 검증 (문자, 숫자, 특수문자 포함 8~20자)
                const hasLetter = /[a-zA-Z]/.test(pwd);
                const hasNumber = /[0-9]/.test(pwd);
                const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pwd);
                const validLength = pwd.length >= 8 && pwd.length <= 20;
                
                if (hasLetter && hasNumber && hasSpecial && validLength) {
                    pwdFormatWarning.style.display = 'block';
                    pwdFormatWarning.className = 'success-text';
                    pwdFormatWarning.textContent = '사용 가능한 비밀번호 형식입니다';
                    isPasswordFormatValid.value = 'true';
                } else {
                    pwdFormatWarning.style.display = 'block';
                    pwdFormatWarning.className = 'warning-text';
                    
                    if (!validLength) {
                        pwdFormatWarning.textContent = '비밀번호는 8~20자 사이여야 합니다';
                    } else if (!hasLetter) {
                        pwdFormatWarning.textContent = '비밀번호에 문자가 포함되어야 합니다';  
                    } else if (!hasNumber) {
                        pwdFormatWarning.textContent = '비밀번호에 숫자가 포함되어야 합니다';
                    } else if (!hasSpecial) {
                        pwdFormatWarning.textContent = '비밀번호에 특수문자가 포함되어야 합니다';
                    }
                    
                    isPasswordFormatValid.value = 'false';
                }
                
                // 비밀번호 변경 시 확인란과 일치 여부 검사
                if (passwordConfirm.value && password.value !== passwordConfirm.value) {
                    pwdMatchWarning.style.display = 'block';
                    pwdMatchWarning.className = 'warning-text';
                    pwdMatchWarning.textContent = '비밀번호가 일치하지 않습니다';
                    isPasswordValid.value = 'false';
                } else if (passwordConfirm.value) {
                    pwdMatchWarning.style.display = 'block';
                    pwdMatchWarning.className = 'success-text';
                    pwdMatchWarning.textContent = '비밀번호가 일치합니다';
                    isPasswordValid.value = 'true';
                }
            });
            
            // 비밀번호 확인 검증
            passwordConfirm.addEventListener('input', function() {
                if (password.value !== passwordConfirm.value) {
                    pwdMatchWarning.style.display = 'block';
                    pwdMatchWarning.className = 'warning-text';
                    pwdMatchWarning.textContent = '비밀번호가 일치하지 않습니다';
                    isPasswordValid.value = 'false';
                } else {
                    pwdMatchWarning.style.display = 'block';
                    pwdMatchWarning.className = 'success-text';
                    pwdMatchWarning.textContent = '비밀번호가 일치합니다';
                    isPasswordValid.value = 'true';
                }
            });
            
            // 폼 검증 함수
            window.validateForm = function() {
                // 비밀번호 형식 검증
                const pwd = password.value;
                const hasLetter = /[a-zA-Z]/.test(pwd);
                const hasNumber = /[0-9]/.test(pwd);
                const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pwd);
                const validLength = pwd.length >= 8 && pwd.length <= 20;
                
                if (!(hasLetter && hasNumber && hasSpecial && validLength)) {
                    alert('비밀번호는 문자, 숫자, 특수문자를 포함한 8~20자여야 합니다.');
                    password.focus();
                    return false;
                }
                
                // 비밀번호 일치 여부 확인
                if (password.value !== passwordConfirm.value) {
                    alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                    passwordConfirm.focus();
                    return false;
                }
                
                // 아이디 유효성 검증 (중복 확인 여부)
                if (isIdValid.value !== 'true') {
                    alert('아이디 중복 확인을 해주세요.');
                    document.getElementById('checkId').focus();
                    return false;
                }
                
                // 전화번호 형식 확인 (하이픈 포함 13자리)
                const phonePattern = /^01[0-9]-[0-9]{3,4}-[0-9]{4}$/;
                if (!phonePattern.test(phoneInput.value)) {
                    alert('전화번호 형식이 올바르지 않습니다. 010-XXXX-XXXX 형식으로 입력해주세요.');
                    phoneInput.focus();
                    return false;
                }
                
                // 모든 검증을 통과했을 때
                return true;
            };
            
            // 가입취소 버튼
            document.getElementById('cancel-btn').addEventListener('click', function() {
                if (confirm('가입을 취소하시겠습니까?')) {
                    window.location.href = 'login.me'; // 로그인 페이지로 이동
                }
            });
            
            // 아이디 중복 확인
            document.getElementById('checkId').addEventListener('click', function() {
                const userid = document.getElementById('userid').value;
                
                if (userid.length < 6 || userid.length > 20) {
                    alert('아이디는 6~20자 사이여야 합니다.');
                    idMessage.style.display = 'block';
                    idMessage.style.color = '#ff6b6b';
                    idMessage.textContent = '아이디는 6~20자 사이여야 합니다';
                    isIdValid.value = 'false';
                } else {
                    // 여기에 실제 서버로 중복 확인 요청을 보내는 코드가 들어갈 수 있습니다.
                    // 예시로 항상 사용 가능하다고 가정합니다.
                      $.ajax({
                    	url:"idCheck.me",
                    	data:{"userId":userid},
                    	success:function(data){
                    		if(data > 0){
                    			alert('사용 불가능한 아이디입니다.');
                                idMessage.style.display = 'block';
                                idMessage.style.color = '#ff6b6b';
                                idMessage.textContent = '사용 불가능한 아이디입니다.';
                                isIdValid.value = 'false';
                    		}else{
                                alert('사용 가능한 아이디입니다.');
                                idMessage.style.display = 'block';
                                idMessage.style.color = '#4CAF50';
                                idMessage.textContent = '사용 가능한 아이디입니다';
                                isIdValid.value = 'true';
                    		}
                    	},error:function(){
                    		console.log("아이디 중복확인용 ajax 통신 실패")
                    	}
                    })
                                        
                  
                }
            });
        });
        
        function updateFormByUserType() {
            const adminRadio = document.getElementById('admin-type');
            const memberRadio = document.getElementById('member-type');

            const adminClassContainer = document.getElementById('admin-class-container');
            const adminClass = document.getElementById('admin_class');

            const memberCodeContainer = document.getElementById('member-code-container');
            const memberCodeInput = document.getElementById('class_code');

            const hiddenAdminYN = document.getElementById('adminYN'); // 새로운 hidden input 필요

            if (adminRadio.checked) {
                // 관리자일 경우
                adminClassContainer.style.display = 'block';
                memberCodeContainer.style.display = 'none';

                adminClass.disabled = false;
                adminClass.setAttribute('required', 'required');
                adminClass.setAttribute('name', 'memClassCode');

                memberCodeInput.disabled = true;
                memberCodeInput.removeAttribute('required');
                memberCodeInput.removeAttribute('name');

                hiddenAdminYN.value = 'Y';
            } else {
                // 일반회원일 경우
                adminClassContainer.style.display = 'none';
                memberCodeContainer.style.display = 'block';

                memberCodeInput.disabled = false;
                memberCodeInput.setAttribute('required', 'required');
                memberCodeInput.setAttribute('name', 'memClassCode');

                adminClass.disabled = true;
                adminClass.removeAttribute('required');
                adminClass.removeAttribute('name');

                hiddenAdminYN.value = 'N';
            }
        }

        // 이벤트 연결
        document.getElementById('admin-type').addEventListener('change', updateFormByUserType);
        document.getElementById('member-type').addEventListener('change', updateFormByUserType);

        // 페이지 로딩 시에도 초기화
        document.addEventListener('DOMContentLoaded', updateFormByUserType);
    </script>
</body>
</html>