/**
 * signup 연결
 */

document.addEventListener('DOMContentLoaded', ()=>{
    
    // true이면 회원가입이 가능. false이면 [작성완료] 버튼은 비활성화.1
    
    // 사용자 아이디를 입력했는가?
    let isUserIdChecked = false;
    
    // 비밀번호를 입력했는가?
    let isPasswordChecked = false;
    
    // 닉네임을 입력했는가?
    let isNicknameChecked = false;
    
    // 이메일을 입력했는가?
    let isEmailChecked = false;
    
    // 휴대폰번호를 입력했는가?
    let isPhoneNumberChecked = false;
    
    // 나이를 입력했는가?
    let isAgeChecked = false;
    
    // 아이디
    const inputUserId = document.querySelector('input#userId')
    // 아이디 검사
    const checkUserIdResult = document.querySelector('div#checkUserIdResult');
    // 닉네임
    const inputNickname = document.querySelector('input#nickname');
    // 닉네임 검사
    const checkNicknameResult = document.querySelector('div#checkNicknameResult');
    // 비밀번호
    const inputPassword = document.querySelector('input#password');
    // 비밀번호 검사
    const checkPasswordResult = document.querySelector('div#checkPasswordResult');
    // 이메일
    const inputEmail = document.querySelector('input#email');
    // 이메일 검사
    const checkEmailResult = document.querySelector('div#checkEmailResult');
    // 휴대폰
    const inputPhoneNumber = document.querySelector('input#phonenumber');
    // 휴대폰 검사
    const checkPhoneNumberResult = document.querySelector('div#checkPhoneNumberResult');
    // 나이
    const inputAge = document.querySelector('input#age');
    // 나이 검사
    const checkAgeResult = document.querySelector('div#checkAgeResult')
    // 주소
    const inputResidence = document.querySelector('select#residence');
    // 버튼 
    const btnSignUp = document.querySelector('button#btnSignUp');
    
    // inputuUserId 요소에 'change' 이벤트 리스너를 설정
    inputUserId.addEventListener('change', checkUserId);

    // inputNickname 요소에 'change' 이벤트 리스너를 설정
    inputNickname.addEventListener('change', checkNickname);
    
    // inputPassword 요소에 'change' 이벤트 리스너를 설정.
    inputPassword.addEventListener('change', checkPassword);

    // inputEmail 요소에 'change' 이벤트 리스너를 설정.
    inputEmail.addEventListener('change', checkEmail);
    
    // inpustPhoneNumber 요소에 'change' 이벤트 리스너를 설정.
    inputPhoneNumber.addEventListener('change',checkPhoneNumber);
    
    // inputAge 요소에 'change' 이벤트 리스너를 설정.
    inputAge.addEventListener('change', checkAge);

    /* ----------------------- 함수 선언 ----------------------- */
    
    // 버튼 클릭 시 전체 유효성 검사
    btnSignUp.addEventListener('click', function (event) {
        event.preventDefault(); // 폼 제출 방지 (유효성 검사 후 진행)

        if (!validateForm()) {
            return;
        }
        // 유효성 검사를 통과하면 폼 제출
        document.querySelector("form").submit();
    });
    
    // 버튼 활성화 상태 변경
    function changeButtonState() {
        
        // 하나라도 만족 못할 경우 버튼을 활성화 시킬 수 없음. 
        if (isUserIdChecked && isPasswordChecked && isEmailChecked &&isNicknameChecked && isPhoneNumberChecked && isAgeChecked) { 
            
            // 버튼 활성화 - class 속성들 중에서 'disabled'를 제거.
            btnSignUp.classList.remove('disabled'); // 모든 html에는 classList 속성이 있음
            
            // 클래스값에는 한개의 값이 아닌 여러개의 값을 설정을 할 수 있으며, 모든 엘리먼트에는 classList라는 속성이 있음.
        } else {
            // 버튼 비활성화 - class 속성에 'disabled'를 추가.
            btnSignUp.classList.add('disabled');
            btnSignUp.removeAttribute('disabled');  // disabled 속성 제거
            // 삭제는 remove, 추가는 add
        }
    }

    // 사용자 아이디 중복 검사
    function checkUserId() {
        const userId = inputUserId.value;
        
        if(userId === '') {
            checkUserIdResult.innerHTML = '사용자 아이디는 필수 입력 항목입니다.';
            
            // userid 중복체크 부분의 클래스 속성을 추가하고 삭제.
            checkUserIdResult.classList.add('text-danger'); 
            checkUserIdResult.classList.remove('text-success');
            
            isUserIdChecked = false; //사용할 수 없는 경우 
            changeButtonState()
            return;
        }
        
        // 아이디 중복 체크 REST API(요청 URI) 요청주소도 대소문자를 구분하기 때문에 controller의 요청 주소와 일치해야함.
        
        const uri = `./checkuserid?userId=${userId}`;

        axios
            .get(uri)
            .then(handleCheckUserIdResp)
            .catch((error) => console.log(error));
    }
    
    function handleCheckUserIdResp({data}){
        console.log(data);

        if (data === 'Y') {
            checkUserIdResult.innerHTML = '사용 가능한 아이디입니다.'
            checkUserIdResult.classList.add('text-success');
            checkUserIdResult.classList.remove('text-danger');
            isUserIdChecked = true; // 사용 가능한 아이디는 버튼을 활성화
        } else {
            checkUserIdResult.innerHTML = '사용할 수 없는 아이디입니다.'
            checkUserIdResult.classList.add('text-danger');
            checkUserIdResult.classList.remove('text-success');
            isUserIdChecked = false; // 사용 불가능한 아이디는 버튼을 비활성화
        }
        changeButtonState(); // 위의 상태에 따라 버튼의 상태를 바꿔야함.

    }
    
    // 닉네임 중복 검사
    function checkNickname(){
        const nickname = inputNickname.value;
                
        if(nickname === '') {
            checkNicknameResult.innerHTML = '사용자 아이디는 필수 입력 항목입니다.';
            
            // userid 중복체크 부분의 클래스 속성을 추가하고 삭제.
            checkNicknameResult.classList.add('text-danger'); 
            checkNicknameResult.classList.remove('text-success');
            
            isNicknameChecked = false; //사용할 수 없는 경우 
            changeButtonState()
            return;
        }
        
        // 아이디 중복 체크 REST API(요청 URI) 요청주소도 대소문자를 구분하기 때문에 controller의 요청 주소와 일치해야함.
        
        const uri = `./checknickname?nickname=${nickname}`;

        axios
            .get(uri)
            .then(handleCheckNicknameResp)
            .catch((error) => console.log(error));
    }
    
    function handleCheckNicknameResp({data}) {
        if (data === 'Y') {
            checkNicknameResult.innerHTML = '사용 가능한 닉네임입니다.'
            checkNicknameResult.classList.add('text-success');
            checkNicknameResult.classList.remove('text-danger');
            isNicknameChecked = true; // 사용 가능한 아이디는 버튼을 활성화
        } else {
            checkNicknameResult.innerHTML = '사용할 수 없는 닉네임입니다.'
            checkNicknameResult.classList.add('text-danger');
            checkNicknameResult.classList.remove('text-success');
            isNicknameChecked = false; // 사용 불가능한 아이디는 버튼을 비활성화
        }
        changeButtonState(); // 위의 상태에 따라 버튼의 상태를 바꿔야함.
    }
    
    // 비밀번호 유효성 검사
    function checkPassword() {
        if (inputPassword.value === '') {
            checkPasswordResult.innerHTML = '비밀번호는 필수입력 항목입니다.'
            checkPasswordResult.classList.add('text-danger');
            checkPasswordResult.classList.remove('text-success');
            isPasswordChecked = false;
        } else {
            checkPasswordResult.innerHTML = '사용할 수 있는 비밀번호입니다.'
            checkPasswordResult.classList.add('text-success');
            checkPasswordResult.classList.remove('text-danger');
            isPasswordChecked = true;
        }
        changeButtonState();
    }

    // 이메일 유효성 및 중복 검사
    function checkEmail() {
        //inputEmail에 입력된 값이 있는 지를 체크
        const email = inputEmail.value.trim();
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|co\.kr|net)$/; 

        if (email === '') {
            checkEmailResult.innerHTML = '이메일은 필수 입력 항목입니다.'
            checkEmailResult.classList.add('text-danger');
            checkEmailResult.classList.remove('text-success');
            isEmailChecked = false;
            changeButtonState();
            return;
        }
        
        if(!emailPattern.test(email)) {
            checkEmailResult.innerHTML = '올바른 이메일 형식을 입력하세요. (예: guest@itwll.com)';
            checkEmailResult.classList.add('text-danger');
            checkEmailResult.classList.remove('text-success');
            isEmailChecked = false;
            changeButtonState();
            return;
        }

        //이메일 중복 체크 REST API(요청 URI)
        // 문자열 @는 그냥 넣면 안되고 encodeURIComponet 인코딩해서 넣어야함.
        const uri = `./checkemail?email=${encodeURIComponent(inputEmail.value)}`;
        // 또는 ./checkemail?email= + encodeURIComponent(inputEmail.value);

        // Ajax 요청을 보냄.
        axios
            .get(uri)
            .then(handleCheckEmailResp)
            .catch((error) => console.log(error));
    }
    
    
    function handleCheckEmailResp({ data }) {
        console.log(data);
        if (data === 'Y') { // 회원 가입 가능한 이메일
            checkEmailResult.innerHTML = '사용가능한 이메일입니다.'
            checkEmailResult.classList.add('text-success');
            checkEmailResult.classList.remove('text-danger');
            isEmailChecked = true; // 사용 가능한 이메일는 버튼을 활성화
        } else { // 중복된 이메일
            checkEmailResult.innerHTML = '사용할 수 없는 이메일입니다.'
            checkEmailResult.classList.add('text-danger');
            checkEmailResult.classList.remove('text-success');
            isEmailChecked = false; // 사용 불가능한 이메일는 버튼을 비활성화
        }
        changeButtonState(); // 위의 상태에 따라 버튼의 상태를 바꿔야함.
    }
    
    // 휴대전화번호 유효성 및 중복 검사
    function checkPhoneNumber(){
        const phonenumber = inputPhoneNumber.value.trim();
        const phonePattern = /^[0-9]{10,11}$/;
                        
        if (phonenumber === '') {
            checkPhoneNumberResult.innerHTML = '휴대전화번호는 필수 입력 항목입니다.';

            checkPhoneNumberResult.classList.add('text-danger');
            checkPhoneNumberResult.classList.remove('text-success');

            isPhoneNumberChecked = false; //사용할 수 없는 경우 
            changeButtonState()
            return;
        }
        
        if (!phonePattern.test(phonenumber)){
            checkPhoneNumberResult.innerHTML = '휴대전화번호는 숫자로 10~11자리 입력해야 합니다.'
            checkPhoneNumberResult.classList.add('text-danger');
            checkPhoneNumberResult.classList.remove('text-success');
            
            isPhoneNumberChecked = false; //사용할 수 없는 경우 
            changeButtonState()
            return;
        }   

        // 아이디 중복 체크 REST API(요청 URI) 요청주소도 대소문자를 구분하기 때문에 controller의 요청 주소와 일치해야함.

        const uri = `./checkphonenumber?phonenumber=${phonenumber}`;

        axios
            .get(uri)
            .then(handleCheckPhoneNumberResp)
            .catch((error) => console.log(error));
    }
    
    function handleCheckPhoneNumberResp({ data }) {
        console.log(data);
        if (data === 'Y') { // 회원 가입 가능한 이메일
            checkPhoneNumberResult.innerHTML = '사용가능한 휴대전화 번호입니다.'
            checkPhoneNumberResult.classList.add('text-success');
            checkPhoneNumberResult.classList.remove('text-danger');
            isPhoneNumberChecked = true; // 사용 가능한 이메일는 버튼을 활성화
        } else { // 중복된 이메일
            checkPhoneNumberResult.innerHTML = '사용할 수 없는 휴대전화 번호입니다.'
            checkPhoneNumberResult.classList.add('text-danger');
            checkPhoneNumberResult.classList.remove('text-success');
            isPhoneNumberChecked = false; // 사용 불가능한 이메일는 버튼을 비활성화
        }
        changeButtonState(); // 위의 상태에 따라 버튼의 상태를 바꿔야함.
    }
    
    // 나이 유효성 검사
    function checkAge(){
        const ageValue = inputAge.value.trim();
        const agePattern = /^[1-9][0-9]?$/;
        
        if (ageValue === '') {
            checkAgeResult.innerHTML = '나이는 필수 입력 항목입니다.';
            checkAgeResult.classList.add('text-danger');
            checkAgeResult.classList.remove('text-success');
            
            isAgeChecked = false;
            changeButtonState();
            return;
        }
        
        if (!agePattern.test(ageValue)) {  
            checkAgeResult.innerHTML = '나이는 1~99 사이의 숫자로 입력해야 합니다.';
            checkAgeResult.classList.add('text-danger');
            checkAgeResult.classList.remove('text-success');
            
            isAgeChecked = false;
            changeButtonState();
            return;
        } 

        checkAgeResult.innerHTML = '사용 가능한 나이입니다.';
        checkAgeResult.classList.add('text-success');
        checkAgeResult.classList.remove('text-danger');
        
        isAgeChecked = true;
        changeButtonState();
    }
    
    /* --------------------  전체 폼 유효성 검사 함수 -------------------- */
    function validateForm() {
        let isValid = true;
        
        const residenceValue = inputResidence.value; // 주소의 현재 값
        
        if(residenceValue === '') {
            alert("주소를 선택해야합니다.")
            isValid = false;
        }
        
        return isValid;
    }
    /* ------------------------------------------------------------------ */
    
    
    const checkFields = [
        "checkUserIdResult",
        "checkNicknameResult",
        "checkPhoneNumberResult",
        "checkEmailResult"
    ];

    checkFields.forEach(id => {
        const element = document.getElementById(id);
        if (element) {
            const observer = new MutationObserver(() => {
                if (element.innerText.trim() !== "") { // 오류 메시지가 나타나면
                    setTimeout(() => {
                        element.scrollIntoView({ behavior: "smooth", block: "center" });
                    }, 200); // 부드러운 스크롤 적용
                }
            });

            observer.observe(element, { childList: true, subtree: true }); // 메시지 변경 감지
        }
    });
});
