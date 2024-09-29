<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đổi mật khẩu</title>
    <!-- Thêm Bootstrap CSS và jQuery từ CDN -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

    <style>
        body {
        }
        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .card-header {
            border-radius: 10px 10px 0 0;
        }
        .card-header h3 {
            margin: 0;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 50px;
        }
        .form-control {
            border-radius: 50px;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group i {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card mt-3">
                <div class="card-header text-center">
                    <h3>Đổi mật khẩu</h3>
                </div>
                <div class="card-body">
                    <form id="changePasswordForm">
                        <div class="form-group">
                            <label for="currentPassword"><i class="fas fa-lock"></i> Mật khẩu hiện tại:</label>
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="newPassword"><i class="fas fa-lock"></i> Mật khẩu mới:</label>
                            <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword"><i class="fas fa-lock"></i> Xác nhận mật khẩu:</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                        </div>
                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-primary">Đổi mật khẩu <i class="fas fa-save"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>
    $('#changePasswordForm').submit(function (event) {
        event.preventDefault();

        // Lấy dữ liệu từ form
        const currentPassword = $('#currentPassword').val();
        const newPassword = $('#newPassword').val();
        const confirmPassword = $('#confirmPassword').val();

        // Kiểm tra mật khẩu mới và xác nhận mật khẩu có khớp hay không
        if (newPassword.length < 6) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: 'Mật khẩu mới phải có ít nhất 6 ký tự!',
                confirmButtonText: 'OK'
            });
            return;
        }

        if (newPassword !== confirmPassword) {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                text: 'Mật khẩu mới và xác nhận mật khẩu không khớp!',
                confirmButtonText: 'OK'
            });
            return;
        }

        // Tạo đối tượng dữ liệu để gửi
        const data = {
            currentPassword: currentPassword,
            newPassword: newPassword
        };

        // Gửi AJAX request
        $.ajax({
            type: "POST",
            url: "/user/change-password",
            data: data,
            success: function (response) {
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công',
                    text: response,
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
            },
            error: function (xhr) {
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
