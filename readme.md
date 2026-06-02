# 二手物品交換平台資料庫 (Second-Hand Exchange Database)

這是一個為「二手物品交換平台」所設計的關聯式資料庫 (Relational Database) 架構，主要用於管理使用者、物品分類、交換請求以及使用者間的訊息溝通。

## 系統需求與特色

* **使用者管理 (User)**：區分管理員 (admin) 與一般使用者 (user)，並包含基本帳號長度與身分驗證限制。
* **商品與分類 (Product & Category)**：採用一對多關聯，使用者可上架多項商品，並將商品歸類以方便系統篩選與管理。
* **訊息互動 (Message)**：建立買賣雙方的溝通管道，完整記錄使用者針對特定物品的詢問與回覆歷程。
* **交換機制 (Exchanges)**：提供發起物品雙向交換的功能。當交換發起時，系統可透過狀態標示將參與交換的兩件物品「鎖定 (Lock)」，防止其同時與他人達成其他交易。

## 檔案說明

* `schema.sql`：資料庫與資料表建立語法 (DDL)，包含 Primary Key (主鍵)、Foreign Key (外部鍵) 關聯以及各欄位的完整性限制。
* `data.sql`：測試用的模擬資料 (DML)，包含預設的分類、模擬使用者 (小華、小明與管理員)、商品資料、對話紀錄與一筆交換請求，方便快速建置測試環境。

## 系統關聯圖 (ER Model)
https://github.com/Chickenedbee/SecondHandExchange-DB/blob/main/%E5%9C%96%E7%89%871.png

https://github.com/Chickenedbee/SecondHandExchange-DB/blob/main/%E5%9C%96%E7%89%872.png

## 建置與使用方式

1. 準備支援 MySQL 語法的資料庫環境（如 MySQL, MariaDB 或 TiDB 等雲端資料庫）。
2. 使用資料庫圖形化工具（如 DBeaver, phpMyAdmin）連線至伺服器。
3. 優先執行 `schema.sql` 以建立 `SecondHandExchange` 資料庫與所有資料表結構。
4. 接著執行 `data.sql` 以匯入測試用的資料。
