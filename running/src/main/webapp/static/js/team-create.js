/**
 * /team/create.jsp에 연결
 */

document.addEventListener("DOMContentLoaded", () => {
	const districtSelect = document.getElementById("districtSelect")
	districtSelect.addEventListener("change", changeParks);

	const teamForm = document.getElementById("teamForm");
	teamForm.addEventListener("submit", validateForm);


	/* -------------------------------------콜백함수--------------------------------- */

	//구를 선택하면 자동으로 공원 목록바뀜
	function changeParks(event) {
		const parkLoc = this.value;
		const parkSelect = document.getElementById("selectPark");

		// 공원 목록 초기화
		parkSelect.innerHTML = '<option value="" selected disabled>공원 선택</option>';

		if (parkLoc) {
			axios.get(`../api/park/search?parkLoc=${parkLoc}`)
				.then((response) => {
					for (const park of response.data) {
						const option = document.createElement("option");
						option.value = park.id;
						option.textContent = park.parkName;
						parkSelect.appendChild(option);
					}

				})
				.catch(error => console.error(error));
		}
	}

	function validateForm(event) {
		event.preventDefault(); // 기본 제출 동작 방지
		const teamName = document.getElementById("teamName").value;
		// 팀 중복 체크 (Axios 요청을 기다림)

		axios.get(`../team/api/count?teamname=${teamName}`).then((response) => {
			if (response.data!=0) {
				alert("같은 이름의 팀이 존재합니다");
				return;
			} else {
				// 모든 검사를 통과하면 폼 제출
				teamForm.submit();
			}
		}).catch((error) => {
			console.log(error);
			alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
		});

	}



});