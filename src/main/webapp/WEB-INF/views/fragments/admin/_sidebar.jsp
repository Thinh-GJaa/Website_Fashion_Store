<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<aside class="app-side" id="app-side">
    <!-- BEGIN .side-content -->
    <div class="side-content">
        <!-- BEGIN .user-profile -->
        <div class="user-profile">

            <img src="/resources/img/user.png" class="profile-thumb">

            <h6 class="profile-name">${sessionScope.usernameAdmin}</h6>
        </div>
        <!-- END .user-profile -->
        <!-- BEGIN .side-nav -->
        <nav class="side-nav">
            <!-- BEGIN: side-nav-content -->
            <ul class="unifyMenu" id="unifyMenu">

                <li class="active selected">
                    <a href="/admin/order/pending" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-shopping-cart"></i> <!-- Sửa icon thành giỏ hàng -->
                        </span>
                        <span class="nav-title">Quản lý Đơn đặt hàng</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href="/admin/order/pending">Chờ duyệt</a>
                        </li>
                        <li>
                            <a href="/admin/order/approved">Đã duyệt</a>
                        </li>
                        <li>
                            <a href="/admin/order/delivered">Đã giao</a>
                        </li>
                        <li>
                            <a href="/admin/order/cancelled">Đã hủy</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="/admin/supplier" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-truck"></i> <!-- Sửa icon thành xe tải -->
                        </span>
                        <span class="nav-title">Quản lý Nhà cung cấp</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href="/admin/supplier">Danh sách nhà cung cấp</a>
                        </li>
                        <li>
                            <a href="/admin/supplier/add">Thêm Nhà cung cấp mới</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="#" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-box-open"></i> <!-- Sửa icon thành hộp mở -->
                        </span>
                        <span class="nav-title">Quản lý Sản phẩm</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href='/admin/product'>Danh sách sản phẩm</a>
                        </li>
                        <li>
                            <a href='/admin/product/update-price'>Cập nhật giá</a>
                        </li>
                        <li>
                            <a href='/admin/product/inventory'>Kiểm tra tồn kho</a>
                        </li>
                        <li>
                            <a href='/admin/category'>Danh mục</a>
                        </li>
                        <li>
                            <a href='/admin/brand'>Thương hiệu</a>
                        </li>
                        <li>
                            <a href='/admin/size'>Size</a>
                        </li>
                        <li>
                            <a href='/admin/material'>Chất liệu</a>
                        </li>

                    </ul>
                </li>

                <li>
                    <a href="/admin/receipt" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-receipt"></i> <!-- Sửa icon thành hóa đơn -->
                        </span>
                        <span class="nav-title">Quản lý Phiếu nhập hàng</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href='/admin/receipt'>Danh sách Phiếu nhập hàng</a>
                        </li>
                        <li>
                            <a href='/admin/receipt/add'>Tạo Phiếu nhập hàng</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="/admin/promotion" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-tags"></i> <!-- Sửa icon thành tag -->
                        </span>
                        <span class="nav-title">Quản lý Khuyến mãi</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href="/admin/promotion">Danh sách Khuyến mãi</a>
                        </li>
                        <li>
                            <a href="/admin/promotion/add">Tạo Khuyến mãi mới</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="/admin/statistics" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-chart-line"></i> <!-- Sửa icon thành biểu đồ đường -->
                        </span>
                        <span class="nav-title">Quản lý Thống kê</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href="/admin/statistic/account">Thống kê Tài Khoản</a>
                        </li>
                        <li>
                            <a href="/admin/statistic/product">Thống kê Sản phẩm</a>
                        </li>
                        <li>
                            <a href="/admin/statistic/order">Thống kê Đơn hàng</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="/admin/account" class="has-arrow" aria-expanded="false">
                        <span class="has-icon">
                            <i class="fas fa-user"></i> <!-- Sửa icon thành người dùng -->
                        </span>
                        <span class="nav-title">Quản lý Tài khoản người dùng</span>
                    </a>
                    <ul aria-expanded="false">
                        <li>
                            <a href="/admin/account/customer">Danh sách Khách hàng</a>
                        </li>
                        <li>
                            <a href="/admin/account/staff">Danh sách Nhân viên</a>
                        </li>

                    </ul>
                </li>

                <!-- Các phần khác nếu cần -->

            </ul>
            <!-- END: side-nav-content -->
        </nav>
        <!-- END: .side-nav -->
    </div>
    <!-- END: .side-content -->
</aside>

