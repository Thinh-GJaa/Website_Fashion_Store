<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thống kê hóa đơn</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 20px;
        }

        .card {
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .card-header {
            padding: 15px;
            background-color: #007bff;
            color: #000000;
            border-bottom: 1px solid #dee2e6;
            border-radius: 8px 8px 0 0;
        }

        .card-body {
            padding: 20px;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Số lượng hóa đơn theo ngày </h3>
                </div>
                <div class="card-body">
                    <form action="/admin/statistic/order/date" method="get" class="form-inline"
                          id="statisticOrderDateForm">
                        <div class="form-row align-items-center">

                            <div class="form-group mb-2 ml-5">
                                <label for="startDate" class="mr-2"> Ngày:</label>
                                <input type="date" id="startDate" name="startDate" class="form-control mr-3" required>
                            </div>
                            <div class="form-group mb-2">
                                <label for="endDate" class="mr-2">đến</label>
                                <input type="date" id="endDate" name="endDate" class="form-control mr-3" required>
                            </div>
                            <div class="form-group mb-2">
                                <button type="submit" class="btn btn-primary">Thống kê</button>
                            </div>
                        </div>
                    </form>


                    <hr>
                    <!-- Biểu đồ thống kê sản phẩm -->
                    <div>
                        <canvas id="orderChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Doanh thu theo ngày </h3>
                </div>
                <div class="card-body">
                    <form action="/admin/statistic/sales/date" method="get" class="form-inline"
                          id="statisticSalesDateForm">
                        <div class="form-row align-items-center">

                            <div class="form-group mb-2 ml-5">
                                <label for="startDate1" class="mr-2"> Ngày:</label>
                                <input type="date" id="startDate1" name="startDate1" class="form-control mr-3" required>
                            </div>
                            <div class="form-group mb-2">
                                <label for="endDate1" class="mr-2">đến</label>
                                <input type="date" id="endDate1" name="endDate1" class="form-control mr-3" required>
                            </div>
                            <div class="form-group mb-2">
                                <button type="submit" class="btn btn-primary">Thống kê</button>
                            </div>
                        </div>
                    </form>


                    <hr>
                    <!-- Biểu đồ thống kê sản phẩm -->
                    <div>
                        <canvas id="salesDateChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Doanh thu theo tháng trong năm </h3>
                </div>
                <div class="card-body">
                    <!-- Biểu đồ thống kê doanh thu theo tháng -->
                    <div>
                        <canvas id="salesMonthChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Doanh thu theo năm </h3>
                </div>
                <div class="card-body">
                    <!-- Biểu đồ thống kê doanh thu theo năm -->
                    <div>
                        <canvas id="salesYearChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- jQuery và các plugin JS khác -->
<script src="<c:url value='/resources/js/jquery.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/vendor/unifyMenu/unifyMenu.js'/>"></script>
<script src="<c:url value='/resources/vendor/onoffcanvas/onoffcanvas.js'/>"></script>
<script src="<c:url value='/resources/js/moment.js'/>"></script>

<!-- Common JS -->
<script src="<c:url value='/resources/js/common.js'/>"></script>

<!-- Data Tables -->
<script src="/resources/vendor/datatables/dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap.min.js"></script>

<!-- Custom Data tables -->
<script src="/resources/vendor/datatables/custom/custom-datatables.js"></script>
<script src="/resources/vendor/datatables/custom/fixedHeader.js"></script>

<!-- Chart JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- SweetAlert library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
    $(document).ready(function () {
        let orderChart = null;
        let salesDateChart = null;

        // Tính toán ngày bắt đầu và ngày kết thúc cho 30 ngày gần nhất
        const now = new Date();
        const endDate = new Date(now);
        const startDate = new Date(now.setDate(now.getDate() - 30));

        // Định dạng ngày theo yêu cầu của input[type="date"]
        const formatDate = (date) => {
            return date.toISOString().split('T')[0];
        };

        // Đặt giá trị mặc định cho các trường input date
        $('#startDate').val(formatDate(startDate));
        $('#endDate').val(formatDate(endDate));
        $('#startDate1').val(formatDate(startDate));
        $('#endDate1').val(formatDate(endDate));

        // Lấy dữ liệu thống kê số lượng hóa đơn cho 30 ngày gần nhất( mặc định)
        $.ajax({
            url: '/admin/statistic/order/date',
            type: 'GET',
            data: {
                startDate: formatDate(startDate),
                endDate: formatDate(endDate)
            },
            success: function (response) {
                const orders = JSON.parse(response);
                updateChartOrder(orders);
            },
            error: function (xhr) {
                Swal.fire("Cảnh báo", xhr.responseText, "warning");
            }
        });

        // Lấy dữ liệu thống kê doanh thu cho 30 ngày gần nhất( mặc định)
        $.ajax({
            url: '/admin/statistic/sales/date',
            type: 'GET',
            data: {
                startDate: formatDate(startDate),
                endDate: formatDate(endDate)
            },
            success: function (response) {
                const sales = JSON.parse(response);
                updateChartSalesDate(sales);
            },
            error: function (xhr) {
                Swal.fire("Cảnh báo", xhr.responseText, "warning");
            }
        });

        //Lấy dữ liệu thống kê doanh thu theo các tháng
        $.ajax({
            url: '/admin/statistic/sales/month',
            type: 'GET',
            success: function (response) {
                const sales = JSON.parse(response);
                updateChartSalesMonth(sales);
            },
            error: function (xhr) {
                Swal.fire("Cảnh báo", xhr.responseText, "warning");
            }
        });

        //Lấy dữ liệu thống kê doanh thu theo các năm
        $.ajax({
            url: '/admin/statistic/sales/year',
            type: 'GET',
            success: function (response) {
                const sales = JSON.parse(response);
                updateChartSalesYear(sales);
            },
            error: function (xhr) {
                Swal.fire("Cảnh báo", xhr.responseText, "warning");
            }
        });

        //Xử lý form khi cập nhật khoảng thời gian thống kê số lượng hoá đơn
        $('#statisticOrderDateForm').submit(function (event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form
            const startDate = $('#startDate').val();
            const endDate = $('#endDate').val();

            $.ajax({
                url: '/admin/statistic/order/date',
                type: 'GET',
                data: {
                    startDate: startDate,
                    endDate: endDate
                },
                success: function (response) {
                    const orders = JSON.parse(response);
                    updateChartOrder(orders);
                },
                error: function (xhr) {
                    Swal.fire("Cảnh báo", xhr.responseText, "warning");
                }
            });
        });

        //Submit form thống kê doanh thu theo ngày
        $('#statisticSalesDateForm').submit(function (event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form
            const startDate = $('#startDate1').val();
            const endDate = $('#endDate1').val();

            $.ajax({
                url: '/admin/statistic/sales/date',
                type: 'GET',
                data: {
                    startDate: startDate,
                    endDate: endDate
                },
                success: function (response) {
                    const sales = JSON.parse(response);
                    updateChartSalesDate(sales);
                },
                error: function (xhr) {
                    Swal.fire("Cảnh báo", xhr.responseText, "warning");
                }
            });
        });


        // Cập nhật biểu đồ thông kê số lượng hóa đơn theo ngày
        function updateChartOrder(statisticOrder) {
            // Kiểm tra nếu dữ liệu trống
            if (statisticOrder.length === 0) {
                // Hiển thị thông báo bằng SweetAlert
                Swal.fire({
                    icon: 'info',
                    title: 'Thông báo',
                    text: 'Không có dữ liệu để hiển thị.'
                });

                // Dừng lại và không vẽ biểu đồ
                return;
            }

            // Lấy phần tử canvas hiện tại và cha của nó
            const canvasParent = $('#orderChart').parent();

            // Xóa canvas hiện tại
            $('#orderChart').remove();

            // Tạo canvas mới và thêm nó vào cha của nó
            canvasParent.append('<canvas id="orderChart"></canvas>');

            // Tạo biểu đồ mới với dữ liệu mới
            const ctx = document.getElementById('orderChart').getContext('2d');
            orderChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: statisticOrder.map(item => item.label),
                    datasets: [{
                        label: 'Số lượng',
                        data: statisticOrder.map(item => item.value),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền với độ mờ
                        borderColor: '#1e88e5',
                        borderWidth: 2,
                        fill: true, // Bật chế độ tô màu
                        tension: 0.2, // Làm đường cong
                    }],
                },
                options: {
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Ngày'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Số lượng'
                            }
                        }
                    }
                }
            });
        }

        // Cập nhật biểu đồ thống kê doanh thu theo khoảng ngày
        function updateChartSalesDate(statisticSales) {
            // Kiểm tra nếu dữ liệu trống
            if (statisticSales.length === 0) {
                // Hiển thị thông báo bằng SweetAlert
                Swal.fire({
                    icon: 'info',
                    title: 'Thông báo',
                    text: 'Không có dữ liệu để hiển thị.'
                });

                // Dừng lại và không vẽ biểu đồ
                return;
            }

            // Lấy phần tử canvas hiện tại và cha của nó
            const canvasParent = $('#salesDateChart').parent();

            // Xóa canvas hiện tại
            $('#salesDateChart').remove();

            // Tạo canvas mới và thêm nó vào cha của nó
            canvasParent.append('<canvas id="salesDateChart"></canvas>');

            // Tạo biểu đồ mới với dữ liệu mới
            const ctx = document.getElementById('salesDateChart').getContext('2d');
            salesDateChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: statisticSales.map(item => item.label),
                    datasets: [{
                        label: 'Doanh thu',
                        data: statisticSales.map(item => item.value),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền với độ mờ
                        borderColor: '#1e88e5',
                        borderWidth: 2,
                        fill: true, // Bật chế độ tô màu
                        tension: 0.2, // Làm đường cong
                    }],
                },
                options: {
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Ngày'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Doanh thu (vnđ)'
                            }
                        }
                    }
                }
            });
        }

        // Cập nhật biểu đồ thống kê doanh thu theo các tháng trong năm
        function updateChartSalesMonth(statisticSales) {
            // Kiểm tra nếu dữ liệu trống
            if (statisticSales.length === 0) {
                // Hiển thị thông báo bằng SweetAlert
                Swal.fire({
                    icon: 'info',
                    title: 'Thông báo',
                    text: 'Không có dữ liệu thống kê theo các tháng.'
                });

                // Dừng lại và không vẽ biểu đồ
                return;
            }

            // Tạo biểu đồ mới với dữ liệu mới
            new Chart($('#salesMonthChart'), {
                type: 'bar',
                data: {
                    labels: statisticSales.map(item => item.label),
                    datasets: [{
                        label: 'Doanh thu',
                        data: statisticSales.map(item => item.value),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền với độ mờ
                        borderColor: '#1e88e5',
                        borderWidth: 2,
                        fill: true, // Bật chế độ tô màu
                        tension: 0.2, // Làm đường cong
                    }],
                },
                options: {
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Tháng'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Doanh thu (vnđ)'
                            }
                        }
                    }
                }
            });
        }


        // Cập nhật biểu đồ thống kê doanh thu theo các năm
        function updateChartSalesYear(statisticSales) {
            // Kiểm tra nếu dữ liệu trống
            if (statisticSales.length === 0) {
                // Hiển thị thông báo bằng SweetAlert
                Swal.fire({
                    icon: 'info',
                    title: 'Thông báo',
                    text: 'Không có dữ liệu thống kê theo các năm.'
                });

                // Dừng lại và không vẽ biểu đồ
                return;
            }

            // Tạo biểu đồ mới với dữ liệu mới
            new Chart($('#salesYearChart'), {
                type: 'bar',
                data: {
                    labels: statisticSales.map(item => item.label),
                    datasets: [{
                        label: 'Doanh thu',
                        data: statisticSales.map(item => item.value),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền với độ mờ
                        borderColor: '#1e88e5',
                        borderWidth: 2,
                        fill: true, // Bật chế độ tô màu
                        tension: 0.2, // Làm đường cong
                    }],
                },
                options: {
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Năm'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Doanh thu (vnđ)'
                            }
                        }
                    }
                }
            });
        }
    });
</script>


</body>
</html>
