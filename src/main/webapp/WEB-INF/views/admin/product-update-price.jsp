<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cập nhật giá</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
</head>
<body>
<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="display-3 card-header d-flex justify-content-between align-items-center">
                    <span><h3>Cập nhật giá</h3></span>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Sản phẩm</th>
                            <th>Giá hiện tại</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${productList}" var="product" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${product.productId}</td>
                                <td>${product.productName}</td>
                                <td class="format-vnd" data-price="${priceList[loop.index]}"></td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal"
                                            data-target="#editPriceModal-${product.productId}">
                                        Sửa <i class="fas fa-pencil-alt"></i>
                                    </button>
                                    <div class="modal fade" id="editPriceModal-${product.productId}"
                                         tabindex="-1"
                                         role="dialog"
                                         aria-labelledby="editPriceModalLabel-${product.productId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-success text-white">
                                                    <h5 class="modal-title"
                                                        id="editPriceModalLabel-${product.productId}">Cập nhật giá </h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="/admin/product/update-price"
                                                          id="editPriceForm-${product.productId}">
                                                        <input type="hidden" name="productId" value="${product.productId}">
                                                        <div class="form-group">
                                                            <label for="product">Tên Sản phẩm : </label>
                                                            <input type="text" class="form-control" id="product"
                                                                   value="${product.productName}" disabled/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="price">Giá : </label>
                                                            <input type="number" class="form-control"
                                                                   name="priceNew"
                                                                   id="price"
                                                                   value="${priceList[loop.index]}" required/>
                                                        </div>
                                                        <button type="submit"
                                                                class="btn btn-success float-right ml-3">
                                                            Lưu
                                                            <i class="fas fa-save"></i></button>
                                                        <button type="button" class="btn btn-secondary float-right"
                                                                data-dismiss="modal">Đóng <i class="fas fa-times"></i></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/vendor/unifyMenu/unifyMenu.js"></script>
<script src="/resources/vendor/onoffcanvas/onoffcanvas.js"></script>
<script src="/resources/js/moment.js"></script>
<script src="/resources/vendor/datatables/dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap.min.js"></script>
<script src="/resources/vendor/datatables/custom/custom-datatables.js"></script>
<script src="/resources/vendor/datatables/custom/fixedHeader.js"></script>
<script src="/resources/js/common.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
    // Hàm định dạng giá tiền
    function formatVND(amount) {
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });
        return formatter.format(amount);
    }

    $(document).ready(function () {
        // Định dạng giá cho tất cả các phần tử có class 'format-vnd'
        $(".format-vnd").each(function() {
            const price = $(this).data('price');
            $(this).text(formatVND(price));
        });

        // Gắn sự kiện submit cho các form động
        $(document).on('submit', '[id^="editPriceForm-"]', function (event) {
            event.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                type: "PUT",
                url: "/admin/product/update-price",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    Swal.fire({
                        title: 'Thành công!',
                        text: response,
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });
                },
                error: function (xhr) {
                    Swal.fire({
                        title: 'Lỗi!',
                        text: xhr.responseText,
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    });
</script>
</body>
</html>
