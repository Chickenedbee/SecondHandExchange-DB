USE SecondHandExchange;

-- 1. 新增分類資料
INSERT INTO Category (CategoryName) VALUES ('攝影器材'), ('書籍');

-- 2. 新增使用者資料 (包含小華與小明)
INSERT INTO User (Name, Email, Password, Account, Role) VALUES 
('Admin', 'admin@test.com', 'Admin1234', 'adminacc', 'admin'),
('小華', 'hua@test.com', 'HuaPassword1', 'huacc123', 'user'),
('小明', 'ming@test.com', 'MingPass12', 'mingacc12', 'user');

-- 3. 新增商品資料 (相機與書籍)
INSERT INTO Product (Title, Description, Price, Status, SellerID, CategoryID) VALUES 
('二手單眼相機', '九成新，附鏡頭', 15000, '上架中', 3, 1),
('哈利波特全套', '保存良好', 3000, '上架中', 2, 2);

-- 4. 新增對話紀錄
INSERT INTO Message (SenderID, ReceiverID, ProductID, Content) VALUES 
(2, 3, 1, '請問相機還有保固嗎？'),
(3, 2, 1, '已經過保囉，但功能一切正常。');

-- 5. 新增一筆交換紀錄
INSERT INTO Exchanges (ProposerUserID, ProposerProductID, ReceiverProductID, Status) VALUES 
(2, 2, 1, '待確認');