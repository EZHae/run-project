/**
 * modify.jsp 연결
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
    // category 값 가져오기
    const category = document.querySelector('input#category').value; 
    console.log("Category element:", category); 
    
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
    
    // 선택한 파일을 요소를 찾음
    const fileInput = document.getElementById("file");
    // 새 이미지의 아이디를 찾음
    const newImageList = document.getElementById("newImageList");

    fileInput.addEventListener("change", function(event) {
        // 새 이미지 미리보기 리스트 초기화
        newImageList.innerHTML = ""; // 기존 리스트 초기화
        
        // 선택한 파일
        Array.from(event.target.files).forEach(file => {
            const reader = new FileReader();
            reader.onload = function(e) {
                //미리보기
                let li = document.createElement('li')
                li.className = "list-group-item";
                // 미리보기 HTML (삭제 버튼 포함)
                li.innerHTML = `
                <div>
                    <img src="${e.target.result}" alt="${file.name}" class="newUploadimage"  style="width:50px; height:50px;">
                    <span>${file.name}</span>
                </div>
                    <input type="button" class="newImageDelete btn btn-outline-danger btn-sm" value="삭제">
                `;
                // 삭제 버튼 이벤트(새 이미지 미리보기 삭제)
                li.querySelector('.newImageDelete').addEventListener("click", function(){
                    li.remove();
                    
                    // DataTransfer를 통해 파일 배열에서 해당 파일 삭제
                    const dataTransfer = new DataTransfer();
                    // 파일 목록 재생성
                    Array.from(fileInput.files).forEach(f => {
                        // 파일 이름을 비교
                        if(f !== file){
                            dataTransfer.items.add(f);
                        }
                    });
                    fileInput.files = dataTransfer.files;
                });
                newImageList.appendChild(li);
            };
            reader.readAsDataURL(file);
        });
    });
    
    // 모든 이미지 삭제 버튼에 이벤트 핸들러 연결
    const deleteButtons = document.querySelectorAll('.rmbtn');
    
    deleteButtons.forEach(button => {
        button.addEventListener("click", function() {
            
            // 삭제 여부
            if(confirm("정말 삭제하시겠습니까?")) {
                
                // 삭제할 이미지 li요소 찾기
                const li = this.closest('li');
                const imageId = li.getAttribute("data-image-id");
                console.log("삭제할 이미지 ID (가져옴):", imageId);
                
                // UI에서 이미지 제거
                li.remove();
                
                // hidden input값 업데이트
                const hiddenInput = document.getElementById('deletedImages');
                console.log("현재 hidden input 값:", hiddenInput.value);
                
                let deletedList = hiddenInput.value ? hiddenInput.value.split(",") : [];
                console.log("현재 deletedList:", deletedList);
                
                
                // 중복 방지
                if(!deletedList.includes(imageId) && imageId){
                    deletedList.push(imageId);
                }
                hiddenInput.value = deletedList.join(",");
                // 수정
            }
        });
    });
});