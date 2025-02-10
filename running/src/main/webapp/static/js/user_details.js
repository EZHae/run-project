/**
 * details 와 연결
 */

document.addEventListener('DOMContentLoaded', ()=> {
    

    // 부트스트랩 모달 객체를 생성.
    const imageModal = new bootstrap.Modal('div#imageModal', { backdrop: true });

    // 버튼의 이벤트 리스너
    const changeImageBtn = document.querySelector('button#changeImageBtn');
    
    
    changeImageBtn.addEventListener('click', showImageModal);
    
    
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
})