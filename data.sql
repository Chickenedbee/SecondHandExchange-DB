USE SecondHandExchange;

-- 1. 新增分類資料
INSERT INTO Category (CategoryName) VALUES ('攝影器材'), ('書籍');

-- 2. 新增使用者資料 (包含小華、小明、管理員，以及被停權的惡意帳號)
INSERT INTO User (Name, Email, Password, Account, Role, AccountStatus) VALUES 
('Admin', 'admin@test.com', 'Admin1234', 'adminacc', 'admin', '正常'),
('小華', 'hua@test.com', 'HuaPassword1', 'huacc123', 'user', '正常'),
('小明', 'ming@test.com', 'MingPass12', 'mingacc12', 'user', '正常'),
('假面超人', 'scammer@test.com', 'BadPass999', 'scam9999', 'user', '停權');

-- 3. 新增商品資料 (相機與書籍，以及假面超人的假商品)
INSERT INTO Product (Title, Description, Price, Status, SellerID, CategoryID) VALUES 
('二手單眼相機', '九成新，附鏡頭', 15000, '上架中', 3, 1),
('哈利波特全套', '保存良好', 3000, '上架中', 2, 2),
('空氣大師神級球鞋', '穿上會飛', 99999, '上架中', 4, 1);

-- 4. 新增對話紀錄
INSERT INTO Message (SenderID, ReceiverID, ProductID, Content) VALUES 
(2, 3, 1, '請問相機還有保固嗎？'),
(3, 2, 1, '已經過保囉，但功能一切正常。');

-- 5. 新增交換紀錄 (包含一筆正常交易，與一筆被標記為惡意的交易)
INSERT INTO Exchanges (ProposerUserID, ProposerProductID, ReceiverProductID, Status, IsMalicious) VALUES 
(2, 2, 1, '已完成', FALSE),
(4, 3, 1, '待確認', TRUE);
