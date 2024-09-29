<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Danh mục</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
    <style>
        #editImage- ${category.categoryId} {
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="display-3 card-header d-flex justify-content-between align-items-center">
                    <span><h3>Danh sách Danh mục sản phẩm</h3></span>
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addCategoryModal">
                        Thêm mới <i class="fas fa-plus"></i>
                    </button>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Danh mục</th>
                            <th>Hình ảnh</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách categoryList -->
                        <c:forEach items="${categoryList}" var="category" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${category.categoryId}</td>
                                <td>${category.categoryName}</td>
                                <td>
                                    <c:if test="${not empty category.image}">
                                        <img src="${category.image.linkImage}" id="image"
                                             alt="${category.categoryName}" width="50">
                                    </c:if>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal"
                                            data-target="#editCategoryModal-${category.categoryId}">
                                        Sửa <i class="fas fa-pencil-alt"></i>
                                    </button>
                                    <!-- Modal Sửa Danh mục -->
                                    <div class="modal fade" id="editCategoryModal-${category.categoryId}" tabindex="-1"
                                         role="dialog" aria-labelledby="editCategoryModalLabel-${category.categoryId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-success text-white">
                                                    <h5 class="modal-title"
                                                        id="editCategoryModalLabel-${category.categoryId}">Sửa danh
                                                        mục </h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="/admin/category" method="post"
                                                          id="editCategoryForm-${category.categoryId}">
                                                        <input type="hidden" id = "editCategoryId" name = "editCategoryId" value="${category.categoryId}">
                                                        <div class="form-group">
                                                            <label for="editCategoryName">Tên Danh mục: </label>
                                                            <input type="text" class="form-control"
                                                                   name="editCategoryName"
                                                                   id="editCategoryName"
                                                                   value="${category.categoryName}" required/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="editCategoryImage-${category.categoryId}">Hình ảnh:</label>
                                                            <input type="file" class="form-control" name="editCategoryImage" id="editCategoryImage-${category.categoryId}" required/>
                                                        </div>
                                                        <div class="mb-4">
                                                            <img class="w-50" src="${category.image.linkImage}" id="editImage-${category.categoryId}" alt="${category.categoryName}"/>
                                                        </div>

                                                        <button type="submit" class="btn btn-success float-right ml-3">
                                                            Lưu Danh mục
                                                            <i class="fas fa-save"></i></button>
                                                        <button type="button" class="btn btn-secondary float-right"
                                                                data-dismiss="modal">Đóng <i
                                                                class="fas fa-times"></i></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Modal Sửa Danh mục -->
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

<!-- Modal Thêm Danh mục mới -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addCategoryModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="addCategoryModalLabel">Thêm Danh mục mới</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/admin/category" method="post" id="addCategoryForm">
                    <div class="form-group">
                        <label for="categoryName">Tên Danh mục mới </label>
                        <input type="text" class="form-control" name="categoryName" id="categoryName" required/>
                    </div>
                    <div class="form-group">
                        <label for="categoryImage">Hình ảnh </label>
                        <input type="file" class="form-control" name="categoryImage" id="categoryImage" required/>
                    </div>
                    <div class="mb-4">
                        <img class="w-50 d-none" id="imagePreview" src="#" alt="Ảnh xem trước">
                    </div>

                    <button type="submit" class="btn btn-success float-right ml-3">Lưu Danh mục <i
                            class="fas fa-save"></i></button>
                    <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Đóng <i
                            class="fas fa-times"></i></button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End Modal Thêm Danh mục mới -->

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

        // Xử lý khi form Thêm Danh mục mới submit
        $('#addCategoryForm').submit(function (event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form
            const formData = new FormData(this);
            // Gửi dữ liệu form đi
            $.ajax({
                type: "POST",
                url: "/admin/category",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    // Hiển thị SweetAlert
                    Swal.fire({
                        icon: 'success',
                        title: 'Thông báo',
                        text: response,
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });
                },
                error: function (xhr, status, error) {
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

        // Gắn sự kiện submit cho các form động
        $(document).on('submit', '[id^="editCategoryForm-"]', function (event) {
            event.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                type: "PUT",
                url: "/admin/category",
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


        // Xử lý sự kiện khi người dùng thay đổi hình ảnh trong modal thêm danh mục
        $('#categoryImage').change(function () {
            const reader = new FileReader();
            reader.onload = function (e) {
                // Set lại src của hình ảnh mới
                $('#imagePreview').attr('src', e.target.result);
                // Hiển thị div chứa hình ảnh
                $('#imagePreview').removeClass('d-none');
            }
            // Đọc file hình ảnh
            if (this.files && this.files[0]) {
                reader.readAsDataURL(this.files[0]);
            }
        });

        // Xử lý sự kiện khi người dùng thay đổi hình ảnh trong modal sửa danh mục
        $('input[id^="editCategoryImage"]').change(function () {
            const id = $(this).attr('id').split('-')[1];
            console.log("id: "+ id);
            const reader = new FileReader();

            reader.onload = function (e) {
                // Set lại src của hình ảnh
                console.log(e.target.result)
                $('#editImage-' + id).attr('src', e.target.result);
                // Hiển thị hình ảnh
                $('#editImage-' + id).removeClass('d-none'); // Loại bỏ class d-none để hiển thị div cha của hình ảnh
            }

            // Đọc file hình ảnh
            if (this.files && this.files[0]) {
                reader.readAsDataURL(this.files[0]);
            }
        });


    });
</script>
</body>
</html>
