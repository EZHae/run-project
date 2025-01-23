/**
 * update.jsp
 */

document.addEventListener('DOMContentLoaded', () => {
	console.log('course-update.js');
	
	// update.jsp가 출력되었을 때 실행할 메서드
	const inputcategory = document.querySelector('input#category');
	const category = inputcategory.value;
	const inputcategoryRec = document.querySelector('input#categoryRec');
	const inputcategoryRev = document.querySelector('input#categoryRev');
	
	// 저장되어 있는 category의 값을 받아와서 해당 category의 속성에 checked 되도록 함.
	if (category == 0) {
		inputcategoryRec.setAttribute('checked', 'checked');
	} else {
		inputcategoryRev.setAttribute('checked', 'checked');
	}
	
	// update.jsp의 btnUpdate를 클릭했을 때 실행할 메서드
	const btnUpdate = document.querySelector('button#btnUpdate');
	btnUpdate.addEventListener('click', () => {
		const updateForm = document.querySelector('form#updateForm');
		const inputTitle = document.querySelector('input#title');
		const inputCourseName = document.querySelector('input#courseName');
		const inputDurationTime = document.querySelector('input#durationTime');
		const inputContent = document.querySelector('input#content');
		
		if (inputTitle.value === '' || inputCourseName === '' || inputDurationTime === '' || inputContent === '') {
			alert('수정 사항을 입력해주세요.');
			return;
		}
		
		const result = confirm('수정 하시겠습니까?');
		if (result) {
			updateForm.method = 'post';
			updateForm.action = 'update';
			updateForm.submit();
		}
	})
});