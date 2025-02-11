/**
 * details.jsp 연결. 신청 버튼의 기능 구현(신청, 신청취소, 모집종료)
 */

document.addEventListener('DOMContentLoaded', function() {
    const applyButton = document.getElementById('applyButton');
    const messageArea = document.getElementById('messageArea');

    applyButton.addEventListener('click', function() {
        const calendarId = this.getAttribute('data-calendar-id');
        const applyUrl = this.getAttribute('data-apply-url');

        // 버튼을 비활성화하여 중복 클릭 방지
        applyButton.disabled = true;

        // Axios 사용
        axios.post(applyUrl, `calendarId=${encodeURIComponent(calendarId)}`, {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
        .then(response => {
            // 요청 완료 후 버튼을 다시 활성화
            applyButton.disabled = false;

            const data = response.data;

            // 메시지 표시
            messageArea.innerHTML = '<div class="alert alert-info">' + data.message + '</div>';

            // 현재 인원수 요소 가져오기
            const currentNumElement = document.getElementById('currentNum');

            if (data.status === 'applied') {
                applyButton.textContent = '신청취소';
                applyButton.classList.remove('btn-primary');
                applyButton.classList.add('btn-danger');

                // 현재 인원수 증가
                currentNumElement.textContent = parseInt(currentNumElement.textContent) + 1;

                // 최대 인원수에 도달했는지 확인
                const maxNum = parseInt(document.getElementById('maxNum').textContent);
                const currentNum = parseInt(currentNumElement.textContent);

                if (currentNum >= maxNum) {
                    applyButton.textContent = '모집종료';
                    applyButton.disabled = true;
                }
            } else if (data.status === 'cancelled') {
                applyButton.textContent = '신청';
                applyButton.classList.remove('btn-danger');
                applyButton.classList.add('btn-primary');

                // 현재 인원수 감소
                currentNumElement.textContent = parseInt(currentNumElement.textContent) - 1;
            } else if (data.status === 'full') {
                applyButton.textContent = '모집종료';
                applyButton.disabled = true;
            } else if (data.status === 'not_member') {
                messageArea.innerHTML = '<div class="alert alert-warning">' + data.message + '</div>';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            messageArea.innerHTML = '<div class="alert alert-danger">요청 처리 중 오류가 발생했습니다.</div>';
            applyButton.disabled = false;
        });
    });
});
