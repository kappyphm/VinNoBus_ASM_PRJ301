<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update User</title>
    </head>
    <body>
        <h2>Update User Information</h2>

        <form action="${ctx}/user/${action}" method="POST">
            <table>
                <tbody>
                    <tr>
                        <td>User ID:</td>
                        <td>
                            <input type="text" name="userId"
                                   value="${not empty userDetail.userId ? userDetail.userId : googleUser.sub}"
                                   readonly>
                        </td>
                    </tr>

                    <tr>
                        <td>Status:</td>
                        <td>
                            <input type="checkbox" name="active"
                                   <c:if test="${userDetail.active}">checked</c:if>
                                   value="${userDetail.active}"
                                   <c:if test="${empty sessionScope.staff}"> disabled </c:if>
                                       </td>
                        </tr>

                        <tr>
                            <td>Full name:</td>
                            <td>
                                <input type="text" name="name" required
                                       value="${not empty userDetail.name ? userDetail.name : googleUser.name}">
                        </td>
                    </tr>

                    <tr>
                        <td>Email:</td>
                        <td>
                            <input type="email" name="email"
                                   value="${not empty userDetail.email ? userDetail.email : googleUser.email}"
                                   readonly>
                        </td>
                    </tr>

                    <tr>
                        <td>Phone:</td>
                        <td>
                            <input type="tel" name="phone"
                                   value="${userDetail.phone}"
                                   required>
                        </td>
                    </tr>

                    <tr>
                        <td>Avatar:</td>
                        <td>
                            <img src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : googleUser.picture}"
                                 alt="Avatar" width="100" height="100"><br>
                            <input type="hidden" name="avatarUrl"
                                   value="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : googleUser.picture}">
                        </td>
                    </tr>

                    <tr>
                        <td>Date of birth:</td>
                        <td>

                            <input type="date" name="dob"
                                   value="<fmt:formatDate value='${userDetail.dob}' pattern='yyyy-MM-dd'/>"

                                   required>
                        </td>
                    </tr>

                    <tr>
                        <td>Address:</td>
                        <td>
                            <input type="text" name="address"
                                   value="${not empty userDetail.address ? userDetail.address : googleUser.local}"
                                   required>
                        </td>
                    </tr>
                </tbody>
            </table>

            <input type="submit" value="Save">
        </form>
    </body>
</html>
