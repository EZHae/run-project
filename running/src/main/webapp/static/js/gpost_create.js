/**
 * create.jsp 연결
 */

document.addEventListener('DOMContentLoaded', () => {

    const fileInput = document.getElementById("file");
    console.log("fileInput:", fileInput); // 이 값이 null이 아니어야 함

    function loadImg(inputElement) {
        const fileListContainer = document.getElementById("fileList");
        fileListContainer.innerHTML = ""; // 기존 리스트 초기화

        // 파일 선택 배열
        const files = inputElement.files;

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            console.log("in");

            // 파일 이름과 확장자 추출
            let fullname = file.name;
            let parts = fullname.split('.');
            let ext = parts[parts.length - 1].toLowerCase();
            console.log("확장자 : " + ext);

            // li 생성
            let node = document.createElement('li')
            node.className = "list-group-item";


            // 미리보기 HTML (삭제 버튼 포함)
            node.innerHTML = `
            <div>
                <img src="" class="uploadimage"  style="width:50px; height:50px;">
                <span>${fullname}</span>
            </div>
                <input type="button" class="rmbtn btn btn-outline-danger btn-sm" value="삭제">
            `;


            // 삭제 버튼 핸들러
            node.querySelector('.rmbtn').onclick = function() {
                node.remove();

                // DataTransfer를 통해 파일 배열에서 해당 파일 삭제
                const dataTransfer = new DataTransfer();

                // Array.from()을 사용하여 files 배열 복사
                let updatedFiles = Array.from(inputElement.files);

                // 현재 파일을 제거
                updatedFiles.splice(i, 1);
                updatedFiles.forEach(file => dataTransfer.items.add(file));

                inputElement.files = dataTransfer.files;

                // 삭제 후 파일 리스트 갱신
                loadImg(inputElement);
            };
            
            // 이미지 파일 미리보기 생성
            if (file.type.startsWith("image/")) {
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    node.querySelector(".uploadimage").setAttribute("src", e.target.result);
                    fileListContainer.appendChild(node);
                };
                reader.readAsDataURL(file);
                
            } else { // 무조건 이미지로 받기로 했으나 필요시 사용
                
                // 이미지가 아닌 경우 기본 아이콘 적용
                
//                node.querySelector(".uploadimage").setAttribute("src", "/assets/img/defaultfile.jpg");
//                fileListContainer.appendChild(node);
            }
        }
    }
    // 파일 선택 시 loadImg 함수 호출
        fileInput.addEventListener("change", function() {
            loadImg(this);
            // 수정22
            //ㄴㄴㄴ
        
            
    });
});