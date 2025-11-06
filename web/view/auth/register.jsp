<%-- 
    Document   : register
    Created on : Nov 4, 2025, 9:41:21 PM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <form action="/auth/register" method="POST">
                <table border="0">

                    <tbody>
                        <tr>
                            <td>User ID:</td>
                            <td>
                                <input type="text" name="userId" value="${googleUser.sub}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td>None</td>
                        </tr>
                        <tr>
                            <td>Full name:</td>
                            <td>
                                <input required type="text" name="name" value="${googleUser.name!=null||googleUser.name!=""?googleUser.name:""}">
                            </td>
                        </tr>
                        <tr>
                            <td>Email: </td>
                            <td><input type="email" name="email" value="${googleUser.email}" readonly></td>
                        </tr>
                        <tr>
                            <td>Phone: </td>
                            <td><input type="tel" name="phone" required></td>
                        </tr>
                        <tr>
                            <td>Avatar: </td>
                            <td>
                                <img src="${googleUser.picture}" alt="alt"/>
                                <input type="text" name="avatarUrl" hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>Date of birth:</td>
                            <td>
                                <input type="date" pattern="" name="dob" required>
                            </td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td><input type="text" name="address" required></td>
                        </tr>
                    </tbody>
                </table>
                <input type="submit" value="Save">
            </form>
        </div>
    </body>
</html>
