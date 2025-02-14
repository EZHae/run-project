/**
 * 
 */


document.addEventListener("DOMContentLoaded", () => {
    const aNotifications = document.querySelector('a#notifications');

    function fetchNotificationCount(event) {
        if (!aNotifications) {
            console.warn("알림 링크 요소가 존재하지 않습니다.");
            return;
        }

        const userid = aNotifications.getAttribute('data-user-id');
        console.log("fetchNotificationCount 실행됨!");
        console.log("userId:", userid);

        if (!userid) {
            console.warn("로그인하지 않은 사용자입니다.");
            return;
        }

        const url = `/running/api/notification/${userid}/unread/count`;
        console.log(" API 요청 URL:", url);

        axios.get(url)
            .then(response => {
                const count = response.data;
                console.log("알림 개수:", count);
                updateNotificationBadge(count);
            })
            .catch(error => {
                console.error("알림 개수 가져오기 실패:", error);
            });
    }
    console.log("DOMContentLoaded 실행됨!");
    fetchNotificationCount(); // ✅ 함수 실행 추가
    
    
    function updateNotificationBadge(count) {
        let badge = document.querySelector("#notification-badge");

        if (!badge) {
            // 부모 요소 찾기
            const notificationsLink = document.querySelector("a#notifications");
            if (!notificationsLink) {
                return;
            }

            // 새 배지 생성
            badge = document.createElement("span");
            badge.id = "notification-badge";
            badge.className = "badge rounded-pill bg-danger ms-2";
            notificationsLink.appendChild(badge);
        }

        if (count > 0) {
            badge.textContent = count;
            badge.style.display = "inline-block"; // 배지를 보이게 설정
			const notiHome = document.querySelector("span#notiHome");
			notiHome.className = ""; // class 내용 지우기
			notiHome.innerHTML = "&#10071"; // 빨간 느낌표 삽입
        } else {
            badge.style.display = "none"; // 알림이 없으면 숨김
        }
    }
	
	// 날씨 API 불러오기
		axios.get('http://api.weatherapi.com/v1/current.json?key=3759ad498523499b98591803251402&q=Seoul&aqi=no')
			.then((response) => {
				if (response.data) {  // 응답이 제대로 오면
					getWeatherInfo(response.data);
					console.log('실행중');
				} else {
					console.log('날씨 데이터를 불러오는 데 실패했습니다.');
				}
			})
			.catch((error) => {
				console.log(error);
			});

		// 날씨 정보 처리 함수
		function getWeatherInfo(data) {
			const location = data.location.name;
			const condition = data.current.condition.text;
			const temperature = data.current.temp_c;
			const feelsLike = data.current.feelslike_c;
			const windSpeed = data.current.wind_kph;
			const humidity = data.current.humidity;

			console.log(`현재 ${location}의 날씨`);
			console.log(`상태: ${condition}`);
			console.log(`기온: ${temperature}°C`);
			console.log(`체감 온도: ${feelsLike}°C`);
			console.log(`바람 속도: ${windSpeed} km/h`);
			console.log(`습도: ${humidity}%`);
		}


		// 날씨 정보 처리 함수
		function getWeatherInfo(data) {
			const location = data.location.name;
			const condition = data.current.condition.text;
			const temperature = data.current.temp_c;
			const feelsLike = data.current.feelslike_c;
			const windSpeed = data.current.wind_kph;
			const humidity = data.current.humidity;

			// 원하는 요소에 날씨 정보 삽입
			// 날씨 상태에 맞는 이모티콘 설정
			let conditionEmoji = '';
			switch (condition) {
				case 'Clear':
					conditionEmoji = '☀️';
					break;
				case 'Partly cloudy':
					conditionEmoji = '⛅️';
					break;
				case 'Cloudy':
					conditionEmoji = '☁️';
					break;
				case 'Rain':
					conditionEmoji = '🌧️';
					break;
				case 'Snow':
					conditionEmoji = '❄️';
					break;
				default:
					conditionEmoji = '🌈';
			}

			// 온도 이모티콘
			const temperatureEmoji = temperature >= 25 ? '🔥' : (temperature <= 5 ? '❄️' : '🌤️');

			// 바람 이모티콘
			const windEmoji = windSpeed >= 15 ? '🌬️' : '💨';

			// 습도 이모티콘
			const humidityEmoji = humidity > 60 ? '💧' : '🌫️';

			// 원하는 요소에 날씨 정보 삽입
			const weatherElement = document.querySelector('#weatherInfo');
			weatherElement.innerHTML = `
			        <strong>현재 ${location}의 날씨 ${conditionEmoji}</strong><br>
			        상태: ${condition} ${conditionEmoji} <br>
			        기온: ${temperature}°C ${temperatureEmoji} <br>
			        체감 온도: ${feelsLike}°C <br>
			        바람 속도: ${windSpeed} km/h ${windEmoji} <br>
			        습도: ${humidity}% ${humidityEmoji}`;
		
	}
});