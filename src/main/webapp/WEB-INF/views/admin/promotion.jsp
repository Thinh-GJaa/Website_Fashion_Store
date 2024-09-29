<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Đợt Khuyến mãi</title>
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
                    <span><h3>Danh sách Đợt Khuyến mãi</h3></span>
                    <button onclick="window.location.href='/admin/promotion/add'" type="button" class="btn btn-success"> Thêm mới <i class="fas fa-plus"></i></button>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Đợt Khuyến mãi</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách promotionList -->
                        <c:forEach items="${promotionList}" var="promotion" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${promotion.promotionId}</td>
                                <td>${promotion.promotionName}</td>
                                <td>${promotion.startDate}</td>
                                <td>${promotion.endDate}</td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#detailPromotionModal-${promotion.promotionId}">
                                        Chi tiết <i class="fas fa-info-circle"></i>
                                    </button>
<%--                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#editpromotionModal-${promotion.promotionId}">--%>
<%--                                        Sửa <i class="fas fa-pencil-alt"></i>--%>
<%--                                    </button>--%>

                                    <!-- Modal Chi tiết Phiếu nhập -->
                                    <div class="modal fade" id="detailPromotionModal-${promotion.promotionId}" tabindex="-1" role="document"
                                         aria-labelledby="detailPromotionModal-${promotion.promotionId}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-info text-white">
                                                    <h5 class="modal-title" id="detailPromotionModalLabel-${promotion.promotionId}">Chi tiết Phiếu nhập</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body" id="detailPromotionModalBody-${promotion.promotionId}">
                                                    <!-- Nội dung chi tiết phiếu nhập -->
                                                    <form class="form-horizontal">
                                                        <div class="form-group row">
                                                            <label for="promotionId" class="col-sm-4 col-form-label">Đợt Khuyến mãi Id:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="promotionId" value="${promotion.promotionId}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="promotionName" class="col-sm-4 col-form-label">Tên Đợt Khuyến mãi:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="promotionName" value="${promotion.promotionName}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="startDate" class="col-sm-4 col-form-label">Ngày bắt đầu:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="startDate" value="${promotion.startDate}" class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="endDate" class="col-sm-4 col-form-label">Ngày kết thúc:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="endDate" value="${promotion.endDate}" class="form-control" disabled>
                                                            </div>
                                                        </div>

                                                        <table id="promotionDetailTable" class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                            <tr>
                                                                <td>Stt</td>
                                                                <td>ID Sản phẩm</td>
                                                                <td>Tên Sản phẩm</td>
                                                                <td>Mức khuyến mãi(%)</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach items="${promotion.promotionDetails}" var="promotionDetail" varStatus="loop">
                                                                <tr>
                                                                    <td>${loop.index + 1}</td>
                                                                    <td>${promotionDetail.product.productId}</td>
                                                                    <td>${promotionDetail.product.productName}</td>
                                                                    <td>${promotionDetail.rate}</td>
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

</body>
</html>
