CREATE DATABASE VinNoBusMERGE;
GO

USE VinNoBusMERGE;
GO



GO

-- ==========================================================
-- 1?? USER TABLE
-- ==========================================================
CREATE TABLE dbo.[user] (
    user_id VARCHAR(128) NOT NULL UNIQUE,
    is_active BIT NOT NULL DEFAULT 1,
    CONSTRAINT pk_user PRIMARY KEY (user_id)
);
GO



-- ==========================================================
-- 2?? PROFILE TABLE
-- ==========================================================
CREATE TABLE dbo.profile (
    user_id VARCHAR(128) NOT NULL UNIQUE,
    full_name NVARCHAR(255) NULL,
    birth_date DATE NULL,
    phone VARCHAR(20) NULL,
    email VARCHAR(255) NULL UNIQUE,
    address NVARCHAR(255) NULL,
    avatar_url VARCHAR(255) NULL,
    CONSTRAINT pk_profile PRIMARY KEY (user_id),
    CONSTRAINT fk_profile_user FOREIGN KEY (user_id)
        REFERENCES dbo.[user](user_id)
        ON DELETE CASCADE
);
GO


-- ==========================================================
-- 3?? CUSTOMER TABLE
-- ==========================================================
CREATE TABLE dbo.customer (
    user_id VARCHAR(128) NOT NULL UNIQUE,
    membership_level VARCHAR(50) NOT NULL DEFAULT 'STANDARD',
    loyalty_points INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_customer PRIMARY KEY (user_id),
    CONSTRAINT fk_customer_user FOREIGN KEY (user_id)
        REFERENCES dbo.[user](user_id)
        ON DELETE CASCADE
);
GO

-- ==========================================================
-- 4?? STAFF TABLE
-- ==========================================================
CREATE TABLE dbo.staff (

    user_id VARCHAR(128) NOT NULL UNIQUE,
    staff_code VARCHAR(50) NOT NULL UNIQUE,
    position NVARCHAR(100) NULL,
    department NVARCHAR(100) NULL,

    CONSTRAINT pk_staff PRIMARY KEY (user_id),
    CONSTRAINT fk_staff_user FOREIGN KEY (user_id)
        REFERENCES dbo.[user](user_id)
        ON DELETE CASCADE
);
GO





-- ==============================================
-- B?ng Xe buýt (Bus)
-- M?i xe có bi?n s? (unique), s?c ch?a, tr?ng thái hi?n t?i
-- current_status l?y theo enum ??nh ngh?a
-- ==============================================
CREATE TABLE Bus (
    bus_id INT IDENTITY(1,1) PRIMARY KEY,
    plate_number VARCHAR(50) NOT NULL UNIQUE,
    capacity INT NOT NULL CHECK (capacity > 0),
    current_status VARCHAR(20) CHECK (current_status IN ('AVAILABLE','IN_USE','MAINTENANCE','BROKEN','REPAIRING','RESERVED'))
);


-- ==============================================
-- B?ng Tr?m xe buýt (Station)
-- Danh sách các tr?m trong h? th?ng
-- ==============================================
CREATE TABLE Station (
    station_id INT IDENTITY(1,1) PRIMARY KEY,
    station_name NVARCHAR(150) NOT NULL,
    location NVARCHAR(255),       -- TODO: có th? thay b?ng t?a ?? GPS
);

-- ==============================================
-- B?ng Tuy?n xe (Route)
-- M?i tuy?n xe có tên, lo?i tuy?n (ROUND_TRIP/CIRCULAR), t?n su?t
-- Không l?u start_point và end_point ?? tránh trùng v?i Route_Station
-- ==============================================
CREATE TABLE Route (
    route_id INT IDENTITY(1,1) PRIMARY KEY,
    route_name NVARCHAR(150) NOT NULL unique,
	type NVARCHAR(10) CHECK (type in ('ROUND_TRIP', 'CIRCULAR')),
    frequency INT CHECK (frequency >= 0)
    
);

-- ==============================================
-- B?ng Quan h? Route ? Station
-- Xác ??nh tuy?n xe ?i qua nh?ng tr?m nào và th? t?
-- station_order: th? t? tr?m trên tuy?n
-- ==============================================
CREATE TABLE Route_Station (
    route_id INT NOT NULL,
    station_id INT NOT NULL,
    station_order INT CHECK (station_order >= 1),
    estimated_time INT DEFAULT 0, -- th?i gian ??c l??ng (phút) t? tr?m này ??n tr?m k? ti?p
    PRIMARY KEY (route_id, station_id),
    CONSTRAINT FK_RS_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_RS_Station FOREIGN KEY (station_id) REFERENCES Station(station_id)
);
-- ==============================================
-- B?ng Chuy?n xe (Trip)
-- M?i chuy?n g?n v?i 1 tuy?n, 1 xe buýt, 1 tài x? và 1 ph? xe
-- departure_time, arrival_time: gi? kh?i hành và k?t thúc
-- status: tr?ng thái chuy?n (NOT_STARTED, IN_PROCESS, FINISHED, CANCELLED)
-- ==============================================
CREATE TABLE Trip (
    trip_id INT IDENTITY(1,1) PRIMARY KEY,
    route_id INT NOT NULL,
    bus_id INT NULL,
    driver_id VARCHAR(128) NULL ,
    conductor_id VARCHAR(128) NULL ,
    departure_time DATETIME NULL,
    arrival_time DATETIME NULL,
    status VARCHAR(20) DEFAULT 'NOT_STARTED' CHECK (status IN ('NOT_STARTED','IN_PROCESS','FINISHED','CANCELLED')),

    CONSTRAINT FK_Trip_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_Trip_Bus FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    CONSTRAINT FK_Trip_Driver FOREIGN KEY (driver_id) REFERENCES [User](user_id),
    CONSTRAINT FK_Trip_Conductor FOREIGN KEY (conductor_id) REFERENCES [User](user_id)
);



