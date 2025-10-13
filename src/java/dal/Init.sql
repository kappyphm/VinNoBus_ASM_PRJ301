-- ==============================================
-- Tạo Database ASM_PRJ
-- ==============================================
CREATE DATABASE VinNoBus;
GO

USE VinNoBus;
GO

-- ==============================================
-- Bảng Người dùng (User)
-- Lưu thông tin chung cho tất cả loại người dùng trong hệ thống
-- role: phân quyền (ADMIN, MANAGER, DRIVER, CONDUCTOR, CUSTOMER)
-- status: trạng thái tài khoản (ACTIVE/INACTIVE)
-- ==============================================
CREATE TABLE [User] (
    user_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name NVARCHAR(200),
    role VARCHAR(20) CHECK (role IN ('ADMIN','MANAGER','DRIVER','CONDUCTOR','CUSTOMER')),
    status VARCHAR(10) CHECK (status IN ('ACTIVE','INACTIVE'))
);

-- ==============================================
-- Bảng Khách hàng (Customer)
-- Lưu thông tin chi tiết của khách hàng, mở rộng từ User
-- Liên kết 1-1 với bảng User qua user_id
-- ==============================================

CREATE TABLE [Customer](
	user_id UNIQUEIDENTIFIER PRIMARY KEY REFERENCES [User](user_id),
	address NVARCHAR(255) NOT NULL,
	phone VARCHAR(15) NOT NULL UNIQUE,
	email VARCHAR(254) NOT NULL UNIQUE,
	avatar_url VARCHAR(500)
);

-- ==============================================
-- Bảng Xe buýt (Bus)
-- Mỗi xe có biển số (unique), sức chứa, trạng thái hiện tại
-- current_status lấy theo enum định nghĩa
-- ==============================================
CREATE TABLE Bus (
    bus_id INT IDENTITY(1,1) PRIMARY KEY,
    plate_number VARCHAR(50) NOT NULL UNIQUE,
    capacity INT NOT NULL CHECK (capacity > 0),
    current_status VARCHAR(20) CHECK (current_status IN ('AVAILABLE','IN_USE','MAINTENANCE','BROKEN','REPAIRING','RESERVED'))
);

-- ==============================================
-- Bảng Lịch sử xe buýt (BusLog)
-- Lưu lại trạng thái thay đổi của xe theo thời gian
-- created_by: người dùng thao tác thay đổi
-- ==============================================
CREATE TABLE BusLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    bus_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('AVAILABLE','IN_USE','MAINTENANCE','BROKEN','REPAIRING','RESERVED')),
    note VARCHAR(255),
    created_by UNIQUEIDENTIFIER NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_BusLog_Bus FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    CONSTRAINT FK_BusLog_User FOREIGN KEY (created_by) REFERENCES [User](user_id)
);

-- ==============================================
-- Bảng Trạm xe buýt (Station)
-- Danh sách các trạm trong hệ thống
-- ==============================================
CREATE TABLE Station (
    station_id INT IDENTITY(1,1) PRIMARY KEY,
    station_name VARCHAR(150) NOT NULL,
    location VARCHAR(255) -- TODO: có thể thay bằng tọa độ GPS
);

-- ==============================================
-- Bảng Tuyến xe (Route)
-- Mỗi tuyến xe có tên, loại tuyến (ROUND_TRIP/CIRCULAR), tần suất
-- Không lưu start_point và end_point để tránh trùng với Route_Station
-- ==============================================
CREATE TABLE Route (
    route_id INT IDENTITY(1,1) PRIMARY KEY,
    route_name VARCHAR(150) NOT NULL,
	type VARCHAR(10) CHECK (type in ('ROUND_TRIP', 'CIRCULAR')),
    frequency INT CHECK (frequency >= 0)
);

