/**
 * /team/create.jsp에 연결
 */

document.addEventListener("DOMContentLoaded", () => {
	const districtSelect=document.getElementById("districtSelect")
	districtSelect.addEventListener("change", changeParks);

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

});