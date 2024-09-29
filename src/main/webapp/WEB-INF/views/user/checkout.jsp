<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán</title>

    <!-- Thêm Bootstrap CSS và jQuery từ CDN -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">



    <style>
        .checkout-container {
            margin-top: 20px;
        }
        .product-card, .payment-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .product-card:hover, .payment-card:hover {
            transform: scale(1.02); /* Giảm kích thước phóng to */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15); /* Giảm độ bóng */
        }
        .product-image {
            width: 100%;
            max-width: 150px; /* Thay đổi kích thước ảnh */
            height: auto;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        .total-price {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
        .form-control {
            border-radius: 10px;
            margin-bottom: 10px;
        }
        .btn-submit {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .product-info {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .product-details {
            font-size: 16px;
            color: #666;
        }
        .payment-method-label {
            font-weight: bold;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>

<div class="container checkout-container">
    <div class="text-center">
        <h2 class="mb-4">Thông tin thanh toán</h2>
    </div>
    <div class="row">
        <!-- Danh sách sản phẩm -->
        <div class="col-md-7">
            <h4>Danh sách sản phẩm</h4>
            <div class="row">
                <c:forEach var="item" items="${productList}">
                    <div class="col-md-12 product-card">
                        <div class="row">
                            <div class="col-md-4">
                                <c:choose>
                                    <c:when test="${not empty item.sizeDetail.product.images}">
                                        <c:forEach var="image" items="${item.sizeDetail.product.images}" varStatus="status">
                                            <c:if test="${status.index == 0}">
                                                <img src="${image.linkImage}" alt="${item.sizeDetail.product.productName}" class="product-image">
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/img/defaultImage.jpg" alt="Hình ảnh không có sẵn" class="product-image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-md-8 product-info">
                                <h5 class="product-name"><a href="/user/product/${item.sizeDetail.product.productId}">${item.sizeDetail.product.productName}</a></h5>
                                <p class="product-details">Kích cỡ: ${item.sizeDetail.size.sizeName}</p>
                                <p class="product-details">Số lượng: ${item.quantity}</p>
                                <p class="product-details">Đơn giá: <span class="format-vnd" data-price="${item.priceDiscount}"></span></p>
                                <p class="product-details">Tổng giá: <span class="format-vnd" data-price="${item.priceDiscount * item.quantity}"></span></p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Thông tin thanh toán -->
        <div class="col-md-5">
            <h4>Thông tin thanh toán</h4>
            <div class="payment-card">
                <form id="checkoutForm">
                    <div class="form-group">
                        <label for="recipientName" class="payment-method-label">Họ và tên:</label>
                        <input type="text" class="form-control" id="recipientName" name="recipientName" required>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber" class="payment-method-label">Số điện thoại:</label>
                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="address" class="payment-method-label">Địa chỉ giao hàng:</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
<%--                    <div class="form-group">--%>
<%--                        <label for="paymentMethod" class="payment-method-label">Phương thức thanh toán:</label>--%>
<%--                        <select class="form-control" id="paymentMethod" name="paymentMethod" required>--%>
<%--                            <option value="creditCard">Thẻ tín dụng</option>--%>
<%--                            <option value="paypal">PayPal</option>--%>
<%--                            <option value="bankTransfer">Chuyển khoản ngân hàng</option>--%>
<%--                        </select>--%>
<%--                    </div>--%>

                    <!-- Hiển thị tổng cộng -->
                    <div class="total-price mb-4">
                        Tổng cộng: <span class="format-vnd" id="totalDiscountAmount" data-price="${totalDiscountAmount}">${totalDiscountAmount}</span>
                    </div>

                    <input type="hidden" id="totalAmount" value="${totalAmount}">

                    <!-- Nút hành động -->
                    <div class="button-group">
                        <button type="button" class="btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/user/cart'">
                            <i class="fas fa-chevron-left"></i> Quay lại giỏ hàng
                        </button>
                        <button type="submit" class="btn-submit"><i class="fas fa-shopping-cart"></i> Mua hàng</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    // Format giá tiền
    function formatPrices() {
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });

        $('.format-vnd').each(function () {
            const price = parseFloat($(this).attr('data-price'));
            $(this).text(formatter.format(price));
        });
    }

    $(document).ready(function () {
        formatPrices();

        $('#checkoutForm').submit(function (e) {
            console.log($('#totalAmount').val());
            e.preventDefault();
            const formData = {
                recipientName: $('#recipientName').val(),
                phoneNumber: $('#phoneNumber').val(),
                address: $('#address').val(),
                totalDiscountAmount: parseFloat($('#totalDiscountAmount').attr('data-price')),
                totalAmount: parseFloat($('#totalAmount').val())

            };

            $.ajax({
                type: 'POST',
                url: '/user/paying',
                data: formData,
                success: function (response) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: response,
                        confirmButtonText: 'Quay lại trang chủ'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "/user/home"
                        }
                    });
                },
                error: function (xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Thất bại',
                        text: xhr.responseText,
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    });
</script>

</body>
</html>
