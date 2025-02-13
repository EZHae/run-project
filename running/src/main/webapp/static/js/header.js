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
        } else {
            badge.style.display = "none"; // 알림이 없으면 숨김
        }
    }
});