/**
 * details.jsp
 */

document.addEventListener('DOMContentLoaded', () => {
	console.log('course-details.js');
	
	const btnDelete = document.querySelector('button#btnDelete');
	const id = document.querySelector('span#id').innerHTML;
	console.log(id);
	console.log(`${signedInUserId}`);
	console.log(`${likeUserIds}`);
	
	if (btnDelete !== null) {
		btnDelete.addEventListener('click', () => {
			const result = confirm('삭제 하시겠습니까?');
			if (result) {
				// 사용자가 [확인]을 클릭하면 GET 방식의 /course/delete?id=번호 요청을 보냄.
				location.href = `delete?id=${id}`;
			}
		});
	}
	
	const btnLike = document.querySelector('button#btnLike');
	btnLike.addEventListener('click', () => {

		const userId = document.querySelector('span#userId').innerHTML;
		if (`${signedInUserId}` === userId) {
			alert('자신의 글에는 좋아요를 할 수 없습니다.');
			return;
		}
		
		if (`${signedInUserId}` === null || `${signedInUserId}` === '') {
			alert('로그인을 해야 좋아요가 가능합니다.');
			return;
		}
		
		if (`${likeUserIds}`.includes(`${signedInUserId}`)) {
			alert('한 글에 좋아요를 두 번 할 수 없습니다.');
			return;
		}
		location.href = `like?id=${id}`;
	});
});