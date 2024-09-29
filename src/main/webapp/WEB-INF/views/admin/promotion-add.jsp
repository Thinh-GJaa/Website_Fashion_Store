<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tạo Đợt khuyến mãi mới</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <!-- Card để nhập thông tin đợt khuyến mãi -->
            <div class="card mb-4">
                <div class="card-header">
                    <h3>Tạo Đợt khuyến mãi mới</h3>
                </div>
                <div class="card-body">
                    <form id="promotionForm">
                        <div class="form-group">
                            <label for="promotionName">Tên Đợt Khuyến Mãi:</label>
                            <input type="text" class="form-control" id="promotionName" name="promotionName" required>
                        </div>
                        <div class="form-group">
                            <label for="startDate">Ngày Bắt Đầu:</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">Ngày Kết Thúc:</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" required>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Card để nhập thông tin sản phẩm khuyến mãi -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span><h3>Thông tin sản phẩm khuyến mãi</h3></span>
                </div>
                <div class="card-body">
                    <table id="productTable" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>ID Sản Phẩm</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Mức Khuyến Mãi (%)</th>
                            <th>Hành Động</th>
                        </tr>
                        </thead>
                        <tbody id="promotionDetails">
                        <!-- Danh sách sản phẩm khuyến mãi sẽ được thêm bằng JavaScript -->
                        </tbody>
                    </table>
                    <button type="button" id="btnSavePromotion" class="btn btn-success float-lg-right ml-2">Lưu đợt khuyến mãi</button>
                    <button type="button" class="btn btn-primary float-lg-right" data-toggle="modal" data-target="#addProductModal">
                        Thêm sản phẩm <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>

            <!-- Modal thêm sản phẩm vào đợt khuyến mãi -->
            <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog"
                 aria-labelledby="addProductModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Thêm Sản Phẩm vào đợt khuyến mãi</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addProductForm">
                                <div class="form-group">
                                    <label for="productName">Tên Sản Phẩm:</label>
                                    <select class="form-control" id="productName" name="productName" multiple>
                                        <c:forEach var="product" items="${productList}">
                                            <option value="${product.productId}">${product.productId}_${product.productName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="promotionRate">Mức Khuyến Mãi (%):</label>
                                    <input type="number" class="form-control" id="promotionRate" name="promotionRate"
                                           min="1" max="100" required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" id="btnAddProduct">Thêm vào đợt khuyến mãi
                            </button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        </div>
                    </div>
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
        let promotionDetails = [];

        // Thêm sản phẩm vào bảng chi tiết đợt khuyến mãi
        $("#btnAddProduct").click(function () {
            const selectedProducts = $("#productName").val(); // Mảng các productId đã chọn
            const promotionRate = $("#promotionRate").val();

            if (!selectedProducts.length) {
                Swal.fire('Thông báo', 'Chưa chọn sản phẩm nào.', 'warning');
                return;
            }

            if(promotionRate === ''){
                Swal.fire('Thông báo', 'Vui lòng nhập mức khuyến mãi.', 'warning');
                return;
            }

            if(promotionRate < 1 || promotionRate > 100){
                Swal.fire('Thông báo', 'Vui lòng nhập giá trị mức khuyến mãi từ 1 đến 100.', 'warning');
                return;
            }

            // Kiểm tra xem sản phẩm đã tồn tại trong bảng chưa và thêm sản phẩm mới vào danh sách
            selectedProducts.forEach(function (productId) {
                const productName = $("#productName option[value='" + productId + "']").text().split("_")[1];
                if (!isProductInPromotion(productId)) {
                    addPromotionDetail(productId, productName, promotionRate);
                }
            });

            $("#addProductModal").modal("hide");

            // In giá trị của promotionDetails ra console
            console.log(promotionDetails);
        });

        // Kiểm tra sản phẩm đã tồn tại trong danh sách chi tiết đợt khuyến mãi
        function isProductInPromotion(productId) {
            return promotionDetails.some(function (detail) {
                return detail.productId === productId;
            });
        }

        // Thêm chi tiết đợt khuyến mãi vào bảng
        function addPromotionDetail(productId, productName, promotionRate) {
            promotionDetails.push({
                productId,
                productName,
                promotionRate
            });
            renderPromotionDetails();

            // In giá trị của promotionDetails ra console
            console.log(promotionDetails);
        }

        // Hiển thị danh sách chi tiết đợt khuyến mãi
        function renderPromotionDetails() {
            const promotionTable = document.getElementById('promotionDetails');
            promotionTable.innerHTML = '';  // Xóa tất cả các hàng hiện tại trong bảng

            promotionDetails.forEach(function (detail, index) {
                const row = document.createElement('tr');

                // STT
                const cellIndex = document.createElement('td');
                cellIndex.textContent = index + 1;
                row.appendChild(cellIndex);

                // ID Sản phẩm
                const cellProductId = document.createElement('td');
                cellProductId.textContent = detail.productId;
                row.appendChild(cellProductId);

                // Tên Sản phẩm
                const cellProductName = document.createElement('td');
                cellProductName.textContent = detail.productName;
                row.appendChild(cellProductName);

                // Mức Khuyến Mãi
                const cellPromotionRate = document.createElement('td');
                const inputPromotionRate = document.createElement('input');
                inputPromotionRate.type = 'number';
                inputPromotionRate.className = 'form-control';
                inputPromotionRate.value = detail.promotionRate;
                inputPromotionRate.min = 1;
                inputPromotionRate.max = 100;
                inputPromotionRate.onchange = function () {
                    detail.promotionRate = inputPromotionRate.value;
                };
                cellPromotionRate.appendChild(inputPromotionRate);
                row.appendChild(cellPromotionRate);

                // Hành Động
                const cellAction = document.createElement('td');
                const deleteButton = document.createElement('button');
                deleteButton.className = 'btn btn-danger btn-sm';
                deleteButton.innerHTML = 'Xóa <i class="fas fa-trash-alt"></i>';
                deleteButton.onclick = function () {
                    removePromotionDetail(index);
                };
                cellAction.appendChild(deleteButton);
                row.appendChild(cellAction);

                // Thêm hàng vào bảng
                promotionTable.appendChild(row);
            });

            // In giá trị của promotionDetails ra console
            console.log(promotionDetails);
        }

        // Xóa chi tiết đợt khuyến mãi khỏi bảng
        function removePromotionDetail(index) {
            promotionDetails.splice(index, 1);
            renderPromotionDetails();

            // In giá trị của promotionDetails ra console
            console.log(promotionDetails);
        }

        // Bắt sự kiện khi nhấn nút Lưu đợt khuyến mãi
        $("#btnSavePromotion").click(function () {
            const promotionName = $("#promotionName").val();
            const startDate = $("#startDate").val();
            const endDate = $("#endDate").val();

            // Kiểm tra các trường không được để trống
            if (!promotionName || !startDate || !endDate) {
                Swal.fire('Thông báo', 'Vui lòng điền đầy đủ thông tin đợt khuyến mãi.', 'warning');
                return;
            }

            // Kiểm tra ngày kết thúc phải lớn hơn ngày bắt đầu
            if (startDate > endDate) {
                Swal.fire('Thông báo', 'Ngày kết thúc phải lớn hơn ngày bắt đầu.', 'warning');
                return;
            }

            // Kiểm tra xem có sản phẩm nào trong đợt khuyến mãi không
            if (promotionDetails.length === 0) {
                Swal.fire('Cảnh báo!', 'Chưa có sản phẩm nào trong đợt khuyến mãi.', 'warning');
                return;
            }

            // Nếu các điều kiện kiểm tra đều đúng, tiến hành gửi dữ liệu lên server
            Swal.fire({
                title: 'Bạn có chắc chắn muốn lưu đợt khuyến mãi này?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                cancelButtonText: 'Hủy bỏ'
            }).then(function (result) {
                if (result.isConfirmed) {
                    const promotionData = {
                        promotionName: promotionName,
                        startDate: startDate,
                        endDate: endDate,
                        promotionDetails: promotionDetails
                    };

                    $.ajax({
                        url: "/admin/promotion",
                        method: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(promotionData),
                        success: function (response) {
                            Swal.fire({
                                title: 'Thành công',
                                icon: 'success',
                                text: 'Đã tạo đợt Khuyễn mãi mới',
                                confirmButtonText: 'OK',
                            }).then(function (result) {
                                if (result.isConfirmed) {
                                    location.reload();
                                }
                            });
                        },
                        error: function (xhr) {
                            Swal.fire('Thất bại!', xhr.responseText, 'error');
                        }
                    });
                }
            });
        });

    });
</script>


</body>
</html>
