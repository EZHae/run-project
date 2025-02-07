/**
 * details.jsp의 신청한 멤버 보기 버튼 
 */

document.addEventListener('DOMContentLoaded', function() {
    const viewMembersButton = document.getElementById('viewMembersButton');
    const membersList = document.getElementById('membersList');
    const membersModal = new bootstrap.Modal(document.getElementById('membersModal'));
    const currentNum = parseInt(viewMembersButton.dataset.currentnum);

    // 현재 인원수가 0인 경우 메시지 표시
    if (currentNum === 0) {
        viewMembersButton.addEventListener('click', function(event) {
            event.preventDefault();

            // 기존 리스트 비우기
            membersList.innerHTML = '';

            // 신청한 멤버가 없을 경우 메시지 표시
            const noMembersMessage = document.createElement('div');
            noMembersMessage.className = 'alert'; // alert 클래스 사용
            noMembersMessage.style.backgroundColor = '#ffffff'; // 흰색 배경 설정
            noMembersMessage.style.color = '#000000'; // 검정색 글자 설정
            noMembersMessage.textContent = '참여한 멤버가 없습니다.';
            membersList.appendChild(noMembersMessage);
            
            // 모달 창 표시하기
            membersModal.show();
        });
    } else {
        viewMembersButton.addEventListener('click', function(event) {
            event.preventDefault();

            const url = this.href;

            // AJAX 요청 보내기
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    // 기존 리스트 비우기
                    membersList.innerHTML = '';

                    // 멤버 데이터 추가하기
                    if (data && Array.isArray(data) && data.length > 0) {
                        data.forEach(member => {
                            const listItem = document.createElement('li');
                            listItem.className = 'list-group-item';
                            listItem.textContent = member.nickname || '닉네임 없음';
                            membersList.appendChild(listItem);
                        });
                    } else {
                        // 신청한 멤버가 없을 경우 메시지 표시
                        const noMembersMessage = document.createElement('div');
                        noMembersMessage.className = 'alert'; // alert 클래스 사용
                        noMembersMessage.style.backgroundColor = '#ffffff'; // 흰색 배경 설정
                        noMembersMessage.style.color = '#000000'; // 검정색 글자 설정
                        noMembersMessage.textContent = '참여한 멤버가 없습니다.';
                        membersList.appendChild(noMembersMessage);
                    }

                    // 모달 창 표시하기
                    membersModal.show();
                })
                .catch(error => console.error('Error fetching members:', error));
        });
    }
});
