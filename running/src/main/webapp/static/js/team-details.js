/**
 * team/details.jps에 연결
 */

document.addEventListener("DOMContentLoaded", () => {
	const btnApply = document.querySelector("button#applyButton");
	btnApply.addEventListener('click', registerApplication);

	const btnApplyCancel = document.querySelector("button#applyCancelButton");
	if (btnApplyCancel != null) {
		btnApplyCancel.addEventListener('click', cancelApplication);
	}

	const btnApplyConfirm = document.querySelectorAll("button#applyConfirmButton");
	for (const btn of btnApplyConfirm) {
		btn.addEventListener('click', confirmApplication);
	}

	const btnApplyDeclineButton = document.querySelectorAll("button#applyDeclineButton");
	for (const btn of btnApplyDeclineButton) {
		btn.addEventListener('click', declineApplication);
	}

	const btnForceToResigns = document.querySelectorAll("button#forceToResignButton");
	for (const btn of btnForceToResigns) {
		btn.addEventListener('click', forceToResign);
	}

	const btnTeamDelete = document.querySelector("button#btnTeamDelete");
	btnTeamDelete.addEventListener('click', deleteTeam);

	const btnTeamUpdate = document.querySelector("button#btnTeamUpdate");
	btnTeamUpdate.addEventListener('click', function() { window.location.href = `../team/update?teamid=${teamId}`; });

	/* -------------------------------------콜백함수--------------------------------- */

	//팀 신청 거절
	function declineApplication(event) {
		console.log("거절");
		const userId = event.target.getAttribute('data-id'); //수락할 회원의 아이디
		const nickname = event.target.getAttribute('data-name'); //수락할 회원의 닉네임
		const applyConfirm = confirm(`${nickname}님의 가입 신청을 거절하시겠습니까?`);
		if (applyConfirm) {
			//applications테이블에서 삭제
			axios.delete(`../api/teamapplication/cancel?teamid=${teamId}&userid=${userId}`).then((response) => {
				if (response.data == 1) {
					alert(`${nickname}님의 신청을 거절하였습니다`);
					window.location.href = `../team/details?teamid=${teamId}`;
				}

			}).catch((error) => {
				console.log(error);
			});
		}
	}

	//팀 삭제
	function deleteTeam(event) {
		const result = confirm(`정말 ${teamName}팀을 삭제하시겠습니까? 복구가 불가능합니다.`);
		if (result) {
			axios.delete(`../team/delete?teamid=${teamId}`).then((response) => {
				if (response.data == 1) {
					alert('삭제가 완료되었습니다');
					window.location.href = `../team/list`;
				}
			}).catch((error) => {
				console.log(error);
			})
		}
	}

	//팀 회원 강제탈퇴
	function forceToResign(event) {
		const userId = event.target.getAttribute('data-id'); //탈퇴할 회원의 아이디
		const nickname = event.target.getAttribute('data-name'); //탈퇴할 회원의 닉네임
		axios.delete(`../api/tmember/delete?teamid=${teamId}&userid=${userId}`).then((response) => {
			if (response.data == 1) {
				alert(`${nickname}님을 강제탈퇴하였습니다`);
				//currentNum 업데이트
				axios.put(`../team/api/minusCurrentNum?teamid=${teamId}`).then((response) => {
					if (response.data == 1) {
						console.log('currentNum 1 증가');
						window.location.href = `../team/details?teamid=${teamId}`;
					}
				}).cancel((error) => {
					console.log(error);
				});

			}
		}).catch((error) => {
			console.log(error);
		})
	}

	//팀 회원 수락
	function confirmApplication(event) {
		const userId = event.target.getAttribute('data-id'); //수락할 회원의 아이디
		const nickname = event.target.getAttribute('data-name'); //수락할 회원의 닉네임
		const applyConfirm = confirm(`${nickname}님의 가입 신청을 수락하시겠습니까?`);
		if (applyConfirm) {
			//applications테이블에서 삭제
			axios.delete(`../api/teamapplication/cancel?teamid=${teamId}&userid=${userId}`).then((response) => {
				//members테이블에 추가
				const data = { leaderCheck: 0, teamId: teamId, userId: userId };
				axios.post(`../api/tmember/confirm`, data).then((response) => {
					if (response.data == 1) {
						alert(`${nickname}님의 신청을 수락하였습니다`);
					}
				}).catch((error) => {
					console.log(error);
				});

			}).catch((error) => {
				console.log(error);
			});

			//currentNum 업데이트
			axios.put(`../team/api/plusCurrentNum?teamid=${teamId}`).then((response) => {
				if (response.data == 1) {
					console.log('currentNum 1 증가');
				}
			}).catch((error) => {
				console.log(error);
			});

			//알림테이블 업데이트
			const link = "/team/details?teamid=" + teamId;
			let newTeamName = teamName;

			if (teamName.length > 10) {
				newTeamName = teamName.substring(0, 10);
				newTeamName = newTeamName + '...';
			}
			const noti = { userId: userId, type: 4, link: link, checked: 0, content: newTeamName };

			axios.post(`../api/notification`, noti).then((response) => {
				if (response.data == 1) {
					console.log("알림업데이트");
					window.location.href = `../team/details?teamid=${teamId}`;
				}
			}).catch((error) => {
				console.log(error);
			})
		}
	}

	//팀 회원 신청 취소
	function cancelApplication(event) {
		const deleteConfirm = confirm(`[${teamName}]팀 신청을 취소하시겠습니까?`);
		if (deleteConfirm) {
			axios.delete(`../api/teamapplication/cancel?teamid=${teamId}&userid=${signedInUserId}`).then((response) => {
				if (response.data == 1) {
					window.location.href = `../team/details?teamid=${teamId}`;
				}
			}).catch((error) => {
				console.log(error);
			});
		}
	}

	//팀 회원 신청
	function registerApplication(event) {
		const introMsg = document.querySelector("textarea#message-text").value;
		if (10 > introMsg.length || introMsg.length > 100) {
			alert('10자 이상 100자 이내로 작성해야합니다');
			return;
		}
		const data = { teamId: teamId, userId: signedInUserId, introMsg: introMsg };
		axios.post('../api/teamapplication', data).then((response) => {
			if (response.data == 1) {
				alert('신청성공!');

				//알림테이블 업데이트
				const link = "/team/details?teamid=" + teamId;

				let content = teamName + '/' + introMsg;
				if (content.length > 10) {
					content = content.substring(0, 10);
					content = content + '...';
				}
				const noti = { userId: teamLeaderId, type: 3, link: link, checked: 0, content: content };

				axios.post(`../api/notification`, noti).then((response) => {
					if (response.data == 1) {
						window.location.href = `../team/details?teamid=${teamId}`;
					}
				}).catch((error) => {
					console.log(error);
				})
			}
		}).catch((error) => {
			console.log(error);
		})
	}
})