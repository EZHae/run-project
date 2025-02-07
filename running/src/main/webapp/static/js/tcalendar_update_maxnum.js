/**
 * 최대인원수 올리는 수정 버튼 (datails.jsp)
 */

document.addEventListener('DOMContentLoaded', function() {
    const updateButtons = document.querySelectorAll('.btn-warning');
    const maxNumInput = document.getElementById('maxNum');
    const teamIdInput = document.getElementById('teamId');
    const calendarIdInput = document.getElementById('calendarId');
    const updateMaxNumForm = document.getElementById('updateMaxNumForm');
    const submitUpdateButton = document.getElementById('submitUpdate');

    // 모달창이 열릴 때 데이터 설정
    updateButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            const teamId = this.dataset.teamid;
            const calendarId = this.dataset.calendarid;
            const currentNum = this.dataset.currentnum;

            maxNumInput.setAttribute('min', currentNum);
            teamIdInput.value = teamId;
            calendarIdInput.value = calendarId;
        });
    });

    // 폼 전송 시 AJAX 요청 보내기
    updateMaxNumForm.addEventListener('submit', function(event) {
        event.preventDefault();
		
		const maxNumInput = document.getElementById('maxNum');

        const maxNum = maxNumInput.value;
        const teamId = teamIdInput.value;
        const calendarId = calendarIdInput.value;

        if (maxNum=='') {
            alert("최대 인원수를 입력해주세요.");
            return;
        }

        // 동적 URL 생성
        const updateMaxNumUrl = `/running/teampage/${teamId}/tcalendar/update`;

        // 폼 데이터 준비
        const formData = new URLSearchParams();
        formData.append('calendarId', calendarId);
        formData.append('teamId', teamId);
        formData.append('maxNum', maxNum);

        // AJAX 요청 보내기
//		const data = {calendarId, teamId, maxNum}
//		ajax.post(`/running/teampage/${teamId}/tcalendar/update`,data).then(
//			(response)=>{
//				if(response==1){
//					
//				}
//			}
//		).catch((error)=>{
//			uri=`../`
//		});
//		
//		axios.put(url.data).then().catch()
		
        fetch(updateMaxNumUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
            },
            body: formData.toString()
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            console.log('Response data:', data); // 디버깅 메시지

            // 모달창 닫기
            const updateMaxNumModal = bootstrap.Modal.getInstance(document.getElementById('updateMaxNumModal'));
            updateMaxNumModal.hide();

            // 상세 페이지 새로고침
            window.location.href = `/running/teampage/${teamId}/tcalendar/details?calendarId=${calendarId}`;
        })
        .catch(error => console.error('Error updating max number:', error));
    });
});