-- ==============================================
-- B?ng Hóa ??n (Invoice)
-- L?u thông tin thanh toán
-- M?t invoice có th? g?n v?i nhi?u ticket (1-n)
-- ==============================================
CREATE TABLE Invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_method VARCHAR(20) CHECK (payment_method IN ('CASH','ONLINE')),
    payment_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(10) CHECK (status IN ('PAID','PENDING'))
);

-- ==============================================
-- B?ng Vé (Ticket)
-- Vé có th? g?n v?i trip (vé l??t) ho?c route (vé ngày/tháng)
-- expiry_date b?t bu?c v?i vé ngày/tháng, NULL v?i vé l??t
-- invoice_id: liên k?t hóa ??n thanh toán
-- ==============================================
CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id VARCHAR(128) NULL,
    trip_id INT NULL,
    route_id INT NULL,
    price DECIMAL(10,2) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NULL,
    invoice_id INT NULL,

    CONSTRAINT FK_Ticket_Customer FOREIGN KEY (customer_id) REFERENCES [User](user_id),
    CONSTRAINT FK_Ticket_Trip FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
    CONSTRAINT FK_Ticket_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_Ticket_Invoice FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),

    -- Logic: Vé l??t thì có trip_id, vé ngày/tháng thì có route_id
    CONSTRAINT CK_Ticket_Validity CHECK (
        (trip_id IS NOT NULL AND route_id IS NULL AND expiry_date IS NULL)
        OR
        (trip_id IS NULL AND route_id IS NOT NULL AND expiry_date IS NOT NULL)
    )
);

INSERT INTO Bus (plate_number, capacity, current_status)
VALUES
('29B-101.01', 45, 'AVAILABLE'),
('29B-101.02', 50, 'IN_USE'),
('29B-101.03', 40, 'MAINTENANCE'),
('29B-101.04', 35, 'AVAILABLE'),
('29B-101.05', 55, 'BROKEN'),
('30B-102.01', 50, 'AVAILABLE'),
('30B-102.02', 45, 'IN_USE'),
('30B-102.03', 60, 'REPAIRING'),
('30B-102.04', 50, 'AVAILABLE'),
('30B-102.05', 40, 'RESERVED'),
('29B-103.01', 45, 'AVAILABLE'),
('29B-103.02', 50, 'IN_USE'),
('29B-103.03', 35, 'AVAILABLE'),
('29B-103.04', 55, 'MAINTENANCE'),
('30B-104.01', 60, 'AVAILABLE'),
('30B-104.02', 50, 'BROKEN'),
('30B-104.03', 45, 'AVAILABLE'),
('30B-104.04', 40, 'IN_USE'),
('29B-105.01', 55, 'AVAILABLE'),
('29B-105.02', 50, 'REPAIRING');
GO

INSERT INTO Station (station_name, location)
VALUES
(N'Long Biên', N'Long Biên, Hà Nội'),
(N'Hoàn Kiếm', N'Hoàn Kiếm, Hà Nội'),
(N'Ba Đình', N'Ba Đình, Hà Nội'),
(N'Tây Hồ', N'Tây Hồ, Hà Nội'),
(N'Cầu Giấy', N'Cầu Giấy, Hà Nội'),
(N'Đống Đa', N'Đống Đa, Hà Nội'),
(N'Hai Bà Trưng', N'Hai Bà Trưng, Hà Nội'),
(N'Hoàng Mai', N'Hoàng Mai, Hà Nội'),
(N'Thanh Xuân', N'Thanh Xuân, Hà Nội'),
(N'Mỹ Đình', N'Mỹ Đình, Hà Nội'),
(N'Đông Anh', N'Đông Anh, Hà Nội'),
(N'Sóc Sơn', N'Sóc Sơn, Hà Nội'),
(N'Sơn Tây', N'Sơn Tây, Hà Nội'),
(N'Thanh Trì', N'Thanh Trì, Hà Nội'),
(N'Bắc Ninh', N'TP Bắc Ninh, Bắc Ninh'),
(N'Từ Sơn', N'Từ Sơn, Bắc Ninh'),
(N'Bắc Giang', N'TP Bắc Giang, Bắc Giang'),
(N'Hưng Yên', N'TP Hưng Yên, Hưng Yên'),
(N'Vĩnh Phúc', N'Vĩnh Yên, Vĩnh Phúc'),
(N'Hà Nam', N'Phủ Lý, Hà Nam');
GO

