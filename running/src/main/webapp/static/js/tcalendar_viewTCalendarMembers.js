/**
 * details.jsp의 신청한 멤버 보기 버튼 
 */

document.addEventListener('DOMContentLoaded', function() {
    const viewMembersButton = document.getElementById('viewMembersButton');
    const membersList = document.getElementById('membersList');
    const membersModal = new bootstrap.Modal(document.getElementById('membersModal'));

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
                if (data && Array.isArray(data)) {
                    data.forEach(member => {
                        const listItem = document.createElement('li');
                        listItem.className = 'list-group-item';
                        listItem.textContent = member.nickname || '닉네임 없음';
                        membersList.appendChild(listItem);
                    });
                } else {
                    console.error('Invalid data format:', data);
                }

                // 모달 창 표시하기
                membersModal.show();
            })
            .catch(error => console.error('Error fetching members:', error));
    });
});
