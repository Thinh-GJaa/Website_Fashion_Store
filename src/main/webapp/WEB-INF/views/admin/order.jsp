<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Danh sách Đơn đặt hàng</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
</head>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="display-3 card-header d-flex justify-content-between align-items-center">
                    <span><h3>Danh sách Đơn đặt hàng</h3></span>
                </div>
                <div class="d-flex align-items-center ml-5 mt-3">
                    <h5>-- Chọn Trạng thái Đơn đặt hàng:
                        <select class="form-select" id="status">
                            <option value="pending" ${status == "pending" ? 'selected' : ''}>Chờ duyệt</option>
                            <option value="approved" ${status == "approved" ? 'selected' : ''}>Đã duyệt</option>
                            <option value="delivered" ${status == "delivered" ? 'selected' : ''}>Đã giao thành công
                            </option>
                            <option value="cancelled" ${status == "cancelled" ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </h5>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id Đơn</th>
                            <th>Id Khách hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách orderList -->
                        <c:forEach items="${orderList}" var="order" varStatus="loop">
                            <tr data-order-id="${order.orderId}">
                                <td>${loop.index + 1}</td>
                                <td>${order.orderId}</td>
                                <td>${order.customer.customerId}</td>
                                <td>${order.createDate}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${order.totalAmount == order.totalDiscountAmount}">
                                            <span class="format-vnd" data-price="${order.totalAmount}"></span>
                                        </c:when>
                                        <c:otherwise>
                                            <del><span class="format-vnd" data-price="${order.totalAmount}"></span>
                                            </del>
                                            <span class="format-vnd" data-price="${order.totalDiscountAmount}"></span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-info" data-toggle="modal"
                                            data-target="#detailOrderModal-${order.orderId}" title="Chi tiết">
                                        <i class="fas fa-info-circle"></i>

                                    </button>
                                    <c:choose>
                                        <c:when test="${status == 'pending'}">
                                            <button onclick="confirmApproveOrder(${order.orderId})"
                                                    class="btn btn-success" title="Duyệt phiếu đặt">
                                                <i class="fas fa-check-circle"></i>
                                            </button>
                                            <button onclick="confirmCancelOrder(${order.orderId})"
                                                    class="btn btn-danger" title="Hủy phiếu đặt">
                                                <i class="fas fa-times-circle"></i>
                                            </button>
                                        </c:when>
                                        <c:when test="${status == 'approved'}">
                                            <button onclick="confirmDeliverOrder(${order.orderId})"
                                                    class="btn btn-success" title="Giao thành công">
                                                <i class="fas fa-truck"></i>
                                            </button>
                                        </c:when>
                                    </c:choose>

                                    <!-- Modal Chi tiết Đơn đặt hàng -->
                                    <div class="modal fade" id="detailOrderModal-${order.orderId}" tabindex="-1"
                                         role="document" aria-labelledby="detailOrderModal-${order.orderId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-info text-white">
                                                    <h5 class="modal-title"
                                                        id="detailOrderModalLabel-${order.orderId}">Chi tiết Đơn đặt
                                                        hàng</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body" id="detailOrderModalBody-${order.orderId}">
                                                    <!-- Nội dung chi tiết đơn đặt hàng sẽ được thêm vào đây -->
                                                    <form class="form-horizontal">
                                                        <div class="form-group row">
                                                            <label for="orderId" class="col-sm-4 col-form-label">Id Đơn
                                                                đặt hàng:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="orderId" value="${order.orderId}"
                                                                       class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="customerId" class="col-sm-4 col-form-label">Id
                                                                Khách hàng:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="customerId"
                                                                       value="${order.customer.customerId}"
                                                                       class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="createDate" class="col-sm-4 col-form-label">Ngày
                                                                đặt hàng:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="createDate"
                                                                       value="${order.createDate}" class="form-control"
                                                                       disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="recipientName" class="col-sm-4 col-form-label">Họ
                                                                tên người nhận:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="recipientName"
                                                                       value="${order.recipientName}"
                                                                       class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="phoneNumber" class="col-sm-4 col-form-label">SĐT:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="phoneNumber"
                                                                       value="${order.phoneNumber}" class="form-control"
                                                                       disabled>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="address" class="col-sm-4 col-form-label">Địa chỉ
                                                                nhận:</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" id="address" value="${order.address}"
                                                                       class="form-control" disabled>
                                                            </div>
                                                        </div>
                                                        <c:if test="${status == 'cancelled'}">
                                                            <div class="form-group row">
                                                                <label for="reason" class="col-sm-4 col-form-label">Lý do hủy:</label>
                                                                <div class="col-sm-8">
                                                                    <input type="text" id="reason"
                                                                           value="${order.reason}"
                                                                           class="form-control" disabled>
                                                                </div>
                                                            </div>
                                                        </c:if>

                                                        <table id="orderDetailTable"
                                                               class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                            <tr>
                                                                <td>Stt</td>
                                                                <td>ID Sản phẩm</td>
                                                                <td>Tên Sản phẩm</td>
                                                                <td>Size</td>
                                                                <td>Hình ảnh</td>
                                                                <td>Giá</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach items="${order.orderDetails}" var="orderDetail"
                                                                       varStatus="loop">
                                                                <tr>
                                                                    <td>${loop.index +1 }</td>
                                                                    <td>${orderDetail.sizeDetail.product.productId}</td>
                                                                    <td>${orderDetail.sizeDetail.product.productName}</td>
                                                                    <td>${orderDetail.sizeDetail.size.sizeName}</td>
                                                                    <td>
                                                                            <%-- Kiểm tra xem Set images có dữ liệu không --%>
                                                                        <c:if test="${not empty orderDetail.sizeDetail.product.images}">
                                                                            <%-- Lặp qua các phần tử trong Set images --%>
                                                                            <c:forEach var="image"
                                                                                       items="${orderDetail.sizeDetail.product.images}"
                                                                                       varStatus="loop">
                                                                                <%-- Chỉ lấy phần tử đầu tiên --%>
                                                                                <c:if test="${loop.index == 0}">
                                                                                    <%-- Hiển thị hình ảnh đầu tiên, ví dụ URL của hình ảnh --%>
                                                                                    <img src="${image.linkImage}"
                                                                                         alt="${orderDetail.sizeDetail.product.productName}"
                                                                                         width="50">
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </c:if>
                                                                    </td>
                                                                    <td data-price="${orderDetail.price}"
                                                                        class="format-vnd"></td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </form>
                                                </div>

                                                <div class="modal-footer">
                                                    <c:choose>
                                                        <c:when test="${status == 'pending'}">
                                                            <button onclick="confirmApproveOrder(${order.orderId})"
                                                                    class="btn btn-success" title="Duyệt phiếu đặt">
                                                                Duyệt Phiếu đặt
                                                                <i class="fas fa-check-circle"></i>
                                                            </button>
                                                            <button onclick="confirmCancelOrder(${order.orderId})"
                                                                    class="btn btn-danger" title="Hủy phiếu đặt">
                                                                Hủy Phiếu đặt
                                                                <i class="fas fa-times-circle"></i>
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${status == 'approved'}">
                                                            <button onclick="confirmDeliverOrder(${order.orderId})"
                                                                    class="btn btn-success" title="Giao thành công">
                                                                Giao thành công
                                                                <i class="fas fa-truck"></i>
                                                            </button>
                                                        </c:when>
                                                    </c:choose>
                                                    <button type="button" class="btn btn-secondary"
                                                            data-dismiss="modal">Đóng <i class="fas fa-times"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Modal Chi tiết Đơn đặt hàng -->

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

<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/vendor/unifyMenu/unifyMenu.js"></script>
<script src="/resources/vendor/onoffcanvas/onoffcanvas.js"></script>
<script src="/resources/js/moment.js"></script>
<script src="/resources/vendor/datatables/dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap.min.js"></script>
<script src="/resources/vendor/datatables/custom/custom-datatables.js"></script>
<script src="/resources/vendor/datatables/custom/fixedHeader.js"></script>
<script src="/resources/js/common.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
    $(document).ready(function () {
        $('#status').on('change', function () {
            const selectedStatus = $(this).val();
            window.location.href = '/admin/order/' + selectedStatus;
        });
    });
</script>

<script>

    // Hàm định dạng giá tiền
    function formatVND(amount) {
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });
        return formatter.format(amount);
    }

    function approveOrder(orderId) {

        // Định dạng giá cho tất cả các phần tử có class 'format-vnd'
        $(".format-vnd").each(function () {
            const price = $(this).data('price');
            $(this).text(formatVND(price));
        });

        // Gửi yêu cầu duyệt đơn hàng đến máy chủ
        $.ajax({
            url: "/admin/order/approve/" + orderId,
            type: "POST",
            success: function (response) {
                // Xóa đơn hàng khỏi bảng
                $("#basicExample tbody tr[data-order-id='" + orderId + "']").remove();
                // Hiển thị thông báo thành công

                Swal.fire({
                    icon: 'success',
                    title: 'Đã duyệt đơn hàng',
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });

            },
            error: function (xhr, textStatus, errorThrown) {
                console.log("Error: " + errorThrown);
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi khi duyệt đơn hàng',
                    text: xhr.message
                });
            }
        });
    }

    function cancelOrder(orderId, reason) {
        // Gửi yêu cầu hủy đơn hàng đến máy chủ
        $.ajax({
            url: "/admin/order/cancel/" + orderId,
            data: {
                reason: reason
            },
            type: "POST",
            success: function (response) {
                // Xóa đơn hàng khỏi bảng
                $("#basicExample tbody tr[data-order-id='" + orderId + "']").remove();
                closeModalOrderDetail(orderId);
                // Hiển thị thông báo thành công
                Swal.fire({
                    icon: 'success',
                    title: 'Đã hủy đơn hàng',
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
                ;
            },
            error: function (xhr, textStatus, errorThrown) {
                console.log("Error: " + errorThrown);
                // Hiển thị thông báo lỗi
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi khi hủy đơn hàng',
                    text: xhr.responseText
                });
            }
        });
    }

    function deliverOrder(orderId) {
        // Gửi yêu cầu giao hàng thành công đến máy chủ
        $.ajax({
            url: "/admin/order/deliver/" + orderId,
            type: "POST",
            success: function (response) {
                // Xóa đơn hàng khỏi bảng
                $("#basicExample tbody tr[data-order-id='" + orderId + "']").remove();
                closeModalOrderDetail(orderId);
                // Hiển thị thông báo thành công
                Swal.fire({
                    icon: 'success',
                    title: 'Xác nhận giao hàng thành công',
                    confirmButtonText: 'OK'
                }).then((result) => {
                }).then((result) => {
                    if (result.isConfirmed) {
                        location.reload();
                    }
                });
            },
            error: function (xhr, textStatus, errorThrown) {
                console.log("Error: " + errorThrown);
                // Hiển thị thông báo lỗi
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi khi xác nhận giao hàng thành công',
                    text: xhr.responseText
                });
            }
        });
    }

    function confirmApproveOrder(orderId) {
        Swal.fire({
            title: 'Xác nhận duyệt đơn hàng?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Duyệt',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu người dùng đồng ý, thực hiện duyệt đơn hàng
                approveOrder(orderId);
            }
        });
    }

    function confirmCancelOrder(orderId) {
        Swal.fire({
            title: 'Xác nhận hủy đơn hàng?',
            text: 'Vui lòng nhập lý do hủy:',
            icon: 'question',
            input: 'textarea',
            inputPlaceholder: 'Nhập lý do hủy...',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xác nhận',
            cancelButtonText: 'Không',
            preConfirm: (reason) => {
                if (!reason) {
                    Swal.showValidationMessage('Lý do hủy không được để trống');
                } else {
                    return reason;
                }
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu người dùng đồng ý và đã nhập lý do, thực hiện hủy đơn hàng
                const reason = result.value;
                cancelOrder(orderId, reason);
            }
        });
    }


    function confirmDeliverOrder(orderId) {
        Swal.fire({
            title: 'Xác nhận giao hàng thành công?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xác nhận',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu người dùng đồng ý, thực hiện giao hàng thành công
                deliverOrder(orderId);
            }
        });
    }

    function closeModalOrderDetail(orderId) {
        $('#detailOrderModal-' + orderId).modal('hide');
    }

    function showModalOrderDetail(orderId) {
        $('#detailOrderModal-' + orderId).modal('show');
    }

    $(document).ready(function () {
        // Định dạng giá cho tất cả các phần tử có class 'format-vnd'
        $(".format-vnd").each(function () {
            const price = $(this).data('price');
            $(this).text(formatVND(price));
        });
    })
</script>

</body>
</html>
