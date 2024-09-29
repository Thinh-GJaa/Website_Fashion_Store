<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fashion Store</title>
    <!-- Thêm Bootstrap CSS và jQuery từ CDN -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <style>
        .product-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            position: relative;
        }
        .product-card:hover {
            transform: scale(1.05);
        }
        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }
        .product-details {
            padding: 15px;
            text-align: center;
        }
        .product-title {
            font-size: 18px;
            font-weight: bold;
        }
        .product-price {
            font-size: 17px;
            color: #f00;
            margin: 10px 0;
        }
        .product-price-original {
            font-size: 17px;
            color: #999;

            margin-right: 5px;
        }
        .discount-label {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #f00;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
        }
        .category-section {
            padding: 20px 0;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .category-item {
            text-align: center;
            padding: 10px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .category-item:hover {
            transform: scale(1.05);
        }
        .category-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-bottom: 10px;
        }
        .carousel-control-prev-icon, .carousel-control-next-icon {
            background-image: none;
        }
        .carousel-control-prev-icon {
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" fill="%23000" viewBox="0 0 8 8"%3E%3Cpath d="M4.707 0L0 4.5 4.707 9l.707-.707L1.707 4.5 5.414.707 4.707 0z" /%3E%3C/svg%3E');
        }
        .carousel-control-next-icon {
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" fill="%23000" viewBox="0 0 8 8"%3E%3Cpath d="M3.293 0L8 4.5 3.293 9l-.707-.707L6.293 4.5.586.707 3.293 0z" /%3E%3C/svg%3E');
        }
        .carousel-control-prev, .carousel-control-next {
            width: 5%;
        }
    </style>
</head>
<body>

<!-- Carousel -->
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://upcontent.vn/wp-content/uploads/2024/06/banner-thoi-trang-nam-1.jpg" class="d-block w-100" alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="https://upcontent.vn/wp-content/uploads/2024/06/banner-thoi-trang-nam-3.jpg" class="d-block w-100" alt="Banner 2">
        </div>
        <div class="carousel-item">
            <img src="https://upcontent.vn/wp-content/uploads/2024/06/banner-thoi-trang-nu-3.jpg" class="d-block w-100" alt="Banner 3">
        </div>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<!-- Danh mục sản phẩm -->
<div class="container mt-3">
    <c:if test="${not empty categoryList}">
        <div class="category-section">
            <h3 class="text-center m3-4">Danh mục sản phẩm</h3>
            <div id="categoryCarousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="category" items="${categoryList}" varStatus="status">
                        <c:if test="${status.index % 4 == 0}">
                            <div class="carousel-item <c:if test="${status.first}">active</c:if>">
                            <div class="row">
                        </c:if>
                        <div class="col-lg-3 mb-4">
                            <div class="category-item">
                                <a href="/user/category/${category.categoryId}">
                                    <img src="${category.image.linkImage}" alt="${category.categoryName}">
                                    <h5>${category.categoryName}</h5>
                                </a>
                            </div>
                        </div>
                        <c:if test="${status.index % 4 == 3 || status.last}">
                            </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <a class="carousel-control-prev" href="#categoryCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#categoryCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </c:if>

    <!-- Gợi ý sản phẩm -->
    <c:if test="${not empty recommendedProducts}">
        <div class="text-center">
            <h2 class="mt-3 mb-3">Dành cho bạn</h2>
        </div>
        <div class="row">
            <c:forEach var="product" items="${recommendedProducts}">
                <div class="col-md-3 mb-4">
                    <div class="product-card" onclick="window.location.href='/user/product/${product.productId}'">
                        <c:if test="${product.discountPrice != 0}">
                            <div class="discount-label">${((product.price - product.discountPrice) / product.price) * 100}%</div>
                        </c:if>
                        <c:if test="${not empty product.productImage}">
                            <img src="${product.productImage}" alt="${product.productName}" class="product-image">
                        </c:if>
                        <div class="product-details">
                            <div class="product-title">${product.productName}</div>
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${product.discountPrice == 0}">
                                        <span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <del><span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span></del>
                                        <span data-price="${product.discountPrice}" class="format-vnd">${product.discountPrice}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- Sản phẩm bán chạy -->
    <c:if test="${not empty topSellingProducts}">
        <div class="text-center">
            <h2 class="mt-3 mb-3">Sản phẩm hot gần đây</h2>
        </div>
        <div class="row">
            <c:forEach var="product" items="${topSellingProducts}">
                <div class="col-md-3 mb-4">
                    <div class="product-card" onclick="window.location.href='/user/product/${product.productId}'">
                        <c:if test="${product.discountPrice != 0}">
                            <div class="discount-label">${((product.price - product.discountPrice) / product.price) * 100}%</div>
                        </c:if>
                        <c:if test="${not empty product.productImage}">
                            <img src="${product.productImage}" alt="${product.productName}" class="product-image">
                        </c:if>
                        <div class="product-details">
                            <div class="product-title">${product.productName}</div>
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${ product.discountPrice == 0}">
                                        <span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <del><span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span></del>
                                        <span data-price="${product.discountPrice}" class="format-vnd">${product.discountPrice}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!--Sản phẩm khuyến mãi-->
    <c:if test="${not empty discountedProducts}">
        <div class="text-center">
            <h2 class="mt-3 mb-3">Sản phẩm đang khuyến mãi</h2>
        </div>
        <div class="row">
            <c:forEach var="product" items="${discountedProducts}">
                <div class="col-md-3 mb-4">
                    <div class="product-card" onclick="window.location.href='/user/product/${product.productId}'">
                        <c:if test="${not empty product.discountPrice}">
                            <div class="discount-label">${((product.price - product.discountPrice) / product.price) * 100}%</div>
                        </c:if>
                        <c:if test="${not empty product.productImage}">
                            <img src="${product.productImage}" alt="${product.productName}" class="product-image">
                        </c:if>
                        <div class="product-details">
                            <div class="product-title">${product.productName}</div>
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${empty product.discountPrice}">
                                        <span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <del><span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span></del>
                                        <span data-price="${product.discountPrice}" class="format-vnd">${product.discountPrice}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>


    <!-- Danh sách sản phẩm  -->
    <c:if test="${not empty productList}">
        <div class="text-center">
            <h2 class="mt-3 mb-3">Danh sách sản phẩm </h2>
        </div>
        <div class="row">
            <c:forEach var="product" items="${productList}">
                <div class="col-md-3 mb-4">
                    <div class="product-card" onclick="window.location.href='/user/product/${product.productId}'">
                        <c:if test="${product.discountPrice != 0}">
                            <div class="discount-label">${((product.price - product.discountPrice) / product.price) * 100}%</div>
                        </c:if>
                        <c:if test="${not empty product.productImage}">
                            <img src="${product.productImage}" alt="${product.productName}" class="product-image">
                        </c:if>
                        <div class="product-details">
                            <div class="product-title">${product.productName}</div>
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${product.discountPrice == 0}">
                                        <span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <del><span data-price="${product.price}" class="format-vnd product-price-original">${product.price}</span></del>
                                        <span data-price="${product.discountPrice}" class="format-vnd">${product.discountPrice}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>
    $(document).ready(function () {
        $('.format-vnd').each(function () {
            let price = $(this).data('price');
            if (price) {
                $(this).text(new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(price));
            }
        });
    });
</script>
</body>
</html>
