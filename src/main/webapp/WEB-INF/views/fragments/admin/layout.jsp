<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@ include file="_head.jsp" %>
<tiles:insertAttribute name="head" />
<body>

    <!-- BEGIN .app-wrap -->
    <div class="app-wrap">
        <!-- Include header -->
        <%@ include file="_header.jsp" %>

        <!-- BEGIN .app-container -->
        <div class="app-container">
            <!-- Include sidebar -->
            <%@ include file="_sidebar.jsp" %>

            <!-- BEGIN .app-main -->
            <div class="app-main">
                <!-- Include content based on the JSP page -->
                <tiles:insertAttribute name="body" />
            </div>
            <!-- END: .app-main -->
        </div>
        <!-- END: .app-container -->

        <!-- BEGIN .main-footer -->
        <%@ include file="_footer.jsp" %>
        <!-- END: .main-footer -->
    </div>
    <!-- END: .app-wrap -->
</body>

</html>
