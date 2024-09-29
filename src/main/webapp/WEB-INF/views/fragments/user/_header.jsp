<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <!-- Thêm Bootstrap CSS và Font Awesome từ CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/user/home">Trang Chủ</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/user/home/products"><i class="fas fa-box-open"></i> Sản Phẩm</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/user/home/promotions"><i class="fas fa-tags"></i> Khuyến Mãi</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/about"><i class="fas fa-info-circle"></i> Giới Thiệu</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/contact"><i class="fas fa-envelope"></i> Liên Hệ</a>
            </li>
        </ul>
        <!-- Thanh tìm kiếm gọn -->
        <form class="form-inline my-2 my-lg-0" action="/user/home/search" method="get">
            <div class="input-group">
                <input class="form-control form-control-sm" type="search" name="keyword" placeholder="Tìm kiếm..." aria-label="Search" required>
                <div class="input-group-append">
                    <button class="btn btn-outline-success btn-sm" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </div>
        </form>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/user/cart">
                    <i class="fas fa-shopping-cart"></i> Giỏ Hàng
                </a>
            </li>
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user"></i> ${sessionScope.username}
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="/user/profile"><i class="fas fa-user-cog"></i> Thông Tin Cá Nhân</a>
                            <a class="dropdown-item" href="/user/order"><i class="fas fa-shopping-cart"></i> Đơn Hàng</a>
                            <a class="dropdown-item" href="/user/change-password"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/user/logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
                        </div>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="/login"><i class="fas fa-sign-in-alt"></i> Đăng Nhập</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/signup"><i class="fas fa-user-plus"></i> Đăng Ký</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<!-- Thêm Bootstrap và jQuery từ CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
