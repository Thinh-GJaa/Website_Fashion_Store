<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tồn kho</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="display-3 card-header d-flex justify-content-between align-items-center">
                    <span><h3>Sản phẩm tồn kho</h3></span>

                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Sản phẩm</th>
                            <th>Size</th>
                            <th>Số lượng tồn</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách categoryList -->
                        <c:forEach items="${productList}" var="product" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${product.product.productId}</td>
                                <td>${product.product.productName}</td>
                                <td>${product.size.sizeName}</td>
                                <td>${product.quantity}</td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal"
                                            data-target="#editSizeDetailModal-${product.product.productId}-${product.size.sizeId}">
                                        Sửa <i class="fas fa-pencil-alt"></i>
                                    </button>
                                    <!-- Modal Sửa Số lượng tồn -->
                                    <div class="modal fade" id="editSizeDetailModal-${product.product.productId}-${product.size.sizeId}"
                                         tabindex="-1"
                                         role="dialog"
                                         aria-labelledby="editSizeDetailModalLabel-${product.product.productId}-${product.size.sizeId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-success text-white">
                                                    <h5 class="modal-title"
                                                        id="editSizeDetailModalLabel-${product.product.productId}-${product.size.sizeId}}">Sửa số lượng tồn </h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="/admin/product/inventory"
                                                          id="editSizeDetailForm-${product.product.productId}-${product.size.sizeId}">
                                                        <input type="hidden" name="product.productId" value="${product.product.productId}">
                                                        <input type="hidden" name="size.sizeId" value="${product.size.sizeId}">

                                                        <div class="form-group">
                                                            <label for="size">Tên Sản phẩm : </label>
                                                            <input type="text" class="form-control" id="size"
                                                                   value="${product.product.productName}" disabled/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="product">Tên Size: </label>
                                                            <input type="text" class="form-control" id="product"
                                                                   value="${product.size.sizeName}" disabled/>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="quantity">Số lượng tồn: </label>
                                                            <input type="number" class="form-control"
                                                                   name="quantity"
                                                                   id="quantity"
                                                                   value="${product.quantity}" required/>
                                                        </div>


                                                        <button type="submit"
                                                                class="btn btn-success float-right ml-3">
                                                            Lưu
                                                            <i class="fas fa-save"></i></button>
                                                        <button type="button" class="btn btn-secondary float-right"
                                                                data-dismiss="modal">Đóng <i
                                                                class="fas fa-times"></i></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Modal Sửa Số lượng tồn -->
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


<!-- jQuery first, then Tether, then other JS. -->
<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/vendor/unifyMenu/unifyMenu.js"></script>
<script src="/resources/vendor/onoffcanvas/onoffcanvas.js"></script>
<script src="/resources/js/moment.js"></script>

<!-- Data Tables -->
<script src="/resources/vendor/datatables/dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap.min.js"></script>

<!-- Custom Data tables -->
<script src="/resources/vendor/datatables/custom/custom-datatables.js"></script>
<script src="/resources/vendor/datatables/custom/fixedHeader.js"></script>

<!-- Common JS -->
<script src="/resources/js/common.js"></script>

<!-- SweetAlert library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!-- Script để xử lý SweetAlert khi submit form -->
<script>


    $(document).ready(function () {

        // Gắn sự kiện submit cho các form động
        $(document).on('submit', '[id^="editSizeDetailForm-"]', function (event) {
            event.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                type: "PUT",
                url: "/admin/product/inventory",
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
