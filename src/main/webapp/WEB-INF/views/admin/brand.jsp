<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý Thương hiệu</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-md-7">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Danh sách Thương hiệu</h3>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Thương hiệu</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách brandList -->
                        <c:forEach items="${brandList}" var="brand" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${brand.brandId}</td>
                                <td>${brand.brandName}</td>
                                <td>
                                    <button type="button" onclick="function editBrand(id) {
                                            $('#editBrandId').val(id);
                                            // Lấy tên thương hiệu từ danh sách hiện tại và điền vào form sửa
                                            const brandName = $('#basicExample').find('tr').eq(id).find('td').eq(2).text();
                                            $('#editBrandName').val(brandName);
                                            }
                                            editBrand(${brand.brandId})"
                                            class="btn btn-info">Sửa <i class="fas fa-pencil-alt"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-5 ">
            <div class="card">
                <div class="card-header">
                    <h3>Thêm mới Thương hiệu</h3>
                </div>
                <div class="card-body">
                    <!-- Form thêm mới thương hiệu -->
                    <form:form modelAttribute="brandNew" id="addBrandForm">
                        <div class="form-group">
                            <label for="brandName">Tên Thương hiệu mới:</label>
                            <input path="brandName" class="form-control" id="brandName" required>
                        </div>
                        <button type="submit" class="btn btn-primary float-xl-right">Thêm mới <i
                                class="fas fa-plus"></i></button>
                    </form:form>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h3>Sửa Thương hiệu</h3>
                </div>
                <div class="card-body">
                    <!-- Form sửa thương hiệu -->
                    <form id="editBrandForm">
                        <input type="hidden" id="editBrandId" name="editBrandId">

                        <div class="form-group">
                            <label for="editBrandName">Tên Thương hiệu cũ:</label>
                            <input type="text" class="form-control" id="editBrandName" name="editBrandName" readonly>
                        </div>
                        <div class="form-group">
                            <label for="editBrandNameNew">Tên Thương hiệu mới:</label>
                            <input type="text" class="form-control" id="editBrandNameNew" name="editBrandNameNew"
                                   required>
                        </div>
                        <button type="submit" class="btn btn-primary float-lg-right">Lưu thay đổi <i
                                class="fas fa-save"></i></button>
                    </form>
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
        function editBrand(id) {
            $('#editBrandId').val(id);
            // Lấy tên thương hiệu từ danh sách hiện tại và điền vào form sửa
            const brandName = $('#basicExample').find('tr').eq(id).find('td').eq(2).text();
            $('#editBrandName').val(brandName);
        }

        $('#addBrandForm').on('submit', function (event) {
            event.preventDefault();

            const formData = {
                brandName: $('#brandName').val()
            };

            $.ajax({
                type: "POST",
                url: "/admin/brand",
                contentType: 'application/json',
                data: JSON.stringify(formData),
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

        $('#editBrandForm').on('submit', function (event) {
            event.preventDefault();

            const formData = {
                brandId: $('#editBrandId').val(),
                brandName: $('#editBrandName').val(),
                brandNameNew: $('#editBrandNameNew').val(),
            };

            $.ajax({
                type: "PUT",
                url: "/admin/brand",
                contentType: 'application/json',
                data: JSON.stringify(formData),
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
