<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Nhân viên</title>
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
                    <span><h3>Danh sách Nhân viên</h3></span>
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addStaffModal">
                        Thêm mới <i class="fas fa-plus"></i>
                    </button>
                </div>

                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Nhân viên</th>
                            <th>Email</th>
                            <th>SĐT</th>
                            <th>Hình ảnh</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách staffList -->
                        <c:forEach items="${staffList}" var="staff" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${staff.staffId}</td>
                                <td>${staff.staffFullName}</td>
                                <td>${staff.account.email}</td>
                                <td>${staff.account.phoneNumber}</td>
                                <td>
                                    <%-- Kiểm tra xem Set images có dữ liệu không --%>
                                    <c:if test="${not empty staff.image}">
                                        <img src="${staff.image.linkImage}" alt="${staff.staffFullName}" width="75">
                                    </c:if>
                                </td>
                                <td>${staff.account.status == true ? 'Đang hoạt động' : 'Đã nghĩ việc'}
                                </td>
                                <td>
                                    <button type="button" class="btn btn-info btn-detail-staff" data-toggle="modal"
                                            data-target="#detailStaffModal-${staff.staffId}" title="Xem chi tiết">
                                        <i class="fas fa-info-circle"></i>
                                    </button>
                                    <button type="button" class="btn btn-info btn-edit-staff" data-toggle="modal"
                                            data-target="#editStaffModal-${staff.staffId}" title="Sửa thông tin">
                                        <i class="fas fa-pencil-alt"></i>
                                    </button>
                                    <c:choose>
                                        <c:when test="${staff.account.status == true}">
                                            <button type="button" class="btn btn-danger"
                                                    onclick="blockStaff('${staff.account.email}')"
                                                    title="Khóa Tài khoản Nhân viên ">
                                                <i class="fas fa-lock"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-success"
                                                    onclick="unblockStaff('${staff.account.email}')"
                                                    title="Mở khóa Tài khoản Khách hàng">
                                                <i class="fas fa-lock-open"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Modal Chi tiết Nhân viên  -->
                                    <div class="modal fade" id="detailStaffModal-${staff.staffId}" tabindex="-1"
                                         role="dialog" aria-labelledby="detailStaffModalLabel-${staff.staffId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-info text-white">
                                                    <h5 class="modal-title"
                                                        id="detailStaffModalLabel-${staff.staffId}">Chi tiết Nhân
                                                        viên</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body"
                                                     id="detailStaffModalBody-${staff.staffId}">
                                                    <!-- Nội dung chi tiết khách hàng sẽ được thêm vào đây -->
                                                    <div class="form-group">
                                                        <label for="staffId">Id Nhân viên:</label>
                                                        <input type="text" id="staffId"
                                                               value="${staff.staffId}" class="form-control"
                                                               disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="staffName">Tên Nhân viên :</label>
                                                        <input type="text" id="staffName"
                                                               value="${staff.staffFullName}"
                                                               class="form-control" disabled>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="gender">Giới tính:</label>
                                                        <input type="text" id="gender"
                                                               value="${staff.gender == '0' ? 'Nữ' : (staff.gender == '1' ? 'Nam' : 'Chưa biết')}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="dateOfBirth">Ngày sinh :</label>
                                                        <input type="text" id="dateOfBirth"
                                                               value="${staff.dateOfBirth}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="phoneNumber">Số điện thoại :</label>
                                                        <input type="text" id="phoneNumber"
                                                               value="${staff.account.phoneNumber}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="email">Email :</label>
                                                        <input type="text" id="email"
                                                               value="${staff.account.email}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="address">Địa chỉ :</label>
                                                        <input type="text" id="address"
                                                               value="${staff.address}"
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
                                    <!-- End Modal Chi tiết Nhân viên  -->

                                    <!-- Modal Sửa Nhân viên -->
                                    <div class="modal fade" id="editStaffModal-${staff.staffId}" tabindex="-1"
                                         role="dialog" aria-labelledby="editStaffModalLabel-${staff.staffId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-primary text-white">
                                                    <h5 class="modal-title"
                                                        id="editStaffModalLabel-${staff.staffId}">Sửa Thông tin Nhân
                                                        viên</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>

                                                <div class="modal-body">
                                                    <form:form modelAttribute="staffEdit"
                                                               id="editStaffForm-${staff.staffId}">
                                                        <form:input type="hidden" path="staffId" name="staffId"
                                                                    value="${staff.staffId}" required="true"/>
                                                        <form:input type="hidden" path="account.accountId"
                                                                    name="account.accountId"
                                                                    value="${staff.account.accountId}" required="true"/>
                                                        <div class="form-group">
                                                            <label for="staffFullName">Tên Nhân viên </label>
                                                            <form:input type="text" class="form-control"
                                                                        id="staffFullName" path="staffFullName"
                                                                        value="${staff.staffFullName}" required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="gender">Giới tính</label>
                                                            <form:select path="gender" class="form-control">
                                                                <option value="0" label="Nữ"
                                                                    <c:if test="${0 == staff.gender}">selected</c:if>>/>
                                                                <option value="1" label="Nam"
                                                                    <c:if test="${1 == staff.gender}">selected</c:if>>/>
                                                                <option value="2" label="Chưa biết"
                                                                    <c:if test="${2 == staff.gender}">selected</c:if>>/>
                                                            </form:select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="dateOfBirth">Ngày sinh </label>
                                                            <form:input type="date" class="form-control"
                                                                        id="dateOfBirth" path="dateOfBirth"
                                                                        value="${staff.dateOfBirth}" required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="account.email">Email </label>
                                                            <form:input type="text" class="form-control"
                                                                        id="account.email" path="account.email"
                                                                        value="${staff.account.email}" required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="account.phoneNumber">Số điện thoại </label>
                                                            <form:input type="text" class="form-control"
                                                                        id="account.phoneNumber"
                                                                        path="account.phoneNumber"
                                                                        value="${staff.account.phoneNumber}"
                                                                        required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="address">Địa chỉ </label>
                                                            <form:input type="text" class="form-control"
                                                                        id="address" path="address"
                                                                        value="${staff.address}" required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="image-${staff.staffId}">Hình ảnh </label>
                                                            <input type="file" class="form-control" name="imageStaffEdit" id="image-${staff.staffId}"/>
                                                        </div>

                                                        <div class="mb-4">
                                                            <%-- Kiểm tra xem Set images có dữ liệu không --%>
                                                            <c:if test="${not empty staff.image}">
                                                                <img class="w-50" id ="editImagePre-${staff.staffId}" src="${staff.image.linkImage}" alt="${staff.staffFullName}">
                                                            </c:if>
                                                        </div>

                                                        <button type="submit" class="btn btn-success float-right ml-3">
                                                            Lưu chỉnh sửa <i class="fas fa-save"></i></button>
                                                        <button type="button" class="btn btn-secondary float-right "
                                                                data-dismiss="modal">Đóng <i class="fas fa-times"></i>
                                                        </button>
                                                    </form:form>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                        <%--End Modal Sửa Nhân viên--%>
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