-- ==============================================
-- Bảng Quan hệ Route ↔ Station
-- Xác định tuyến xe đi qua những trạm nào và thứ tự
-- station_order: thứ tự trạm trên tuyến
-- ==============================================
CREATE TABLE Route_Station (
    route_id INT NOT NULL,
    station_id INT NOT NULL,
    station_order INT CHECK (station_order >= 1),
    PRIMARY KEY (route_id, station_id),
    CONSTRAINT FK_RS_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_RS_Station FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

-- ==============================================
-- Bảng Chuyến xe (Trip)
-- Mỗi chuyến gắn với 1 tuyến, 1 xe buýt, 1 tài xế và 1 phụ xe
-- departure_time, arrival_time: giờ khởi hành và kết thúc
-- status: trạng thái chuyến (NOT_STARTED, IN_PROCESS, FINISHED, CANCELLED)
-- ==============================================
CREATE TABLE Trip (
    trip_id INT IDENTITY(1,1) PRIMARY KEY,
    route_id INT NOT NULL,
    bus_id INT NOT NULL,
    driver_id UNIQUEIDENTIFIER NOT NULL,
    conductor_id UNIQUEIDENTIFIER NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'NOT_STARTED' CHECK (status IN ('NOT_STARTED','IN_PROCESS','FINISHED','CANCELLED')),

    CONSTRAINT FK_Trip_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_Trip_Bus FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    CONSTRAINT FK_Trip_Driver FOREIGN KEY (driver_id) REFERENCES [User](user_id),
    CONSTRAINT FK_Trip_Conductor FOREIGN KEY (conductor_id) REFERENCES [User](user_id)
);

-- ==============================================
-- Bảng Nhật ký công việc (WorkLog)
-- Lưu lại check-in/check-out của nhân viên trong chuyến
-- Chỉ áp dụng cho role DRIVER và CONDUCTOR
-- Ràng buộc: mỗi chuyến chỉ có 1 driver + 1 conductor
-- ==============================================


CREATE TABLE WorkLog (
    worklog_id INT IDENTITY(1,1) PRIMARY KEY,
    trip_id INT NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    role VARCHAR(20) NOT NULL,
    checkin_time DATETIME NULL,
    checkout_time DATETIME NULL,
    notes NVARCHAR(255) NULL,

    CONSTRAINT FK_WorkLog_Trip FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
    CONSTRAINT FK_WorkLog_User FOREIGN KEY (user_id) REFERENCES [User](user_id),
    CONSTRAINT CK_WorkLog_Role CHECK (role IN ('DRIVER','CONDUCTOR')),
    CONSTRAINT UQ_WorkLog_TripRole UNIQUE (trip_id, role)
);

-- ==============================================
-- Bảng Hóa đơn (Invoice)
-- Lưu thông tin thanh toán
-- Một invoice có thể gắn với nhiều ticket (1-n)
-- ==============================================
CREATE TABLE Invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH','ONLINE')),
    payment_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(10) CHECK (status IN ('PAID','PENDING'))
);

-- ==============================================
-- Bảng Vé (Ticket)
-- Vé có thể gắn với trip (vé lượt) hoặc route (vé ngày/tháng)
-- expiry_date bắt buộc với vé ngày/tháng, NULL với vé lượt
-- invoice_id: liên kết hóa đơn thanh toán
-- ==============================================
CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id UNIQUEIDENTIFIER NULL,
    trip_id INT NULL,
    route_id INT NULL,
    price DECIMAL(10,2) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NULL,
    created_by UNIQUEIDENTIFIER NOT NULL,
    invoice_id INT NULL,

    CONSTRAINT FK_Ticket_Customer FOREIGN KEY (customer_id) REFERENCES [User](user_id),
    CONSTRAINT FK_Ticket_Trip FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
    CONSTRAINT FK_Ticket_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_Ticket_CreatedBy FOREIGN KEY (created_by) REFERENCES [User](user_id),
    CONSTRAINT FK_Ticket_Invoice FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),

    -- Logic: Vé lượt thì có trip_id, vé ngày/tháng thì có route_id
    CONSTRAINT CK_Ticket_Validity CHECK (
        (trip_id IS NOT NULL AND route_id IS NULL AND expiry_date IS NULL)
        OR
        (trip_id IS NULL AND route_id IS NOT NULL AND expiry_date IS NOT NULL)
    )
);
