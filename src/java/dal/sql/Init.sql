-- ==========================================================
-- USER MODULE DATABASE SCHEMA (FIXED FOR SQL SERVER)
-- Author: Kappy (FPT University)
-- ==========================================================

-- Xóa b?ng theo ?úng th? t? quan h?
IF OBJECT_ID('dbo.staff', 'U') IS NOT NULL DROP TABLE dbo.staff;
IF OBJECT_ID('dbo.customer', 'U'	) IS NOT NULL DROP TABLE dbo.customer;
IF OBJECT_ID('dbo.profile', 'U') IS NOT NULL DROP TABLE dbo.profile;
IF OBJECT_ID('dbo.[user]', 'U') IS NOT NULL DROP TABLE dbo.[user];
IF OBJECT_ID('dbo.WorkLog', 'U') IS NOT NULL DROP TABLE dbo.WorkLog;
IF OBJECT_ID('dbo.Ticket', 'U') IS NOT NULL DROP TABLE dbo.Ticket;
IF OBJECT_ID('dbo.Invoice', 'U') IS NOT NULL DROP TABLE dbo.Invoice;
IF OBJECT_ID('dbo.Trip', 'U') IS NOT NULL DROP TABLE dbo.Trip;
IF OBJECT_ID('dbo.Route_Station', 'U') IS NOT NULL DROP TABLE dbo.Route
IF OBJECT_ID('dbo.Route', 'U') IS NOT NULL DROP TABLE dbo.Route;
IF OBJECT_ID('dbo.Station', 'U') IS NOT NULL DROP TABLE dbo.Station;
IF OBJECT_ID('dbo.BusLog', 'U') IS NOT NULL DROP TABLE dbo.BusLog;
IF OBJECT_ID('dbo.Bus', 'U') IS NOT NULL DROP TABLE dbo.Bus;


GO

-- ==========================================================
-- 1?? USER TABLE
-- ==========================================================
CREATE TABLE dbo.[user] (
    user_id VARCHAR(128) NOT NULL UNIQUE,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_user PRIMARY KEY (user_id)
);
GO

-- Trigger c?p nh?t updated_at t? ??ng
CREATE TRIGGER trg_user_update_timestamp
ON dbo.[user]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE u
    SET u.updated_at = GETDATE()
    FROM dbo.[user] u
    INNER JOIN inserted i ON u.user_id = i.user_id;
END;
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
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_profile PRIMARY KEY (user_id),
    CONSTRAINT fk_profile_user FOREIGN KEY (user_id)
        REFERENCES dbo.[user](user_id)
        ON DELETE CASCADE
);
GO

CREATE TRIGGER trg_profile_update_timestamp
ON dbo.profile
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE p
    SET p.updated_at = GETDATE()
    FROM dbo.profile p
    INNER JOIN inserted i ON p.user_id = i.user_id;
END;
GO

-- ==========================================================
-- 3?? CUSTOMER TABLE
-- ==========================================================
CREATE TABLE dbo.customer (
    user_id VARCHAR(128) NOT NULL UNIQUE,
    membership_level VARCHAR(50) NOT NULL DEFAULT 'STANDARD',
    loyalty_points INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_customer PRIMARY KEY (user_id),
    CONSTRAINT fk_customer_user FOREIGN KEY (user_id)
        REFERENCES dbo.[user](user_id)
        ON DELETE CASCADE
);
GO

CREATE TRIGGER trg_customer_update_timestamp
ON dbo.customer
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE c
    SET c.updated_at = GETDATE()
    FROM dbo.customer c
    INNER JOIN inserted i ON c.user_id = i.user_id;
END;
GO

