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
	
	
	// 25-02-12 지해추가: 공원 선택할때 공원지도 미리보기
	const selectPark = document.getElementById("selectPark");
	selectPark.addEventListener('change', (event) => {
		selectParkViewMap(event.target.value);
	});
	
	function selectParkViewMap(id) {
	    console.log(id);
	    
	    axios.get(`../api/park/search/${id}`)
	        .then((response) => {
	            const selectedParkLat = response.data.parklat;
	            const selectedParkLng = response.data.parkLng;
	            
	            console.log(selectedParkLat, selectedParkLng);
	            
	            const container = document.getElementById('map');
	            container.style.width = "100%";
	            container.style.height = `${container.offsetWidth * 0.5}px`; // 2:1 비율
	            
	            let options = {
	                center: new kakao.maps.LatLng(selectedParkLat, selectedParkLng),
	                level: 3
	            };

	            let map = new kakao.maps.Map(container, options);

	            let markerPosition  = new kakao.maps.LatLng(selectedParkLat, selectedParkLng); 
	            let marker = new kakao.maps.Marker({
	                position: markerPosition
	            });

	            marker.setMap(map);

	            // 지도를 다시 그리도록 트리거
	            setTimeout(() => map.relayout(), 100);
	            
	        }).catch((error) => {
	            console.log(error);
	        });
	}
});