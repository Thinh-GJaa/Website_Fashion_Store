<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Mua Hàng</title>

    <!-- Thêm Bootstrap CSS và jQuery từ CDN -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">



    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        h1 {
            margin-bottom: 25px;
        }

        .nav-tabs .nav-link {
            color: #495057;
        }

        .nav-tabs .nav-link.active {
            color: #007bff;
        }

        .order-list {
            margin-top: 0px;
        }

        .order-item {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            margin-bottom: 15px;
            padding: 15px;
            position: relative;
            cursor: pointer;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .order-body {
            display: none;
        }

        .order-body.active {
            display: block;
        }

        .order-body ul {
            list-style: none;
            padding-left: 0;
            margin-bottom: 15px;
        }

        .order-body ul li {
            margin-bottom: 5px;
        }

        .order-details {
            margin-bottom: 15px;
        }

        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }

        .order-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #dee2e6;
            padding-top: 10px;
            margin-top: 10px;
        }

        .order-footer .order-total {
            margin-bottom: 0;
        }

        .empty-list {
            text-align: center;
        }

        .empty-image {
            max-width: 100px;
        }

        .star-rating .fa {
            color: #ddd;
            cursor: pointer;
        }

        .star-rating .fa.checked {
            color: #ffcc00;
        }
    </style>
