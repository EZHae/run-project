/**
* details.jsp에 연결
*/

document.addEventListener("DOMContentLoaded", () => {
	//댓글 화면에 띄우기
	
	//임의로 글작성자 이름 저장
	const postUserId='user1';
	
	
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
                <div class="d-flex flex-start">
                  <img class="rounded-circle shadow-1-strong me-3"
                    src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(10).webp" alt="avatar" width="65"
                    height="65" />`
			}
			else {
				//대댓글일 때
				html += ` <div class="reply-container ms-5 mt-3">
                <div class="d-flex flex-start">
                  <img class="rounded-circle shadow-1-strong me-3"
                    src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(11).webp" alt="avatar" width="50"
                    height="50" />`
			}
			if(comment.secret==1){
				//비밀댓글일때
				if(signedInUser===comment.userId||signedInUser===postUserId||signedInUser===comment.parentId){
					//비밀댓글을 볼 수 있는 권한이 있는 사용자
					html +=
													`<div class="flex-grow-1 flex-shrink-1">
												      <div>
												        <div class="d-flex justify-content-between align-items-center">
												          <p class="mb-1">
												            ${comment.nickname} <span class="small">- 1 hour ago</span>
												          </p>
														  <p>비밀댓글</p>
												          <button id="delete"><span class="small">수정</span></button>
												          <button id="update"><span class="small">삭제</span></button>
												        </div>
												        <p class="small mb-0">${comment.ctext}</p>
												      </div>
												    </div>
												  </div>
												</div>`	
				}else{
					//비밀댓글을 볼 수 없는 사용자
					html +=
													`<div class="flex-grow-1 flex-shrink-1">
												      <div>
												        <div class="d-flex justify-content-between align-items-center">
												          <p class="mb-1">
												            ? <span class="small">- 1 hour ago</span>
												          </p>
												          <button id="delete"><span class="small">수정</span></button>
												          <button id="update"><span class="small">삭제</span></button>
												        </div>
												        <p class="small mb-0">비밀댓글입니다</p>
												      </div>
												    </div>
												  </div>
												</div>`			
				}
			}else{
				//비밀댓글이 아닌 일반 댓글일 때
				html +=
								`<div class="flex-grow-1 flex-shrink-1">
							      <div>
							        <div class="d-flex justify-content-between align-items-center">
							          <p class="mb-1">
							            ${comment.nickname} <span class="small">- 1 hour ago</span>
							          </p>
							          <button id="delete"><span class="small">수정</span></button>
							          <button id="update"><span class="small">삭제</span></button>
							        </div>
							        <p class="small mb-0">${comment.ctext}</p>
							      </div>
							    </div>
							  </div>
							</div>`
			}
		}
		sectionComment.innerHTML = html;	
	}
	
	
	
	
	
	
	
	
	
	
	
})