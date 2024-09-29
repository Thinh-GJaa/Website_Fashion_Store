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
                    <span><h3>Tạo Phiếu nhập hàng mới </h3></span>
                    <button href="/admin/receipt/add" type="button" class="btn btn-success"> Thêm mới <i
                            class="fas fa-plus"></i></button>
                </div>
                <div class="d-flex align-items-center ml-5 mt-3">
                    <h5> -- Chọn Nhà cung cấp:
                        <select id="supplier" name ="supplier" class="ml-2" data-live-search="true" required>
                            <c:forEach var="supplier" items="${supplierList}">
                                <option value="${supplier.supplierId}">${supplier.supplierName}</option>
                            </c:forEach>
                        </select>
                    </h5>
                </div>


                <div class="card-body">
                    <table id="productTable" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Tên Sản phẩm</th>
                            <th>Size</th>
                            <th>Số lượng</th>
                            <th>Giá nhập</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody id="invoiceTable">
                        <!-- Danh sách sản phẩm sẽ được thêm bằng JavaScript -->
                        </tbody>
                    </table>
                    <div class="fixed-buttons mt-3">
                        <!-- Nút để mở dialog -->
                        <button type="button" class="btn btn-primary" data-toggle="modal"
                                data-target="#addProductModal">Thêm Sản Phẩm
                        </button>
                        <!-- Nút để mở dialog -->
                        <button type="button" id="btnAddReceipt" class="btn btn-success">Thêm phiếu nhập</button>
                    </div>

                    <!-- Modal thêm sản phẩm vào phiếu nhập -->
                    <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog"
                         aria-labelledby="addProductModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header bg-success text-white">
                                    <h5 class="modal-title" id="addProductModalLabel">Thêm Sản Phẩm vào phiếu</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="addProductName">Tên Sản Phẩm:</label>
                                        <div class="d-flex">
                                            <select id="addProductName" name="addProductName"
                                                    class="form-control" data-live-search="true" required>
                                                <c:forEach var="product" items="${productList}">
                                                    <option value="${product.productId}">${product.productName}</option>
                                                </c:forEach>
                                            </select>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="addProductSize">Size:</label>
                                        <div class="d-flex">
                                            <select id="addProductSize" name="addProductSize" class="form-control"
                                                    required>
                                                <c:forEach var="size" items="${sizeList}">
                                                    <option value="${size.sizeId}">${size.sizeName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="addProductPrice">Giá Nhập:</label>
                                        <input type="number" class="form-control" id="addProductPrice"
                                               name="addProductPrice" min="1" required/>
                                    </div>
                                    <div class="form-group">
                                        <label for="addProductQuantity">Số Lượng:</label>
                                        <input type="number" class="form-control" id="addProductQuantity"
                                               name="addProductQuantity" required min="1"/>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-success float-lg-right ml-3"
                                            id="btnAddProduct">Thêm Vào Phiếu <i class="fas fa-plus"></i></button>
                                    <button type="button" class="btn btn-secondary float-lg-right" data-dismiss="modal">
                                        Đóng <i class="fas fa-times"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bao gồm các thư viện JavaScript -->
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

    $(document).ready(function () {

        let invoices = [];

        // Thêm sản phẩm vào phiếu nhập
        $("#btnAddProduct").click(function () {
            const productName = $("#addProductName option:selected").text();
            const productId = $("#addProductName").val();
            const productSize = $("#addProductSize option:selected").text();
            const sizeId = $("#addProductSize").val();
            const productPrice = $("#addProductPrice").val();
            const productQuantity = $("#addProductQuantity").val();

            //Kiểm tra size sp đã tồn tại trong bảng chưa
            if (isProductInInvoices(productId, sizeId)) {
                Swal.fire('Thông báo', 'Sản phẩm đã tồn tại trong phiếu nhập.', 'warning');
                return;
            }

            //Kiểm tra giá nhập rỗng
            if (productPrice === "") {
                Swal.fire('Cảnh báo', 'Giá nhập không được để trống.', 'warning');
                return;
            }

            //Kiểm tra số lượng rỗng
            if (productQuantity === "") {
                Swal.fire('Cảnh báo', 'Số lượng không được để trống.', 'warning');
                return;
            }

            addInvoice(productName, productId, productSize, sizeId, productPrice, productQuantity);
            Swal.fire({
                title: 'Thêm thành công',
                text: 'Sản phẩm ' + productName + '_' + productSize,
                icon: 'success',
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
            });
            $("#addProductModal").modal("hide");

        });

        // Kiểm tra sản phẩm đã tồn tại trong phiếu nhập hay chưa
        function isProductInInvoices(productId, sizeId) {
            return invoices.some(function (invoice) {
                return invoice.productId=== productId && invoice.sizeId === sizeId;
            });
        }

        // Thêm phiếu nhập vào bảng
        function addInvoice(productName, productId, productSize, sizeId, productPrice, productQuantity) {
            invoices.push({
                productName,
                productId,
                productSize,
                sizeId,
                productPrice,
                productQuantity
            });
            renderInvoices();
        }

        // Hiển thị danh sách phiếu nhập
        function renderInvoices() {
            const invoiceTable = document.getElementById('invoiceTable');
            invoiceTable.innerHTML = '';  // Xóa tất cả các hàng hiện tại trong bảng

            console.log("Invoices data:", invoices);

            invoices.forEach(function (invoice, index) {
                console.log("Rendering invoice index:", index);
                console.log("Product Name:", invoice.productName);
                console.log("Product Size:", invoice.productSize);
                console.log("Product Quantity:", invoice.productQuantity);
                console.log("Product Price:", invoice.productPrice);

                // Tạo hàng mới
                const row = document.createElement('tr');

                // Tạo và thêm ô số thứ tự
                const cellIndex = document.createElement('td');
                cellIndex.textContent = index + 1;
                row.appendChild(cellIndex);

                // Tạo và thêm ô tên sản phẩm
                const cellProductName = document.createElement('td');
                cellProductName.textContent = invoice.productName;
                row.appendChild(cellProductName);

                // Tạo và thêm ô kích cỡ sản phẩm
                const cellProductSize = document.createElement('td');
                cellProductSize.textContent = invoice.productSize;
                row.appendChild(cellProductSize);

                // Tạo và thêm ô số lượng
                const cellProductQuantity = document.createElement('td');
                cellProductQuantity.textContent = invoice.productQuantity;
                row.appendChild(cellProductQuantity);

                // Tạo và thêm ô giá nhập
                const cellProductPrice = document.createElement('td');
                cellProductPrice.textContent = invoice.productPrice;
                row.appendChild(cellProductPrice);

                const cellAction = document.createElement('td');
                const deleteButton = document.createElement('button');
                deleteButton.className = 'btn btn-danger btn-sm';
                deleteButton.innerHTML = 'Xóa <i class="fas fa-trash-alt"></i>'; // Thêm icon trước chữ Xóa
                deleteButton.onclick = function () {
                    removeInvoice(index);
                };
                cellAction.appendChild(deleteButton);
                row.appendChild(cellAction);


                // Thêm hàng vào bảng
                invoiceTable.appendChild(row);
            });
        }

        // Xóa sản phẩm khỏi phiếu nhập
        window.removeInvoice = function (index) {
            invoices.splice(index, 1);
            renderInvoices();
            Swal.fire({
                title: 'Đã xóa khỏi danh sách',
                icon: 'warning',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
            });
        };

        // Xác nhận thêm phiếu nhập
        $("#btnAddReceipt").click(function () {
            if (invoices.length === 0) {
                Swal.fire('Cảnh báo!', 'Chưa có sản phẩm nào trong phiếu nhập.', 'warning');
                return;
            }

            Swal.fire({
                title: 'Bạn có chắc chắn muốn thêm phiếu nhập ?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                confirmButtonColor: 'Green',
                cancelButtonText: 'Hủy bỏ',
            }).then(function (result) {
                if (result.isConfirmed) {
                    const supplierId = $("#supplier").val();
                    $.ajax({
                        url: "/admin/receipt?supplier=" + supplierId,
                        method: "POST",
                        data: JSON.stringify(invoices),
                        contentType: "application/json",
                        success: function (response) {
                            // Xử lý khi nhận được phản hồi từ server
                            Swal.fire({
                                icon: 'success',
                                title: 'Thông báo',
                                text: response,
                                confirmButtonText: 'OK',
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = "/admin/receipt";
                                }
                            });

                        },
                        error: function () {
                            Swal.fire('Thất bại!', 'Thêm phiếu nhập hàng thất bại.', 'error');
                        },
                    });
                }
            });

        });

    });

</script>

</body>
</html>
