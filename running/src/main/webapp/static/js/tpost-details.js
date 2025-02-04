/**
 * details.jsp
 */

document.addEventListener('DOMContentLoaded', () => {
	console.log('tpost-details.js');
	
	const btnDelete = document.querySelector('button#btnDelete');
	console.log(id);
	
	if (btnDelete !== null) {
		btnDelete.addEventListener('click', () => {
			const result = confirm('삭제 하시겠습니까?');
			if (result) {
				// 사용자가 [확인]을 클릭하면 GET 방식의 /course/delete?id=번호 요청을 보냄.
				location.href = `delete`;
			}
		});
	}
	
});