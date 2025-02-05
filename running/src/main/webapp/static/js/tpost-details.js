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
	
/**************************************************************************/
	//TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO	

	getALLComments();
	
	
	// 현재 보고있는 포스트에 달려있는 댓글 목록 가져오기
	function getALLComments() {
	    // 댓글 목록을 요청하기 위한 postId
	    const postId = document.querySelector('input#id').value;

	    // 댓글 목록을 요청하기 위한 REST API(요청 URI)
	    const uri = `../api/tcomment/all/${postId}`;

	    // AJAX 요청을 보냄.
	    axios.get(uri).then((response) => { // response.data 속성에 서버가 보내준 댓글 목록이 있음.
	        console.log(response);

	        // divComments 영역에 댓글목록을 출력.
	        makeCommentSection(response.data);
	    })
	        .catch((error) => {
	            console.log(error)
	        });
	}
	
	// 댓글 목록을 가져올 함수
	function makeCommentSection(data) {
		const sectionComment = document.querySelector("section#commentSection");
		let html = 
		`<div class="container my-1 py-1">
			<div class="row d-flex justify-content-center">
	  			<div class="col-md-12 col-lg-10 col-xl-8">
	    			<div class="card p-4">`;
					
		for (const comment of data) {
			const parentId = comment.parentId;
			if (!parentId) {
				//최상위댓글일 때
				html += 
				`<div class="comment-container  mt-3">
					<div class="d-flex flex-start">`;
			} else {
				//대댓글일 때
				html += 
				`<div class="reply-container ms-5 mt-3">
					<div class="d-flex flex-start">`;
			}

			let nickname = '';
			let ctext = '';
			
			//TODO: img src 경로, parentId에 연결된 닉네임가져오기
			axios.get().then().catch();
			
			
			html +=
				`<div class="flex-grow-1 flex-shrink-1">
					<div>
						<div class="d-flex justify-content-between align-items-center">
							<p class="mb-1">
								${comment.nickname} 
								<span class="small">
									- 1 hour ago
								</span>
							</p>`;
			if (comment.userId!=='unknown'&&!signedInUserId=='') {
				html += `<button class="btnReply ${dnone} btn btn-sm" data-id="${comment.id}">답글</button>`;
			}

			if (signedInUserId == comment.userId) {
				html += `<button class="btnUpdateComment btn btn-outline-success btn-sm" data-id="${comment.id}">수정</button>
					     <button class="btnDeleteComment btn btn-outline-danger btn-sm" data-id="${comment.id}">삭제</button>`;
			}
			
			html += `</div>`;

			if (!comment.parentId == "") {
				//TODO: parentNickName을 넣을 것.
				html += `<span class="sm text-muted h6"><em>@${comment.parentId}</em></span>`;
			}

			html += ` <span class="small mb-0" data-id="${comment.id}">${comment.ctext}</span>
						</div>
							</div>
								</div>
									</div>`;
			html += `<div class="replySectoin" id="${comment.id}"></div>`;
		}
		sectionComment.innerHTML = html;

		const btnDeletes = document.querySelectorAll("button.btnDeleteComment");
		for (const btn of btnDeletes) {
			btn.addEventListener('click', deleteComment);
		}

		const btnUpdates = document.querySelectorAll("button.btnUpdateComment");
		for (const btn of btnUpdates) {
			btn.addEventListener('click', openUpdateComment);
		}

		const btnReplies = document.querySelectorAll("button.btnReply");
		for (const btn of btnReplies) {
			btn.addEventListener('click', openReplyCommentForm);
		}
	}
});