</head>
<body>
<div class="container mt-1">
    <h1 class="text-center">Lịch Sử Mua Hàng</h1>
    <ul class="nav nav-tabs" id="orderHistoryTabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="pending-tab" data-toggle="tab" href="#pending" role="tab"
               aria-controls="pending" aria-selected="true">Chờ Duyệt</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="approved-tab" data-toggle="tab" href="#approved" role="tab" aria-controls="approved"
               aria-selected="false">Đã Duyệt</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="delivered-tab" data-toggle="tab" href="#delivered" role="tab"
               aria-controls="delivered" aria-selected="false">Đã Giao</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="cancelled-tab" data-toggle="tab" href="#cancelled" role="tab"
               aria-controls="cancelled" aria-selected="false">Đã Hủy</a>
        </li>
    </ul>

    <div class="tab-content" id="orderHistoryTabsContent">

        <%--Tab cho phần Chờ duyệt--%>
        <div class="tab-pane fade show active" id="pending" role="tabpanel" aria-labelledby="pending-tab">
            <div class="order-list">
                <c:if test="${empty pendingOrders}">
                    <div class="empty-list text-center">
                        <img src="/resources/img/list-empty.jpg" alt="Không có đơn hàng" class="img-fluid">
                        <p>Không có đơn hàng.</p>
                    </div>
                </c:if>
                <c:forEach var="order" items="${pendingOrders}">
                    <div class="order-item" data-order-id="${order.orderId}">
                        <div class="order-header">
                            <span>Mã đơn hàng: ${order.orderId}</span>
                            <span>Ngày đặt: ${order.createDate}</span>
                        </div>
                        <div class="order-body">
                            <ul>
                                <li>Tên người nhận: ${order.recipientName}</li>
                                <li>Địa chỉ: ${order.address}</li>
                                <li>Số điện thoại: ${order.phoneNumber}</li>
                            </ul>
                            <div class="order-details">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Size</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <tr>
                                            <td>
                                                <c:forEach var="image" items="${orderDetail.sizeDetail.product.images}" varStatus="status">
                                                    <c:if test="${status.first}">
                                                        <img src="${image.linkImage}" alt="Hình ảnh sản phẩm" class="product-image">
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>${orderDetail.sizeDetail.product.productName}</td>
                                            <td>${orderDetail.sizeDetail.size.sizeName}</td>
                                             <td data-price="${orderDetail.price}" class="format-vnd"></td>

                                            <td>${orderDetail.quantity}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền:<span class="format-vnd" data-price="${order.totalAmount}"></span> </div>
                            <div class="order-actions">
                                <button class="btn btn-danger btn-cancel-order" data-order-id="${order.orderId}"
                                        onclick="confirmCancelOrder('${order.orderId}')">Hủy Đơn Hàng</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%--Tab cho phần Đã duyệt--%>
        <div class="tab-pane fade" id="approved" role="tabpanel" aria-labelledby="approved-tab">
            <div class="order-list">
                <c:if test="${empty approvedOrders}">
                    <div class="empty-list">
                        <img src="/resources/img/list-empty.jpg" alt="Không có đơn hàng" class="empty-image">
                        <p>Không có đơn hàng.</p>
                    </div>
                </c:if>
                <c:forEach var="order" items="${approvedOrders}">
                    <div class="order-item" data-order-id="${order.orderId}">
                        <div class="order-header">
                            <span>Mã đơn hàng: ${order.orderId}</span>
                            <span>Ngày đặt: ${order.createDate}</span>
                        </div>
                        <div class="order-body">
                            <ul>
                                <li>Tên người nhận: ${order.recipientName}</li>
                                <li>Địa chỉ: ${order.address}</li>
                                <li>Số điện thoại: ${order.phoneNumber}</li>
                            </ul>
                            <div class="order-details">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Size</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <tr>
                                            <td>
                                                <c:forEach var="image" items="${orderDetail.sizeDetail.product.images}" varStatus="status">
                                                    <c:if test="${status.first}">
                                                        <img src="${image.linkImage}" alt="Hình ảnh sản phẩm" class="product-image">
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>${orderDetail.sizeDetail.product.productName}</td>
                                            <td>${orderDetail.sizeDetail.size.sizeName}</td>
                                             <td data-price="${orderDetail.price}" class="format-vnd"></td>

                                            <td>${orderDetail.quantity}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền:<span class="format-vnd" data-price="${order.totalAmount}"></span> </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

            <%--Tab cho phần Đã giao--%>
            <div class="tab-pane fade" id="delivered" role="tabpanel" aria-labelledby="delivered-tab">
                <div class="order-list">
                    <c:if test="${empty deliveredOrders}">
                        <div class="empty-list">
                            <img src="/resources/img/list-empty.jpg" alt="Không có đơn hàng" class="empty-image">
                            <p>Không có đơn hàng.</p>
                        </div>
                    </c:if>
                    <c:forEach var="order" items="${deliveredOrders}">
                        <div class="order-item" data-order-id="${order.orderId}">
                            <div class="order-header">
                                <span>Mã đơn hàng: ${order.orderId}</span>
                                <span>Ngày đặt: ${order.createDate}</span>
                            </div>
                            <div class="order-body">
                                <ul>
                                    <li>Tên người nhận: ${order.recipientName}</li>
                                    <li>Địa chỉ: ${order.address}</li>
                                    <li>Số điện thoại: ${order.phoneNumber}</li>
                                </ul>
                                <div class="order-details">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Hình ảnh</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Size</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Đánh giá</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <tr>
                                                <td>
                                                    <c:forEach var="image" items="${orderDetail.sizeDetail.product.images}" varStatus="status">
                                                        <c:if test="${status.first}">
                                                            <img src="${image.linkImage}" alt="Hình ảnh sản phẩm" class="product-image">
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${orderDetail.sizeDetail.product.productName}</td>
                                                <td>${orderDetail.sizeDetail.size.sizeName}</td>
                                                <td data-price="${orderDetail.price}" class="format-vnd"></td>
                                                <td>${orderDetail.quantity}</td>
                                                <td class="rate-column">
                                                    <div class="star-rating"
                                                         data-input-id="rating-${orderDetail.sizeDetail.product.productId}-${orderDetail.sizeDetail.size.sizeId}">
                                                        <i class="fa fa-star" data-rating="1"></i>
                                                        <i class="fa fa-star" data-rating="2"></i>
                                                        <i class="fa fa-star" data-rating="3"></i>
                                                        <i class="fa fa-star" data-rating="4"></i>
                                                        <i class="fa fa-star" data-rating="5"></i>
                                                        <input type="hidden" id="rating-${orderDetail.sizeDetail.product.productId}-${orderDetail.sizeDetail.size.sizeId}" value="${orderDetail.ratingScore}">
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="order-footer">
                                <div class="order-total">Tổng tiền:<span class="format-vnd" data-price="${order.totalAmount}"></span> </div>
