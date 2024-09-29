<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="/resources/img/favicon.svg"/>
    <title>Đặt lại mật khẩu</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/resources/fonts/icomoon/icomoon.css"/>

    <!-- Main and Login CSS -->
    <link rel="stylesheet" href="/resources/css/main.min.css"/>

</head>

<body class="login-bg">

<div class="container">
    <div class="login-screen row align-items-center">
        <div class="col-sm-12">
            <form action="/forgot-password-email" id="resetPasswordForm">
                <div class="login-container">
                    <div class="row no-gutters">
                        <div class="col-xl-4 col-lg-5 col-md-6 col-sm-12">
                            <div class="login-box">
                                <a href="/" class="login-logo">
                                    <img src="/resources/img/logo-dark.svg" alt="Admin Dashboard"/>
                                </a>

                                <h5>Đặt lại mật khẩu</h5>
                                <input type="hidden" name="token" value="${token}">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="password">
                                            <i class="icon-key"></i>
                                        </span>
                                    </div>
                                    <input type="password" class="form-control" placeholder="Nhập mật khẩu mới"
                                           aria-label="password"
                                           aria-describedby="password" name="password" required>
                                </div>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="confirmPassword">
                                            <i class="icon-key"></i>
                                        </span>
                                    </div>
                                    <input type="password" class="form-control" placeholder="Nhập lại mật khẩu mới"
                                           aria-label="confirmPassword"
                                           aria-describedby="confirmPassword" name="confirmPassword" required>
                                </div>

                                <div class="actions clearfix">
                                    <button type="submit" class="btn btn-primary">Xác nhận</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-8 col-lg-7 col-md-6 col-sm-12">
                            <div class="login-slider">

                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<script>
    $(document).ready(function () {
        $('#resetPasswordForm').on('submit', function (event) {
            event.preventDefault();

            const formData = new FormData(this);
            $.ajax({
                type: "POST",
                url: "/forgot-password-email",
                data: formData,
                processData: false,
                contentType: false,

                success: function () {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: 'Mật khẩu đã được thay đổi thành công!',
                        confirmButtonText: 'Chuyển đến đăng nhập'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "/login";
                        }
                    });
                },
                error: function (xhr) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi',
                        text: xhr.responseText,
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    });
</script>

</body>
</html>
