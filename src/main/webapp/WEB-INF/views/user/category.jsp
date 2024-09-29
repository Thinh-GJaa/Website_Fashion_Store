<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm</title>
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
    </style>
</head>
<body>
<div class="container mt-3">
    <h2 class="mb-3">Danh mục sản phẩm: ${category.categoryName}</h2>
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
                                <c:when test="${product.discountPrice == 0 }">
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
