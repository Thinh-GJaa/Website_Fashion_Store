<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
</head>
<body>

<div class="main-content">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <form:form modelAttribute="staff" id="profileForm" class="text-left">
                <div class="card">
                    <div class="card-header">
                        <h3>Thông tin cá nhân</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-5 text-center">
                                <c:if test="${not empty staff.image}">
                                    <img id="profileImage" src="${staff.image.linkImage}" alt="${staff.staffFullName}"
                                         class="rounded-circle mb-4"
                                         style="width: 350px; height: 350px; object-fit: cover;">
                                </c:if>
                                <c:if test="${empty staff.image}">
                                    <img id="profileImage" src="/resources/img/avatar-default.jpg" alt="Profile Image"
                                         class="rounded-circle mb-4"
                                         style="width: 300px; height: 300px; object-fit: cover;">
                                </c:if>
                                <div id="editProfileImage" style="display: none;">
                                    <input type="file" id="imageInput" name="imageInput" accept="image/*"
                                           style="display: none;">
                                    <label for="imageInput" class="btn btn-primary mt-2">Chọn ảnh mới</label>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <form:hidden path="account.accountId"/>
                                <form:hidden path="staffId"/>
                                <form:hidden path="image.linkImage"/>
                                <form:hidden path="image.imageId"/>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-id-badge"></i> Mã nhân viên:</label>
                                    <div class="col-sm-8">
                                        <form:input path="staffId" cssClass="form-control-plaintext" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-user"></i> Họ và
                                        tên:</label>
                                    <div class="col-sm-8">
                                        <form:input path="staffFullName" cssClass="form-control-plaintext"
                                                    readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-venus-mars"></i> Giới tính:</label>
                                    <div class="col-sm-8">

                                        <form:select path="gender" cssClass="form-control">
                                            <form:option value="0" label="Nữ"/>
                                            <form:option value="1" label="Nam"/>
                                            <form:option value="2" label="Chưa biết"/>
                                        </form:select>

                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-calendar-alt"></i> Ngày
                                        sinh:</label>
                                    <div class="col-sm-8">
                                        <form:input path="dateOfBirth" cssClass="form-control-plaintext" readonly="true"
                                                    type="date"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-envelope"></i>
                                        Email:</label>
                                    <div class="col-sm-8">
                                        <form:input path="account.email" cssClass="form-control-plaintext"
                                                    readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-phone"></i> Số điện
                                        thoại:</label>
                                    <div class="col-sm-8">
                                        <form:input path="account.phoneNumber" cssClass="form-control-plaintext"
                                                    readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 col-form-label"><i class="fas fa-map-marker-alt"></i> Địa
                                        chỉ:</label>
                                    <div class="col-sm-8">
                                        <form:input path="address" cssClass="form-control-plaintext" readonly="true"/>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-right">
                        <button type="button" class="btn btn-success" id="editButton" onclick="toggleEditMode(true)">
                            Chỉnh sửa <i class="fas fa-edit"></i>
                        </button>
                        <button type="submit" class="btn btn-primary d-none" id="saveButton">
                            Lưu <i class="fas fa-save"></i>
                        </button>
                        <button type="button" class="btn btn-secondary d-none" id="cancelButton"
                                onclick="toggleEditMode(false)">
                            Thoát chỉnh sửa <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>

<!-- jQuery first, then Bootstrap JS. -->
<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/vendor/unifyMenu/unifyMenu.js"></script>
<script src="/resources/vendor/onoffcanvas/onoffcanvas.js"></script>
<script src="/resources/js/moment.js"></script>

<!-- Common JS -->
<script src="/resources/js/common.js"></script>

<!-- SweetAlert library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
    // Xử lý khi click nút "Chỉnh sửa"
    function toggleEditMode(editMode) {
        const formElements = document.querySelectorAll('#profileForm input, #profileForm select');
        formElements.forEach(element => {
            element.readOnly = !editMode;
            element.classList.toggle('form-control-plaintext', !editMode);
            element.classList.toggle('form-control', editMode);
        });

        document.getElementById('editButton').classList.toggle('d-none', editMode);
        document.getElementById('saveButton').classList.toggle('d-none', !editMode);
        document.getElementById('cancelButton').classList.toggle('d-none', !editMode);

        // Hiển thị input chọn ảnh nếu đang ở chế độ chỉnh sửa
        const editProfileImage = document.getElementById('editProfileImage');
        editProfileImage.style.display = editMode ? 'block' : 'none';
    }

    // Xử lý khi chọn file ảnh mới
    document.getElementById('imageInput').addEventListener('change', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (event) {
                const profileImage = document.getElementById('profileImage');
                profileImage.src = event.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Xử lý khi submit form thành công
    $('#profileForm').submit(function (event) {
        event.preventDefault();

        // Tạo FormData object
        const formData = new FormData(this);

        // Gửi AJAX request
        $.ajax({
            type: "PUT",
            url: "/admin/profile",
            data: formData,
            processData: false, // Không xử lý dữ liệu, vì chúng ta đang gửi FormData object
            contentType: false, // Không đặt contentType, jQuery sẽ tự động đặt
            success: function (response) {
                // Xử lý khi nhận được phản hồi từ server
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công',
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
                    title: 'Thất bại',
                    text: xhr.responseText,
                    confirmButtonText: 'OK'
                });
            }
        });
    });
</script>

</body>
</html>
