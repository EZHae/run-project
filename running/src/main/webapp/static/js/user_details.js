/**
 * details 와 연결
 */

document.addEventListener('DOMContentLoaded', ()=> {
    
    // 버튼의 이벤트 리스너
    const btnLeaveTeam = document.querySelectorAll('button.btnLeaveTeam');
    for (const btn of btnLeaveTeam){
        btn.addEventListener('click', leaveTeam);
    }
    
    function leaveTeam(event){
        console.log(event.target);
        
        const teamId = event.target.getAttribute('data-team-id');
        
        const result = confirm('정말로 이 팀에서 탈퇴하시겠습니까?');
        if (!result) { // 사용자가 [취소]를 클릭했을 때
            return; // 함수 종료
        }
        
        const uri = `../user/leave/${teamId}`;
        
        axios
        .delete(uri)
        .then(response => {
            alert(response.data);
            window.location.reload();
        })
        .catch(error => {
            alert("탈퇴 실패: " + error.response.data);
        });
    }
    
})