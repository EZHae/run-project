/**
 * details.jsp의 신청한 멤버 보기 버튼 
 */

document.addEventListener('DOMContentLoaded', function() {
    const viewMembersButton = document.getElementById('viewMembersButton');
    const membersList = document.getElementById('membersList');
    const membersModal = new bootstrap.Modal(document.getElementById('membersModal'));
    const currentNum = parseInt(viewMembersButton.dataset.currentnum);

    // 리스트 초기화 및 메시지 표시
    function showNoMembersMessage() {
        membersList.innerHTML = '';  // 기존 리스트 비우기
        const noMembersMessage = document.createElement('div');
        noMembersMessage.className = 'alert';  // alert 클래스 사용
        noMembersMessage.style.backgroundColor = '#ffffff';  // 흰색 배경 설정
        noMembersMessage.style.color = '#000000';  // 검정색 글자 설정
        noMembersMessage.textContent = '참여한 멤버가 없습니다.';
        membersList.appendChild(noMembersMessage);
    }

    viewMembersButton.addEventListener('click', function(event) {
        event.preventDefault();

        if (currentNum === 0) { // 현재 인원수가 0일 때
            showNoMembersMessage();
            membersModal.show();
        } else { // 현재 인원수가 1 이상일 때
            const url = this.href;

            // AJAX 요청 보내기
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    membersList.innerHTML = '';  // 기존 리스트 비우기

                    if (data && Array.isArray(data) && data.length > 0) {
                        data.forEach(member => {
                            const listItem = document.createElement('li');
                            listItem.className = 'list-group-item';
                            listItem.textContent = member.nickname;
                            membersList.appendChild(listItem); // appendChild : listItem(<li>)이 membersList(<ul> || <ol>)의 자식 요소라서, listItem을 membersList라는 부모 요소의 마지막 자식 요소로 추가
                        });
                    } else {
                        showNoMembersMessage();
                    }

                    membersModal.show();
                })
                .catch(error => console.error('Error fetching members:', error));
        }
    });
});
