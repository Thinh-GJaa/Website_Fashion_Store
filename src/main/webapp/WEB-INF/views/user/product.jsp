<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <!-- Thêm Bootstrap CSS và jQuery từ CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    <style>
        /* Căn chỉnh cho hình ảnh */
        .product-image {
            width: 100%;
            border-radius: 3%;
            object-fit: cover;
            height: 510px;
        }

        .container_inf {
            font-size: 18px;
            border-radius: 3%;
            height: auto;
            background-color: #ffffff;
        }

        /* Phần hiển thị đánh giá sản phẩm */
        #rating-container {
            display: flex;
            align-items: center;
        }

        .fa {
            font-size: 20px;
            margin: 0 5px;
        }

        #rating-stars {
            color: orange;
        }
    </style>
</head>
<body>
<div class="container-fluid mb-4">
    <div class="header text-center mt-3 mb-3">
        <h2>Thông tin chi tiết sản phẩm</h2>
    </div>

    <div class="row">
        <div class="col-md-5">
            <!-- Hiển thị ảnh sản phẩm -->
            <c:forEach var="image" items="${product.images}" varStatus="status">
                <img src="${image.linkImage}" alt="Hình Ảnh ${status.index + 1}" class="product-image mb-2">
            </c:forEach>
        </div>
        <div class="col-md-7">
            <div class="card mx-auto container_inf">
                <div class="card-body ml-20">
                    <input type="hidden" id="productId" value="${product.productId}">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong class="mr-2">Tên sản phẩm :</strong>
                            <span>${product.productName}</span></li>
                        <li class="list-group-item"><strong class="mr-2">Thương hiệu:</strong>
                            <span>${product.brand.brandName}</span></li>
                        <li class="list-group-item"><strong class="mr-2">Chất liệu:</strong>
                            <span>${product.material.materialName}</span></li>
                        <li class="list-group-item"><strong class="mr-2">Dành cho giới tính:</strong>
                            <span>${product.gender == 0 ? 'Nữ' : product.gender == 1 ? 'Nam' : 'Unisex'}</span></li>
                        <li class="list-group-item">
                            <strong class="mr-2">Giá:</strong>
                            <c:choose>
                                <c:when test="${empty discountPrice}">
                                    <span data-price="${price}" id="price" class="format-vnd">${price}</span>
                                </c:when>
                                <c:otherwise>
                                    <del><span data-price="${price}" id="price" class="format-vnd">${price}</span></del>
                                    <span data-price="${discountPrice}" id="discountPrice" class="format-vnd"></span>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <li class="list-group-item"><strong class="mr-2">Kích thước:</strong>
                            <select id="sizeSelect" class="form-select">
                                <c:forEach var="sizeDetail" items="${product.sizeDetails}">
                                    <option value="${sizeDetail.size.sizeId}">${sizeDetail.size.sizeName}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li class="list-group-item"><strong class="mr-2">Mô tả:</strong>
                            <span>${product.description}</span></li>

                        <li class="list-group-item d-flex"><strong class="mr-2">Điểm đánh giá:</strong>
                            <div id="rating-container">
                                <div id="rating-stars"></div>
                                <input type="hidden" id="rating" value="${rating}">
                                <div id="rating-score"></div>
                            </div>
                        </li>
                    </ul>

                    <div class="text-center mt-3">
                        <button id="btnAddCart" name="btnAddCart" class="btn-lg btn-success float-lg-right">
                            <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                        </button>
<%--                        <button class="btn-lg btn-primary" id="btnBuyNow">--%>
<%--                            <i class="fas fa-shopping-bag"></i> Mua ngay--%>
<%--                        </button>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>
    $(document).ready(() => {
        // Hàm định dạng giá tiền
        function formatVND(amount) {
            const formatter = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND',
            });
            return formatter.format(amount);
        }

        // Định dạng giá cho tất cả các phần tử có class 'format-vnd'
        $(".format-vnd").each(function() {
            const price = $(this).data('price');
            $(this).text(formatVND(price));
        });

        $("#sizeSelect").change(() => {
            $("#btnAddCart").html('<i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng');
            $("#btnAddCart").attr("disabled", false);
        });

        $("#btnAddCart").click((event) => {
            const data = {
                productId: $("#productId").val(),
                sizeId: $("#sizeSelect").val()
            };
            console.log("sizeId: " + $("#sizeSelect").val());

            $.ajax({
                url: "/user/product/add-cart",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: () => {
                    $("#btnAddCart").html('<i class="fas fa-check"></i> Đã thêm vào giỏ hàng');
                    $("#btnAddCart").attr("disabled", true);
                    Swal.fire('Thành công!', 'Đã thêm sản phẩm vào giỏ hàng.', 'success');
                },
                error: () => {
                    console.error("Lỗi khi thêm vào giỏ hàng");
                }
            });
        });

        const ratingScore = $('#rating').val(); // Điểm đánh giá với phần thập phân lẻ

        const starsContainer = $("#rating-stars");

        const scoreContainer = $("#rating-score");

        // Làm tròn phần thập phân để xác định nửa ngôi sao
        let integerPart = Math.floor(ratingScore);
        const decimalPart = ratingScore - integerPart;
        let halfStar = false;

        if (decimalPart > 0.75) {
            integerPart = integerPart + 1;
        }

        if (decimalPart >= 0.25 && decimalPart <= 0.75) {
            halfStar = true;
        }

        // Xóa nội dung các phần tử container trước khi cập nhật
        starsContainer.empty();

        // Tạo ngôi sao dựa trên phần nguyên
        for (let i = 1; i <= 5; i++) {
            let star = null;
            if (i <= integerPart) {
                star = $("<span>").addClass("fa fa-star");
            } else if (halfStar) {
                if (i === integerPart + 1) {
                    star = $("<span>").addClass("fa fa-star-half-o");
                } else {
                    star = $("<span>").addClass("fa fa-star-o");
                }
            } else {
                star = $("<span>").addClass("fa fa-star-o");
            }

            starsContainer.append(star);
        }

        // Hiển thị điểm đánh giá
        scoreContainer.text(parseFloat(ratingScore).toFixed(1).toString() + '/5');

        const giaKMElement = document.getElementById('giaKM');
        if (giaKMElement) {
            const giaKM = giaKMElement.getAttribute('data-giaKM');
            giaKMElement.textContent = formatVND(giaKM);
        }
    });
</script>
</body>
</html>
