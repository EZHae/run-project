/**
 * timage/list.jsp
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log('timage-list.js loaded');

    const inputCategoryRadio = document.querySelectorAll('input[name="category"]');
    const divImageList = document.querySelector('div#imageList');
	const modalImage = document.getElementById('modalImage');
	const modalElement = new bootstrap.Modal(document.getElementById('imageModal'));
	

	// 페이지 로드 시 전체 이미지 가져오기 (기본값: category=0)
	fetchImages(0);

    // 현재 teamId 확인 (undefined가 아니라면 정상)
    console.log(`teamId: ${teamId}`);

    // 라디오 버튼 변경 이벤트 리스너 추가
    inputCategoryRadio.forEach(radio => {
        radio.addEventListener('change', (event) => {
            fetchImages(event.target.value);
        });
    });
	
   
	
	/************** 콜 백 함수 **************/
	// 카테고리가 변경될 때마다 실행할 함수 
	function fetchImages(category) {
		const url = `/running/teampage/${teamId}/image/list/api?category=${category}`;
		console.log('불러올 rest 주소: ', url);

		// 서버에서 JSON 데이터 가져오기
		axios.get(url).then((response) => {
			// 받아온 데이터
			const images = response.data;
			console.log('받아온 이미지 데이터:', images);
			
			// 기존 이미지 초기화
			divImageList.innerHTML = '';
			
			if (images.length === 0) {
				const spanNotImage = document.createElement('span');
				spanNotImage.innerText = '등록된 사진이 없습니다.';
				divImageList.appendChild(spanNotImage);
				return;
			}

			// 이미지 리스트 동적 생성
			images.forEach(image => {
				const imgElement = document.createElement('img');
				imgElement.src = `/running/teampage/${teamId}/image/view/${image.uniqName}`;
				imgElement.alt = image.uniqName;
				imgElement.classList.add('img-thumbnail', 'm-2');
				imgElement.style.width = '150px';
				imgElement.style.height = '150px';
				imgElement.style.objectFit = 'cover';

				// 이미지를 클릭하면 모달 열기
				imgElement.addEventListener('click', () => {
					modalImage.src = imgElement.src;
					modalElement.show(); // 모달 열기
				});

				// 생성된 이미지들을 div#imageList에 추가
				divImageList.appendChild(imgElement);
			});
		}).catch((error) => {
			console.log('이미지를 불러오는 중 오류 발생:', error);
		});
	};
});