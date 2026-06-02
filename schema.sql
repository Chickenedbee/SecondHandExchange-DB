-- 建立資料庫
CREATE DATABASE IF NOT EXISTS SecondHandExchange;
USE SecondHandExchange;

-- ==========================================
-- 1. 建立 Category (商品分類表)
-- ==========================================
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- ==========================================
-- 2. 建立 User (使用者表)
-- ==========================================
CREATE TABLE User (
    UserID INT AUTO_INCREMENT PRIMARY KEY COMMENT '使用者編號 (PK)',
    Name VARCHAR(50) NOT NULL COMMENT '使用者名字',
    Email VARCHAR(100) NOT NULL UNIQUE COMMENT '電子信箱 (唯一值)',
    -- 密碼與帳號的長度限制與英數混合規則，實務上強烈建議在「後端應用程式」進行驗證，但此處加上基本長度限制
    Password VARCHAR(255) NOT NULL CHECK (CHAR_LENGTH(Password) >= 8) COMMENT '密碼', 
    Account VARCHAR(50) NOT NULL UNIQUE CHECK (CHAR_LENGTH(Account) >= 8 AND CHAR_LENGTH(Account) <= 10) COMMENT '帳號',
    Role VARCHAR(10) NOT NULL DEFAULT 'user' CHECK (Role IN ('admin', 'user')) COMMENT '角色 (admin 或 user)'
);

-- ==========================================
-- 3. 建立 Product (商品表)
-- 備註：依需求「相同商品需個別分開儲存」，因此不設數量欄位，每筆紀錄即代表實體一件。
-- ==========================================
CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT '上架中',
    SellerID INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (SellerID) REFERENCES User(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- ==========================================
-- 4. 建立 Message (訊息表)
-- ==========================================
CREATE TABLE Message (
    MessageID INT AUTO_INCREMENT PRIMARY KEY,
    SenderID INT NOT NULL,
    ReceiverID INT NOT NULL,
    ProductID INT NOT NULL,
    Content TEXT NOT NULL,
    SentTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SenderID) REFERENCES User(UserID),
    FOREIGN KEY (ReceiverID) REFERENCES User(UserID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- ==========================================
-- 5. 建立 Exchanges (交換紀錄表)
-- ==========================================
CREATE TABLE Exchanges (
    ExchangesID INT AUTO_INCREMENT PRIMARY KEY,
    ProposerUserID INT NOT NULL,
    ProposerProductID INT NOT NULL,
    ReceiverProductID INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) NOT NULL DEFAULT '待確認',
    IsMalicious BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (ProposerUserID) REFERENCES User(UserID),
    FOREIGN KEY (ProposerProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (ReceiverProductID) REFERENCES Product(ProductID)
);
