<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Sản phẩm</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
</head>
<style>
    .image-product img {
        width: 60px;
        height: 60px;
        object-fit: cover;
    }
</style>
<body>

<div class="main-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="display-3 card-header d-flex justify-content-between align-items-center">
                    <span><h3>Danh sách Sản phẩm</h3></span>
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addProductModal">
                        Thêm mới <i class="fas fa-plus"></i>
                    </button>
                </div>
                <div class="card-body">
                    <table id="basicExample" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>Stt</th>
                            <th>Id</th>
                            <th>Tên Sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Hình ảnh</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Sử dụng forEach để lặp qua danh sách productList -->
                        <c:forEach items="${productList}" var="product" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${product.productId}</td>
                                <td>${product.productName}</td>
                                <td>${product.category.categoryName}</td>
                                <td class="image-product">
                                        <%-- Kiểm tra xem Set images có dữ liệu không --%>
                                    <c:if test="${not empty product.images}">
                                        <%-- Lặp qua các phần tử trong Set images --%>
                                        <c:forEach var="image" items="${product.images}" varStatus="loop">
                                            <%-- Chỉ lấy phần tử đầu tiên --%>
                                            <c:if test="${loop.index == 0}">
                                                <%-- Hiển thị hình ảnh đầu tiên, ví dụ URL của hình ảnh --%>
                                                <img src="${image.linkImage}" alt="${product.productName}" width="100">
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.status == 0}">
                                            Tạm ngừng bán
                                        </c:when>
                                        <c:otherwise>
                                            Đang bán
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-info btn-detail-product" data-toggle="modal"
                                            data-target="#detailProductModal-${product.productId}">
                                        Chi tiết <i class="fas fa-info-circle"></i>
                                    </button>
                                    <button type="button" class="btn btn-info btn-edit-product" data-toggle="modal"
                                            data-target="#editProductModal-${product.productId}">
                                        Sửa <i class="fas fa-pencil-alt"></i>
                                    </button>

                                    <!-- Modal Chi tiết SP -->
                                    <div class="modal fade" id="detailProductModal-${product.productId}" tabindex="-1"
                                         role="dialog" aria-labelledby="detailProductModalLabel-${product.productId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-info text-white">
                                                    <h5 class="modal-title"
                                                        id="detailProductModalLabel-${product.productId}">Chi tiết Sản
                                                        phẩm</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body"
                                                     id="detailProductModalBody-${product.productId}">
                                                    <!-- Nội dung chi tiết sản phẩm sẽ được thêm vào đây -->
                                                    <div class="form-group">
                                                        <label for="productName">Tên Sản phẩm :</label>
                                                        <input type="text" id="productName"
                                                               value="${product.productName}" class="form-control"
                                                               disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="category">Danh mục :</label>
                                                        <input type="text" id="category"
                                                               value="${product.category.categoryName}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="material">Chất liệu :</label>
                                                        <input type="text" id="material"
                                                               value="${product.material.materialName}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="gender">Dành cho giới tính:</label>
                                                        <input type="text" id="gender"
                                                               value="${product.gender == '0' ? 'Nữ' : (product.gender == '1' ? 'Nam' : 'Unisex')}"
                                                               class="form-control" disabled>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="brand">Thương hiệu :</label>
                                                        <input type="text" id="brand" value="${product.brand.brandName}"
                                                               class="form-control" disabled>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="description">Mô tả :</label>
                                                        <textarea id="description" class="form-control" rows="3"
                                                                  disabled>${product.description}</textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="image">Hình ảnh :</label>
                                                            <%-- Kiểm tra xem Set images có dữ liệu không --%>
                                                        <c:if test="${not empty product.images}">
                                                            <%-- Lặp qua các phần tử trong Set images --%>
                                                            <c:forEach var="image" items="${product.images}"
                                                                       varStatus="loop">
                                                                <%-- Chỉ lấy phần tử đầu tiên --%>
                                                                <img src="${image.linkImage}" id="image"
                                                                     alt="${product.productName}" width="50"
                                                                     height="50">

                                                            </c:forEach>
                                                        </c:if>
                                                    </div>


                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                            data-dismiss="modal">Đóng <i class="fas fa-times"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- End Modal Chi tiết SP -->

                                    <!-- Modal Sửa SP -->
                                    <div class="modal fade" id="editProductModal-${product.productId}" tabindex="-1"
                                         role="dialog" aria-labelledby="editProductModalLabel-${product.productId}"
                                         aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header bg-primary text-white">
                                                    <h5 class="modal-title"
                                                        id="editProductModalLabel-${product.productId}">Sửa Sản
                                                        phẩm</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form:form modelAttribute="productEdit"
                                                               id="editProductForm-${product.productId}"
                                                               enctype="multipart/form-data">
                                                        <form:input type="hidden" path="productId"
                                                                    value="${product.productId}" required="true"/>
                                                        <div class="form-group">
                                                            <label for="productName">Tên Sản phẩm </label>
                                                            <form:input type="text" class="form-control"
                                                                        id="productName" path="productName"
                                                                        value="${product.productName}" required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="category.categoryId">Danh mục</label>
                                                            <form:select path="category.categoryId" class="form-control"
                                                                         id="category">
                                                                <c:forEach var="category" items="${categoryList}">
                                                                    <option value="${category.categoryId}"
                                                                            <c:if test="${category.categoryId == product.category.categoryId}">selected</c:if>>${category.categoryName}</option>
                                                                </c:forEach>
                                                            </form:select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="material.materialId">Chất liệu</label>
                                                            <form:select path="material.materialId" class="form-control"
                                                                         id="material">
                                                                <c:forEach var="material" items="${materialList}">
                                                                    <option value="${material.materialId}"
                                                                            <c:if test="${material.materialId == product.material.materialId}">selected</c:if>>${material.materialName}</option>
                                                                </c:forEach>
                                                            </form:select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="brand.brandId">Thương hiệu</label>
                                                            <form:select path="brand.brandId" class="form-control"
                                                                         id="brand">
                                                                <c:forEach var="brand" items="${brandList}">
                                                                    <option value="${brand.brandId}"
                                                                            <c:if test="${brand.brandId == product.brand.brandId}">selected</c:if>>${brand.brandName}</option>
                                                                </c:forEach>
                                                            </form:select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="gender">Dành cho giới tính</label>
                                                            <form:select path="gender" class="form-control">
                                                            <option value="0" label="Nữ"
                                                                    <c:if test="${0 == product.gender}">selected</c:if>>
                                                                />
                                                            <option value="1" label="Nam"
                                                                    <c:if test="${1 == product.gender}">selected</c:if>>
                                                                />
                                                            <option value="2" label="Unisex"
                                                                    <c:if test="${2 == product.gender}">selected</c:if>>
                                                                />
                                                                </form:select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="description">Mô tả</label>
                                                            <form:input rows="3" class="form-control" id="description"
                                                                        path="description"
                                                                        value="${product.description}" required="true"/>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="gender">Trạng thái</label>
                                                            <form:select path="status" class="form-control">
                                                            <option value="0" label="Tạm ngừng bán"
                                                                    <c:if test="${0 == product.status}">selected</c:if>>
                                                                />
                                                            <option value="1" label="Đang bán"
                                                                    <c:if test="${1 == product.status}">selected</c:if>>
                                                                />

                                                                </form:select>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="imageProduct">Hình ảnh</label>
                                                            <input type="file" class="form-control" id="imageProduct"
                                                                   name="imageProduct"
                                                                   accept="image/jpeg, image/png"/>
                                                        </div>
                                                        <button type="submit" class="btn btn-success float-right ml-3">
                                                            Lưu chỉnh sửa <i class="fas fa-save"></i></button>
                                                        <button type="button" class="btn btn-secondary float-right "
                                                                data-dismiss="modal">Đóng <i class="fas fa-times"></i>
                                                        </button>
                                                    </form:form>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                        <%--End Modal Sửa SP--%>

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

