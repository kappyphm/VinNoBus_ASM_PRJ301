<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Thông tin người dùng</jsp:attribute>

    <jsp:body>
        <main class="max-w-5xl mx-auto px-5 py-8">

            <jsp:include page="/view/user/component/DetailHeader.jsp" />

            <jsp:include page="/view/user/manage/profile-detail.jsp" />

            <jsp:include page="/view/user/manage/staff-detail.jsp" />

            <jsp:include page="/view/user/manage/customer-detail.jsp" />

        </main>
    </jsp:body>
</ui:layout>