INSERT INTO Route (route_name, type, frequency)
VALUES
(N'Long Biên vòng', N'CIRCULAR', 8),
(N'Hoàn Kiếm vòng', N'CIRCULAR', 7),
(N'Ba Đình vòng', N'CIRCULAR', 6),
(N'Tây Hồ nối', N'ROUND_TRIP', 5),
(N'Cầu Giấy nối', N'ROUND_TRIP', 5),
(N'Đống Đa tuyến', N'ROUND_TRIP', 4),
(N'Hai Bà Trưng tuyến', N'ROUND_TRIP', 4),
(N'Hoàng Mai tuyến', N'ROUND_TRIP', 4),
(N'Thanh Xuân vòng', N'CIRCULAR', 3),
(N'Mỹ Đình vòng', N'CIRCULAR', 5),
(N'Đông Anh vòng', N'CIRCULAR', 4),
(N'Sóc Sơn vòng', N'CIRCULAR', 3),
(N'Sơn Tây tuyến', N'ROUND_TRIP', 3),
(N'Thanh Trì nối', N'ROUND_TRIP', 3),
(N'Bắc Ninh tuyến', N'ROUND_TRIP', 3),
(N'Từ Sơn tuyến', N'ROUND_TRIP', 3),
(N'Bắc Giang tuyến', N'ROUND_TRIP', 3),
(N'Hưng Yên tuyến', N'ROUND_TRIP', 3),
(N'Vĩnh Yên tuyến', N'ROUND_TRIP', 4),
(N'Phủ Lý tuyến', N'ROUND_TRIP', 3);
GO

INSERT INTO Route_Station (route_id, station_id, station_order, estimated_time)
VALUES
-- Route 1: Long Biên vòng
(1, 1, 1, 0),
(1, 10, 2, 15),
(1, 11, 3, 20),
(1, 2, 4, 25),

-- Route 2: Hoàn Kiếm vòng
(2, 2, 1, 0),
(2, 3, 2, 10),
(2, 4, 3, 15),
(2, 5, 4, 20),

-- Route 3: Ba Đình vòng
(3, 3, 1, 0),
(3, 5, 2, 12),
(3, 6, 3, 18),
(3, 7, 4, 22),

-- Route 4: Tây Hồ nối
(4, 4, 1, 0),
(4, 5, 2, 10),
(4, 6, 3, 15),
(4, 7, 4, 20),

-- Route 5: Cầu Giấy nối
(5, 5, 1, 0),
(5, 6, 2, 12),
(5, 7, 3, 18),
(5, 8, 4, 22),

-- Route 6: Đống Đa tuyến
(6, 6, 1, 0),
(6, 7, 2, 10),
(6, 8, 3, 15),
(6, 9, 4, 20),

-- Route 7: Hai Bà Trưng tuyến
(7, 7, 1, 0),
(7, 8, 2, 12),
(7, 9, 3, 18),
(7, 10, 4, 22),

-- Route 8: Hoàng Mai tuyến
(8, 8, 1, 0),
(8, 9, 2, 10),
(8, 10, 3, 15),
(8, 11, 4, 20),

-- Route 9: Thanh Xuân vòng
(9, 9, 1, 0),
(9, 10, 2, 12),
(9, 11, 3, 18),
(9, 12, 4, 22),

-- Route 10: Mỹ Đình vòng
(10, 10, 1, 0),
(10, 11, 2, 15),
(10, 12, 3, 20),
(10, 13, 4, 25),

-- Route 11: Đông Anh vòng
(11, 11, 1, 0),
(11, 12, 2, 15),
(11, 1, 3, 25),

-- Route 12: Sóc Sơn vòng
(12, 12, 1, 0),
(12, 1, 2, 20),
(12, 2, 3, 25),

-- Route 13: Sơn Tây tuyến
(13, 13, 1, 0),
(13, 14, 2, 15),
(13, 1, 3, 30),

-- Route 14: Thanh Trì nối
(14, 14, 1, 0),
(14, 2, 2, 20),
(14, 3, 3, 25),

-- Route 15: Bắc Ninh tuyến
(15, 15, 1, 0),
(15, 16, 2, 15),
(15, 1, 3, 30),

-- Route 16: Từ Sơn tuyến
(16, 16, 1, 0),
(16, 15, 2, 15),
(16, 2, 3, 25),

-- Route 17: Bắc Giang tuyến
(17, 17, 1, 0),
(17, 11, 2, 20),
(17, 3, 3, 30),

-- Route 18: Hưng Yên tuyến
(18, 18, 1, 0),
(18, 3, 2, 20),
(18, 4, 3, 25),

-- Route 19: Vĩnh Yên tuyến
(19, 19, 1, 0),
(19, 1, 2, 25),
(19, 5, 3, 30),

-- Route 20: Phủ Lý tuyến
(20, 20, 1, 0),
(20, 15, 2, 30),
(20, 2, 3, 35);
GO