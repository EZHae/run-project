/**
 * details.jsp
 */

document.addEventListener('DOMContentLoaded', () => {
	console.log('tpost-details.js');
	
	const btnDelete = document.querySelector('button#btnDelete');
	console.log(postId);
	
	if (btnDelete !== null) {
		btnDelete.addEventListener('click', () => {
			const result = confirm('삭제 하시겠습니까?');
			if (result) {
				// 사용자가 [확인]을 클릭하면 GET 방식의 /course/delete?id=번호 요청을 보냄.
				location.href = `delete`;
			}
		});
	}
	
	getALLComments();
/**************************************************************************/
	//TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO	
	const btnRegisterComment = document.querySelector("button#btnRegisterComment");
	
	btnRegisterComment.addEventListener('click', registerComment);
	
	
	
	
	function registerComment() {
		console.log('registerComment');
		const ctext = document.querySelector("textarea#ctext").value;
		const userId = signedInUserId;
		const nickname = signedInUserNickname;
		const commentType = 0;
		
		if (ctext === '') {
			alert("댓글 내용을 반드시 입력하세요");
			return;
		}
		const data = { teamId, postId, ctext, userId, nickname, commentType };
		axios.post('../api/tcomment', data).then((response) => {
			if (response.data === 1) {
				alert('댓글을 등록하였습니다.');
				document.querySelector('textarea#ctext').value = '';
				//업데이트된 내용을 보여준다.
				getALLComments();
			}
		}).catch((error) => {
			console.log(error);
		});
	}
	
	// 현재 보고있는 포스트에 달려있는 댓글 목록 가져오기
	function getALLComments() {

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
	function makeCommentSection(comments) {
		console.log(comments);
		const sectionComment = document.querySelector("section#commentSection");
		
		sectionComment.innerHTML = '';
		
		const divContainer = document.createElement('div');
			divContainer.classList.add('container', 'my-1', 'py-1');
			
		const divDisplay = document.createElement('div');
			divDisplay.classList.add('row', 'd-flex', 'justify-content-center');
			divContainer.appendChild(divDisplay);
			
		const divDisplayDetails = document.createElement('div');
			divDisplayDetails.classList.add('col-md-12', 'col-lg-10', 'col-xl-8');
			divDisplay.appendChild(divDisplayDetails);
			
		const divCard = document.createElement('div');
			divCard.classList.add('card', 'p-4');
			divDisplayDetails.appendChild(divCard);

		comments.forEach(comment => {
			console.log(comment);
			
			const id = comment.id;
			const teamId = comment.teamId;
			const postId = comment.postId;
			const ctext = comment.ctext;
			const userId = comment.userId;
			const nickname = comment.nickname;
			const createdTime = comment.createdTime;
			const modifiedTime = comment.modifiedTime;
			const parentId = comment.parentId;
			const commentType = comment.commentType;
			const deleted = comment.deleted;
			
			const divCommentContainer = document.createElement('div');
				divCommentContainer.setAttribute("id", `comment-${id}`);
				if (parentId === null) {
					console.log('댓글');
					divCommentContainer.classList.add('comment-container', 'mt-3');
				} else {
					console.log('답글');
					divCommentContainer.classList.add('reply-container', 'ms-5', 'mt-3');
				}
				divCard.appendChild(divCommentContainer);
			
			const divReply = document.createElement('div');
				divReply.classList.add('replySection');
				divReply.setAttribute('id', `replyId-${id}`);
				divCard.appendChild(divReply);
				
			const divFlex = document.createElement('div');
				divFlex.classList.add('d-flex', 'flex-start');
				divCommentContainer.appendChild(divFlex);
				
			const imgProfile = document.createElement('img');
				imgProfile.classList.add('rounded-circle', 'shadow-1-strong', 'me-3');
				imgProfile.src = 'https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(10).webp';
				imgProfile.alt = 'avatar';
				imgProfile.width = '65';
				imgProfile.height = '65';
				divFlex.appendChild(imgProfile);
				
			const divFlexDetails = document.createElement('div');
				divFlexDetails.classList.add('flex-grow-1', 'flex-shrink-1');
				divFlex.appendChild(divFlexDetails);
			
			const divNull = document.createElement('div');
				divFlexDetails.appendChild(divNull);
			
			
			// 여기부터가 응답받은 comment(response.data)를 활용하는 영역
			const divComment = document.createElement('div');
				divComment.classList.add('d-flex', 'justify-content-between', 'align-items-center');
				divNull.appendChild(divComment);
			
			const spanParentId = document.createElement('span');
				spanParentId.classList.add('sm', 'text-muted', 'h6');
				if (parentId != null) {
					const emTag = document.createElement('em');
					
					emTag.innerText = '@' + parentId;
					
					spanParentId.appendChild(emTag);
					divNull.appendChild(spanParentId);
				}
				
			const spanCtext = document.createElement('span');
				spanCtext.classList.add('small', 'mb-0');
				spanCtext.setAttribute('data-id', id);
				spanCtext.innerText = ctext
				divNull.appendChild(spanCtext);
			
			const pNickname = document.createElement('p');
				pNickname.classList.add('mb-1');
				pNickname.innerText = nickname;
				divComment.appendChild(pNickname);
				
			
			const btnUpdateComment = document.createElement('button');
				btnUpdateComment.setAttribute('id', 'btnUpdateComment')
				btnUpdateComment.classList.add('btn', 'btn-sm', 'btn-outline-success');
				btnUpdateComment.setAttribute('data-id', id);
				btnUpdateComment.innerText = '수정';
				//btnUpdateComment.addEventListener('click');
			
			const btnDeleteComment = document.createElement('button');
				btnDeleteComment.setAttribute('id', 'btnDelete');
				btnDeleteComment.classList.add('btn', 'btn-sm', 'btn-outline-danger');
				btnDeleteComment.setAttribute('data-id', id);
				btnDeleteComment.innerText = '삭제';
				btnDeleteComment.addEventListener('click', deleteComment);
				
				if (deleted === 0 && signedInUserId == userId) {
					divComment.appendChild(btnUpdateComment);
					divComment.appendChild(btnDeleteComment);
				}
			
			const btnReplyComment = document.createElement('button');
				btnReplyComment.setAttribute('id', 'btnReplyComment')
				btnReplyComment.classList.add('btn', 'btn-sm');
				btnReplyComment.setAttribute('data-id', id);
				btnReplyComment.setAttribute('data-teamId', teamId);
				btnReplyComment.setAttribute('data-postId', postId);
				btnReplyComment.innerText = '답글';
				btnReplyComment.addEventListener('click', openReplyCommentForm);
				
				if (deleted === 0 && !signedInUserId == '' || !signedInUserId == null) {
					divComment.appendChild(btnReplyComment);
				}
			
			const spanTime = document.createElement('span');
				spanTime.classList.add('small');
				spanTime.innerText = '-1 hour ago';
				pNickname.appendChild(spanTime);
			

				
			
			
			
			sectionComment.appendChild(divContainer);
			
		});
	}
	
	function deleteComment(event) {
		const id = event.target.getAttribute('data-id');
		console.log('deleteComment(id =', id, ')');
		
		const result = confirm('댓글을 삭제하시겠습니까?');
		if (!result) {
			return;
		} else {
			const uri = `../api/tcomment/delete/${id}`;
			axios.put(uri).then((response) => {
				console.log(response);
			})
			.catch((error) => {
				console.log(error);
			});
		alert('댓글이 삭제되었습니다.');
		
		getALLComments();
		}
	}
	
	//TODO
	function openReplyCommentForm(event) {
		const parentId = event.target.getAttribute('data-id');
		const divReply = document.querySelector(`div#replyId-${parentId}`);
		const teamId = event.target.getAttribute('data-teamId');
		const postId = event.target.getAttribute('data-postId');
		const userId = signedInUserId;
		const nickname = signedInUserNickname;
		const commentType = 1;
		console.log('openReplyCommentForm(to id =', parentId, ')');
		console.log(divReply);
		console.log('openReplyCommentForm(to teamId =', teamId, ')');
		console.log('openReplyCommentForm(to postId =', postId, ')');
		console.log('openReplyCommentForm(by userId =', userId, ')');
		console.log('openReplyCommentForm(by nickname =', nickname, ')');
		console.log('openReplyCommentForm(commentType =', commentType, ')');
		
		let html = 
		`<div class="reply-container ms-5 mt-3">
			<div class="d-flex flex-start">
				<img class="rounded-circle shadow-1-strong me-3" src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(10).webp" 
						alt="avatar" width="65" height="65" />
				<div class="flex-grow-1 flex-shrink-1">
					<div>
						<div class="d-flex justify-content-between align-items-center">
							<p class="mb-1">
								${signedInUserNickname}
							</p>
						</div>
						<!-- 댓글 입력 영역 -->
						<div class="comment-input-area mt-3">
						<!-- 댓글 입력 textarea -->
						<textarea class="form-control mb-2" id="reply-input-${parentId}" rows="2" placeholder="댓글 내용을 입력하세요."></textarea>
						<!-- 댓글 작성 완료 버튼 -->
						<button class="btn btn-primary" id="submitCommentButton" parent-id="${parentId}">작성</button>
						<button class="btn" id="submitCancelButton" parent-id="${parentId}">취소</button>
				        </div>
				    </div>
				</div>
			</div>
		</div>`;
		divReply.innerHTML = html;
	}
});