<!-- Modal Thêm Sản phẩm mới -->
<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="addProductModalLabel">Thêm Sản phẩm mới</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="productNew" action="/admin/product" method="post" id="addProductForm">
                    <div class="form-group">
                        <label for="productName">Tên Sản phẩm mới</label>
                        <form:input type="text" class="form-control" id="productName" path="productName"
                                    required="true"/>
                    </div>
                    <div class="form-group">
                        <label for="category.categoryId">Danh mục</label>
                        <form:select path="category.categoryId" class="form-control" id="category"
                                     defaultValue="${categoryList[0].categoryId}">
                            <form:options items="${categoryList}" itemValue="categoryId" itemLabel="categoryName"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label for="material.materialId">Chất liệu</label>
                        <form:select path="material.materialId" class="form-control" id="material"
                                     defaultValue="${materialList[0].materialId}">
                            <form:options items="${materialList}" itemValue="materialId" itemLabel="materialName"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label for="brand.brandId">Thương hiệu</label>
                        <form:select path="brand.brandId" class="form-control" id="brand"
                                     defaultValue="${brandList[0].brandId}">
                            <form:options items="${brandList}" itemValue="brandId" itemLabel="brandName"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label for="gender">Dành cho giới tính</label>
                        <form:select path="gender" class="form-control" defaultValue="0">
                            <form:option value="0" label="Nữ"/>
                            <form:option value="1" label="Nam"/>
                            <form:option value="2" label="Unisex"/>
                        </form:select>
                    </div>

                    <div class="form-group">
                        <label for="files">Hình ảnh</label>
                        <input type="file" class="form-control" id="files" name="files" multiple
                               accept="image/jpeg, image/png"/>
                    </div>

                    <div class="form-group">
                        <label for="description">Mô tả</label>
                        <form:textarea rows="3" type="text" class="form-control" id="description" path="description"
                                       required="true"/>
                    </div>

                    <button type="submit" class="btn btn-success float-right ml-3">Lưu Sản phẩm <i
                            class="fas fa-save"></i></button>
                    <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Đóng <i
                            class="fas fa-times"></i></button>
                </form:form>
            </div>
        </div>
    </div>
