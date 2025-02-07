/**
 * 
 */

document.addEventListener('DOMContentLoaded', ()=> {
    // 포스트 아이디 위치
    const inputUserId = document.querySelector('input#userId');

    // 부트스트랩 모달 객체를 생성.
    const imageModal = new bootstrap.Modal('div#imageModal', { backdrop: true });

    // 버튼의 이벤트 리스너
    const changeImageBtn = document.querySelector('button#changeImageBtn');
    const btnDelete = document.querySelector('button#btnDelete')
    const btnUpdate = document.querySelector('button#btnUpdate')
    
    changeImageBtn.addEventListener('click', showImageModal);
    btnDelete.addEventListener('click', deleteUser);
    btnUpdate.addEventListener('click', updateUser);
    
    
    function showImageModal(event) {
        
        // 현재 로그인한 유저 ID 가져오기
        const userId = changeImageBtn.getAttribute('data-user-id');
        console.log("현재 로그인한 사용자 ID:", userId);
        
        // 모달표시
        imageModal.show();

        
        const uri = `../user/api/${userId}`;
        
        axios
        .get(uri)
        .then(response => {
            console.log("서버 응답 데이터:", response.data);
        })
        .catch(error => {
            console.error("에러 발생:", error);
        });
    }
    
    
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
            window.location.href = "/running/user/details";
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
})