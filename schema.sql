-- 建立資料庫 (可選)
CREATE DATABASE IF NOT EXISTS SecondHandExchange;
USE SecondHandExchange;

-- ==========================================
-- 1. 建立 Category (商品分類表)
-- ==========================================
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY COMMENT '分類編號 (PK)',
    CategoryName VARCHAR(50) NOT NULL UNIQUE COMMENT '分類名稱 (唯一值)'
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
    ProductID INT AUTO_INCREMENT PRIMARY KEY COMMENT '商品編號 (PK)',
    Title VARCHAR(50) NOT NULL COMMENT '產品名稱 (上限50字元)',
    Description TEXT COMMENT '產品描述 (可為NULL)',
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0) COMMENT '產品價格 (需大於等於0)',
    -- 根據需求加入「交換鎖定中」的狀態，以防同時與他人交易
    Status VARCHAR(20) NOT NULL DEFAULT '上架中' CHECK (Status IN ('上架中', '交換鎖定中', '已交換', '已下架')) COMMENT '狀態',
    SellerID INT NOT NULL COMMENT '賣家編號 (FK)',
    CategoryID INT NOT NULL COMMENT '分類編號 (FK)',
    
    FOREIGN KEY (SellerID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- ==========================================
-- 4. 建立 Message (訊息表)
-- ==========================================
CREATE TABLE Message (
    MessageID INT AUTO_INCREMENT PRIMARY KEY COMMENT '訊息編號 (PK)',
    SenderID INT NOT NULL COMMENT '發送者編號 (FK)',
    ReceiverID INT NOT NULL COMMENT '接收者編號 (FK)',
    ProductID INT NOT NULL COMMENT '關聯產品編號 (FK)',
    Content TEXT NOT NULL COMMENT '訊息內容 (不可為空)',
    SentTime DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '發送時間 (預設系統當前時間)',
    
    FOREIGN KEY (SenderID) REFERENCES User(UserID),
    FOREIGN KEY (ReceiverID) REFERENCES User(UserID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- ==========================================
-- 5. 建立 Exchanges (交換紀錄表)
-- ==========================================
CREATE TABLE Exchanges (
    ExchangesID INT AUTO_INCREMENT PRIMARY KEY COMMENT '交換編號 (PK)',
    ProposerUserID INT NOT NULL COMMENT '提出交換者編號 (FK)',
    ProposerProductID INT NOT NULL COMMENT '提出者提供的物品編號 (FK)',
    ReceiverProductID INT NOT NULL COMMENT '對方物品編號 (FK)',
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '發起時間 (預設系統當前時間)',
    Status VARCHAR(20) NOT NULL DEFAULT '待確認' CHECK (Status IN ('待確認', '已同意', '已拒絕', '已完成')) COMMENT '交易狀態',
    
    FOREIGN KEY (ProposerUserID) REFERENCES User(UserID),
    FOREIGN KEY (ProposerProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (ReceiverProductID) REFERENCES Product(ProductID)
);