</div>
<%--End Modal thêm mới sp--%>

<!-- jQuery first, then Tether, then other JS. -->
<script src="/resources/js/jquery.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/vendor/unifyMenu/unifyMenu.js"></script>
<script src="/resources/vendor/onoffcanvas/onoffcanvas.js"></script>
<script src="/resources/js/moment.js"></script>

<!-- Data Tables -->
<script src="/resources/vendor/datatables/dataTables.min.js"></script>
<script src="/resources/vendor/datatables/dataTables.bootstrap.min.js"></script>

<!-- Custom Data tables -->
<script src="/resources/vendor/datatables/custom/custom-datatables.js"></script>
<script src="/resources/vendor/datatables/custom/fixedHeader.js"></script>

<!-- Common JS -->
<script src="/resources/js/common.js"></script>

<!-- SweetAlert library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<script>
    $(document).ready(function () {

        $('#addProductForm').submit(function (event) {
            event.preventDefault(); // Ngăn chặn submit mặc định của form

            // Tạo FormData object
            const formData = new FormData(this);

            // Gửi AJAX request
            $.ajax({
                type: "POST",
                url: "/admin/product",
                data: formData,
                processData: false, // Không xử lý dữ liệu, vì chúng ta đang gửi FormData object
                contentType: false, // Không đặt contentType, jQuery sẽ tự động đặt
                success: function (response) {
                    // Xử lý khi nhận được phản hồi từ server
                    Swal.fire({
                        icon: 'success',
                        title: 'Thông báo',
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
                        title: 'Lỗi',
                        text: xhr.responseText,
                        confirmButtonText: 'OK'
                    });
                }
            });
        });


        // Gắn sự kiện submit cho các form động
        $(document).on('submit', '[id^="editProductForm-"]', function (event) {
            event.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                type: "PUT",
                url: "/admin/product",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    Swal.fire({
                        title: 'Thành công!',
                        text: response,
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload();
                        }
                    });
                },
                error: function (xhr) {
                    Swal.fire({
                        title: 'Lỗi!',
                        text: xhr.responseText,
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            });
        });
    })
</script>

</body>
</html>
