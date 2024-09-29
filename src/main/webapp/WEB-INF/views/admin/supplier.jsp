<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Nhà cung cấp</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="display-3 card-header d-flex justify-content-between align-items-center">
                    <span><h3>Danh sách Nhà cung cấp</h3></span>
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addSupplierModal">
                        Thêm mới  <i class="fas fa-plus"></i>
                    </button>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Nhà cung cấp</th>
                            <th>Người đại diện</th>
                            <th>Email</th>
                            <th>SĐT</th>
                            <th>Địa chỉ</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách supplierList -->
                        <c:forEach items="${supplierList}" var="supplier" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${supplier.supplierId}</td>
                                <td>${supplier.supplierName}</td>
                                <td>${supplier.representative}</td>
                                <td>${supplier.email}</td>
                                <td>${supplier.phoneNumber}</td>
                                <td>${supplier.address}</td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#editSupplierModal"
                                            data-id="${supplier.supplierId}"
                                            data-name="${supplier.supplierName}"
                                            data-representative="${supplier.representative}"
                                            data-email="${supplier.email}"
                                            data-phone="${supplier.phoneNumber}"
                                            data-address="${supplier.address}">
                                         Sửa <i class="fas fa-pencil-alt"></i>
                                    </button>
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

<!-- Modal Thêm Nhà cung cấp mới -->
<div class="modal fade" id="addSupplierModal" tabindex="-1" role="dialog" aria-labelledby="addSupplierModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="addSupplierModalLabel">Thêm Nhà cung cấp mới</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="supplier" action="/admin/supplier" method="post" id="addSupplierForm">
                    <div class="form-group">
                        <label for="supplierName">Tên Nhà cung cấp</label>
                        <form:input type="text" class="form-control" id="supplierName" path="supplierName" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="representative">Người đại diện</label>
                        <form:input type="text" class="form-control" id="representative" path="representative" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <form:input type="email" class="form-control" id="email" path="email" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">SĐT</label>
                        <form:input type="text" class="form-control" id="phoneNumber" path="phoneNumber" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="address">Địa chỉ</label>
                        <form:input type="text" class="form-control" id="address" path="address" required="true"/>
                    </div>
                    <button type="submit" class="btn btn-success float-right ml-3">Lưu Nhà cung cấp <i class="fas fa-save"></i></button>
                    <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Đóng <i class="fas fa-times"></i></button>

                </form:form>
            </div>
        </div>
    </div>
</div>
<!-- End Modal Thêm Nhà cung cấp mới -->

<!-- Modal Sửa Nhà cung cấp -->
<div class="modal fade" id="editSupplierModal" tabindex="-1" role="dialog" aria-labelledby="editSupplierModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title" id="editSupplierModalLabel">Chỉnh sửa thông tin Nhà cung cấp</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="supplier" action="/admin/supplier" method="put" id="editSupplierForm">
                    <input type="hidden" id="editSupplierId" path="supplierId" />
                    <div class="form-group">
                        <label for="editSupplierName">Tên Nhà cung cấp</label>
                        <form:input type="text" class="form-control" id="editSupplierName" path="supplierName" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="editRepresentative">Người đại diện</label>
                        <form:input type="text" class="form-control" id="editRepresentative" path="representative" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email</label>
                        <form:input type="email" class="form-control" id="editEmail" path="email" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="editPhoneNumber">SĐT</label>
                        <form:input type="text" class="form-control" id="editPhoneNumber" path="phoneNumber" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="editAddress">Địa chỉ</label>
                        <form:input type="text" class="form-control" id="editAddress" path="address" required="true"/>
                    </div>
                    <button type="submit" class="btn btn-success float-right ml-3">Lưu chỉnh sửa <i class="fas fa-save"></i></button>
                    <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Đóng <i class="fas fa-times"></i></button>
                </form:form>
            </div>
        </div>
    </div>
</div>
<!-- End Modal Sửa Nhà cung cấp -->

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
    $(document).ready(function() {
        // Xử lý khi click vào nút Sửa
        $('#editSupplierModal').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget); // Nút được click để mở modal
            var id = button.data('id'); // Lấy thông tin từ data-* attributes
            var name = button.data('name');
            var representative = button.data('representative');
            var email = button.data('email');
            var phone = button.data('phone');
            var address = button.data('address');

            // Đổ dữ liệu vào form chỉnh sửa
            $('#editSupplierId').val(id);
            $('#editSupplierName').val(name);
            $('#editRepresentative').val(representative);
            $('#editEmail').val(email);
            $('#editPhoneNumber').val(phone);
            $('#editAddress').val(address);
        });

        // Xử lý khi form Thêm Nhà cung cấp mới submit
        $('#addSupplierForm').submit(function(event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form

            // Gửi dữ liệu form đi
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/admin/supplier",
                data: JSON.stringify({
                    supplierName: $('#supplierName').val(),
                    representative: $('#representative').val(),
                    email: $('#email').val(),
                    phoneNumber: $('#phoneNumber').val(),
                    address: $('#address').val()
                }),
                success: function(response) {
                    // Hiển thị SweetAlert
                    Swal.fire({
                        icon: 'success',
                        title: 'Thông báo',
                        text: response,
                        confirmButtonText: 'OK',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });

                },
                error: function(xhr, status, error) {
                    // Xử lý khi có lỗi
                    Swal.fire({
                        icon: 'error',
                        title: 'Đã xảy ra lỗi!',
                        text: xhr.responseText,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'OK'
                    });
                }
            });
        });

        // Xử lý khi form Sửa Nhà cung cấp submit
        $('#editSupplierForm').submit(function(event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form

            // Gửi dữ liệu form đi
            $.ajax({
                type: "PUT",
                contentType: "application/json",
                url: "/admin/supplier" ,
                data: JSON.stringify({
                    supplierId: $('#editSupplierId').val(),
                    supplierName: $('#editSupplierName').val(),
                    representative: $('#editRepresentative').val(),
                    email: $('#editEmail').val(),
                    phoneNumber: $('#editPhoneNumber').val(),
                    address: $('#editAddress').val()
                }),
                success: function(response) {
                    // Hiển thị SweetAlert
                    Swal.fire({
                        icon: 'success',
                        title: 'Thông báo',
                        text: response,
                        showConfirmButton: false,
                        timer: 1500
                    });
                    // Sau 2 giây, thực hiện reload trang
                    setTimeout(function() {
                        location.reload();
                    }, 2000); // Thời gian đợi là 2 giây

                },
                error: function(xhr, status, error) {
                    // Xử lý khi có lỗi
                    Swal.fire({
                        icon: 'error',
                        title: 'Đã xảy ra lỗi!',
                        text: xhr.responseText,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    });
</script>
</body>
</html>