<!-- Modal Thêm Nhân viên mới -->
<div class="modal fade" id="addStaffModal" tabindex="-1" role="dialog" aria-labelledby="addStaffModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="addStaffModalLabel">Thêm Nhân viên mới</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="staffNew" action="/admin/account/staff" method="post" id="addStaffForm">
                    <div class="form-group">
                        <label for="staffFullName">Tên Nhân viên mới</label>
                        <form:input type="text" class="form-control" id="staffFullName" path="staffFullName"
                                    required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <form:select path="gender" class="form-control" defaultValue="0">
                            <form:option value="0" label="Nữ"/>
                            <form:option value="1" label="Nam"/>
                            <form:option value="2" label="Chưa biết"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label for="dateOfBirth">Ngày sinh </label>
                        <form:input type="date" class="form-control"
                                    id="dateOfBirth" path="dateOfBirth" required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="account.email">Email </label>
                        <form:input type="text" class="form-control"
                                    id="account.email" path="account.email"
                                    required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="account.phoneNumber">Số điện thoại </label>
                        <form:input type="text" class="form-control"
                                    id="account.phoneNumber" path="account.phoneNumber"
                                    required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="address">Địa chỉ </label>
                        <form:input type="text" class="form-control"
                                    id="address" path="address"
                                    required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="imageStaff">Hình ảnh </label>
                        <input type="file" class="form-control" id="imageStaff" name="imageStaff"
                               accept="image/jpeg, image/png" required/>
                    </div>
                    <div class="mb-4 form-group">
                        <img class="w-50 d-none form-group" id="imagePreview" src="#" alt="Ảnh xem trước">
                    </div>
                    <button type="submit" class="btn btn-success float-right ml-3">Lưu Sản phẩm <i
                            class="fas fa-save"></i></button>
                    <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Đóng <i
                            class="fas fa-times"></i></button>
                </form:form>
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

    //Khóa tài khoản Nhân viên
    function blockStaff(email) {
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
    function unblockStaff(email) {
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

    $(document).ready(function () {

        // Xử lý sự kiện khi người dùng thay đổi hình ảnh trong modal thêm nhân viên
        $('#imageStaff').change(function () {
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

        // Xử lý sự kiện khi người dùng thay đổi hình ảnh trong modal sửa nhân viên
        $('input[id^="image"]').change(function () {
            const id = $(this).attr('id').split('-')[1];
            console.log("id: "+ id);
            const reader = new FileReader();

            reader.onload = function (e) {
                // Set lại src của hình ảnh
                console.log(e.target.result)
                $('#editImagePre-' + id).attr('src', e.target.result);
            }

            // Đọc file hình ảnh
            if (this.files && this.files[0]) {
                reader.readAsDataURL(this.files[0]);
            }
        });

        $('#addStaffForm').submit(function (event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form

            // Tạo FormData object
            const formData = new FormData(this);

            // Gửi AJAX request
            $.ajax({
                type: "POST",
                url: "/admin/account/staff",
                data: formData,
                processData: false, // Không xử lý dữ liệu, vì chúng ta đang gửi FormData object
                contentType: false, // Không đặt contentType, jQuery sẽ tự động đặt
                success: function (response) {
                    // Xử lý khi nhận được phản hồi từ server
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
                error: function (xhr) {
                    // Xử lý khi gặp lỗi
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi',
                        text: xhr.responseText,
                        confirmButtonText: 'OK'
                    });
                }
            });
        });


        $(document).on('submit', '[id^="editStaffForm-"]', function (event) {
            event.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                type: "PUT",
                url: "/admin/account/staff",
                data: formData,
                processData: false, // Không xử lý dữ liệu, vì chúng ta đang gửi FormData object
                contentType: false, // Không đặt contentType, jQuery sẽ tự động đặt
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
    })
</script>

</body>
</html>
