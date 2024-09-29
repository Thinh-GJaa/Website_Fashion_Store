<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Khách hàng</title>
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
                    <span><h3>Danh sách Khách hàng</h3></span>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Khách hàng</th>
                            <th>Email</th>
                            <th>SĐT</th>
                            <th>Hình ảnh</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách customerList -->
                        <c:forEach items="${customerList}" var="customer" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${customer.customerId}</td>
                                <td>${customer.customerName}</td>
                                <td>${customer.account.email}</td>
                                <td>${customer.account.phoneNumber}</td>
                                <td>
                                        <%-- Kiểm tra xem Set images có dữ liệu không --%>
                                    <c:if test="${not empty customer.image}">
                                        <img src="${customer.image.linkImage}" alt="${customer.customerName}"
                                             width="100">
                                    </c:if>
                                    <c:if test="${empty customer.image}">
                                        Chưa cập nhật
                                    </c:if>
                                </td>
                                <td>${customer.account.status == true ? 'Đang hoạt động' : 'Đã khóa'}</td>
                                <td>
                                    <button type="button" class="btn btn-info btn-detail-customer" data-toggle="modal"
                                            data-target="#detailCustomerModal-${customer.customerId}"
                                            title="Xem chi tiết">
                                        <i class="fas fa-info-circle"></i>
                                    </button>

                                    <c:choose>
                                        <c:when test="${customer.account.status == true}">
                                            <button type="button" class="btn btn-danger"
                                                    onclick="blockCustomer('${customer.account.email}')"
                                                    title="Khóa Tài khoản Khách hàng">
                                                <i class="fas fa-ban"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-success"
                                                    onclick="unblockCustomer('${customer.account.email}')"
                                                    title="Mở khóa Tài khoản Khách hàng">
                                                <i class="fas fa-check-circle"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>


                                    <!-- Modal Chi tiết Khách hàng -->
                                    <div class="modal fade" id="detailCustomerModal-${customer.customerId}"
                                         tabindex="-1"
                                         role="dialog" aria-labelledby="detailCustomerModalLabel-${customer.customerId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-info text-white">
                                                    <h5 class="modal-title"
                                                        id="detailCustomerModalLabel-${customer.customerId}">Chi tiết
                                                        Khách hàng</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body"
                                                     id="detailCustomerModalBody-${customer.customerId}">
                                                    <!-- Nội dung chi tiết khách hàng sẽ được thêm vào đây -->
                                                    <div class="form-group">
                                                        <label for="customerId">Id Khách hàng :</label>
                                                        <input type="text" id="customerId"
                                                               value="${customer.customerId}" class="form-control"
                                                               disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="customerName">Tên Khách hàng :</label>
                                                        <input type="text" id="customerName"
                                                               value="${customer.customerName}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="gender">Giới tính:</label>
                                                        <input type="text" id="gender"
                                                               value="${customer.gender == '0' ? 'Nữ' : (customer.gender == '1' ? 'Nam' : 'Chưa biết')}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="dateOfBirth">Ngày sinh :</label>
                                                        <input type="text" id="dateOfBirth"
                                                               value="${customer.dateOfBirth}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="phoneNumber">Số điện thoại :</label>
                                                        <input type="text" id="phoneNumber"
                                                               value="${customer.account.phoneNumber}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="email">Email :</label>
                                                        <input type="text" id="email"
                                                               value="${customer.account.email}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="address">Địa chỉ :</label>
                                                        <input type="text" id="address"
                                                               value="${customer.address}"
                                                               class="form-control" disabled>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-dismiss="modal">Đóng <i class="fas fa-times"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Modal Chi tiết Khách hàng -->
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

    //Khóa tài khoản Khàng hàng
    function blockCustomer(email) {
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: "Bạn có chắc chắn muốn khóa tài khoản này?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có, khóa ngay!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: "PUT",
                    url: "/admin/account/block/" + email,
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
            }
        });
    }

    //Mở khóa tài khoản Khách hàng
    function unblockCustomer(email) {
        Swal.fire({
            title: 'Bạn có chắc chắn?',
            text: "Bạn có chắc chắn muốn mở khóa tài khoản này?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có, mở khóa ngay!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: "PUT",
                    url: "/admin/account/unblock/" + email,
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
            }
        });
    }
</script>
</body>
</html>
