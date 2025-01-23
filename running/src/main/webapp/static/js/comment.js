/**
* details.jsp에 연결
*/

document.addEventListener("DOMContentLoaded", () => {


	const btnRegisterComment = document.querySelector("button#btnRegisterComment");
	if(!btnRegisterComment==''){
		btnRegisterComment.addEventListener('click', registerComment);
	}
	getALLComments();



	/* -------------------------------------콜백함수--------------------------------- */
	
	function getALLComments(){
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
	
	function registerComment(){
		const ctext=document.querySelector("textarea#ctext").value;
		if (ctext == '') {
		            alert("댓글 내용을 반드시 입력하세요");
		            return;
		        }
		const secret=document.querySelector("input#secret");
		let secretType;
		if(secret.checked){
			secretType=1;
		}
		else{
			secretType=0;
		}
		const data={postId:postId, ctext:ctext, userId:signedInUserId, nickname:signedInUserName, commentType:0, secret:secretType};
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

	
	
	
	
	//댓글 목록을 가져올 함수
	function makeCommentSection(data) {
		const sectionComment = document.querySelector("section#commentSection");
		let html = ` <div class="container my-5 py-5">
  <div class="row d-flex justify-content-center">
    <div class="col-md-12 col-lg-10 col-xl-8">
      <div class="card">
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
			let imgsrc = '';

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
							<span class="small text-danger">${secretType}</span>
								</p>`;
					if(!comment.userId=='unknown'){
						html+=`<button class="btnReply ${dnone} btn btn-sm" data-id="${comment.id}">답글</button>`;
					}

			if (signedInUserId == comment.userId) {
				html += `<button class="btnUpdateComment btn btn-outline-success btn-sm" data-id="${comment.id}">수정</button>
					     <button class="btnDeleteComment btn btn-outline-danger btn-sm" data-id="${comment.id}">삭제</button>`;
			}
			html+=`</div>`;
			
			if(!comment.parentId==""){
				//TODO: parentNickName을 넣을 것.
				html+=`<span class="sm text-muted h6"><em>@${comment.parentId}</em></span>`;
			}

			html += ` <span class="small mb-0">${ctext}</span>
						</div>
							</div>
								</div>
									</div>`;
		}
		sectionComment.innerHTML = html;
		
		const btnDeletes = document.querySelectorAll("button.btnDeleteComment");
		for (const btn of btnDeletes) {
		    btn.addEventListener('click', deleteComment);
		}

		const btnUpdates = document.querySelectorAll("button.btnUpdateComment");
		for (const btn of btnUpdates) {
		    btn.addEventListener('click', updateComment);
		}
		const btnReplies=document.querySelectorAll("button.btnReply");
		for (const btn of btnReplies) {
				    btn.addEventListener('click', replyComment);
				}
	}
	
	//댓글 삭제 버튼의 클릭 이벤트 리스너 
	function deleteComment(event) {
	    console.log(event.target);

	    //HTML 요소의 속성(attribute)의 값을 찾음:
	    const commentId = event.target.getAttribute('data-id');
		
	    const result = confirm("댓글을 삭제하시겠습니까?");

	    if (!result) {
	        return;
	    } else {
			axios.get(`../api/comment/deletetest/${commentId}`).then(
				(response)=>{
					
					
					//대댓글이 존재하는 댓글인지 아닌지 검사
					const result=response.data;
					if(result==0){
						//대댓글이 존재하며 최상위 댓글일 때 댓글일 때, userId와 nickname을 삭제하고 내용을 없앰.
						const ctext="작성자에 의해 삭제된 댓글입니다";
						const data={id:commentId, ctext:ctext, userId:'unknown', nickname:'unknown'};
						axios.put(`../api/comment/deleteinvalidcomment/${commentId}`,data).then((response)=>{
							console.log(response);
						}).catch(
							(error) => {console.log(error);}
						);
						alert('댓글이 삭제됐습니다');
						getALLComments();
						
						
					}else{
						//그 외, 그냥 삭제 가능
						//Ajax 댓글 삭제 요청 REST API (요청 URI)
						        const uri = `../api/comment/${commentId}`;
						        //Ajax 요청을 보냄.
						        axios
						            .delete(uri).then((response) => {
						                console.log(response);
						            }).catch((error) => {
						                console.log(error);
						            });
						        alert('댓글이 삭제됐습니다');
						        getALLComments();
					}
				}
			).catch((error)=>{
				console.log(error);
			});
			
	    }
		}











})