-- ==========================================================
-- 4?? STAFF TABLE
-- ==========================================================
CREATE TABLE dbo.staff (

    user_id VARCHAR(128) NOT NULL UNIQUE,
    staff_code VARCHAR(50) NOT NULL UNIQUE,
    position NVARCHAR(100) NULL,
    department NVARCHAR(100) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_staff PRIMARY KEY (user_id),
    CONSTRAINT fk_staff_user FOREIGN KEY (user_id)
        REFERENCES dbo.[user](user_id)
        ON DELETE CASCADE
);
GO

CREATE TRIGGER trg_staff_update_timestamp
ON dbo.staff
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE s
    SET s.updated_at = GETDATE()
    FROM dbo.staff s
    INNER JOIN inserted i ON s.user_id = i.user_id;
END;
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
-- B?ng L?ch s? xe buýt (BusLog)
-- L?u l?i tr?ng thái thay ??i c?a xe theo th?i gian
-- created_by: ng??i dùng thao tác thay ??i
-- ==============================================
CREATE TABLE BusLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    bus_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('AVAILABLE','IN_USE','MAINTENANCE','BROKEN','REPAIRING','RESERVED')),
    note VARCHAR(255),
    created_by VARCHAR(128) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_BusLog_Bus FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    CONSTRAINT FK_BusLog_User FOREIGN KEY (created_by) REFERENCES [User](user_id)
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
    route_name NVARCHAR(150) NOT NULL,
    type VARCHAR(10) CHECK (type in ('ROUND_TRIP', 'CIRCULAR')),
    frequency INT CHECK (frequency >= 0),
    CONSTRAINT UQ_Route_RouteName UNIQUE (route_name)
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
    CONSTRAINT FK_RS_Station FOREIGN KEY (station_id) REFERENCES Station(station_id) ON DELETE CASCADE
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
    bus_id INT NOT NULL,
    driver_id VARCHAR(128) NOT NULL UNIQUE,
    conductor_id VARCHAR(128) NOT NULL UNIQUE,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'NOT_STARTED' CHECK (status IN ('NOT_STARTED','IN_PROCESS','FINISHED','CANCELLED')),

    CONSTRAINT FK_Trip_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_Trip_Bus FOREIGN KEY (bus_id) REFERENCES Bus(bus_id),
    CONSTRAINT FK_Trip_Driver FOREIGN KEY (driver_id) REFERENCES [User](user_id),
    CONSTRAINT FK_Trip_Conductor FOREIGN KEY (conductor_id) REFERENCES [User](user_id)
);

-- ==============================================
-- B?ng Nh?t ký công vi?c (WorkLog)
-- L?u l?i check-in/check-out c?a nhân viên trong chuy?n
-- Ch? áp d?ng cho role DRIVER và CONDUCTOR
-- Ràng bu?c: m?i chuy?n ch? có 1 driver + 1 conductor
-- ==============================================


CREATE TABLE WorkLog (
    worklog_id INT IDENTITY(1,1) PRIMARY KEY,
    trip_id INT NOT NULL,
    user_id VARCHAR(128) NOT NULL UNIQUE,
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
    created_by VARCHAR(128) NOT NULL UNIQUE,
    invoice_id INT NULL,

    CONSTRAINT FK_Ticket_Customer FOREIGN KEY (customer_id) REFERENCES [User](user_id),
    CONSTRAINT FK_Ticket_Trip FOREIGN KEY (trip_id) REFERENCES Trip(trip_id),
    CONSTRAINT FK_Ticket_Route FOREIGN KEY (route_id) REFERENCES Route(route_id),
    CONSTRAINT FK_Ticket_CreatedBy FOREIGN KEY (created_by) REFERENCES [User](user_id),
    CONSTRAINT FK_Ticket_Invoice FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),

    -- Logic: Vé l??t thì có trip_id, vé ngày/tháng thì có route_id
    CONSTRAINT CK_Ticket_Validity CHECK (
        (trip_id IS NOT NULL AND route_id IS NULL AND expiry_date IS NULL)
        OR
        (trip_id IS NULL AND route_id IS NOT NULL AND expiry_date IS NOT NULL)
    )
);
