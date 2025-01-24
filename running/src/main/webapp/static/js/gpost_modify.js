/**
 *  gpost/modify.jsp 파일에 포함
 *  포스트 업데이트, 삭제 기능
 */

document.addEventListener('DOMContentLoaded', ()=>{
    
    // 폼 위치
    const modifyForm = document.querySelector('form#modifyForm');
    // 포스트 제목 위치
    const inputTitle = document.querySelector('input#title');
    // 포스트 아이디 위치
    const inputId = document.querySelector('input#id');
    // 포스트 작성자 위치
    const inputNickname = document.querySelector('input#nickname');
    // 포스트 내용 위치
    const textContent = document.querySelector('textarea#content');
    // 포스트 업데이트 버튼 위치
    const btnUpdate = document.querySelector('button#btnUpdate');
    // 포스트 삭제 버튼 위치
    const btnDelete = document.querySelector('button#btnDelete');
    const category = document.querySelector('input#category').value; // category 값 가져오기
    // 삭제버튼 이벤트 리스너
    btnDelete.addEventListener('click', ()=>{
        const result = confirm('정말 삭제할까요?');
        if(result) {
            
            const deleteUrl = `delete?id=${inputId.value}&category=${category}`;
            console.log("Generated delete URL:", deleteUrl);
            
            location.href = deleteUrl;
        }
    })
    
    // 업데이트버튼 이벤트 리스너
    btnUpdate.addEventListener('click', ()=>{
        
        if(inputTitle.value === '' || textContent.value === ''){
            alert('제목과 내용은 반드시 입력하세요.');
            return;
        }
        
        const result = confirm('변경 내용을 저장할까요?');
        if(result) {
            modifyForm.method = 'post';
            modifyForm.action = 'update';
            modifyForm.submit();
        }

    })
})