<%--                                <div class="order-actions">--%>
<%--                                    <button class="btn btn-success btn-rate-order" >Đánh Giá</button>--%>
<%--                                    <button class="btn btn-info btn-buy-again">Mua Lại</button>--%>
<%--                                </div>--%>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>


        <%--Tab cho phần Đã hủy--%>
        <div class="tab-pane fade" id="cancelled" role="tabpanel" aria-labelledby="cancelled-tab">
            <div class="order-list">
                <c:if test="${empty cancelledOrders}">
                    <div class="empty-list">
                        <img src="/resources/img/list-empty.jpg" alt="Không có đơn hàng" class="empty-image">
                        <p>Không có đơn hàng.</p>
                    </div>
                </c:if>
                <c:forEach var="order" items="${cancelledOrders}">
                    <div class="order-item" data-order-id="${order.orderId}">
                        <div class="order-header">
                            <span>Mã đơn hàng: ${order.orderId}</span>
                            <span>Ngày đặt: ${order.createDate}</span>
                        </div>
                        <div class="order-body">
                            <ul>
                                <li>Tên người nhận: ${order.recipientName}</li>
                                <li>Địa chỉ: ${order.address}</li>
                                <li>Số điện thoại: ${order.phoneNumber}</li>
                                <li>Lý do hủy đơn: ${order.reason}</li>
                            </ul>
                            <div class="order-details">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Size</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>

                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <tr>
                                            <td>
                                                <c:forEach var="image" items="${orderDetail.sizeDetail.product.images}" varStatus="status">
                                                    <c:if test="${status.first}">
                                                        <img src="${image.linkImage}" alt="Hình ảnh sản phẩm" class="product-image">
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>${orderDetail.sizeDetail.product.productName}</td>
                                            <td>${orderDetail.sizeDetail.size.sizeName}</td>
                                             <td data-price="${orderDetail.price}" class="format-vnd"></td>

                                            <td>${orderDetail.quantity}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền:<span class="format-vnd" data-price="${order.totalAmount}"></span> </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>

    function confirmCancelOrder(orderId) {
        Swal.fire({
            title: 'Xác nhận hủy đơn hàng?',
            text: 'Vui lòng nhập lý do hủy:',
            icon: 'question',
            input: 'textarea',
            inputPlaceholder: 'Nhập lý do hủy...',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xác nhận',
            cancelButtonText: 'Không',
            preConfirm: (reason) => {
                if (!reason) {
                    Swal.showValidationMessage('Lý do hủy không được để trống');
                } else {
                    return reason;
                }
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu người dùng đồng ý và đã nhập lý do, thực hiện hủy đơn hàng
                const reason = result.value;
                cancelOrder(orderId, reason);
            }
        });
    }

    function cancelOrder(orderId, reason) {
        // Gửi yêu cầu hủy đơn hàng đến máy chủ
        $.ajax({
            url: "/user/order/cancel",
            data: {
                orderId: orderId,
                reason: reason
            },
            type: "POST",
            success: function (response) {
                Swal.fire({
                    icon: 'success',
                    title: 'Đã hủy đơn hàng',
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
                ;
            },
            error: function (xhr, textStatus, errorThrown) {
                console.log("Error: " + errorThrown);
                // Hiển thị thông báo lỗi
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi khi hủy đơn hàng',
                    text: xhr.responseText
                });
            }
        });
    }




    $(document).ready(function () {

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

        $('.order-header').on('click', function () {
            $(this).siblings('.order-body').toggleClass('active');
        });

        // Đánh giá bằng cách click vào các ngôi sao
        $('.star-rating .fa').on('click', function () {
             const $star = $(this);
             const $ratingContainer = $star.closest('.star-rating');
             const inputId = $ratingContainer.data('input-id');
             const rating = $star.data('rating');

            $('#' + inputId).val(rating);

            $star.siblings().removeClass('checked');
            $star.addClass('checked');
            $star.prevAll().addClass('checked');

            // Lưu đánh giá vào cơ sở dữ liệu
             const productId = inputId.split('-')[1];
             const sizeId = inputId.split('-')[2];
             const orderId = $star.closest('.order-item').data('order-id');
            $.ajax({
                type: 'POST',
                url: '/user/order/rate',
                data: {orderId: orderId,
                       productId: productId,
                       sizeId: sizeId,
                       rating: rating},
                success: function (response) {
                    Swal.fire(
                        'Đã đánh giá!',
                        'Đánh giá của bạn đã được lưu.',
                        'success'
                    );
                },
                error: function (response) {
                    Swal.fire(
                        'Đánh giá thất bại!',
                        'Không thể lưu đánh giá của bạn.',
                        'error'
                    );
                }
            });
        });

        // Hiển thị các ngôi sao đã đánh giá
        $('.star-rating').each(function () {
             const $ratingContainer = $(this);
             const inputId = $ratingContainer.data('input-id');
             const rating = $('#' + inputId).val();

            $ratingContainer.find('.fa').each(function () {
                 const $star = $(this);
                if ($star.data('rating') <= rating) {
                    $star.addClass('checked');
                }
            });
        });

        $('.btn-buy-again').on('click', function () {
             const orderId = $(this).data('order-id');
            // Thêm logic để xử lý mua lại đơn hàng
        });


    });
</script>

</body>
</html>
