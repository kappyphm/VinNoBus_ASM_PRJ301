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
    route_name VARCHAR(150) NOT NULL unique,
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
