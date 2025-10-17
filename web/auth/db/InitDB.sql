/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  kappyphm
 * Created: Oct 8, 2025
 */



-- =========================================
-- 1. Bảng người dùng chính
-- =========================================
CREATE TABLE Users (
    uid UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    email VARCHAR(256) NOT NULL UNIQUE,
    is_active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT SYSUTCDATETIME()
);

-- =========================================
-- 2. Bảng vai trò hệ thống
-- =========================================
CREATE TABLE Roles (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(20) NOT NULL UNIQUE

);

-- =========================================
-- 3. Liên kết người dùng với vai trò (n-n)
-- =========================================
CREATE TABLE UserRoles (
    user_id UNIQUEIDENTIFIER NOT NULL REFERENCES Users(uid) ON DELETE CASCADE,
    role_id INT NOT NULL REFERENCES Roles(role_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- =========================================
-- 4. Bảng thông tin nhân viên
-- =========================================
CREATE TABLE Staff (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id UNIQUEIDENTIFIER NOT NULL UNIQUE REFERENCES Users(uid) ON DELETE CASCADE,
    staff_code VARCHAR(50) UNIQUE,
    full_name NVARCHAR(200),
    phone VARCHAR(50),
    department NVARCHAR(100),
    position NVARCHAR(100)
);

-- =========================================
-- 5. Bảng thông tin khách hàng
-- =========================================
CREATE TABLE Customer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id UNIQUEIDENTIFIER NOT NULL UNIQUE REFERENCES Users(uid) ON DELETE CASCADE,
    customer_code VARCHAR(50) UNIQUE,
    full_name NVARCHAR(200),
    phone VARCHAR(50),
    address NVARCHAR(500)
);

-- =========================================
-- 6. Bảng xác thực (đa nhà cung cấp)
-- =========================================
CREATE TABLE AuthProviders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id UNIQUEIDENTIFIER NOT NULL REFERENCES Users(uid) ON DELETE CASCADE,
    provider VARCHAR(50) NOT NULL CHECK (provider IN ('LOCAL', 'GOOGLE')),
    provider_uid VARCHAR(256) NULL,          -- UID từ Google / Firebase
    password_hash VARCHAR(512) NULL,         -- LOCAL
    created_at DATETIME NOT NULL DEFAULT SYSUTCDATETIME(),
    UNIQUE (provider, provider_uid)
);

-- =========================================
-- 7. Dữ liệu khởi tạo vai trò
-- =========================================
INSERT INTO Roles (role_name)
VALUES ('ADMIN'), ('STAFF'), ('CUSTOMER');
