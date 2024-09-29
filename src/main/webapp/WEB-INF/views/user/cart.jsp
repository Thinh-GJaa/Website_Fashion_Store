<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <!-- Thêm Bootstrap CSS và jQuery từ CDN -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <style>
        .cart-container {
            margin-top: 20px;
            border-color: black;
            margin-bottom: 10px;
            min-height: 400px;
        }

        .cart-header {
            color: #433f3f;
            text-align: center;
            margin-bottom: 20px;
        }

        .cart-header-row {
            background-color: #9ba4ac;
            padding: 10px 0;
        }

        .cart-item {
            padding: 15px 0;
            border-bottom: 1px solid #ddd;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        .cart-item:hover {
            background-color: #f0f8ff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }

        .cart-item-details h5 {
            margin: 0 0 5px;
        }

        .cart-item-quantity {
            max-width: 80px;
        }

        .btn-checkout {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 10px;

        }

        .btn-checkout:hover {
            background-color: #0056b3;
        }

        .cart-total {
            padding: 15px;
            background-color: #f7f7f7;
            border-top: 1px solid #ddd;
            font-size: 18px;
        }

        .btn-remove {
            color: red;
            cursor: pointer;
        }

        .btn-remove-text {
            cursor: pointer;
        }

        .form-check-input.align-checkbox {
            margin-left: 0.3rem;
        }

        .select-all-container {
            display: flex;
            align-items: center;
        }

        .empty-cart-message {
            text-align: center;
            margin-top: 20px;
        }

        .empty-cart-message img {
            width: 200px;
            height: auto;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container cart-container">
    <div class="cart-header">
        <h2>Giỏ hàng của bạn</h2>
    </div>
    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="empty-cart-message">
                <img src="/resources/img/list-empty.jpg" alt="Giỏ hàng trống" class="w-40">
                <h3>Bạn chưa có sản phẩm nào trong giỏ hàng, nhanh tay chọn sản phẩm!</h3>
            </div>
        </c:when>
        <c:otherwise>
            <form id="cartForm" method="post" action="/user/checkout">
                <!-- Các trường ẩn để lưu thông tin sản phẩm đã chọn -->
                <input type="hidden" name="selectedProductIds" id="selectedProductIds">
                <input type="hidden" name="selectedSizeIds" id="selectedSizeIds">
                <input type="hidden" name="selectedQuantities" id="selectedQuantities">
                <input type="hidden" name="selectedPrices" id="selectedPrices">
                <input type="hidden" name="selectedDiscountPrices" id="selectedDiscountPrices">

                <div class="cart-header-row row rounded">
                    <div class="col-md-2 select-all-container">
                        <input type="checkbox" class="form-check-input align-checkbox" id="selectAll" onclick="toggleSelectAll(this)">
                        <label class="form-check-label ml-4" for="selectAll"><strong>Chọn tất cả</strong></label>
                    </div>
                    <div class="col-md-3"><strong>Hình ảnh</strong></div>
                    <div class="col-md-3"><strong>Thông tin sản phẩm</strong></div>
                    <div class="col-md-2"><strong>Số lượng</strong></div>
                    <div class="col-md-2 text-center"><strong>Hành động</strong></div>
                </div>
                <div class="cart-body">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item row align-items-center d-flex">
                            <div class="col-md-2">
                                <input type="checkbox" class="form-check-input align-checkbox" name="selectedItems" value="${item.sizeDetail.product.productId}-${item.sizeDetail.size.sizeId}" onchange="updateTotal()">
                            </div>
                            <div class="col-md-3">
                                <c:choose>
                                    <c:when test="${not empty item.sizeDetail.product.images}">
                                        <c:forEach var="image" items="${item.sizeDetail.product.images}" varStatus="status">
                                            <c:if test="${status.index == 0}">
                                                <img src="${image.linkImage}" alt="${item.sizeDetail.product.productName}" class="rounded">
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="defaultImage.jpg" alt="Hình ảnh không có sẵn">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-md-3 cart-item-details">
                                <h5><a href="/user/product/${item.sizeDetail.product.productId}">${item.sizeDetail.product.productName}</a></h5>
                                <p>Size: ${item.sizeDetail.size.sizeName}</p>
                                <p>Giá:
                                    <c:choose>
                                        <c:when test="${item.priceDiscount == 0}">
                                            <span class="format-vnd" data-price="${item.price}"></span>
                                        </c:when>
                                        <c:otherwise>
                                            <del><span class="format-vnd" data-price="${item.price}"></span></del>
                                            <span class="format-vnd km" data-price="${item.priceDiscount}"></span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="col-md-2">
                                <input type="number" class="form-control cart-item-quantity" value="${item.quantity}" min="1" onchange="updateQuantity(this, '${item.sizeDetail.product.productId}', '${item.sizeDetail.size.sizeId}')">
                            </div>
                            <div class="col-md-2 text-center">
                                <span class="fa fa-trash btn-remove" onclick="removeItem(this, '${item.sizeDetail.product.productId}', '${item.sizeDetail.size.sizeId}')"></span>
                                <span class="btn-remove-text" onclick="removeItem(this, '${item.sizeDetail.product.productId}', '${item.sizeDetail.size.sizeId}')">Xóa</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="cart-total row align-items-center mt-3">
                    <div class="col-md-6">
                        <h4>Tổng cộng: <span class="format-vnd" data-price="0"> 0 đ</span></h4>
                    </div>
                    <div class="col-md-6 text-right">
                        <button type="button" class="btn-checkout" onclick="submitCart()">Thanh toán  <i class="fa fa-credit-card"></i></button>
                    </div>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>
    function submitCart() {
        const form = document.getElementById('cartForm');
        const productIds = [];
        const sizeIds = [];
        const quantities = [];
        const prices = [];
        const discountPrices = [];

        form.querySelectorAll('input[name="selectedItems"]:checked').forEach((checkbox) => {
            const item = $(checkbox).closest('.cart-item');
            const productId = $(item).find('input[name="selectedItems"]').val().split('-')[0];
            const sizeId = $(item).find('input[name="selectedItems"]').val().split('-')[1];
            const quantity = $(item).find('.cart-item-quantity').val();
            const price = parseFloat($(item).find('.cart-item-details .format-vnd').attr('data-price'));
            const discountPrice = parseFloat($(item).find('.cart-item-details .km').last().attr('data-price'));

            productIds.push(productId);
            sizeIds.push(sizeId);
            quantities.push(quantity);
            prices.push(price);

            // Nếu có giá khuyến mãi thì thêm vào danh sách
            if (!isNaN(discountPrice) && discountPrice < price) {
                discountPrices.push(discountPrice);
            } else {
                discountPrices.push(price); // Nếu không có thì sử dụng giá gốc
            }
        });

        document.getElementById('selectedProductIds').value = productIds.join(',');
        document.getElementById('selectedSizeIds').value = sizeIds.join(',');
        document.getElementById('selectedQuantities').value = quantities.join(',');
        document.getElementById('selectedPrices').value = prices.join(',');
        document.getElementById('selectedDiscountPrices').value = discountPrices.join(',');

        if (productIds.length > 0) {
            form.submit();
        } else {
            Swal.fire("Thông báo", "Vui lòng chọn sản phẩm trước khi thanh toán!!", "warning")
        }
    }





    function removeItem(btn, productId, sizeId) {
        $(btn).closest('.cart-item').remove();
        updateTotal();
        deleteCookie('cart-' + productId + '-' + sizeId);
        // Hiển thị thông báo khi tất cả sản phẩm bị xóa
        if ($('.cart-item').length === 0) {
            $('.empty-cart-message').show();
            $('.cart-header').hide();
        }
    }

    function updateQuantity(input, productId, sizeId) {
        const quantity = input.value;
        if (quantity > 0) {
            setCookie('cart-' + productId + '-' + sizeId, quantity, 7);
        } else {
            deleteCookie('cart-' + productId + '-' + sizeId);
        }
        updateTotal();
    }

    function updateTotal() {
        let total = 0;
        $('.cart-item').each(function () {
            const checkbox = $(this).find('input[name="selectedItems"]');
            if (checkbox.is(':checked')) {
                const price = parseFloat($(this).find('.cart-item-details .format-vnd').attr('data-price'));
                const discountPrice = parseFloat($(this).find('.cart-item-details .km ').attr('data-price'));

                const quantity = $(this).find('.cart-item-quantity').val();

                if(discountPrice !== 0){
                    total += discountPrice * quantity;
                }else {
                    total += price * quantity;
                }
            }
        });
        const totalFormatted = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        }).format(total);

        $('.cart-total h4').text('Tổng cộng: ' + totalFormatted);
        $('.cart-total .format-vnd').attr('data-price', total).text(totalFormatted);
    }

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

    function toggleSelectAll(selectAllCheckbox) {
        const checkboxes = document.querySelectorAll('input[name="selectedItems"]');
        checkboxes.forEach((checkbox) => {
            checkbox.checked = selectAllCheckbox.checked;
        });
        updateTotal();
    }

    function setCookie(name, value, days) {
        const d = new Date();
        d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
        const expires = "expires=" + d.toUTCString();
        document.cookie = name + "=" + value + ";" + expires + ";path=/";
    }

    function getCookie(name) {
        const cname = name + "=";
        const decodedCookie = decodeURIComponent(document.cookie);
        const ca = decodedCookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(cname) == 0) {
                return c.substring(cname.length, c.length);
            }
        }
        return "";
    }

    function deleteCookie(name) {
        document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT; path=/;';
    }

    $(document).ready(function () {
        $('.btn-remove').on('click', function () {
            $(this).closest('.cart-item').remove();
            updateTotal();
            if ($('.cart-item').length === 0) {
                $('.empty-cart-message').show();
                $('.cart-header').hide();
            }
        });

        $('.cart-item-quantity').on('change', function () {
            updateTotal();
        });

        $('input[name="selectedItems"]').on('change', function () {
            updateTotal();
        });

        updateTotal();
        formatPrices();
        // Ẩn thông báo giỏ hàng trống nếu có sản phẩm
        if ($('.cart-item').length > 0) {
            $('.empty-cart-message').hide();
        }
    });
</script>

</body>
</html>
