/**
 * details.jsp 연결. 신청 버튼의 기능 구현(신청, 신청취소, 모집종료)
 */

document.addEventListener('DOMContentLoaded', function() {
    const applyButton = document.getElementById('applyButton');
    const messageArea = document.getElementById('messageArea');

    applyButton.addEventListener('click', function() {
        const calendarId = this.getAttribute('data-calendar-id');
        //const teamId = this.getAttribute('data-team-id');
		const applyUrl = this.getAttribute('data-apply-url');

        // 버튼을 비활성화하여 중복 클릭 방지
        applyButton.disabled = true;

        const xhr = new XMLHttpRequest();
        xhr.open('POST', applyUrl);

        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

		xhr.onload = function() {
		    // 요청 완료 후 버튼을 다시 활성화
		    applyButton.disabled = false;

		    if (xhr.status === 200) {
		        try {
		            const response = JSON.parse(xhr.responseText);

		            // 메시지 표시
		            messageArea.innerHTML = '<div class="alert alert-info">' + response.message + '</div>';

		            // 현재 인원수 요소 가져오기
		            const currentNumElement = document.getElementById('currentNum');

		            if (response.status === 'applied') { //신청 버튼을 누르면
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

		            } else if (response.status === 'cancelled') { //신청취소 버튼을 누르면
		                applyButton.textContent = '신청';
		                applyButton.classList.remove('btn-danger');
		                applyButton.classList.add('btn-primary');

		                // 현재 인원수 감소
		                currentNumElement.textContent = parseInt(currentNumElement.textContent) - 1;

		            } else if (response.status === 'full') { // 현재 인원수 = 최대인원수
		                applyButton.textContent = '모집종료';
		                applyButton.disabled = true;

		            } else if (response.status === 'not_member') {
		                messageArea.innerHTML = '<div class="alert alert-warning">' + response.message + '</div>';
		            }

		        } catch (e) {
		            console.error("응답 처리 중 오류 발생", e);
		            messageArea.innerHTML = '<div class="alert alert-danger">응답 처리 중 오류가 발생했습니다.</div>';
		        }

		    } else {
		        // 요청 실패 시 버튼을 다시 활성화하고 메시지 표시
		        console.error("요청 실패:", xhr.responseText);
		        applyButton.disabled = false;
		        messageArea.innerHTML = '<div class="alert alert-danger">요청 처리 중 오류가 발생했습니다.</div>';
		    }
		};


        xhr.onerror = function() {
            // 네트워크 오류 발생 시 버튼을 다시 활성화하고 메시지 표시
            applyButton.disabled = false;
            messageArea.innerHTML = '<div class="alert alert-danger">네트워크 오류가 발생했습니다.</div>';
        };

		//calendarId 값을 문자열로 추가해 서버로 전송
        xhr.send('calendarId=' + calendarId);
    });
});
