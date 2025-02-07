<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TeamLists</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>

	<c:forEach items="${teamItemDtoList}" var="team">
		<c:url var="teamDetailPage" value="/team/details">
			<c:param name="teamid" value="${team.teamId}" />
		</c:url>
		<a href="${teamDetailPage}">${team.teamName}</a>
	</c:forEach>

	<div>
		<c:url var="teamCreatePage" value="/team/create" />
		<a href="${teamCreatePage}">새 팀 생성</a>
	</div>

	<div id="map" style="width: 500px; height: 400px;"></div>


	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a968ac66f9f47a5a20d82c0fa106e0f0&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript">
		// <맵 생성>
		var container = document.getElementById('map');
		var options = {
			center : new kakao.maps.LatLng(37.5665, 126.9780), // 서울 중심부(시청 기준)
			level : 9
		};

		var map = new kakao.maps.Map(container, options);
		// </맵 생성>

		//db에서 공원 위도,경도 불러오기
		let positions = []; // 빈 배열 생성
		//parkdata에 공원리스트담기
		//for (const park of parkdata) {
		//positions.push({
		//title: `${park.parkName}`,
		//lat: `${park.parkLat}`,  // 위도 값
		//lng: `${park.parkLng}` // 경도 값
		//});
		//}
		positions.push({
			title : '상암공원',
			lat : 37.5738,
			lng : 126.8955
		})

		var markers = positions.map(function(position) { // 마커를 배열 단위로 묶음
			return new kakao.maps.Marker({
				position : new kakao.maps.LatLng(position.lat, position.lng)
			});
		});

		var clusterer = new kakao.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			minLevel : 5, // 클러스터 할 최소 지도 레벨 
			markers : markers // 클러스터에 마커 추가
		});
	</script>



	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>