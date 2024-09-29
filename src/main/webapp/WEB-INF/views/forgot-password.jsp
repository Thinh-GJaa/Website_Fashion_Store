<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="/resources/img/favicon.svg" />
    <title>Forgot Password</title>

    <!-- Common CSS -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/fonts/icomoon/icomoon.css" />

    <!-- Mian and Login css -->
    <link rel="stylesheet" href="/resources/css/main.min.css" />

    <style>
        /* Spinner CSS */
        .spinner-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .spinner {
            border: 8px solid rgba(0, 0, 0, 0.1);
            border-top: 8px solid #3498db;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

    </style>

</head>

<body class="login-bg">

<div class="container">

    <div id="spinner" class="spinner-overlay" style="display: none;">
        <div class="spinner"></div>
    </div>

    <div class="login-screen row align-items-center">
        <div class="col-sm-12">
            <form action="/forgot-password" id="forgotPasswordForm">
                <div class="login-container">
                    <div class="row no-gutters">
                        <div class="col-xl-4 col-lg-5 col-md-6 col-sm-12">
                            <div class="login-box">
                                <a href="/" class="login-logo">
                                    <img src="/resources/img/logo-dark.svg" alt="Admin Dashboard" />
                                </a>

                                <h5>Quên mật khẩu?</h5>
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
												<span class="input-group-text">
													<i class="icon-account_circle"></i>
												</span>
                                    </div>
                                    <input type="email" id="email" class="form-control" placeholder="Nhập Email..." aria-label="email"
                                           aria-describedby="email" name="email">
                                </div>

                                <div class="actions clearfix">
                                    <button type="submit" class="btn btn-primary">Submit</button>
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
    $(document).ready(function() {
        $('#forgotPasswordForm').on('submit', function(event) {
            event.preventDefault();

            // Hiển thị spinner
            $('#spinner').show();

            $.ajax({
                type: "POST",
                url: "/forgot-password",
                data: {
                    email : $('#email').val()
                },
                success: function() {
                    // Ẩn spinner
                    $('#spinner').hide();

                    // Hiển thị thông báo thành công
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: 'Vui lòng kiểm tra Email!',
                        confirmButtonText: 'Chuyển đến đăng nhập'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "/login";
                        }
                    });
                },
                error: function(xhr) {
                    // Ẩn spinner
                    $('#spinner').hide();

                    // Hiển thị thông báo lỗi
                    Swal.fire({
                        icon: 'warning',
                        title: 'Cảnh báo',
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