/**
 * 최대인원수 올리는 수정 버튼 (datails.jsp)
 */

document.addEventListener('DOMContentLoaded', function() {
    const updateButtons = document.querySelectorAll('.btn-warning');
    const maxNumInput = document.getElementById('maxNum');
    const teamIdInput = document.getElementById('teamId');
    const calendarIdInput = document.getElementById('calendarId');
    const updateMaxNumForm = document.getElementById('updateMaxNumForm');

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

        const formData = new FormData(updateMaxNumForm);
        const teamId = formData.get('teamId');
        const calendarId = formData.get('calendarId');
        const maxNum = formData.get('maxNum');

        fetch(`/teampage/${teamId}/tcalendar/update`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
            },
            body: new URLSearchParams(formData)
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

            // 상세페이지 새로고침
            window.location.href = `/teampage/${teamId}/tcalendar/details?calendarId=${calendarId}`;
        })
        .catch(error => console.error('Error updating max number:', error));
    });
});
