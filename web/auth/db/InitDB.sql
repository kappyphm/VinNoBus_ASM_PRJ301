-- ==========================================================
-- USER MODULE DATABASE SCHEMA (FIXED FOR SQL SERVER)
-- Author: Kappy (FPT University)
-- ==========================================================

-- Xóa bảng theo đúng thứ tự quan hệ
IF OBJECT_ID('dbo.staff', 'U') IS NOT NULL DROP TABLE dbo.staff;
IF OBJECT_ID('dbo.customer', 'U') IS NOT NULL DROP TABLE dbo.customer;
IF OBJECT_ID('dbo.profile', 'U') IS NOT NULL DROP TABLE dbo.profile;
IF OBJECT_ID('dbo.[user]', 'U') IS NOT NULL DROP TABLE dbo.[user];
GO

-- ==========================================================
-- 1️⃣ USER TABLE
-- ==========================================================
CREATE TABLE dbo.[user] (
    user_id INT IDENTITY(1,1),
    firebase_uid VARCHAR(128) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL 
        CHECK (role IN ('ADMIN', 'STAFF', 'CUSTOMER')) 
        DEFAULT 'CUSTOMER',
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_user PRIMARY KEY (user_id)
);
GO

-- Trigger cập nhật updated_at tự động
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
-- 2️⃣ PROFILE TABLE
-- ==========================================================
CREATE TABLE dbo.profile (
    profile_id INT IDENTITY(1,1),
    user_id INT NOT NULL UNIQUE,
    full_name NVARCHAR(255) NULL,
    birth_date DATE NULL,
    phone VARCHAR(20) NULL,
    email VARCHAR(255) NULL,
    address NVARCHAR(255) NULL,
    avatar_url VARCHAR(255) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_profile PRIMARY KEY (profile_id),
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
    INNER JOIN inserted i ON p.profile_id = i.profile_id;
END;
GO

-- ==========================================================
-- 3️⃣ CUSTOMER TABLE
-- ==========================================================
CREATE TABLE dbo.customer (
    customer_id INT IDENTITY(1,1),
    user_id INT NOT NULL UNIQUE,
    membership_level VARCHAR(50) NOT NULL DEFAULT 'STANDARD',
    loyalty_points INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_customer PRIMARY KEY (customer_id),
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
    INNER JOIN inserted i ON c.customer_id = i.customer_id;
END;
GO

-- ==========================================================
-- 4️⃣ STAFF TABLE
-- ==========================================================
CREATE TABLE dbo.staff (
    staff_id INT IDENTITY(1,1),
    user_id INT NOT NULL UNIQUE,
    staff_code VARCHAR(50) NOT NULL,
    position NVARCHAR(100) NULL,
    department NVARCHAR(100) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_staff PRIMARY KEY (staff_id),
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
    INNER JOIN inserted i ON s.staff_id = i.staff_id;
END;
GO
