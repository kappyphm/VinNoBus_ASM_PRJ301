<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Về VinNoBus</title>

        <!-- Roboto Mono -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'}},
                        boxShadow: {soft: '0 8px 24px rgba(2, 6, 23, 0.06)'}
                    }
                }
            }
        </script>
        <style> html {
                font-family: 'Roboto Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
            } </style>
    </head>
    <body class="bg-white text-slate-800">
        <header class="border-b border-slate-200">
            <div class="max-w-6xl mx-auto px-5 py-4 flex items-center justify-between">
                <a href="/VinNoBus" class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                    <span class="font-semibold">VinNoBus</span>
                </a>
                <nav class="hidden sm:flex items-center gap-6 text-sm text-slate-600">
                    <a href="#cau-chuyen" class="hover:text-brand-700">Câu chuyện</a>
                    <a href="#gia-tri" class="hover:text-brand-700">Giá trị</a>
                    <a href="#hanh-trinh" class="hover:text-brand-700">Hành trình</a>
                    <a href="#lien-he" class="hover:text-brand-700">Liên hệ</a>
                </nav>
                <jsp:include page="/WEB-INF/components/LoginButton.jsp" />
            </div>

        </header>

        <section class="bg-brand-50">
            <div class="max-w-6xl mx-auto px-5 py-16 lg:py-24">
                <div class="max-w-3xl">
                    <h1 class="text-3xl md:text-5xl font-semibold leading-tight">Chúng tôi chở những mùa đi, để mọi hành trình trở nên nhẹ nhàng.</h1>
                    <p class="mt-5 text-slate-600">VinNoBus là hãng xe được sinh ra từ một câu hỏi giản dị: làm sao để mỗi chuyến đi đều đúng giờ, êm ái, và tử tế? Chúng tôi chọn bắt đầu từ những điều nhỏ — một chỗ ngồi sạch, một cú phanh mượt, một lời chào ấm áp — vì đó là cách những điều lớn lao được gây dựng.</p>
                    <div class="mt-8 flex items-center gap-3">
                        <a href="/VinNoBus/search" class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm shadow-soft hover:bg-brand-700">Tìm tuyến</a>
                        <a href="#cau-chuyen" class="px-4 py-2 rounded-xl border border-brand-200 text-brand-700 text-sm hover:bg-brand-100">Tìm hiểu thêm</a>
                    </div>
                </div>
            </div>
        </section>

        <section id="cau-chuyen" class="max-w-6xl mx-auto px-5 py-14">
            <div class="grid md:grid-cols-2 gap-10 items-start">
                <div>
                    <h2 class="text-2xl font-semibold">Câu chuyện khởi hành</h2>
                    <p class="mt-4 text-slate-600">Những ngày đầu, đội ngũ chỉ có vài người và một bến đỗ nhỏ. Nhưng chúng tôi có thứ quý giá nhất: niềm tin rằng công nghệ và sự chỉn chu có thể thay đổi trải nghiệm di chuyển ở Việt Nam. Từ hệ thống đặt vé minh bạch, thuật toán tối ưu lịch trình, đến các tiêu chuẩn bảo dưỡng khắt khe — mọi thứ được thiết kế để phục vụ con người.</p>
                </div>
                <div class="rounded-2xl border border-slate-200 p-6 bg-white shadow-soft">
                    <ul class="text-sm space-y-3">
                        <li class="flex items-start gap-3"><span class="w-2 h-2 rounded-full bg-brand-600 mt-2"></span>Đặt đúng người, đúng chỗ, đúng giờ.</li>
                        <li class="flex items-start gap-3"><span class="w-2 h-2 rounded-full bg-brand-600 mt-2"></span>Minh bạch giá vé, hoàn tiền nhanh chóng khi có thay đổi.</li>
                        <li class="flex items-start gap-3"><span class="w-2 h-2 rounded-full bg-brand-600 mt-2"></span>Đội ngũ tài xế được đào tạo định kỳ về an toàn và dịch vụ.</li>
                    </ul>
                </div>
            </div>
        </section>

        <section id="gia-tri" class="bg-slate-50">
            <div class="max-w-6xl mx-auto px-5 py-14">
                <h2 class="text-2xl font-semibold">Giá trị cốt lõi</h2>
                <div class="mt-6 grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
                    <article class="rounded-2xl border border-slate-200 bg-white p-5">
                        <h3 class="font-semibold">Tử tế</h3>
                        <p class="mt-2 text-sm text-slate-600">Mỗi quyết định đều bắt đầu bằng việc tôn trọng khách hàng và đồng nghiệp.</p>
                    </article>
                    <article class="rounded-2xl border border-slate-200 bg-white p-5">
                        <h3 class="font-semibold">Chuẩn xác</h3>
                        <p class="mt-2 text-sm text-slate-600">Chúng tôi quan niệm "đúng giờ" không phải khẩu hiệu, mà là cam kết.</p>
                    </article>
                    <article class="rounded-2xl border border-slate-200 bg-white p-5">
                        <h3 class="font-semibold">Đổi mới</h3>
                        <p class="mt-2 text-sm text-slate-600">Ứng dụng dữ liệu để tối ưu tuyến, bến, tải trọng — giảm lãng phí, tăng trải nghiệm.</p>
                    </article>
                </div>
            </div>
        </section>

        <section id="hanh-trinh" class="max-w-6xl mx-auto px-5 py-14">
            <h2 class="text-2xl font-semibold">Hành trình phát triển</h2>
            <div class="mt-6 space-y-6">
                <div class="flex gap-4 items-start">
                    <div class="w-2 h-2 mt-2 rounded-full bg-brand-600"></div>
                    <div><div class="font-medium">2022 — Khởi động</div><p class="text-sm text-slate-600">Ra mắt những tuyến đầu tiên ở miền Nam, hệ thống đặt vé trực tuyến phiên bản 1.0.</p></div>
                </div>
                <div class="flex gap-4 items-start">
                    <div class="w-2 h-2 mt-2 rounded-full bg-brand-600"></div>
                    <div><div class="font-medium">2023 — Mở rộng</div><p class="text-sm text-slate-600">Thêm tuyến liên tỉnh, đưa vào vận hành trung tâm điều hành thông minh.</p></div>
                </div>
                <div class="flex gap-4 items-start">
                    <div class="w-2 h-2 mt-2 rounded-full bg-brand-600"></div>
                    <div><div class="font-medium">2024 — Nâng chuẩn</div><p class="text-sm text-slate-600">Chuẩn hoá tiêu chuẩn dịch vụ, tích hợp ví điện tử, số hoá quy trình hoàn tiền.</p></div>
                </div>
            </div>
        </section>

        <section id="lien-he" class="bg-brand-50">
            <div class="max-w-6xl mx-auto px-5 py-12 flex flex-col md:flex-row gap-6 md:items-center md:justify-between">
                <div>
                    <h2 class="text-xl font-semibold">Kết nối với VinNoBus</h2>
                    <p class="mt-2 text-slate-600 text-sm">Hợp tác vận hành, truyền thông hoặc góp ý dịch vụ — chúng tôi luôn lắng nghe.</p>
                </div>
                <div class="flex flex-wrap gap-3">
                    <a href="mailto:contact@vinnobus.example" class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm shadow-soft hover:bg-brand-700">Email</a>
                    <a href="tel:+84000000000" class="px-4 py-2 rounded-xl border border-brand-200 text-brand-700 text-sm hover:bg-brand-100">Hotline</a>
                </div>
            </div>
        </section>

        <footer class="text-center py-6 text-xs text-slate-500">© <span id="y2"></span> VinNoBus. All rights reserved.</footer>
        <script>document.getElementById('y2').textContent = new Date().getFullYear()</script>
    </body>
</html>
quan