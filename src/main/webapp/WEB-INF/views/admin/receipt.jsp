<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Phiếu nhập hàng</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span><h3>Danh sách Phiếu nhập hàng</h3></span>
                    <button onclick="window.location.href='/admin/receipt/add'" type="button" class="btn btn-success"> Thêm mới <i class="fas fa-plus"></i></button>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Nhà cung cấp </th>
                            <th>Ngày tạo</th>
                            <th>Nhân viên tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách receiptList -->
                        <c:forEach items="${receiptList}" var="receipt" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${receipt.receiptId}</td>
                                <td>${receipt.supplier.supplierName}</td>
                                <td>${receipt.createDate}</td>
                                <td>${receipt.staff.staffFullName}</td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#detailReceiptModal-${receipt.receiptId}">
                                        Chi tiết <i class="fas fa-info-circle"></i>
                                    </button>
<%--                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#editReceiptModal-${receipt.receiptId}">--%>
<%--                                        Sửa <i class="fas fa-pencil-alt"></i>--%>
<%--                                    </button>--%>

                                    <!-- Modal Chi tiết Phiếu nhập -->
                                    <div class="modal fade" id="detailReceiptModal-${receipt.receiptId}" tabindex="-1" role="document"
                                         aria-labelledby="detailReceiptModal-${receipt.receiptId}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-info text-white">
                                                    <h5 class="modal-title" id="detailReceiptModalLabel-${receipt.receiptId}">Chi tiết Phiếu nhập</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body" id="detailReceiptModalBody-${receipt.receiptId}">
                                                    <!-- Nội dung chi tiết phiếu nhập -->
                                                    <form class="form-horizontal">
                                                        <div class="form-group row">
                                                            <label for="receiptId" class="col-sm-4 col-form-label">Phiếu nhập Id:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="receiptId" value="${receipt.receiptId}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="supplierName" class="col-sm-4 col-form-label">Nhà cung cấp:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="supplierName" value="${receipt.supplier.supplierName}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="createDate" class="col-sm-4 col-form-label">Ngày tạo:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="createDate" value="${receipt.createDate}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="staff" class="col-sm-4 col-form-label">Nhân viên tạo:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="staff" value="${receipt.staff.staffFullName}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <table id="receiptDetailTable" class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                            <tr>
                                                                <td>Stt</td>
                                                                <td>ID Sản phẩm</td>
                                                                <td>Tên Sản phẩm</td>
                                                                <td>Số lượng</td>
                                                                <td>Giá nhập</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach items="${receipt.receiptDetails}" var="receiptDetail" varStatus="loop">
                                                                <tr>
                                                                    <td>${loop.index + 1}</td>
                                                                    <td>${receiptDetail.sizeDetail.product.productId}</td>
                                                                    <td>${receiptDetail.sizeDetail.product.productName}</td>
                                                                    <td>${receiptDetail.quantity}</td>
                                                                    <td data-price="${receiptDetail.importPrice}" class="format-vnd"></td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng <i class="fas fa-times"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Modal Chi tiết Phiếu nhập -->

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
