/**
* details.jsp에 연결
*/

document.addEventListener("DOMContentLoaded", () => {


	const btnRegisterComment = document.querySelector("button#btnRegisterComment");
	if (!btnRegisterComment == '') {
		btnRegisterComment.addEventListener('click', registerComment);
	}
	getALLComments();



	/* -------------------------------------콜백함수--------------------------------- */

	function getALLComments() {
		//답댓글이 없는 unknown댓글 삭제
		axios.delete(`../api/comment/deleteunknown`).then((response)=>{
			console.log(response);
		}).catch((error)=>{console.log(error);})
		
		//댓글읽기
		const url = `../api/comment/all/${postId}`;
		axios.get(url).then((response) => {
			if (!response == " ") {
				makeCommentSection(response.data);
			}
		}).catch((error) => {
			console.log(error)
		});
	}

	//일반댓글달기
	function registerComment() {
		const ctext = document.querySelector("textarea#ctext").value;
		if (ctext == '') {
			alert("댓글 내용을 반드시 입력하세요");
			return;
		}
		const secret = document.querySelector("input#secret");
		let secretType;
		if (secret.checked) {
			secretType = 1;
		}
		else {
			secretType = 0;
		}
		const data = { postId: postId, ctext: ctext, userId: signedInUserId, nickname: signedInUserNickname, commentType: 0, secret: secretType };
		axios.post('../api/comment', data).then((response) => {
			if (response.data === 1) {
				alert('댓글 1개 등록 성공');
				document.querySelector('textarea#ctext').value = '';
				secret.checked=false;
				//업데이트된 내용을 보여준다.
				getALLComments();
			}

		}).catch((error) => {
			console.log(error);
		});
	}

	
	//현재시간을 초/분/시로 계산
	function timeAgo(dateString) {
	    const date = new Date(dateString);
	    const now = new Date();
	    const diffInSeconds = Math.floor((now - date) / 1000);
	    
	    if (diffInSeconds < 60) return `${diffInSeconds}초 전`;
	    
	    const diffInMinutes = Math.floor(diffInSeconds / 60);
	    if (diffInMinutes < 60) return `${diffInMinutes}분 전`;
	    
	    const diffInHours = Math.floor(diffInMinutes / 60);
	    if (diffInHours < 24) return `${diffInHours}시간 전`;
	    
	    const diffInDays = Math.floor(diffInHours / 24);
	    if (diffInDays < 30) return `${diffInDays}일 전`;
	    
	    return dateString.toISOString().split('T')[0]; // 30일 이상이면 YYYY-MM-DD 형식으로 표시
	}



	//댓글 목록을 가져올 함수
	function makeCommentSection(data) {
		const sectionComment = document.querySelector("section#commentSection");
		let html = ` <div class="container my-1 py-1">
  <div class="row d-flex justify-content-center">
    <div class="col-md-12 col-lg-10 col-xl-8">
      <div class="card p-4">
         `;
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


			let secretType = ''; //비밀댓글여부 
			let dnone = ''; //reply버튼이 보이는지 여부
			let nickname = '';
			let ctext = '';

			if (comment.secret == 1) {
				//비밀댓글일때
				secretType = '비밀댓글';
				if (signedInUserId === comment.userId || signedInUserId === postUserId || signedInUserId === comment.parentId) {
					//비밀댓글을 볼 수 있는 권한이 있는 사용자
					dnone = ''; //reply버튼이 보임
					nickname = comment.nickname; //작성자가보임
					ctext = comment.ctext; //내용이보임
				} else {
					//비밀댓글을 볼 수 없는 사용자
					dnone = 'd-none'; //reply버튼을 볼 수 없음
					ctext = '비밀댓글을 볼 권한이 없습니다';
				}


			} else {
				//비밀댓글이 아닌 일반 댓글일 때
				secretType = '';
				dnone = ''; //reply버튼이 보임
				nickname = comment.nickname; //작성자가보임
				ctext = comment.ctext; //내용이보임
			}
			
			
			const date = new Date(
				//ajax로 받은 createdTime을 localDateTime으로 변환
			    comment.createdTime[0],      // 연도
			    comment.createdTime[1] - 1,  // 월 (0부터 시작하므로 1을 빼줘야 올바른 월)
			    comment.createdTime[2],      // 일
			    comment.createdTime[3],      // 시
			    comment.createdTime[4],      // 분
			    comment.createdTime[5],      // 초
			    comment.createdTime[6] / 1000000 // 밀리초
			);
			const time=timeAgo(date); //원하는 시간포맷으로 변환
			
			html +=
				`<img class="rounded-circle shadow-1-strong me-3"
					src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(10).webp" alt="avatar" width="65"
					height="65" />
					<div class="flex-grow-1 flex-shrink-1">
					<div>
						<div class="d-flex justify-content-between align-items-center">
							<p class="mb-1">
							${nickname} <span class="small">${time}</span>
							<span class="small text-danger">${secretType}</span>
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
				html += `<span class="sm text-muted h6"><em>@${comment.parentNickname}</em></span>`;
			}

			html += ` <span class="small mb-0" data-id="${comment.id}">${ctext}</span>
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
	

	//댓글수정 버튼 클릭 후
	function openUpdateComment(event) {
		const commentId = event.target.getAttribute('data-id'); //수정할댓글의 아이디
		let ctext='';
		let secret='';
		axios.get(`../api/comment/${commentId}`).then((response)=>{
			ctext = response.data.ctext.toString();
			secret=response.data.secret.toString();
			console.log(ctext);
			
			const updateSpan = document.querySelector(`span[data-id="${commentId}"]`);
			let html=`<textarea class="form-control mb-2" id="update-input-${commentId}" rows="2">${ctext}</textarea>
					  <!-- 댓글 작성 완료 버튼 -->
					<button class="btn btn-primary" id="updateCommentButton" data-id="${commentId}">수정</button>
					<button class="btn" id="updateCancelButton" data-id="${commentId}">취소</button>
					<input class="form-check-input" type="checkbox" id="update-secret-input-${commentId}">
					<label class="form-check-label" for="privateCommentCheckbox">
					비밀 댓글
					</label>`;
			updateSpan.innerHTML=html;
			
			if(secret==1){
				//기존댓글이 비밀댓글인경우
				document.getElementById(`update-secret-input-${commentId}`).checked = true;
			}
			
			const updateCancelButtons = document.querySelectorAll("button#updateCancelButton");
			for (btn of updateCancelButtons){
				btn.addEventListener('click', getALLComments);
			}
			const updateCommentButtons = document.querySelectorAll("button#updateCommentButton");
			for (btn of updateCommentButtons){
				btn.addEventListener('click', updateComment);
			}
			
		}).catch((error)=>{console.log(error);});
		
	}
	
	//댓글수정
	function updateComment(event){
		const commentId = event.target.getAttribute('data-id'); //수정할 댓글의 아이디
		const ctext = document.querySelector(`textarea[id="update-input-${commentId}"]`);
		if (ctext.value == '') {
			alert("수정할 내용을 반드시 입력하세요");
			return;
		}
		const secret = document.getElementById(`update-secret-input-${commentId}`);
		let secretType;
		if (secret.checked) {
			secretType = 1;
		}
		else {
			secretType = 0;
		}
		const data = {id:commentId, ctext: ctext.value, secret: secretType};
		axios.put(`../api/comment/${commentId}`,data).then((response)=>{
			alert("수정완료");
			getALLComments();
		}).catch((error)=>{console.log(error);})
		
	}
	
	//답글달기 버튼 클릭 후
	function openReplyCommentForm(event) {
		const parentId = event.target.getAttribute('data-id'); //답글달 댓글의 아이디
		const replySection = document.querySelector(`div.replySectoin[id="${parentId}"]`);

		let html = `<div class="reply-container ms-5 mt-3">
		    <div class="d-flex flex-start">
		        <img class="rounded-circle shadow-1-strong me-3"
		             src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(10).webp" 
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
		                    <!-- 비밀 댓글 체크박스 -->
		                    <div class="form-check mb-2">
		                        <input class="form-check-input" type="checkbox" id="secret-input-${parentId}">
		                        <label class="form-check-label" for="privateCommentCheckbox">
		                            비밀 댓글
		                        </label>
		                    </div>
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
		replySection.innerHTML = html;
		const submitCommentButton = document.querySelector(`button#submitCommentButton[parent-id="${parentId}"]`);
		submitCommentButton.addEventListener('click', createReply);
		const submitCancelButton=document.querySelector(`button#submitCancelButton[parent-id="${parentId}"]`);
		submitCancelButton.addEventListener('click',cancelReply);
	}
	
	
	//답글등록취소
	function cancelReply(event){
		const parentId=event.target.getAttribute('parent-id');
		const replySection = document.querySelector(`div.replySectoin[id="${parentId}"]`);
		replySection.innerHTML='';
	}


	//답글등록
	function createReply(event) {
		const parentId = event.target.getAttribute('parent-id');
		const replyInput = document.getElementById(`reply-input-${parentId}`);
		const replyText = replyInput.value;
		if (replyText == '') {
			alert("댓글 내용을 반드시 입력하세요");
			return;
		}
		const secret = document.getElementById(`secret-input-${parentId}`);
		let secretType;
		if (secret.checked) {
			secretType = 1;
		}
		else {
			secretType = 0;
		}
		const data = {
			postId: postId, ctext: replyText, userId: signedInUserId, nickname: signedInUserNickname, commentType: 1,
			parentId: parentId, secret: secretType
		};
		axios.post('../api/comment', data).then((response) => {
			if (response.data === 1) {
				alert('댓글 1개 등록 성공');
				document.querySelector('textarea#ctext').value = '';
				//업데이트된 내용을 보여준다.
				getALLComments();
			}

		}).catch((error) => {
			console.log(error);
		});
	}


	//댓글 삭제 버튼의 클릭 이벤트 리스너 
	function deleteComment(event) {
		//HTML 요소의 속성(attribute)의 값을 찾음:
		const commentId = event.target.getAttribute('data-id');
		console.log(commentId);
		const result = confirm("댓글을 삭제하시겠습니까?");

		if (!result) {
			return;
		} else {
			axios.get(`../api/comment/deletetest/${commentId}`).then(
				(response) => {
					//대댓글이 존재하는 댓글인지 아닌지 검사
					const result = response.data;
					if (result == 0) {
						//대댓글이 존재하며 최상위 댓글일 때 댓글일 때, userId와 nickname을 삭제하고 내용을 없앰.
						const ctext = "작성자에 의해 삭제된 댓글입니다";
						const data = { id: commentId, ctext: ctext, userId: 'unknown', nickname: 'unknown' };
						axios.put(`../api/comment/updatetounknown/${commentId}`, data).then((response) => {
							console.log(response);
							if (response.data === 1) {
								alert('댓글이 삭제됐습니다');
								getALLComments();
							}
						}).catch(
							(error) => { console.log(error); }
						);

					} else {
						//그 외, 그냥 삭제 가능
						//Ajax 댓글 삭제 요청 REST API (요청 URI)
						const uri = `../api/comment/${commentId}`;
						//Ajax 요청을 보냄.
						axios
							.delete(uri).then((response) => {
								console.log(response);
								if (response.data === 1) {
									alert('댓글이 삭제됐습니다');
									getALLComments();
								}
							}).catch((error) => {
								console.log(error);
							});
					}
				}
			).catch((error) => {
				console.log(error);
			});

		}
	}











})