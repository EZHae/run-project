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
	
	/* ▼▼▼▼▼▼▼▼▼ 댓글/답글 관련 ▼▼▼▼▼▼▼▼▼ */
	// 페이지 들어오자마자 해당 postId에 작성되어 있는 댓글/답글 목록을 출력
	let currentPage = 0;
	const pageSize = 10;
	const blockSize = 5;
	getPagedComments(currentPage);
	// getALLComments();

	/**
	 * 댓글 작성 버튼을 클릭하면 registerComment 함수를 호출 하는데, 
	 * 함수에서 객체(data = TCommentCreateDto)를 생성하지 않고 생성을 한 후, 함수에 아규먼트로 전달함.
	 * - 이유: 댓글 작성뿐만 아니라 답글 작성도 해당 함수를 사용하기 때문에, 객체를 생성 후 전달하는게 안정적임. 
	 * 
	 * @function registerComment 댓글을 DB에 추가하기 위해 axios.post를 호출하는 함수
	 * 		@param data 댓글 생성에 필요한 TCommentCreateDTo 객체
	 */
	const btnRegisterComment = document.querySelector("button#btnRegisterComment");
	btnRegisterComment.addEventListener('click', () => {
		const ctext = document.querySelector('textarea#ctext').value;
		const userId = signedInUserId;
		const nickname = signedInUserNickname;
		const commentType = 0;
		
		const data = { teamId, postId, ctext, userId, nickname, commentType };
		registerComment(data);
		});
	
	/** 
	 * 댓글/답글의 작성 버튼 클릭 시 호출될 함수 
	 * 
	 * @param data 작성 버튼을 클릭 했을 때 만들어질 commentCreateDto 객체
	 */
	function registerComment(data) {
		console.log('registerComment');
		console.log(data);
		
		if (!data.ctext || data.ctext.trim() === '') {
			alert("내용을 반드시 입력하세요");
			return;
		}
		
		axios.post('../api/tcomment', data).then((response) => {
			if (response.data === 1) {
				
				if (data.parentId) {
					alert('답글을 등록하였습니다.');
					document.querySelector(`div#replyId-${data.parentId} textarea#ctext`).value = '';
				} else {
					alert('댓글을 등록하였습니다.');
					document.querySelector('textarea#ctext').value = '';
				}
				
				// 댓글/답글 작성 후 댓글/답글 목록을 새로 받아와 출력한다.
				getPagedComments(currentPage);
			}
		}).catch((error) => {
			console.log(error);
		});
	}
	 
	/**
	 * 현재 보고있는 포스트에 달려있는 댓글/답글 목록을 가져온다.
	 * + 페이징처리 되어 있음.
	 * TComment-mapper.xml 참고
	 * 
	 * 호출: TCommentController getPagedComments() -> 리턴: Map<String, Object>
	 * 리턴받은 Map의 comments, currentPage, totalPages를 각각 필요한 메서드에 전달
	 * 
	 * @param page 해당 페이지에 있는 댓글 리턴(최대 10개 리턴, 기본값 0)
	 * @function makeCommentSection 리턴받은 TCommentItemDto 객체를 html로 출력하게 하는 함수
	 * @function renderPagination 리턴받은 현재 페이지와 총 페이지 개수를 html(페이징 숫자 버튼)로 출력하게 하는 함수
	 */
	function getPagedComments(page) {
		console.log('getPagedComments');
	    const uri = `../api/tcomment/paged/${postId}?page=${page}&size=${pageSize}`;

	    axios.get(uri).then((response) => {
	        const data = response.data;
			console.log(data);
	        makeCommentSection(data.comments);
	        renderPagination(data.currentPage, data.totalPages);
			if (data.comments.length === 0) {
				const sectionComment = document.querySelector("section#commentSection");
				
				const html =
				`<div class="container my-1 py-1">
					<div class="row d-flex justify-content-center">
						<div class="col-md-12 col-lg-10 col-xl-8"> 
							<div class="card p-4">
								<p class="text-center">등록된 댓글이 없습니다.</p>
							</div>
						</div>
					</div>
				</div>`
				
				sectionComment.innerHTML = html;
			}
	    }).catch((error) => {
	        console.log(error);
	    });
	}
	/*
	function getALLComments() {
		console.log('getALLComments');
		
	    const uri = `../api/tcomment/all/${postId}`;

	    axios.get(uri).then((response) => {
	        console.log(response);

			// 받아온 data를 해당 함수에 전달하여 html을 출력한다.
	        makeCommentSection(response.data);
			
			if (response.data.length === 0) {
				const sectionComment = document.querySelector("section#commentSection");
				
				const html =
				`<div class="container my-1 py-1">
					<div class="row d-flex justify-content-center">
						<div class="col-md-12 col-lg-10 col-xl-8"> 
							<div class="card p-4">
								<p class="text-center">등록된 댓글이 없습니다.</p>
							</div>
						</div>
					</div>
				</div>`
				
				sectionComment.innerHTML = html;
			}
	    })
	        .catch((error) => {
	            console.log(error)
	        });
	}
	*/

	/**
	 * 리턴받은 현재 페이지와 총 페이지 개수를 html(페이징 숫자 버튼)로 출력하게 하는 함수
	 * 
	 * @param currentPage 현재 페이지
	 * @param totalpages 총 페이지 개수
	 * @function createPaginationButton 페이징 버튼(이전, 숫자, 다음)에 해당 페이지로 이동하는 기능을 넣는 함수 
	 * 		@param text 페이징 버튼에 출력될 글자 
	 * 		@param page 이동할 페이지 번호
	 */
	function renderPagination(currentPage, totalPages) {
	    const pagination = document.querySelector('#pagination');
	    pagination.innerHTML = '';

	    let startPage = Math.floor(currentPage / blockSize) * blockSize;
	    let endPage = Math.min(startPage + blockSize, totalPages);

		// 시작 페이지가 0보다 크면(댓글이 50개 초과인 경우, 한 페이지당 10개씩 출력되기 때문)
		// 시작 페이지 번호는 1, 6, 11, ... 처럼 1부터 5씩 증가됨(blocksize를 5로 지정했기 때문에)
	    if (startPage > 0) {
			// '이전' 버튼 생성, page = 사용자가 보고 있는 블럭의 시작페이지 -1 블럭
			// ex) 7페이지를 보고 있었으면 startPage는 6이므로, 5페이지로 이동 
	        const prevButton = createPaginationButton('이전', startPage - 1);
	        pagination.appendChild(prevButton);
	    }

		// 페이지 번호를 마지막 페이지번호 까지 생성
	    for (let i = startPage; i < endPage; i++) {
	        const pageButton = createPaginationButton(i + 1, i);
	        if (i === currentPage) {
				// 사용자가 해당 페이지를 보고 있으면 active 효과 추가
	            pageButton.classList.add('active');
	        }
	        pagination.appendChild(pageButton);
	    }

		// 마지막 페이지가 전체페이지보다 적은 경우
	    if (endPage < totalPages) {
			// '다음' 버튼 생성
	        const nextButton = createPaginationButton('다음', endPage);
	        pagination.appendChild(nextButton);
	    }
	}

	/**
	 * 페이징 버튼(이전, 숫자, 다음)에 해당 페이지로 이동하는 기능을 넣는 함수
	 * + 해당 버튼 클릭 시 해당 페이지에 있는 comments를 요청하게 됨
	 * 
	 * @param text 버튼에 출력될 글자
	 * @param page 버튼을 클릭 시 @function getPagedComments(@param currentPage)를 호출하여 해당 페이지에 있는 comments를 요청
	 */
	function createPaginationButton(text, page) {
	    const li = document.createElement('li');
	    li.classList.add('page-item');

	    const button = document.createElement('button');
	    button.classList.add('page-link');
	    button.innerText = text;
	    button.addEventListener('click', () => {
	        currentPage = page;
	        getPagedComments(currentPage);
	    });

	    li.appendChild(button);
	    return li;
	}
	
	/**
	 * 댓글/답글 목록 데이터를 html로 출력하기 위한 함수.
	 * 
	 * @param comments html로 출력할 댓글/답글 목록 데이터
	 */
	function makeCommentSection(comments) {
		console.log('makeCommentSection');
		console.log(comments);
		
		// 데이터를 출력할 최상위 section (이 section의 자식으로 댓글/답글을 출력함.)
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

		/**
		 * 댓글/답글 목록 데이터를 한 개씩 comment 객체로 만든 후,
		 * comment가 가지고 있는 데이터 정보들을 이용하여 html을 출력함. 
		 */
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
			
			// 받아온 데이터가 댓글인지, 답글인지 확인
			const divCommentContainer = document.createElement('div');
				divCommentContainer.setAttribute("id", `comment-${id}`);
				if (parentId === null) {
					console.log('▼댓글▼');
					divCommentContainer.classList.add('comment-container', 'mt-3');
				} else {
					console.log('▼답글▼');
					divCommentContainer.classList.add('reply-container', 'ms-5', 'mt-3');
				}
				divCard.appendChild(divCommentContainer);
			
			// 댓글/답글에 답글을 달 수 있는 영역을 미리 설정
			const divReply = document.createElement('div');
				divReply.classList.add('replySection');
				divReply.setAttribute('id', `replyId-${id}`);
				divCard.appendChild(divReply);
				
			const divFlex = document.createElement('div');
				divFlex.classList.add('d-flex', 'flex-start');
				divCommentContainer.appendChild(divFlex);
				
			const imgProfile = document.createElement('img');
				imgProfile.classList.add('rounded-circle', 'shadow-1-strong', 'me-3');
				const imgPath = `/running/image/view/user/${userId}`
				imgProfile.src = imgPath;
				imgProfile.alt = 'avatar';
				imgProfile.width = '65';
				imgProfile.height = '65';
				divFlex.appendChild(imgProfile);
				
			const divFlexDetails = document.createElement('div');
				divFlexDetails.classList.add('flex-grow-1', 'flex-shrink-1');
				divFlex.appendChild(divFlexDetails);
			
			const divNull = document.createElement('div');
				divFlexDetails.appendChild(divNull);
			
			/**
			 * 실질적으로 사용자가 확인할 수 있는 데이터 정보들
			 * (작성자 닉네임, 작성시간, 상위 댓/답글 닉네임 from 답글(@닉네임), 내용)
			 */
			const divComment = document.createElement('div');
				divComment.classList.add('d-flex', 'justify-content-between', 'text-center');
				divNull.appendChild(divComment);
				
			const divFirst = document.createElement('div');
				divFirst.classList.add('flex-grow-1', 'text-start');
				divComment.appendChild(divFirst)
			
			const divSecond = document.createElement('div');
				divSecond.classList.add('text-end');
				divComment.appendChild(divSecond);
				
			
			
			// 상위 댓/답글 닉네임 from 답글
			const spanNickname = document.createElement('span');
				spanNickname.classList.add('sm', 'text-muted', 'h6');
				if (parentId != null) {
					const emTag = document.createElement('em');
					let nickname = '';
					
					const url = `../api/tcomment/nickname/${parentId}`;
					axios.get(url).then((response) => {
						nickname = response.data;
						// console.log(nickname);
						
						emTag.innerText = '@' + nickname + ' ';
											
						spanNickname.appendChild(emTag);
						divNull.appendChild(spanNickname);
						
						// 내용
						const spanCtext = document.createElement('span');
							spanCtext.classList.add('small', 'mb-0');
							spanCtext.setAttribute('data-id', id);
							spanCtext.innerText = ctext
							divNull.appendChild(spanCtext);
					})
					.catch((error) => {
						console.log(error);
					}); 
					
				} else {
					// 내용
					const spanCtext = document.createElement('span');
						spanCtext.classList.add('small', 'mb-0');
						spanCtext.setAttribute('data-id', id);
						spanCtext.innerText = ctext
						divNull.appendChild(spanCtext);
				}
			
			// 작성자 닉네임
			const pNickname = document.createElement('p');
				pNickname.classList.add('mb-1');
				pNickname.innerText = nickname;
				divFirst.appendChild(pNickname);
			
			// 작성 시간
			const spanTime = document.createElement('span');
				spanTime.classList.add('small');
				console.log(createdTime);
				spanTime.innerText = ' ' + formatCreateTime(createdTime);
				pNickname.appendChild(spanTime);
			/**
			 * comments들을 for-each하여 comment 객체를 만들고, comment가 가진 createdTime을
			 * spanTime에 바로 넣지 않고, 형식을 변형하여 출력하게 하는 함수.
			 * createdTime은 LocalDateTime으로 저장되어 있기에 배열로 출력되는데, 이를 Date 타입으로 바꾸어 저장함.
			 * 그 후 현재 시간과 비교하여 출력결과를 각각 다르게 출력한다.
			 * 작성한지 60분 미만일 경우 'n분 전', 24시간 미만일 경우 'n시간 전', 그 이상일 경우 생성일시를 출력.
			 * 
			 * @param createdTimeData comment가 가지고 있는 LocalDateTime 타입 createdTime 이름을 가진 변수
			 */
			function formatCreateTime(createdTimeData) {
				const createdDateTime = new Date(createdTimeData[0], createdTimeData[1] - 1, createdTimeData[2]
					, createdTimeData[3], createdTimeData[4], createdTimeData[5]
				); // 순서대로 연도, 월, 일, 시, 분, 초

				// 현재 시간 가져오기
				const now = new Date();

				// 시간 차이 계산 (ms)
				const diffMs = now - createdDateTime;
				const diffMinutes = Math.floor(diffMs / (1000 * 60)); // 분
				const diffHours = Math.floor(diffMinutes / 60); // 시

				if (diffMinutes < 60) { // 1시간 이내일 경우 분 단위 표시
					return `${diffMinutes}분 전`;
				} else if (diffHours < 24) { // 1시간 이상, 24시간 미만면 시간 단위 표시
					return `${diffHours}시간 전`;
				} else { // 그 외(24시간 이상)일 경우 날짜 표시
					return createdDateTime.toISOString().split('T')[0];
				}
			}
			
			/**
			 * 댓/답글 수정 버튼
			 * 버튼 클릭 시 내용(ctext) 영역이 span에서 textarea로 변경됨. 
			 * @function openUpdateCommentForm 해당 버튼 클릭 시 호출할 댓글 수정 Form 함수
			 */
			const btnUpdateComment = document.createElement('button');
				btnUpdateComment.setAttribute('id', 'btnUpdateComment')
				btnUpdateComment.classList.add('btn', 'btn-sm', 'btn-outline-success', 'me-1');
				btnUpdateComment.setAttribute('data-id', id);
				btnUpdateComment.innerText = '수정';
				btnUpdateComment.addEventListener('click', openUpdateCommentForm);
			
			/**
			 * 댓/답글 삭제 버튼
			 * 해당 댓글이 실제로는 삭제되지 않고, '작성자가 삭제한 댓글입니다.'로 변경되며,
			 * 아무런 접근을 할 수 없게 됨(deleted컬럼의 값을 0 -> 1로 변경) 
			 */
			const btnDeleteComment = document.createElement('button');
				btnDeleteComment.setAttribute('id', 'btnDelete');
				btnDeleteComment.classList.add('btn', 'btn-sm', 'btn-outline-danger', 'me-1');
				btnDeleteComment.setAttribute('data-id', id);
				btnDeleteComment.innerText = '삭제';
				btnDeleteComment.addEventListener('click', (event) => {
					const id = event.target.getAttribute('data-id');
					console.log('deleteComment(id =', id, ')');

					const result = confirm('댓글을 삭제하시겠습니까?');
					if (!result) {
						return;
					} else {
						const uri = `../api/tcomment/delete/${id}`;
						axios.put(uri, id).then((response) => {
							console.log(response);
						})
						.catch((error) => {
							console.log(error);
						});
					alert('댓글이 삭제되었습니다.');

					getPagedComments(currentPage);
					}
				});
				
				if (deleted === 0 && signedInUserId == userId) {
					divSecond.appendChild(btnUpdateComment);
					divSecond.appendChild(btnDeleteComment);
				}
			
			/**
			 * 답글 작성 버튼
			 * 버튼 클릭 시 답글을 작성할 수 있는 모달을 출력함.
			 * 
			 * @function openReplyCommentForm 해당 버튼 클릭 시 호출할 답글작성Form 함수
			 * 
			 * 추가로 해당 모달이 열려 있는 상태에서 또 다시 버튼을 클릭 하면 해당 영역을 제거함.
			 */
			const btnReplyComment = document.createElement('button');
				btnReplyComment.setAttribute('id', 'btnReplyComment')
				btnReplyComment.classList.add('btn', 'btn-sm', 'btn-outline-dark');
				btnReplyComment.setAttribute('data-id', id);
				btnReplyComment.setAttribute('data-teamId', teamId);
				btnReplyComment.setAttribute('data-postId', postId);
				btnReplyComment.innerText = '답글';
				btnReplyComment.addEventListener('click', (event) => {
					const parentId = event.target.getAttribute('data-id');
					const divReply = document.querySelector(`div#replyId-${parentId}`);

					// 이미 열려 있는 폼이 있으면 제거
					// 기존 폼을 닫기만 하고 새 폼을 열지 않음
					if (divReply.innerHTML.trim() !== '') {
						divReply.innerHTML = '';
						return; 
					}
					openReplyCommentForm(event);
				});
				
				if (deleted === 0 && !signedInUserId == '' || !signedInUserId == null) {
					divSecond.appendChild(btnReplyComment);
				}

			// 최종적으로 만들어진 html(댓/답글)을 divContainer에 상속한다.
			sectionComment.appendChild(divContainer);
			// -> for-each이기 때문에 반복.
		});
	}
	
	/**
	 * 댓/답글 수정 버튼 클릭 시 생성하여 변경될 모달 함수
	 * 
	 * 기존에 ctext가 출력되고 있는 영역(span)을 사용자가 변경할 수 있는 영역(textarea)로 변경함.
	 * 사용자가 도중에 취소 버튼을 누를 경우 이 함수에서 생성된 영역을 지우고 원래 있던 영역(span)으로 변경함.
	 */
	function openUpdateCommentForm(event) {
		console.log('openUpdateCommentForm');
		
		const id = event.target.getAttribute('data-id');
		console.log('updateComment(id =', id, ')');
		
		const uri = `../api/tcomment/${id}`;
		axios.get(uri).then((response) => {
			ctext = response.data.ctext.toString();
			
			// 기존 ctext 영역 백업 (취소 버튼 클릭 시 복원하기 위해)
			const updateCtext = document.querySelector(`span[data-id="${id}"]`);
			if (updateCtext === null) {
				return;
			}
			console.log('기존 영역: ', updateCtext);
			
			// 기존 ctext 내용 백업 (취소 버튼 클릭 시 복원하기 위해)
			const originCtext = updateCtext.innerText;
			console.log('기존 ctext: ', originCtext);
			
			const inputCtext = document.createElement('textarea');
				inputCtext.classList.add('form-control', 'mb-2');
				inputCtext.setAttribute('id', `update-input-${id}`);
				inputCtext.setAttribute('rows', 2);
				inputCtext.innerText = ctext;
				
			const btnUpdate = document.createElement('button');
				btnUpdate.classList.add('btn', 'btn-primary');
				btnUpdate.setAttribute('id', 'updateCommentButton');
				btnUpdate.setAttribute('data-id', id);
				btnUpdate.innerText = '수정';
				btnUpdate.addEventListener('click', () => {
					const ctext = inputCtext.value;
					
					const result = confirm('댓글을 수정하시겠습니까?');
					if (!result) {
						return;
					} else {
						const uri = `../api/tcomment/update/${id}`;
						const data = { id, ctext };
						console.log(data);
						
						axios.put(uri, data).then((response) => {
							console.log(response);
						}).catch((error) => {
							console.log(error);
						});
					alert('댓글이 수정되었습니다.');
					
					getPagedComments(currentPage);
					}
				});
				
			const btnCancel = document.createElement('button');
				btnCancel.classList.add('btn', 'btn-outline-danger');
				btnCancel.setAttribute('id', 'updateCancelButton');
				btnCancel.setAttribute('data-id', id);
				btnCancel.innerText = '취소';
				
				updateCtext.replaceWith(inputCtext);
				
				inputCtext.after(btnUpdate, btnCancel);
				
				btnCancel.addEventListener('click', () => {
					btnUpdate.remove(); 
					btnCancel.remove(); 
					inputCtext.replaceWith(updateCtext); // textarea를 span으로 변경
					updateCtext.innerText = originCtext; // 백업된 ctext 복원
				});
		})
		.catch((error) => {
			console.log(error);
		});
	}
	
	/**
	 * 답글 버튼 클릭 시 생성될 모달 함수
	 * 답글을 작성할 수 있는 영역
	 * 
	 * 무조건 답글이기 때문에, commentType을 1로 할당함.
	 */
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
		
		divReply.innerHTML = '';
		
		const divReplyCreateContainer = document.createElement('div');
			divReplyCreateContainer.classList.add('reply-container', 'ms-5', 'mt-3');
			
		const divFlex = document.createElement('div');
			divFlex.classList.add('d-flex', 'flex-start');
			divReplyCreateContainer.appendChild(divFlex);

		const imgProfile = document.createElement('img');
			imgProfile.classList.add('rounded-circle', 'shadow-1-strong', 'me-3');
			const imgPath = `/running/image/view/user/${userId}`
			imgProfile.src = imgPath;
			imgProfile.alt = 'avatar';
			imgProfile.width = '65';
			imgProfile.height = '65';
			divFlex.appendChild(imgProfile);

		const divFlexDetails = document.createElement('div');
			divFlexDetails.classList.add('flex-grow-1', 'flex-shrink-1');
			divFlex.appendChild(divFlexDetails);
		
		const divNull = document.createElement('div');
			divFlexDetails.appendChild(divNull);
			
		const divReplyComment = document.createElement('div');
			divReplyComment.classList.add('d-flex', 'justify-content-between', 'align-items-center');
			divNull.appendChild(divReplyComment);
			
		const pNickname = document.createElement('p');
			pNickname.classList.add('mb-1');
			pNickname.innerText = nickname;
			divReplyComment.appendChild(pNickname);
			
		const divReplyInput = document.createElement('div');
			divReplyInput.classList.add('comment-input-area', 'mt-3');
			divNull.appendChild(divReplyInput);
		
		const textReplyComment = document.createElement('textarea');
			textReplyComment.classList.add('form-control', 'mb-2')
			textReplyComment.setAttribute('id', 'ctext');
			textReplyComment.setAttribute('rows', 2);
			textReplyComment.setAttribute('placeholder', '답글 내용을 입력하세요.');
			divReplyInput.appendChild(textReplyComment);
			
		const btnRegisterReplyComment = document.createElement('button');
			btnRegisterReplyComment.classList.add('btn', 'btn-primary');
			btnRegisterReplyComment.setAttribute('id', 'submitCommentButton');
			btnRegisterReplyComment.setAttribute('parent-id', parentId);
			btnRegisterReplyComment.innerText = '작성';
			/**
			 * 답글 작성 버튼을 클릭하면 registerComment 함수를 호출 하는데, 
			 * 함수에서 객체(data = TCommentCreateDto)를 생성하지 않고 생성을 한 후, 함수에 아규먼트로 전달함.
			 * - 이유: 답글 작성뿐만 아니라 댓글 작성도 해당 함수를 사용하기 때문에, 객체를 생성 후 전달하는게 안정적임. 
			 * 
			 * @function registerComment 댓글을 DB에 추가하기 위해 axios.post를 호출하는 함수
			 * 		@param data 댓글 생성에 필요한 TCommentCreateDTo 객체
			 */
			btnRegisterReplyComment.addEventListener('click', () => {
				const ctext = textReplyComment.value;
				const data = { teamId, postId, ctext, userId, nickname, parentId, commentType };
				registerComment(data);
			});
			divReplyInput.appendChild(btnRegisterReplyComment);
			
		const btnReplyCommentFormClose = document.createElement('button');
			btnReplyCommentFormClose.classList.add('btn', 'btn-outline-danger');
			btnReplyCommentFormClose.setAttribute('id', 'closeReplyFormButton');
			btnReplyCommentFormClose.setAttribute('parentId', parentId);
			btnReplyCommentFormClose.innerText = '닫기';
			btnReplyCommentFormClose.addEventListener('click', () => {
				divReply.innerHTML = '';
			});
			divReplyInput.appendChild(btnReplyCommentFormClose);
		
		// 최종적으로 만들어진 html(답글 작성 폼)을 divReplyCreateContainer에 상속한다.
		divReply.appendChild(divReplyCreateContainer);
		
	}
});