/**
 * details 와 연결
 */

document.addEventListener('DOMContentLoaded', ()=> {
    
    // 버튼의 이벤트 리스너
    const btnLeaveTeam = document.querySelectorAll('button.btnLeaveTeam');
    const btnDeleteTeam = document.querySelectorAll('button.btnDeleteTeam');
    
    for (const btn of btnLeaveTeam){
        btn.addEventListener('click', leaveTeam);
    }
    for (const btn of btnDeleteTeam){
        btn.addEventListener('click', deleteTeam);
    }
    
	function leaveTeam(event) {
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
				axios.put(`../team/api/minusCurrentNum?teamid=${teamId}`).then((response) => {
					if (response.data == 1) {
						console.log('currentNum 1 감소');
						window.location.reload();
					}
				}).cancel((error) => {
					console.log(error);
				});
			})
			.catch(error => {
				alert("탈퇴 실패: " + error.response.data);
			});
	}
    
    function deleteTeam(event) {
        console.log(event.target);
        
        const teamId = event.target.getAttribute('data-team-id');
        
        const firstConfirm  = confirm('정말로 이 팀을 삭제하시겠습니까? 삭제 후 복구가 불가능합니다.');
        if (!firstConfirm) return;
        const secondConfirm = confirm('한 번 더 확인합니다. 팀을 삭제하시겠습니까?');
        if (!secondConfirm) return;
        
        const uri = `../user/delete/${teamId}`;
                
        axios
        .delete(uri)
        .then(response => {
            alert(response.data);
            window.location.reload();
        })
        .catch(error => {
            alert("삭제 실패: " + error.response.data);
        });
    }
    
    
    // 유효성 검사
    
    const checkNicknameResult = document.querySelector('div#checkNicknameResult');
    const checkPhoneNumberResult = document.querySelector('div#checkPhoneNumberResult');
    const checkEmailResult = document.querySelector('div#checkEmailResult');
    
    const inputNickname = document.querySelector('input#nickname');
    const inputEmail = document.querySelector('input#email');
    const inputPhoneNumber = document.querySelector('input#phonenumber');
    
    // inputNickname 요소에 'change' 이벤트 리스너를 설정
    inputNickname.addEventListener('change', checkNickname);
    // inputEmail 요소에 'change' 이벤트 리스너를 설정.
    inputEmail.addEventListener('change', checkEmail);
    // inpustPhoneNumber 요소에 'change' 이벤트 리스너를 설정.
    inputPhoneNumber.addEventListener('change',checkPhoneNumber);

})