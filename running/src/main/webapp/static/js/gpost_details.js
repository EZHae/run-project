/**
 * details.jsp 와 연결
 */

document.addEventListener('DOMContentLoaded', function() {
    
    const downloadLinks = document.querySelectorAll('.downloadLink');
    downloadLinks.forEach(function(link) {
        link.addEventListener('click', function(event) {
            if(!signedInUserId || signedInUserId.trim() === '') {
                event.preventDefault();
                alert('로그인 후 다운로드 가능합니다.')
                // 테스트
            }
        });
    });
});