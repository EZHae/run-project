/**
 * team/update.jsp 와 연결
 */

document.addEventListener("DOMContentLoaded", () => {
	const selectGenderLimit=document.querySelector("select#genderLimit");
	showGenderOption();
	
	/* -------------------------------------콜백함수--------------------------------- */
	
	function showGenderOption(){
		if(tgenderLimit==0){
			//전체
			selectGenderLimit.innerHTML='<option value="0">성별 무관</option>';
		}
		else if(tgenderLimit==1){
			//남자만
			selectGenderLimit.innerHTML='<option value="1">남자만</option> <option value="0">성별 무관</option>';
			
		}else{
			//여자만nerHTML='<option value="2">여자만</option> <option value="0">성별 무관</option>';
		}
	}
	
});