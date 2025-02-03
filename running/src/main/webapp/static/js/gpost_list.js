/*
 * 포스트 목록을 카테고리로 보여주는 기능
 */
    
function setCategory(category) {
    //카테고리 값을 설정
    document.getElementById('categoryInput').value = category;
    
    console.log("버튼 카테고리 값:", category);
    
    // 폼 자동 제출
    document.getElementById('searchForm').submit();
}
     // 수정
