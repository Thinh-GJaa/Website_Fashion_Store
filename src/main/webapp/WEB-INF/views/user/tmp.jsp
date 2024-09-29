<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/main.min.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <style>
        .step {
            display: none;
        }
        .step.active {
            display: block;
        }
        .form-container {
            max-width: 500px;
            margin: auto;
        }
        .btn-custom {
            background-color: #007bff;
            color: #fff;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .progress-step {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .progress-step .step-item {
            position: relative;
            flex: 1;
            text-align: center;
            font-size: 14px;
        }
        .progress-step .step-item::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #e0e0e0;
            transform: translate(-50%, -50%);
        }
        .progress-step .step-item.active::before {
            background-color: #007bff;
            color: #fff;
        }
        .progress-step .step-item.active {
            font-weight: bold;
        }
        .progress-step .step-item::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 100%;
            width: 100%;
            height: 2px;
            background-color: #e0e0e0;
            transform: translateY(-50%);
        }
        .progress-step .step-item:last-child::after {
            display: none;
        }
        .progress-step .step-item.active + .step-item::after {
            background-color: #007bff;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-lg-6 col-md-8">
            <div class="form-container">
                <!-- Progress Steps -->
                <div class="progress-step">
                    <div class="step-item active" id="step-1-indicator">Bước 1</div>
                    <div class="step-item" id="step-2-indicator">Bước 2</div>
                    <div class="step-item" id="step-3-indicator">Bước 3</div>
                </div>

                <!-- Step 1: Enter Email -->
                <div id="step-1" class="step active">
                    <div class="text-center mb-4">
                        <h2>Nhập Email Để Nhận OTP</h2>
                    </div>
                    <form id="email-form">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
                            <small class="form-text text-danger">${message}</small>
                        </div>
                        <button type="button" class="btn btn-custom btn-block" onclick="sendOTP()">Gửi OTP</button>
                    </form>
                </div>

                <!-- Step 2: Enter OTP -->
                <div id="step-2" class="step">
                    <div class="text-center mb-4">
                        <h2>Nhập OTP</h2>
                    </div>
                    <form id="otp-form">
                        <div class="form-group">
                            <label for="otp">Mã OTP</label>
                            <input type="text" id="otp" name="otp" class="form-control" placeholder="Nhập mã OTP đã nhận" required>
                            <small class="form-text text-danger">${message}</small>
                        </div>
                        <button type="button" class="btn btn-custom btn-block" onclick="verifyOTP()">Xác Nhận OTP</button>
                    </form>
                </div>

                <!-- Step 3: Reset Password -->
                <div id="step-3" class="step">
                    <div class="text-center mb-4">
                        <h2>Đặt Lại Mật Khẩu</h2>
                    </div>
                    <form id="reset-form">
                        <div class="form-group">
                            <label for="newPassword">Mật Khẩu Mới</label>
                            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Nhập Lại Mật Khẩu</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu" required>
                            <small class="form-text text-danger">${message}</small>
                        </div>
                        <button type="button" class="btn btn-custom btn-block" onclick="resetPassword()">Cập Nhật Mật Khẩu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function showStep(step) {
        document.querySelectorAll('.step').forEach((element) => {
            element.classList.remove('active');
        });
        document.querySelectorAll('.step-item').forEach((element) => {
            element.classList.remove('active');
        });
        document.getElementById('step-' + step).classList.add('active');
        document.getElementById('step-' + step + '-indicator').classList.add('active');
    }

    function sendOTP() {
        // Simulate sending OTP
        showStep(2);
    }

    function verifyOTP() {
        // Simulate OTP verification
        showStep(3);
    }

    function resetPassword() {
        // Simulate password reset
        alert('Mật khẩu đã được cập nhật thành công!');
        // Redirect hoặc làm gì đó sau khi cập nhật mật khẩu
    }
</script>
</body>

</html>
