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
    
    changeImageBtn.addEventListener('click', showImageModal);
    btnDelete.addEventListener('click', deleteUser);
    
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
    
    
    // 유저삭제버튼 이벤트 리스너
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