/**
 * 
 */

document.addEventListener('DOMContentLoaded', ()=> {
    // 아이디 위치
    const inputUserId = document.querySelector('input#userId');

    // 버튼의 이벤트 리스너
    
    const btnDelete = document.querySelector('button#btnDelete');
    const btnUpdate = document.querySelector('button#btnUpdate');
    const btnUpload = document.querySelector('button#btnUpload');
    const btnUpdatePassword = document.querySelector('button#btnUpdatePassword');
    
    
    btnDelete.addEventListener('click', deleteUser);
    btnUpdate.addEventListener('click', updateUser);
    btnUpload.addEventListener('click', updateImage);
    btnUpdatePassword.addEventListener('click', updatePassword);
    
    // 부트스트랩 모달 객체를 생성.
    const changeImageBtn = document.querySelector('button#changeImageBtn');
    const changePasswordBtn = document.querySelector('button#changePasswordBtn')
    
    const imageModal = new bootstrap.Modal('div#imageModal', { backdrop: true });
    const passwordModal = new bootstrap.Modal('div#passwordModal', { backdrop: true });
    
    changeImageBtn.addEventListener('click', showImageModal);
    changePasswordBtn.addEventListener('click', showPasswordModal);
    
    
    // 포커스 해제 
    document.querySelector('div#imageModal').addEventListener('hidden.bs.modal', (e) => {
        if (document.activeElement) {
            document.activeElement.blur();
        }
    });
    document.querySelector('div#passwordModal').addEventListener('hidden.bs.modal', (e) => {
        if (document.activeElement) {
            document.activeElement.blur();
        }
        document.querySelector('input#currentPassword').value = '';
        document.querySelector('input#newFirstPassword').value = '';
        document.querySelector('input#newSecondPassword').value = '';
    });
    
    //-------------------------------------------------
    
    // 유저 업데이트 버튼 이벤트 리스너
    function updateUser(event) {
        console.log(event.target);
        const userId = btnUpdate.getAttribute('data-user-id');
        
        
        // 업데이트할 데이터
        const nickname = document.querySelector('input#nickname').value;
        const username = document.querySelector('input#username').value;
        const age = document.querySelector('input#age').value;
        const phonenumber =document.querySelector('input#phonenumber').value;
        const email = document.querySelector('input#email').value;
        const password = document.querySelector('input#password').value;
        const gender = document.querySelector('select#gender').value;
        const residence = document.querySelector('select#residence').value;
        const imgId = document.querySelector('input#imgId').value;
        
        const data = {userId, nickname, username, age, phonenumber, email, password, gender, residence, imgId}
        console.log(data);
        
        
        const result = confirm('변경 하시겠습니까?')
        if (!result) {
            return;
        }   
        
        const uri = `../user/api/${userId}`;
        
        axios
        .put(uri,data)
        .then((response) => {
            console.log(response);
			alert('다시 로그인해주세요.')
            window.location.href = "/running/user/signout";
        })
        .catch((error) => {
            alert("수정 실패: " + error.response.data);
        });
    }
    
    // 유저 삭제 버튼 이벤트 리스너
    function deleteUser(event) {
        console.log(event.target);

        const result = confirm('계정을 정말 탈퇴합니까?');
        if (!result) { // 사용자가 [취소]를 클릭했을 때
            return; // 함수 종료
        }

        const userId = btnDelete.getAttribute('data-user-id');
        const uri = `../user/${userId}`

        axios
        .delete(uri)
        .then(response => {
            alert(response.data);
            window.location.href = "/running"; // 홈페이지로 이동 (로그아웃됨)
        })
        .catch(error => {
            alert("삭제 실패: " + error.response.data);
        });
    }
    
    
    // 모달창을 보여주기 위한 이벤트 리스너 -------------------------------------------------------------
    // 이미지 수정 모달
    function showImageModal(event) {
            
        // 현재 로그인한 유저 ID 가져오기
        const userId = changeImageBtn.getAttribute('data-user-id');
        console.log("현재 로그인한 사용자 ID:", userId);

        const uri = `../user/api/${userId}`;

        axios
        .get(uri)
        .then(response => {
            console.log("서버 응답 데이터:", response.data);

            const userImgId = response.data.imgId;
            console.log("현재 사용자의 프로필 이미지:", userImgId);
            
            
            // 모달표시
            imageModal.show();
            
//            document.getElementById('imageModal').focus();
            
            
            
        })
        .catch(error => {
            console.error("에러 발생:", error);
        });
    }
    
    
    // 패스워드 모달 
    function showPasswordModal(event) {
            
            const userId = changePasswordBtn.getAttribute('data-user-id');
            console.log("현재 로그인한 사용자 ID:", userId);
            
            const uri = `../user/api/${userId}`;

            axios
            .get(uri)
            .then(response => {
                console.log("서버 응답 데이터:", response.data);

                // 모달표시
                passwordModal.show();
            })
            .catch(error => {
                console.error("에러 발생:", error);
            });
        }
        
            
    
    
    // 이미지 업데이트
    function updateImage() {
        
        // 사용자 아이디
        const userId = btnUpload.getAttribute('data-user-id');
        const imageForm = document.querySelectorAll('div#imageForm');

        if (!userId) {
            alert("사용자 ID를 찾을 수 없습니다.");
            return;
        }
        
        // 선택된 라디오 버튼
        const selectedRadio = document.querySelector('input[name="imgId"]:checked');


        if (!selectedRadio) {
            alert("이미지를 선택하세요.");
            return;
        }
        
        // 라디오 버튼이 포함된 `label` 태그 내부의 이미지 태그 가져오기
        const selectedLabel = selectedRadio.closest("label");
        if (!selectedLabel) {
            alert("선택된 이미지의 정보를 찾을 수 없습니다.");
            return;
        }
        
        const selectedImage = selectedLabel.querySelector("img");
        if (!selectedImage) {
            alert("이미지 태그를 찾을 수 없습니다.");
            return;
        }
        
        
        const imageName = selectedImage.getAttribute("data-image-name"); // 원본 이미지명
        const imageFileName = selectedImage.getAttribute("data-image-file"); // 이미지 파일 이름만 보내고 컨트롤러에서 경로 저장

        const basePath = "C:/upload_data/profile/"; // 파일 경로
        const imagePath = basePath + imageFileName;
                
        // 서버에 보낼 데이터 객체
        const data = {userId, imageName, imagePath};
        
        console.log("서버로 보낼 데이터:", data);
        
        // 이미지 업데이트 REST API(요청 URI)
        const uri = `../user/api/${userId}/image`;

        // Ajax 요청을 보냄.
        axios
            .put(uri, data)
            .then((response) => {
                console.log(response);
                alert("프로필 이미지가 변경되었습니다!");
                window.location.reload();
                
                
                // 모달 닫기
                imageModal.hide();
            })
            .catch((error) => {});
    }
    
    
    // 비밀번호 업데이트 이벤트 
    function updatePassword(event) {
        event.preventDefault(); //  기본 폼 제출 동작 막기 (submit 동작 막기)
        const userId = changePasswordBtn.getAttribute('data-user-id');
        
        const currentPassword = document.querySelector('input#currentPassword').value;
        const password = document.querySelector('input#newFirstPassword').value;
        const newSecondPassword = document.querySelector('input#newSecondPassword').value;

        console.log("유저 아이디 : ",userId);
        console.log("유저 변경 전 패스워드 : ",currentPassword);
        console.log("유저 변경 후 패스워드 : ",password);
        
        const storedPassword = document.querySelector('input#password').value;
        console.log("유저 기존 패스워드 : ",storedPassword);
        
        if (!currentPassword.trim()) {
            alert("현재 비밀번호를 입력해주세요.");
            return;
        }
        if (!password.trim()) {
            alert("새 비밀번호를 입력해주세요.");
            return;
        }
        if (password !== newSecondPassword) {
            alert("새 비밀번호가 일치하지 않습니다.");
            return;
        }
        if (!password || password.trim() === '') {
            alert("새 비밀번호를 입력해주세요.");
            return;
        }
        if (password !== newSecondPassword) {
            alert("새 비밀번호가 일치하지 않습니다.");
            return;
        }
        if (currentPassword === password) {
            alert("현재 비밀번호와 동일한 비밀번호를 사용할 수 없습니다.");
            return;
        }
        const data = { password , currentPassword};
        const uri = `../user/api/${userId}/password`
        
        console.log("데이터 정보 : ",data);
        
        // 비밀번호 변경 요청 (AJAX 요청 예제)
        axios
        .put(uri, data)
        .then((response) => {
            console.log(response)
            alert("비밀번호 변경이 완료되었습니다."); 
            
            console.log(signedInUserId);
            passwordModal.hide();
            window.location.reload(true);
        })
        .catch((error) => {
            console.log("에러 발생:", error.response);
            if (error.response && error.response.data) {
                alert(error.response.data); // 서버에서 반환한 에러 메시지 출력
            } else {
                alert("비밀번호 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
    
    
    
    // 유효성 검사
    let isNicknameChecked = false;
    let isPhoneNumberChecked = false;
    
    const originalNickname = document.querySelector('input#nickname').value;
    const originalPhone = document.querySelector('input#phonenumber').value;
    console.log("닉네임",originalNickname);
    console.log("핸펀",originalPhone)
    const checkNicknameResult = document.querySelector('div#checkNicknameResult');
    const checkPhoneNumberResult = document.querySelector('div#checkPhoneNumberResult');

    const inputNickname = document.querySelector('input#nickname');
    const inputPhoneNumber = document.querySelector('input#phonenumber');

    // inputNickname 요소에 'change' 이벤트 리스너를 설정
    inputNickname.addEventListener('change', checkNickname);
    // inpustPhoneNumber 요소에 'change' 이벤트 리스너를 설정.
    inputPhoneNumber.addEventListener('change',checkPhoneNumber);
    
    /* ----------------------- 함수 선언 ----------------------- */

    // 버튼 클릭 시 전체 유효성 검사
    btnUpdate.addEventListener('click', function (event) {
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
        if (isNicknameChecked && isPhoneNumberChecked) { 
            // 버튼 활성화 - class 속성들 중에서 'disabled'를 제거.
            btnUpdate.classList.remove('disabled'); // 모든 html에는 classList 속성이 있음
            // 클래스값에는 한개의 값이 아닌 여러개의 값을 설정을 할 수 있으며, 모든 엘리먼트에는 classList라는 속성이 있음.
        } else {
            // 버튼 비활성화 - class 속성에 'disabled'를 추가.
            btnUpdate.classList.add('disabled');
            btnUpdate.removeAttribute('disabled');  // disabled 속성 제거
            // 삭제는 remove, 추가는 add
        }
    }

    // 닉네임 중복 검사
    function checkNickname(){
        const nickname = inputNickname.value;
                
        if (nickname === originalNickname) {
            checkNicknameResult.textContent = '기존 닉네임입니다.';
            checkNicknameResult.className = 'text-success';
            isNicknameChecked = true;
            changeButtonState();
            return;
        }
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

    // 휴대전화번호 유효성 및 중복 검사
    function checkPhoneNumber(){
        const phonenumber = inputPhoneNumber.value.trim();
        const phonePattern = /^[0-9]{10,11}$/;
                        
        
        if (phonenumber === originalPhone) {
            checkPhoneNumberResult.textContent = '기존 전화번호입니다.';
            checkPhoneNumberResult.className = 'text-success';
            isPhoneNumberChecked = true;
            changeButtonState();
            return;
          }
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
});