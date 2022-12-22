<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>

		 <sec:authorize access="isAuthenticated()">
		 
		 <c:if test="${pinfo.member.phone == null}">
		 <script>
		alert("마이페이지에서 추가정보를 입력해주세요")
		location.href="/mypage/${pinfo.member.id }"
		</script>
		</c:if>
 		 </sec:authorize>
<style>
.carousel .carousel-item {
	height: 400px;
}

.carousel-item img {
	min-height: 400px;
	object-fit: cover
}

a {
	color: black;
}
</style>
<div id="carouselExampleIndicators"
	class="carousel slide justify-content-center" data-ride="carousel">
	<ol class="carousel-indicators">
		<li data-target="#carouselExampleIndicators" data-slide-to="0"
			class="active"></li>
		<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	</ol>
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img class="d-block w-100"
				src="/image/1MuYxN3D5YriNiAN3qi8xy5nIZzF93ta.jpg" alt="First slide">
		</div>
		<div class="carousel-item">
			<img class="d-block w-100"
				src="/image/OSAsY7tTnPX6vqhuUO6rrDspShO5znUT.jpg" alt="Second slide">
		</div>
		<div class="carousel-item">
			<img class="d-block w-100"
				src="/image/zy1SJPaI4Z7wBjDwwwpPu4S8UeEii5LL.jpg" alt="Third slide">
		</div>
	</div>
	<a class="carousel-control-prev" href="#carouselExampleIndicators"
		role="button" data-slide="prev"> <span
		class="carousel-control-prev-icon" aria-hidden="true"></span> <span
		class="sr-only">Previous</span>
	</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
		role="button" data-slide="next"> <span
		class="carousel-control-next-icon" aria-hidden="true"></span> <span
		class="sr-only">Next</span>
	</a>
</div>
<section class="py-5">
	<!-- 등록순 -->
	<h3 class="text-center">신상품</h3>
	<div class="container px-4 px-lg-5 mt-3">
		<div class="row justify-content-center">
			<c:forEach items="${product}" var="product" begin="0" end="3">
				<div class="col-3 mb-3">
					<div class="card h-100">
						<!-- Product image-->
						<a href="/pdetail/${product.productid}"><img
							class="card-img-top" src="/image/${product.filename}"
							style="height: 200px" alt="..." /></a>
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-left">
								<!-- Product name-->
								<a href="/pdetail/${product.productid}"><h5
										class="fw-bolder">${product.pname }</h5></a>
								<!-- Product price-->
								<fmt:formatNumber pattern="###,###,###"
									value="${product.price }" />
								원<br> 리뷰 ${product.reviewcnt }개
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<br>
	<!-- 	리뷰순 -->
	<h3 class="text-center">인기상품</h3>
	<div class="container px-4 px-lg-5 mt-3">
		<div class="row justify-content-center">
			<c:forEach items="${product_r}" var="product_r" begin="0" end="3">
				<div class="col-3 mb-3">
					<div class="card h-100">
						<!-- Product image-->
						<a href="/pdetail/${product_r.productid}"><img
							class="card-img-top" src="/image/${product_r.filename}"
							style="height: 200px" alt="..." /></a>
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-left">
								<!-- Product name-->
								<a href="/pdetail/${product_r.productid}">
									<h5 class="fw-bolder">${product_r.pname }</h5>
								</a>
								<!-- Product price-->
								<fmt:formatNumber pattern="###,###,###"
									value="${product_r.price }" />
								원<br> 리뷰 ${product_r.reviewcnt }개
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>
<%@ include file="includes/footer.jsp"%>