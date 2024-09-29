<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thống kê sản phẩm</title>
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

        .table {
            width: 100%;
            margin-bottom: 0.5rem;
            color: #212529;
        }

        .table thead th {
            vertical-align: bottom;
            border-bottom: 2px solid #dee2e6;
        }

        .table tbody + tbody {
            border-top: 2px solid #dee2e6;
        }

        .table .table {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="container">
    <%--Thống kê top10 sp bán chạy--%>
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Top 5 sản phẩm bán chạy nhất</h3>
                </div>
                <div class="card-body">
                    <!-- Form chọn ngày -->
                    <form action="/admin/statistic/top-product/date" class="form-inline"
                          id="statisticTopProductDateForm">
                        <div class="form-group mb-2">
                            <label for="startDate" class="mr-2">Ngày bắt đầu:</label>
                            <input type="date" id="startDate" name="startDate" class="form-control mr-3" required>
                        </div>
                        <div class="form-group mb-2">
                            <label for="endDate" class="mr-2">Ngày kết thúc:</label>
                            <input type="date" id="endDate" name="endDate" class="form-control mr-3" required>
                        </div>
                        <button type="submit" class="btn btn-primary mb-2">Thống kê</button>
                    </form>
                    <hr>
                    <!-- Bảng thống kê sản phẩm -->
                    <table class="table" id="productTable">
                        <thead>
                        <tr>
                            <th>Top</th>
                            <th>ID Sản phẩm</th>
                            <th>Tên Sản phẩm</th>
                            <th>Hình ảnh</th>
                            <th>Số lượng bán được</th>
                        </tr>
                        </thead>
                        <tbody id="productTableBody">
                        <c:forEach var="product" items="${topSellingProduct}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${product.productId}</td>
                                <td>${product.productName}</td>
                                <td>
                                    <img src="${product.productImage}" alt="${product.productName}" width="50">
                                </td>
                                <td>${product.quantity}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>Thống kê Số lượng bán được theo ngày của sản phẩm</h3>
                </div>
                <div class="card-body">
                    <form action="/admin/statistic/product/date" class="form-inline" id="statisticProductDateForm">
                        <div class="form-row align-items-center">
                            <div class="form-group mb-2">
                                <label for="productId" class="mr-2">Sản phẩm:</label>
                                <select id="productId" name="productId" class="form-control mr-3" required>
                                    <c:forEach items="${productList}" var="product">
                                        <option value="${product.productId}">${product.productId}_${product.productName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group mb-2">
                                <label for="startDate1" class="mr-2"> | Ngày:</label>
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
                    <!-- Bảng thống kê sản phẩm -->
                    <div>
                        <canvas id="productChart"></canvas>
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

        $('#statisticTopProductDateForm').submit(function (event) {
                event.preventDefault(); // Ngăn chặn submit mặc định của form
                const startDate = $('#startDate').val();
                const endDate = $('#endDate').val();


                $.ajax({
                    url: '<c:url value="/admin/statistic/top-product/date"/>',
                    type: 'GET',
                    data: {
                        startDate: startDate,
                        endDate: endDate
                    },
                    success: function (response) {

                        const products = JSON.parse(response);
                        if(products.length === 0){
                            Swal.fire({
                                icon: 'info',
                                title: 'Thông báo',
                                text: 'Không có dữ liệu để hiển thị.'
                            });
                            return;
                        }


                        const tableBody = $('#productTableBody');
                        tableBody.empty(); // Xóa dữ liệu cũ

                        products.forEach(function (product, index) {
                            const row = document.createElement('tr');

                            // Tạo các ô (cell) trong hàng (row)
                            const cell1 = document.createElement('td');
                            cell1.textContent = index + 1; // Hiển thị thứ tự sản phẩm

                            const cell2 = document.createElement('td');
                            cell2.textContent = product.productId;

                            const cell3 = document.createElement('td');
                            cell3.textContent = product.productName;

                            const cell4 = document.createElement('td');
                            const img = document.createElement('img');
                            img.src = product.productImage;
                            img.alt = product.productName;
                            img.width = 50;
                            cell4.appendChild(img);

                            const cell5 = document.createElement('td');
                            cell5.textContent = product.quantity;

                            // Thêm các ô vào hàng
                            row.appendChild(cell1);
                            row.appendChild(cell2);
                            row.appendChild(cell3);
                            row.appendChild(cell4);
                            row.appendChild(cell5);

                            // Thêm hàng vào tbody
                            tableBody[0].appendChild(row);
                        });
                    },
                    error: function (xhr) {
                        Swal.fire("Cảnh báo", xhr.responseText, "warning");
                    }
                });
            }
        );


        let productChart = null;

        // Tính toán ngày bắt đầu và ngày kết thúc cho 30 ngày gần nhất
        const now = new Date();
        const endDate = new Date(now);
        const startDate = new Date(now.setDate(now.getDate() - 30));

        // Định dạng ngày theo yêu cầu của input[type="date"]
        const formatDate = (date) => {
            return date.toISOString().split('T')[0];
        };

        // Đặt giá trị mặc định cho các trường input date
        $('#startDate1').val(formatDate(startDate));
        $('#endDate1').val(formatDate(endDate));

        const productId1 = $('#productId').val();
        const startDate1 = $('#startDate1').val();
        const endDate1 = $('#endDate1').val();

        // Gọi AJAX để lấy dữ liệu thống kê cho 30 ngày gần nhất
        $.ajax({
            url: '<c:url value="/admin/statistic/product/date"/>',
            type: 'GET',
            data: {
                productId: productId1,
                startDate: startDate1,
                endDate: endDate1,
            },
            success: function (response) {
                const products = JSON.parse(response);
                updateCharProduct(products);
            },
            error: function (xhr) {
                Swal.fire("Cảnh báo", xhr.responseText, "warning");
            }
        });

        // Cập nhật biểu đồ ngày tạo
        function updateCharProduct(statisticProductJson) {
            // Kiểm tra nếu dữ liệu trống
            if (statisticProductJson.length === 0) {
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
            const canvasParent = $('#productChart').parent();

            // Xóa canvas hiện tại
            $('#productChart').remove();

            // Tạo canvas mới và thêm nó vào cha của nó
            canvasParent.append('<canvas id="productChart"></canvas>');

            // Tạo biểu đồ mới với dữ liệu mới
            const ctx = document.getElementById('productChart').getContext('2d');
            productChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: statisticProductJson.map(item => item.label),
                    datasets: [{
                        label: 'Số lượng',
                        data: statisticProductJson.map(item => item.value),
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Màu nền với độ mờ
                        borderColor: '#1e88e5',
                        borderWidth: 2,
                        fill: true, // Bật chế độ tô màu
                        tension: 0.2, // Làm đường cong
                    }],
                },
                options: {
                    plugins: {

                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Ngày Tạo'
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





        $('#statisticProductDateForm').submit(function (event) {
                event.preventDefault(); // Ngăn chặn submit mặc định của form
                const productId = $('#productId').val();
                const startDate = $('#startDate1').val();
                const endDate = $('#endDate1').val();


                $.ajax({
                    url: '<c:url value="/admin/statistic/product/date"/>',
                    type: 'GET',
                    data: {
                        productId: productId,
                        startDate: startDate,
                        endDate: endDate
                    },
                    success: function (response) {
                        const products = JSON.parse(response);
                        console.log('Parsed Products:', products);

                        updateCharProduct(products);
                    },
                    error: function (xhr) {
                        Swal.fire("Cảnh báo", xhr.responseText, "warning");
                    }
                });
            }
        );

    });



</script>

</body>
</html>
