<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Complete Your Profile</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-50 flex items-center justify-center min-h-screen">

        <div class="w-full max-w-lg bg-white shadow-xl rounded-2xl p-8">
            <h2 class="text-2xl font-semibold text-center mb-6 text-gray-800">Complete Your Profile</h2>

            <!-- Hiển thị thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-4 text-center">
                    ${errorMessage}
                </div>
            </c:if>

            <form action="/auth/register" method="post" class="space-y-5">
                <!-- Profile Picture -->
                <div>
                    <c:if test="${not empty sessionScope.googleProfile.picture}">
                        <div class="mb-3">
                            <img src="${sessionScope.googleProfile.picture}" alt="Profile Picture" class="w-24 h-24 rounded-full mx-auto">
                        </div>
                    </c:if>
                    <input type="hidden" name="pictureUrl" value="${sessionScope.googleProfile.picture}">
                </div>

                <!-- user sub -->
                <div>
                    <input type="hidden" name="googleSub" value="${sessionScope.googleProfile.userId}">
                </div>

                <!-- Full Name -->
                <div>
                    <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="${param.fullName != null? param.fullName : sessionScope.googleProfile.name}"
                           class="w-full border border-gray-300 rounded-lg p-2.5 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                </div>

                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                    <input type="email" id="email" name="email"
                           value="${param.email != null ? param.email : sessionScope.googleProfile.email}"
                           readonly
                           class="w-full bg-gray-100 border border-gray-300 rounded-lg p-2.5 text-gray-600 cursor-not-allowed">
                </div>

                <!-- Phone -->
                <div>
                    <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="0123456789"
                           value="${param.phone}"
                           class="w-full border border-gray-300 rounded-lg p-2.5 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                </div>

                <!-- Address -->
                <div>
                    <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                    <textarea id="address" name="address" rows="2"
                              class="w-full border border-gray-300 rounded-lg p-2.5 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">${param.address}</textarea>
                </div>

                <!-- Date of Birth -->
                <div>
                    <label for="dob" class="block text-sm font-medium text-gray-700 mb-1">Date of Birth</label>
                    <input type="date" id="dob" name="dateOfBirth"
                           class="w-full border border-gray-300 rounded-lg p-2.5 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500" required>
                </div>



                <!-- Submit Button -->
                <div class="pt-3">
                    <button type="submit"
                            class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2.5 rounded-lg transition duration-200">
                        Save Profile
                    </button>
                </div>

            </form>
        </div>

    </body>
</html>

