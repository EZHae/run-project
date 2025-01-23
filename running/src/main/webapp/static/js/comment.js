/**
* details.jsp에 연결
*/

document.addEventListener("DOMContentLoaded", () => {
	//댓글 화면에 띄우기

	//TODO 임의로 글작성자 이름 저장 => 다시 테스트할 때 postUserId 받아오기!!!
	const postUserId = 'user1';


	//포스트1 댓글읽기
	const url=`../api/comment/all/${postId}`;
		axios.get(url).then((response) => {
			makeCommentSection(response.data);
		}).catch((error) => {
			console.log(error)
		});




	/* -------------------------------------콜백함수--------------------------------- */

	//댓글 목록을 가져올 함수
	function makeCommentSection(data) {
		const sectionComment = document.querySelector("section#commentSection");
		let html = ` <div class="container my-5 py-5">
  <div class="row d-flex justify-content-center">
    <div class="col-md-12 col-lg-10 col-xl-8">
      <div class="card">
        <div class="card-body p-4">
          <div class="row">
            <div class="col">`;
		for (const comment of data) {
			const parentId = comment.parentId;
			if (!parentId) {
				//최상위댓글일 때
				html += ` <div class="comment-container  mt-3">
                <div class="d-flex flex-start">`;
			}
			else {
				//대댓글일 때
				html += ` <div class="reply-container ms-5 mt-3">
                <div class="d-flex flex-start">`;
			}
			
			
			const secretType = ''; //비밀댓글여부 
			const dnone=''; //reply버튼이 보이는지 여부
			const nickname='';
			const ctext='';
			const imgsrc='';
			
			if (comment.secret == 1) {
				//비밀댓글일때
				secretType = '비밀댓글'; 
				if (signedInUser === comment.userId || signedInUser === postUserId || signedInUser === comment.parentId) {
					//비밀댓글을 볼 수 있는 권한이 있는 사용자
					dnone=''; //reply버튼이 보임
					nickname=comment.nickname; //작성자가보임
					ctext=comment.ctext; //내용이보임
				} else {
					//비밀댓글을 볼 수 없는 사용자
					dnone='d-none'; //reply버튼을 볼 수 없음
					ctext='비밀댓글을 볼 권한이 없습니다';
				}
			
			
			} else {
				//비밀댓글이 아닌 일반 댓글일 때
				secretType = '';
				dnone=''; //reply버튼이 보임
				nickname=comment.nickname; //작성자가보임
				ctext=comment.ctext; //내용이보임
			}
			
			//TODO: img src 경로 바꾸기
			html +=
									`<img class="rounded-circle shadow-1-strong me-3"
								      src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(10).webp" alt="avatar" width="65"
								      height="65" />
									<div class="flex-grow-1 flex-shrink-1">
															      <div>
															        <div class="d-flex justify-content-between align-items-center">
															          <p class="mb-1">
															            ${nickname} <span class="small">- 1 hour ago</span>
															          </p>
																	  <button class="btnReply ${dnone} btn btn-sm" data-id="${comment.id}">답글</button>`;
				
								if (signedInUser === comment.username) {
									html += `<button class="btnUpdateComment btn btn-outline-success btn-sm" data-id="${comment.id}">수정</button>
											 <button class="btnDeleteComment btn btn-outline-danger btn-sm" data-id="${comment.id}">삭제</button>`;
								}
								
								html+=`</div>
															        <p class="small mb-0">${ctext}</p>
															      </div>
															    </div>
															  </div>
															</div>`;
		}
		sectionComment.innerHTML = html;
	}











})