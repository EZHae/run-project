<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Running</title>

<!-- 지해가 작성 -->
<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- Favicons -->
<link href="/assets/img/favicon.png" rel="icon">
<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect">
<link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">


<!-- Main CSS File -->
<link href="assets/css/main.css" rel="stylesheet">

</head>
<body>
	<%@ include file="./fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="홈페이지" />
	</div>
	<%@ include file="./fragments/footer.jspf"%>
<body class="index-page">

	<header id="header" class="header d-flex align-items-center sticky-top">
		<div
			class="container-fluid container-xl position-relative d-flex align-items-center">

			<a href="index.html" class="logo d-flex align-items-center me-auto">
				<!-- Uncomment the line below if you also wish to use an image logo -->
				<!-- <img src="assets/img/logo.png" alt=""> -->
				<h1 class="sitename">Runners</h1>
			</a>

			<nav id="navmenu" class="navmenu">
				<ul>
					<li><c:url value="/" var="homePage" /><a href="${homePag}" class="active">Home<br></a></li>
					<li class="dropdown"><c:url value="/course/list"
							var="courseListPage" /><a href="${courseListPage }"><span>Course</span> <i
							class="bi bi-chevron-down toggle-dropdown"></i></a>
						<ul>
							<li><a href="#">코스 추천</a></li>
							<li><a href="#">코스 리뷰</a></li>
						</ul>
					<li class="dropdown"><c:url value="/team/list"
							var="courseRecruitPage" /><a href="${courseRecruitPage}"><span>Team</span> <i
							class="bi bi-chevron-down toggle-dropdown"></i></a>
						<ul>
							<li><a href="#">팀 생성하기</a></li>
						</ul>
					<li class="dropdown"><c:url value="/gpost/list"
							var="gPostListPage" /><a href="${gPostListPage}"><span>Posts</span> <i
							class="bi bi-chevron-down toggle-dropdown"></i></a>
						<ul>
							<li><a href="#">질문</a></li>
							<li><a href="#">자유</a></li>
						</ul></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
				<i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
			</nav>

			<button class="btn btn-outline-success ms-3" href="#about">Get
				Started</button>
			<a class="btn-getstarted" data-bs-toggle="offcanvas"
				data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">내
				정보</a>
			<!-- 오프캔버스 -->
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
				<div class="offcanvas-header bg-success text-white">
					<h5 class="offcanvas-title" id="offcanvasRightLabel">유저 정보</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<c:if test="${not empty signedInUserId}">
						<div class="d-flex align-items-center mb-3">
							<img src="<c:url value='/image/view/user/${signedInUserId}' />"
								alt="프로필 이미지" class="rounded-circle me-2"
								style="width: 50px; height: 50px;"> <span class="fw-bold">반갑습니다,
								${signedInUserId} 님</span>
						</div>
					</c:if>
					<ul class="list-group list-group-flush">
						<c:if test="${empty signedInUserId}">
							<li class="list-group-item"><c:url value="/user/signin"
									var="userSignInPage" /><a
								class="text-decoration-none fw-semibold text-success"
								href="${userSignInPage}">로그인</a></li>
							<li class="list-group-item"><c:url value="/user/signup"
									var="userSignUpPage" /><a
								class="text-decoration-none fw-semibold text-success"
								href="${userSignUpPage}">회원가입</a></li>
						</c:if>
						<c:if test="${not empty signedInUserId}">
							<li class="list-group-item"><c:url value="/user/signout"
									var="userSignOutPage" /> <a
								class="text-decoration-none fw-semibold text-success"
								href="${userSignOutPage}"> ${signedInUserId} 로그아웃 </a></li>
							<li class="list-group-item"><c:url value="/user/details"
									var="userProfilePage" /> <a
								class="text-decoration-none fw-semibold text-success"
								href="${userProfilePage}">마이페이지</a></li>
							<li class="list-group-item"><c:url
									value="/user/notifications" var="userNotificationPage">
									<c:param name="userid" value="${signedInUserId}"></c:param>
								</c:url><a class="text-decoration-none fw-semibold text-success"
								href="${userNotificationPage}">알림목록</a></li>
						</c:if>
					</ul>
				</div>
			</div>

		</div>
	</header>
	<main class="main">

		<!-- Hero Section -->
		<section id="hero" class="hero section">

			<img src="assets/img/hero-bg-abstract.jpg" alt="" data-aos="fade-in"
				class="">

			<div class="container">
				<div class="row justify-content-center" data-aos="zoom-out">
					<div class="col-xl-7 col-lg-9 text-center">
						<h1>One Page Bootstrap Website Template</h1>
						<p>We are team of talented designers making websites with
							Bootstrap</p>
					</div>
				</div>
				<div class="text-center" data-aos="zoom-out" data-aos-delay="100">
					<a href="#about" class="btn-get-started">Get Started</a>
				</div>

				<div class="row gy-4 mt-5">
					<div class="col-md-6 col-lg-3" data-aos="zoom-out"
						data-aos-delay="100">
						<div class="icon-box">
							<div class="icon">
								<i class="bi bi-easel"></i>
							</div>
							<h4 class="title">
								<a href="">Lorem Ipsum</a>
							</h4>
							<p class="description">Voluptatum deleniti atque corrupti
								quos dolores et quas molestias excepturi</p>
						</div>
					</div>
					<!--End Icon Box -->

					<div class="col-md-6 col-lg-3" data-aos="zoom-out"
						data-aos-delay="200">
						<div class="icon-box">
							<div class="icon">
								<i class="bi bi-gem"></i>
							</div>
							<h4 class="title">
								<a href="">Sed ut perspiciatis</a>
							</h4>
							<p class="description">Duis aute irure dolor in reprehenderit
								in voluptate velit esse cillum dolore</p>
						</div>
					</div>
					<!--End Icon Box -->

					<div class="col-md-6 col-lg-3" data-aos="zoom-out"
						data-aos-delay="300">
						<div class="icon-box">
							<div class="icon">
								<i class="bi bi-geo-alt"></i>
							</div>
							<h4 class="title">
								<a href="">Magni Dolores</a>
							</h4>
							<p class="description">Excepteur sint occaecat cupidatat non
								proident, sunt in culpa qui officia</p>
						</div>
					</div>
					<!--End Icon Box -->

					<div class="col-md-6 col-lg-3" data-aos="zoom-out"
						data-aos-delay="400">
						<div class="icon-box">
							<div class="icon">
								<i class="bi bi-command"></i>
							</div>
							<h4 class="title">
								<a href="">Nemo Enim</a>
							</h4>
							<p class="description">At vero eos et accusamus et iusto odio
								dignissimos ducimus qui blanditiis</p>
						</div>
					</div>
					<!--End Icon Box -->

				</div>
			</div>

		</section>
		<!-- /Hero Section -->
	</main>


	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>
</body>
</html>