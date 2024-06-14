DROP DATABASE if exists BUAN6320_008_Group_01;
CREATE database BUAN6320_008_Group_01; -- creating a database
show databases;
use BUAN6320_008_Group_01;

-- -------------------------USER TABLE--------------------------------------
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    UserID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserName VARCHAR(30) NOT NULL,
    Password CHAR(15) NOT NULL,
    Email VARCHAR(20) NOT NULL UNIQUE,
    DateJoined DATE NOT NULL,
    LastLogin DATETIME DEFAULT CURRENT_TIMESTAMP,
    MobileNumber VARCHAR(15) NOT NULL,
    DOB DATE NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (UserID))
    AUTO_INCREMENT = 1;
       

-- -------------------------USER ADDRESS TABLE --------------------------------------
	DROP TABLE IF EXISTS addresses;
    CREATE TABLE addresses (
    AddressID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    StreetAddress VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(20) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    PRIMARY KEY (AddressID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
) AUTO_INCREMENT 801;


-- -------------------------USER DEMOGRAPHICS TABLE --------------------------------------
DROP TABLE IF EXISTS userdemographics;
CREATE TABLE userdemographics (
    DemoID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    Age INT NOT NULL,
    Gender CHAR(1) NOT NULL,
    Income DECIMAL(10, 2) DEFAULT 0,
    Occupation VARCHAR(50),
    EducationLevel VARCHAR(50),
    MaritalStatus VARCHAR(20),
    PRIMARY KEY (DemoID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
);



-- -------------------------USER PORTFOLIO TABLE--------------------------------------
DROP TABLE IF EXISTS userportfolio;
CREATE TABLE userportfolio (
    PortfolioID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    PortfolioName VARCHAR(20) NOT NULL,
    CreationDate DATE NOT NULL,
    LastModified DATE DEFAULT NULL,
    PRIMARY KEY (PortfolioID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
)AUTO_INCREMENT=101;

-- -------------------------USER BANK DETAIL TABLE --------------------------------------
DROP TABLE IF EXISTS bankdetails;
 CREATE TABLE bankdetails (
    BankID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    BankName VARCHAR(20),
    AccountNumber VARCHAR(20),
    PRIMARY KEY (BankID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
)AUTO_INCREMENT = 201;

-- -------------------------ASSET TABLE --------------------------------------
DROP TABLE IF EXISTS assets;
CREATE TABLE assets ( 
  AssetID int UNSIGNED NOT NULL AUTO_INCREMENT,
  Symbol VARCHAR(10),
  AssetName varchar(40) NOT NULL DEFAULT '',
  AssetType  varchar(20) NOT NULL DEFAULT '',
  RiskLevel varchar(20) NOT NULL DEFAULT '',
  MarketValue DECIMAL(15, 2),
  PRIMARY KEY (`AssetID`)
); 

-- -------------------------MARKET DATA TABLE--------------------------------------
DROP TABLE IF EXISTS MarketData;
CREATE TABLE MarketData (
	MarketdataID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    AssetID INT UNSIGNED,
    MarketPrice DECIMAL(15, 2),
    Volume INT DEFAULT 0,
	OpeningPrice decimal(15,2) DEFAULT NULL,
    ClosingPrice  decimal(15,2) DEFAULT NULL,
    DateUpdated DATE,
    PRIMARY KEY (MarketdataID),
    FOREIGN KEY (AssetID) REFERENCES Assets (AssetID)
)AUTO_INCREMENT 1001;

-- ------------------------- USER ASSET TABLE --------------------------------------
DROP TABLE IF EXISTS userassets;
CREATE TABLE userassets (
    AssetID INT UNSIGNED NOT NULL,
    UserID INT UNSIGNED NOT NULL,
    PortfolioID INT UNSIGNED NOT NULL,
    AssetQuantity INT DEFAULT 0,
    PRIMARY KEY (AssetID,UserID,PortfolioID),
    FOREIGN KEY (AssetID) REFERENCES assets (AssetID),
    FOREIGN KEY (UserID) REFERENCES users (UserID),
    FOREIGN KEY (PortfolioID) REFERENCES userportfolio (PortfolioID)
);

-- -------------------------  TRANSACTION TABLE --------------------------------------
DROP TABLE IF EXISTS transaction;
    CREATE TABLE transaction (
    TransactionID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    PortfolioID INT UNSIGNED NOT NULL,
    AssetID INT UNSIGNED NOT NULL,
    TransactionType VARCHAR(20) NOT NULL DEFAULT '',
    TransactionDate DATE NOT NULL,
    Quantity INT DEFAULT 0,
    TransactionPrice DECIMAL(15, 2) DEFAULT NULL,
    Commission DECIMAL(15, 2) DEFAULT NULL,
    TotalAmount DECIMAL(15, 2) DEFAULT NULL,
    Description TEXT,
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (UserID) REFERENCES users (UserID),
     FOREIGN KEY (PortfolioID) REFERENCES userportfolio (PortfolioID),
    FOREIGN KEY (AssetID) REFERENCES assets (AssetID)
)AUTO_INCREMENT=5001;



-- -------------------------USER PLAN TABLE --------------------------------------
DROP TABLE IF EXISTS userplan;
CREATE TABLE userplan (
    userplanID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
	Risklevel VARCHAR(50),
    Short_termplan BOOLEAN DEFAULT TRUE,
    Long_termplan BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (userplanID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
);

-- -------------------------INVESTMENT HISTORY TABLE --------------------------------------
DROP TABLE IF EXISTS investmenthistory;
CREATE TABLE investmenthistory (
    HistoryID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    AssetID INT UNSIGNED NOT NULL,
    PortfolioID INT UNSIGNED NOT NULL,
    InvestmentDate DATE NOT NULL,
    InvestmentAmount DECIMAL(15 , 2 ) DEFAULT NULL,
    PRIMARY KEY (HistoryID),
    FOREIGN KEY (UserID)
        REFERENCES users (UserID),
    FOREIGN KEY (AssetID)
        REFERENCES userassets (AssetID),
    FOREIGN KEY (PortfolioID)
        REFERENCES userportfolio (PortfolioID)
);

-- ------------------------- SIP DETAIL TABLE --------------------------------------
DROP TABLE IF EXISTS sipdetails;
CREATE TABLE sipdetails (
    SIPID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    SIPName VARCHAR(20),
    SIPAmount DECIMAL(15, 2) DEFAULT NULL,
    SIPFrequency VARCHAR(20),
    PRIMARY KEY (SIPID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
);

-- ------------------------- ACCOUNT HISTORY TABLE --------------------------------------
DROP TABLE IF EXISTS accounthistory;
CREATE TABLE accounthistory (
    HistoryID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    UserID INT UNSIGNED NOT NULL,
    AccountBalance DECIMAL(15, 2) DEFAULT NULL,
    HistoryDate DATE,
    PRIMARY KEY (HistoryID),
    FOREIGN KEY (UserID) REFERENCES users (UserID)
);

-- ------------------------- USER AUDIT TABLE --------------------------------------
DROP TABLE IF EXISTS users_audit;
-- create audit table for user
CREATE TABLE users_audit (
    UserID INT UNSIGNED NOT NULL,
    UserName VARCHAR(30) NOT NULL,
    OldPassword CHAR(15) NOT NULL,
    NewPassword CHAR(15) NOT NULL,
    OldEmail VARCHAR(30) NOT NULL ,
    NewEmail VARCHAR(30) NOT NULL ,
    OldMobileNumber VARCHAR(15) NOT NULL,
    NewMobileNumber VARCHAR(15) NOT NULL,
	DateUpdated DATETIME,
    PRIMARY KEY (UserID), 
    FOREIGN KEY (UserID) REFERENCES users (UserID)
    
    
);

-- ------------------------- MARKET DATA AUDIT TABLE --------------------------------------
DROP TABLE IF EXISTS MarketData_Audit;
-- audit table for market data 
CREATE TABLE MarketData_Audit (
	MarketdataID INT UNSIGNED NOT NULL,
    AssetID INT UNSIGNED,
    OldMarketPrice DECIMAL(15, 2),
    NewMarketPrice DECIMAL(15, 2),
    OldVolume INT DEFAULT 0,
    NewVolume INT DEFAULT 0,
    OldOpeningPrice decimal(15,2) DEFAULT NULL,
    OldClosingPrice  decimal(15,2) DEFAULT NULL,
    NewOpeningPrice decimal(15,2) DEFAULT NULL,
    NewClosingPrice  decimal(15,2) DEFAULT NULL,
    DateUpdated DATETIME,
    PRIMARY KEY (MarketdataID),
    FOREIGN KEY (AssetID) REFERENCES Assets (AssetID)
    
);

-- ------------------------- ASSET AUDIT TABLE --------------------------------------
-- audit table for assets
DROP TABLE IF EXISTS Assets_Audit;
CREATE TABLE Assets_Audit (
    AssetID INT UNSIGNED NOT NULL,
    OldAssetName VARCHAR(40) NOT NULL DEFAULT '',
    OldAssetType VARCHAR(20) NOT NULL DEFAULT '',
    NewAssetName VARCHAR(40) NOT NULL DEFAULT '',
    NewAssetType VARCHAR(20) NOT NULL DEFAULT '',
    OldMarketValue DECIMAL(15, 2) DEFAULT NULL,
    NewMarketValue DECIMAL(15, 2) DEFAULT NULL,
   DateUpdated DATETIME,
   PRIMARY KEY (AssetID)
   
);

-- ------------------------- BANK DETAIL AUDIT TABLE --------------------------------------
-- audit table to record the changes in bank detail
DROP TABLE IF EXISTS bankdetails_Audit;
CREATE TABLE bankdetails_Audit (
    BankID INT UNSIGNED NOT NULL,
    UserID INT UNSIGNED NOT NULL,
    OldBankName VARCHAR(20),
	NewBankName VARCHAR(20),
    OldAccountNumber VARCHAR(20),
	NewAccountNumber VARCHAR(20),
    DateUpdated DATETIME,
    PRIMARY KEY (BankID),
	FOREIGN KEY (UserID) REFERENCES users (UserID)
    
);

-- ---------------------------------- AssetCurrentPrice ---------------------------------------------------
-- Table represents an update to the market price of a specific asset at a particular date.
CREATE TABLE AssetCurrentPrice (
    UpdateID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    AssetID INT UNSIGNED NOT NULL,
    MarketPrice DECIMAL(15, 2),
    UpdateDate DATE,
    PRIMARY KEY (UpdateID),
    FOREIGN KEY (AssetID) REFERENCES Assets (AssetID)
);




-- ************************************************************************************************************************---------

INSERT INTO users (UserName, Password, Email, DateJoined, MobileNumber,DOB)
VALUES
	('JohnDoe', 'password1', 'john@example.com', '2023-01-01', 1234567890,'1990-05-15'),
    ('AliceSmith', 'pass1234', 'alice@example.com', '2023-01-02',9876543210,'1985-08-22'),
    ('BobJohnson', 'qwerty12', 'bob@example.com', '2023-01-03', 5556667777,'1995-02-10'),
    ('EvaMiller', 'secure01', 'eva@example.com', '2023-01-04', 1112223333,'1988-11-30'),
    ('DavidBrown', 'abc12345', 'david@example.com', '2023-01-05', 9998887777,'1982-07-18'),
    ('SophieWilliams', 'pass4321', 'sophie@example.com', '2023-01-06', 7778889999,'1993-04-25'),
    ('MichaelLee', 'mike5678', 'michael@example.com', '2023-01-07', 4445556666,'1980-09-12'),
    ('OliviaJones', 'olivia987', 'olivia@example.com', '2023-01-08', 2223334444,'1998-06-03'),
    ('DanielSmith', 'danielPass', 'daniel@example.com', '2023-01-09', 6667778888,'1991-12-15'),
    ('EmmaBrown', 'emmaPass1', 'emma@example.com', '2023-01-10', 3334445555,'1987-03-08'),
    ('LiamJohnson', 'liamPass', 'liam@example.com', '2023-01-11', 5554443333,'2000-08-17'),
    ('AvaTaylor', 'avaPass', 'ava@example.com', '2023-01-12', 2223334444,'1996-02-28'),
    ('NoahSmith', 'noah123', 'noah@example.com', '2023-01-13', 9998887777,'1989-10-05'),
    ('IsabellaLee', 'isabella01', 'isabella@example.com', '2023-01-14', 7778889999,'1997-07-20'),
    ('MasonDavis', 'masonPass', 'mason@example.com', '2023-01-15', 3334445555,'1992-11-13'),
    ('MiaMartin', 'miaPass', 'mia@example.com', '2023-01-16', 6667778888,'1995-05-09'),
    ('JamesAnderson', 'jamesPass', 'james@example.com', '2023-01-17', 4445556666, '1986-12-01'),
    ('EmmaWhite', 'emmaPass2', 'emmaw@example.com', '2023-01-18', 1112223333,'1990-04-22'),
    ('Maddy White', 'emmaPass2', 'maddy@example.com', '2023-01-18', 1112223333,'1990-04-22'); 
    
   -- -------------------------  USER ADDRESSES DATA INSERTION--------------------------------------

INSERT INTO addresses (UserID, StreetAddress, City, State, PostalCode, Country)
VALUES
    (1, '123 Main St', 'New York City', 'New York', '12345', 'USA'),
    (2, '456 Oak Ave', 'Los Angeles', 'California', '67890', 'USA'),
    (3, '789 Pine Rd', 'Chicago', 'Illinois', '98765', 'USA'),
    (4, '101 Elm Blvd', 'Houston', 'Texas', '54321', 'USA'),
    (5, '202 Maple Ln', 'Phoenix', 'Arizona', '67890', 'USA'),
    (6, '303 Cedar Dr', 'Philadelphia', 'Pennsylvania', '13579', 'USA'),
    (7, '404 Birch St', 'San Antonio', 'Texas', '24680', 'USA'),
    (8, '505 Spruce Ave', 'San Diego', 'California', '86420', 'USA'),
    (9, '606 Oak Rd', 'Dallas', 'Texas', '97531', 'USA'),
    (10, '707 Pine Blvd', 'San Jose', 'California', '24680', 'USA'),
    (11, '808 Maple Ln', 'Austin', 'Texas', '13579', 'USA'),
    (12, '909 Cedar Dr', 'Jacksonville', 'Florida', '86420', 'USA'),
    (13, '1010 Birch St', 'Indianapolis', 'Indiana', '97531', 'USA'),
    (14, '1111 Spruce Ave', 'San Francisco', 'California', '12345', 'USA'),
    (15, '1212 Elm Blvd', 'Columbus', 'Ohio', '67890', 'USA'),
    (16, '1313 Maple Ln', 'Charlotte', 'North Carolina', '98765', 'USA'),
    (17, '1414 Cedar Dr', 'Seattle', 'Washington', '54321', 'USA'),
    (18, '1515 Pine Rd', 'Denver', 'Colorado', '86420', 'USA');
    
    

    -- -------------------------USER Demographics DATA INSERTION --------------------------------------
    

INSERT INTO userdemographics (UserID, Age, Gender, Income, Occupation, EducationLevel, MaritalStatus)
VALUES
    (1, 30, 'M', 60000, 'Engineer', 'Bachelor', 'Single'),
    (2, 40, 'F', 80000, 'Doctor', 'Doctorate', 'Married'),
    (3, 25, 'M', 30000, 'Teacher', 'Master', 'Single'),
    (4, 35, 'F', 55000, 'Nurse', 'Bachelor', 'Married'),
    (5, 45, 'M', 70000, 'Business Analyst', 'Master', 'Divorced'),
    (6, 50, 'F', 90000, 'Lawyer', 'Doctorate', 'Married'),
    (7, 28, 'M', 48000, 'Software Developer', 'Bachelor', 'Single'),
    (8, 38, 'F', 65000, 'Accountant', 'Bachelor', 'Married'),
    (9, 29, 'M', 50000, 'Research Scientist', 'Doctorate', 'Single'),
    (10, 55, 'F', 95000, 'CEO', 'Master', 'Widowed'),
    (11, 25, 'F', 21000, 'Engineer', 'Bachelor', 'Single'),
    (12, 32, 'M', 72000, 'Marketing Manager', 'Master', 'Married'),
	(13, 41, 'F', 68000, 'HR Specialist', 'Bachelor', 'Divorced'),
	(14, 27, 'M', 54000, 'Graphic Designer', 'Bachelor', 'Single'),
	(15, 36, 'F', 62000, 'Financial Analyst', 'Master', 'Married'),
	(16, 48, 'M', 78000, 'IT Manager', 'Master', 'Single'),
	(17, 53, 'F', 85000, 'Project Manager', 'Master', 'Widowed'),
	(18, 30, 'M', 46000, 'Journalist', 'Bachelor', 'Divorced'),
    (19, 31, 'F', 80000, 'Doctor', 'Doctorate', 'Married');

    

    
    --  -------------------------USER PORTFOLIO DATA INSERTION ------------------------------------ --

 INSERT INTO userportfolio (UserID, PortfolioName, CreationDate, LastModified)
VALUES
    (1, 'Portfolio 1', '2023-01-01', '2023-01-10'),
    (2, 'Portfolio 2', '2023-01-02', '2023-01-12'),
    (3, 'Portfolio 3', '2023-01-03', '2023-01-15'),
    (4, 'Portfolio 4', '2023-01-04', '2023-01-20'),
    (5, 'Portfolio 5', '2023-01-05', '2023-01-25'),
    (6, 'Portfolio 6', '2023-01-06', '2023-02-01'),
    (7, 'Portfolio 7', '2023-01-07', '2023-02-05'),
    (8, 'Portfolio 8', '2023-01-08', '2023-02-10'),
    (9, 'Portfolio 9', '2023-01-09', '2023-02-15'),
    (10, 'Portfolio 10', '2023-01-10', '2023-02-20'),
    (11, 'Portfolio 11', '2023-01-11', '2023-02-25'),
    (12, 'Portfolio 12', '2023-01-12', '2023-03-01'),
    (13, 'Portfolio 13', '2023-01-13', '2023-03-05'),
    (14, 'Portfolio 14', '2023-01-14', '2023-03-10'),
    (15, 'Portfolio 15', '2023-01-15', '2023-03-15'),
    (16, 'Portfolio 16', '2023-01-16', '2023-03-20'),
    (17, 'Portfolio 17', '2023-01-17', '2023-03-25'),
    (18, 'Portfolio 18', '2023-01-18', '2023-03-30'),
    (1, 'Portfolio 19', '2023-01-19', '2023-04-01'),
    (2, 'Portfolio 20', '2023-01-20', '2023-04-05'),
    (3, 'Portfolio 21', '2023-01-21', '2023-04-10'),
    (4, 'Portfolio 22', '2023-01-22', '2023-04-15'),
    (5, 'Portfolio 23', '2023-01-23', '2023-04-20'),
    (6, 'Portfolio 24', '2023-01-24', '2023-04-25');
    
    
-- -------------------------USER BANK DETAIL DATA INSERTION --------------------------------------

INSERT INTO bankdetails (UserID, BankName, AccountNumber)
VALUES
	(1, 'Bank of America', '1234567890'),
    (2, 'Chase Bank', '9876543210'),
    (3, 'Wells Fargo', '5551122333'),
    (4, 'Citibank', '7778899001'),
    (5, 'HSBC', '1122334455'),
    (6, 'US Bank', '9988776655'),
    (7, 'TD Bank', '6543210987'),
    (8, 'PNC Bank', '1122334455'),
    (9, 'SunTrust', '9876543210'),
    (10, 'KeyBank', '4567890123'),
    (11, 'Capital One', '7890123456'),
    (12, 'BB&T', '3456789012'),
    (13, 'Ally Bank', '5678901234'),
    (14,'Regions Bank', '8901234567'),
    (15, 'M&T Bank', '2345678901'),
    (16, 'Fifth Third Bank', '6789012345'),
    (17, 'Santander Bank', '9012345678'),
    (18, 'Citizens Bank', '1234567890');
    

   -- ------------------------- ASSET DATA INSERTION --------------------------------------
    INSERT INTO Assets (AssetID, Symbol, AssetName, AssetType, RiskLevel,MarketValue)
VALUES
	(2001,'AAPL', 'Apple Inc.', 'Stock','Moderate',5500.00),
    (2002, 'GOOGL', 'Google', 'Stock', 'Moderate',6500.00),
    (2003, 'MCRSFT', 'Microsoft Corp.', 'Equity', 'Low',20500.00),
    (2004, 'AMZ', 'Amazon.com Inc.', 'Equity', 'Moderate',25500.00),
    (2005, 'USTB', 'US Treasury Bond', 'Fixed Income', 'Low',10800.00),
    (2006, 'RIC', 'Realty Income Corp', 'Real Estate', 'High',20800.00),
    (2007, 'DGB', 'Dynamic Global Bond', 'Fixed Income', 'Moderate',15800.00),
    (2008, 'MNT', 'Multinational Treasury', 'Fixed Income', 'Low',10500.00),
    (2009, 'TSL', 'Tesla', 'Fixed Income', 'High',15800.00),
    (2010, 'CAUS', 'Calvert US ETF', 'ETF', 'Moderate',8800.00),
    (2011, 'NVDA', 'NVIDIA Corporation', 'Stock', 'High',35000),
    (2012, 'INTC', 'Intel Corporation', 'Stock', 'Moderate',6510.00),
    (2013, 'GS', 'Goldman Sachs Group', 'Equity', 'Moderate',24500.00),
    (2014, 'GOVT', 'iShares U.S. Treasury Bond ETF', 'ETF', 'Low',11300.00),
    (2015, 'V', 'Visa Inc.', 'Stock', 'Moderate',25000.00),
    (2016, 'JPM', 'JPMorgan Chase & Co.', 'Equity', 'Moderate',33000.00),
    (2017, 'NFLX', 'Netflix Inc.', 'Stock', 'High',45000.00),
    (2018, 'TROW', 'T. Rowe Price Group', 'Equity', 'Moderate',18700.00);
    
          -- ------------------------- ASSET MARKET DATA INSERTION --------------------------------------
    
    INSERT INTO MarketData (AssetID, MarketPrice, Volume,OpeningPrice,ClosingPrice, DateUpdated  ) VALUES
	(2001,5500.00,10000,5100.00,5400.00,'2023-01-15'),
    (2002,6500.00,11000,6100.00,6400.00,'2023-01-20'),
    (2003,20500.00,9000,20499.00,20450.00,'2023-02-20'),		
    (2004,25500.00,9000,25000.00,25460.00,'2023-02-05'),
    (2005,10800.00,2000,10400.00,10700.00,'2023-04-12'),
    (2006,20800.00,500,20840.00,10830.00,'2022-09-14'),
    (2007,15800.00,1000,15810.00,15805.00,'2022-02-20'),
    (2008,10500.00,850,10540.00,10501.00,'2022-04-29'),
    (2009,15800.00,1850,15700.00,15790.00,'2023-04-17'),
    (2010,8800.00,650,8790.00,8799.00,'2023-06-21'),
    (2011, 35000.00, 5000,36000.00,35500.00,'2023-01-25'),
    (2012,6510.00, 12000,6500.00,6590.00, '2023-05-10'),
    (2013,24500.00, 3000, 24500.00,25500.00,'2023-03-05'),
    (2014,11300.00, 2200,11100.00,11200.00, '2023-04-28'),
    (2015,25000.00, 7000, 24900.00,24990.00, '2023-02-15'),
    (2016,33000.00, 4000,30000.00,33100.00, '2023-01-10'),
    (2017,45000.00, 3000,43000.00,44500.00, '2023-05-20'),
    (2018,18700.00, 5000,18000.00,18600.00, '2023-06-05');
    
	-- -------------------------  USER ASSET DATA INSERTION --------------------------------------
       
       INSERT INTO userassets (UserID, PortfolioID, AssetID, AssetQuantity)
VALUES
    (1, 101, 2001, 5),
    (3, 103, 2003, 12),
    (5, 105, 2005, 20),
    (7, 107, 2007, 8),
    (9, 109, 2009, 3),
    (11, 111, 2011, 10),
    (13, 113, 2013, 15),
    (15, 115, 2015, 8),
    (17, 117, 2017, 3),
    (2, 102, 2002, 8),
    (4, 104, 2004, 15),
    (6, 106, 2006, 5),
    (8, 108, 2008, 10),
    (10, 110, 2010, 15),
    (12, 112, 2012, 5),
    (14, 114, 2014, 10),
    (16, 116, 2016, 5),
    (18, 118, 2018, 7)
    ;
    
    -- -------------------------  TRANSACTION DATA INSERTION --------------------------------------
    -- CHANGED VALUES FOR first 3 TRANSACTIONS from 5500 to 4000
            INSERT INTO transaction (UserID, PortfolioID, AssetID, TransactionType, TransactionDate, Quantity, TransactionPrice, Commission, TotalAmount, Description)
VALUES
    (1, 101, 2001, 'Buy', '2023-01-15', 5, 4000.00, 5.00, 27525.00, 'Buying 5 shares of AAPL'),
    (2, 102, 2002, 'Buy', '2023-01-20', 8, 5000.00, 6.00, 51844.00, 'Buying 8 shares of GOOGL'),
    (3, 103, 2003, 'Buy', '2023-02-20', 12, 15500.00, 10.00, 246210.00, 'Buying 12 shares of MCRSFT'),
    (4, 104, 2004, 'Buy', '2023-02-05', 15, 28500.00, 12.50, 381937.50, 'Buying 15 shares of AMZ'),
    (5, 105, 2005, 'Buy', '2023-04-12', 20, 10800.00, 8.00, 216008.00, 'Buying 20 units of USTB'),
    (6, 106, 2006, 'Buy', '2022-09-14', 5, 20800.00, 7.00, 103603.00, 'Buying 5 units of RIC'),
    (7, 107, 2007, 'Buy', '2022-02-20', 8, 15800.00, 6.50, 126524.00, 'Buying 8 units of DGB'),
    (8, 108, 2008, 'Buy', '2022-04-29', 10, 10500.00, 5.00, 104495.00, 'Buying 10 units of MNT'),
    (9, 109, 2009, 'Buy', '2023-04-17', 3, 15800.00, 4.00, 47458.00, 'Buying 3 units of TSL'),
    (10, 110, 2010, 'Buy', '2023-06-21', 15, 8800.00, 8.50, 131502.50, 'Buying 15 units of CAUS'),
    (11, 111, 2011, 'Buy', '2023-01-25', 10, 35000.00, 15.00, 350015.00, 'Buying 10 shares of NVDA'),
    (12, 112, 2012, 'Buy', '2023-05-10', 5, 6510.00, 3.50, 32517.50, 'Buying 5 shares of INTC'),
    (13, 113, 2013, 'Buy', '2023-03-05', 15, 24500.00, 12.00, 367512.00, 'Buying 15 shares of GS'),
    (14, 114, 2014, 'Buy', '2023-04-28', 10, 11300.00, 5.00, 112995.00, 'Buying 10 units of GOVT'),
    (15, 115, 2015, 'Buy', '2023-02-15', 8, 25000.00, 8.50, 200016.00, 'Buying 8 shares of V'),
    (16, 116, 2016, 'Buy', '2023-01-10', 5, 33000.00, 7.00, 164493.00, 'Buying 5 shares of JPM'),
    (17, 117, 2017, 'Buy', '2023-05-20', 3, 45000.00, 10.00, 135040.00, 'Buying 3 shares of TROW'),
	(18, 118, 2018, 'Buy', '2023-06-05', 7, 18700.00, 9.00, 131551.00, 'Buying 7 shares of TROW'),
    (19, 119, 2018, 'Buy', '2023-06-05', 9, 18700.00, 9.00, 131551.00, 'Buying 9 shares of TROW');
 
 
  -- -------------------------  USER PLAN DATA INSERTION --------------------------------------
INSERT INTO userplan (UserID, Risklevel, Short_termplan, Long_termplan) VALUES
(1, 'Low', TRUE, TRUE),
(2, 'Moderate', TRUE, FALSE),
(3, 'High', FALSE, TRUE),
(4, 'Moderate', TRUE, TRUE);

-- -------------------------  SIP DETAILS DATA INSERTION --------------------------------------
INSERT INTO sipdetails (UserID, SIPName, SIPAmount, SIPFrequency) VALUES
(1, 'SIP Plan 1', 100.00, 'Monthly'),
(1, 'SIP Plan 2', 150.00, 'Quarterly'),
(2, 'SIP Plan 3', 200.00, 'Monthly'),
(3, 'SIP Plan 4', 250.00, 'Monthly'),
(4, 'SIP Plan 5', 120.00, 'Monthly');

-- -------------------------  ACCOUNT HISTORY  DATA INSERTION --------------------------------------
-- Inserting 5 rows into accounthistory table
INSERT INTO accounthistory (UserID, AccountBalance, HistoryDate)
VALUES
    (1, 1000.50, '2023-01-01'),
    (2, 1500.75, '2023-01-02'),
    (3, 2000.00, '2023-01-03'),
    (4, 1200.25, '2023-01-04'),
    (5, 1800.50, '2023-01-05');

-- Insert values for AssetCurrentPrice for Day 1
INSERT INTO AssetCurrentPrice (AssetID, MarketPrice, UpdateDate)
VALUES
    (2001, 5550.00, '2023-06-01'),
    (2002, 6600.00, '2023-06-01'),
    (2003, 20700.00, '2023-06-01');

-- Insert values for AssetCurrentPrice for Day 2
INSERT INTO AssetCurrentPrice (AssetID, MarketPrice, UpdateDate)
VALUES
    (2001, 5600.00, '2023-06-02'),
    (2002, 6700.00, '2023-06-02'),
    (2003, 20800.00, '2023-06-02');

-- ----------------------------------JOINS----------------------------------------------------

-- Retrieve all transactions with corresponding asset and user details.

SELECT users.UserName, transaction.TransactionID, transaction.TransactionType, transaction.TransactionDate, 
       assets.Symbol, assets.AssetName, transaction.Quantity, transaction.TransactionPrice
FROM transaction
LEFT JOIN assets ON transaction.AssetID = assets.AssetID
LEFT JOIN users ON transaction.UserID = users.UserID;

-- Retrieve information about the assets in a user's portfolio along with market data.

SELECT userportfolio.PortfolioID, userportfolio.PortfolioName, userassets.AssetID, assets.AssetName,
       MarketData.MarketPrice, MarketData.Volume
FROM userportfolio
INNER JOIN userassets ON userportfolio.PortfolioID = userassets.PortfolioID
INNER JOIN assets ON userassets.AssetID = assets.AssetID
LEFT JOIN MarketData ON assets.AssetID = MarketData.AssetID;


-- Retrieve the User with the Highest Total Market Value of Stocks:

SELECT users.UserID,users.UserName,SUM(userassets.AssetQuantity * assets.MarketValue) AS TotalStockValue
FROM users
JOIN userassets  ON users.UserID = userassets.UserID
JOIN assets  ON userassets.AssetID = assets.AssetID
WHERE assets.AssetType = 'Stock'
GROUP BY users.UserID
ORDER BY TotalStockValue DESC
LIMIT 1;

-- Total Investment Value by User 
SELECT u.UserID,u.UserName,SUM(ua.AssetQuantity*a.MarketValue) AS TotalAssetsValue
FROM users u
JOIN userassets ua ON u.UserID = ua.UserID
JOIN assets a ON ua.AssetID = a.AssetID
GROUP BY u.UserID,u.UserName	
ORDER BY TotalAssetsValue DESC;
# LIMIT 3;

-- Tracking Profits and Losses in User Investments 

	SELECT u.UserID, u.UserName,
		   SUM((a.MarketValue - (t.TransactionPrice + Commission))* t.Quantity) as OverallPerformance
	FROM users u
	JOIN transaction t ON u.UserID = t.UserID
	JOIN assets a ON t.AssetID = a.AssetID
	GROUP BY u.UserID, u.UserName
    LIMIT 4
 ;
 
 --   Analyzing Asset Distribution in User Portfolios 

SELECT a.AssetType, COUNT(DISTINCT ua.PortfolioID) as NumberOfPortfolios, 
       SUM(ua.AssetQuantity) as TotalQuantity
FROM assets a
JOIN userassets ua ON a.AssetID = ua.AssetID
GROUP BY a.AssetType
ORDER BY TotalQuantity DESC;

-- ----- USER DEMOGRAPHIC ANALYSIS -----------
SELECT ud.Gender,  ud.Occupation,
       COUNT(DISTINCT u.UserID) as NumberOfUsers,
       COUNT(t.TransactionID) as NumberOfTransactions,
       AVG(t.TotalAmount) as AverageTransactionAmount,
       SUM(t.TotalAmount) as TotalInvestment,
       COUNT(t.TransactionID) / COUNT(DISTINCT u.UserID) as TransactionsPerUser
FROM userdemographics ud
JOIN users u ON ud.UserID = u.UserID
JOIN transaction t ON u.UserID = t.UserID
GROUP BY ud.Gender, ud.Occupation
ORDER BY  ud.Gender, ud.Occupation;

--  -- ----Analyzing User Plan Preferences and Risk Profiles ------------
	SELECT up.Risklevel, 
		   COUNT(DISTINCT up.UserID) as NumberOfUsers,
		   SUM(CASE WHEN up.Short_termplan = TRUE THEN 1 ELSE 0 END) as ShortTermPlanCount,
		   SUM(CASE WHEN up.Long_termplan = TRUE THEN 1 ELSE 0 END) as LongTermPlanCount
	FROM userplan up
	GROUP BY up.Risklevel
	ORDER BY NumberOfUsers DESC;


 
SELECT u.UserID, u.UserName, s.SIPID, s.SIPName, s.SIPAmount,s.SIPFrequency
FROM users u
JOIN sipdetails s ON u.UserID = s.UserID;
 
-- -------------------------------- Self join ----------------------------------
-- Pairing Users Based on Risk Level and Investment Strategy --
-- self join --
SELECT UP1.UserID AS UserID1, UP2.UserID AS UserID2, UP1.Risklevel, UP1.Short_termplan, UP1.Long_termplan
FROM userplan UP1
JOIN userplan UP2 ON UP1.userplanID != UP2.userplanID 
AND UP1.Risklevel = UP2.Risklevel 
AND (UP1.Short_termplan = UP2.Short_termplan OR UP1.Long_termplan = UP2.Long_termplan)
AND UP1.UserID != UP2.UserID;

-- ----------------------------- SUB QUERIES--------------------------------------

-- Find assets with a market value above the average market value 
SELECT * FROM assets
WHERE MarketValue > (SELECT AVG(MarketValue) FROM assets);
-- Get the total commission earned for each transaction type:
SELECT DISTINCT TransactionType,
       (SELECT SUM(Commission) FROM transaction WHERE transaction.TransactionType = t.TransactionType) AS TotalCommission
FROM transaction t;

-- Find users who have invested in assets with a risk level of 'High':
SELECT * FROM users
WHERE UserID IN (
    SELECT DISTINCT UserID
    FROM userassets
    WHERE AssetID IN (SELECT AssetID FROM assets WHERE RiskLevel = 'High')
);
-- Get the top10 portfolios with the highest total market value:
SELECT PortfolioID, TotalMarketValue
FROM (
    SELECT PortfolioID, SUM(MarketValue) AS TotalMarketValue
    FROM userassets
    JOIN assets ON userassets.AssetID = assets.AssetID
    GROUP BY PortfolioID
) AS PortfolioTotals
ORDER BY TotalMarketValue DESC
LIMIT 10;


-- 
-- Find the top 5 assets with the highest average transaction price:
SELECT AssetID, AVG(TransactionPrice) AS AverageTransactionPrice
FROM transaction
GROUP BY AssetID
ORDER BY AverageTransactionPrice DESC
LIMIT 5;


  -- -------------------------  TRIGGERS --------------------------------------
   


-- ----------------- Trigger to insert the transaction information into the user asset table and update the volume availability in the user asset and market data table --------------------------------------



-- trigger to check if the volume of asset in market data is lower than the quantity of asset that has to be inserted in the transaction table
DELIMITER //
CREATE TRIGGER Trg_before_insert_transaction
BEFORE INSERT
ON transaction
FOR EACH ROW
BEGIN
	-- declare two variables for storing  MarketdataID and asset volume from market data and asset volume from userassets
    DECLARE market_volume INT;
    DECLARE market_id INT UNSIGNED;
    DECLARE userasset_volume INT;
    
    -- Get the corresponding market data id for the asset
    SELECT MarketdataID INTO market_id
    FROM MarketData
    WHERE AssetID = NEW.AssetID;
    

    -- Get the corresponding market data volume for the asset
    SELECT volume INTO market_volume
    FROM MarketData
    WHERE AssetID = NEW.AssetID;
    
    SELECT AssetQuantity INTO userasset_volume
    FROM userassets
    WHERE AssetID = NEW.AssetID and UserID = NEW.UserID;
    
	    

    -- Check if transaction quantity is greater than market volume
    IF NEW.quantity > market_volume AND NEW.TransactionType ='Buy'THEN
        -- Set am error message  when the volume of asset available is less
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Available Volume is low. Transaction not allowed.';
	ELSEIF NEW.quantity > userasset_volume AND NEW.TransactionType ='Sell'THEN
        -- Set am error message  when the volume of asset available is less
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Available Volume is low. Transaction not allowed.';
	
    -- Update MarketData based on TransactionType
    ELSEIF NEW.TransactionType = 'Buy' THEN
        -- Increase the quantity in MarketData for a Buy transaction
        UPDATE MarketData
        SET Volume = Volume - NEW.Quantity
        WHERE AssetID = NEW.AssetID and MarketdataID=market_id;
        
        IF NOT EXISTS (SELECT 1 FROM userassets WHERE UserID = NEW.UserID and AssetID= NEW.assetID) THEN
        -- Insert the record into Table A
			INSERT INTO userassets (UserID, PortfolioID, AssetID, AssetQuantity)
			VALUES (NEW.UserID, NEW.PortfolioID, NEW.AssetId,New.Quantity);
       
		ELSE
			UPDATE userassets
			SET AssetQuantity = AssetQuantity + NEW.Quantity
			WHERE AssetID = NEW.AssetID and UserID=NEW.UserID;
        
        END IF;
        
        
        
    ELSEIF NEW.TransactionType = 'Sell' THEN
        -- Decrease the quantity in MarketData for a Sell transaction
        UPDATE MarketData
        SET Volume = Volume + NEW.Quantity
        WHERE AssetID = NEW.AssetID and MarketdataID=market_id;
        
	 IF NOT EXISTS (SELECT 1 FROM userassets WHERE UserID = NEW.UserID and AssetID= NEW.assetID) THEN
        -- Insert the record into Table A
			INSERT INTO userassets (UserID, PortfolioID, AssetID, AssetQuantity)
			VALUES (NEW.UserID, NEW.PortfolioID, NEW.AssetId,New.Quantity);
       
		ELSE
			UPDATE userassets
			SET AssetQuantity = AssetQuantity - NEW.Quantity
			WHERE AssetID = NEW.AssetID and UserID=NEW.UserID;
        
        END IF;
    END IF;
END//
DELIMITER ;

INSERT INTO transaction (UserID, AssetID, PortfolioID, TransactionType, TransactionDate, Quantity, TransactionPrice, Commission, TotalAmount, Description)
	VALUES (1, 2003, 101, 'Buy','2023-11-20', 30, 20500.00, 10.00, 246210.00, 'Buying 30 shares of MCRSFT');
    
    
INSERT INTO transaction (UserID, AssetID, PortfolioID, TransactionType, TransactionDate, Quantity, TransactionPrice, Commission, TotalAmount, Description)
	VALUES (1, 2001, 101, 'Sell', '2023-01-15', 1, 5500.00, 3.00, 5615.00, 'Selling 1 shares of AAPL');
    
select * from userassets;
select* from marketdata;
select* from transaction;


-- -------------------------  Trigger to audit updates in bank detail  --------------------------------------



DELIMITER //
CREATE TRIGGER Trg_BankDetail_Update
AFTER UPDATE ON bankdetails
FOR EACH ROW
BEGIN

	IF  CHAR_LENGTH(NEW.AccountNumber)> 12 OR  CHAR_LENGTH(NEW.AccountNumber)< 8 THEN
        -- Set a message when the account number is less than 8 characters or 12 characters
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The length of the account number is not valid. It needs to be in the range between 8 and 12.';
	ELSE
		-- Insert the audit fields into the table bankdetails_Audit to record the changes
		INSERT INTO bankdetails_Audit VALUES(
			OLD.BankID,OLD.UserID,OLD.BankName,NEW.BankName,OLD.AccountNumber,NEW.AccountNumber,NOW());
			
END IF;
END//
DELIMITER ;

UPDATE bankdetails
SET AccountNumber = 34567891023
WHERE UserID = 1;

select * from bankdetails;
select * from bankdetails_Audit;
-- -----------Trigger to audit updates in market data table and update market price change in asset table --------------------------------------


DELIMITER //
CREATE TRIGGER trg_UpdateMarketValue
BEFORE UPDATE
ON MarketData FOR EACH ROW
BEGIN
	-- if the new market value of any asset is different than its old market value then update the market value in asset table 
    IF NEW.MarketPrice <> OLD.MarketPrice THEN
        UPDATE assets
        SET MarketValue = NEW.MarketPrice
        WHERE assets.AssetID = NEW.AssetID;
    END IF;
    --  Insert the updated records of the market data table into MarketData_Audit table
	INSERT INTO MarketData_Audit VALUES(
		OLD.MarketdataID,OLD.AssetID,OLD.MarketPrice,NEW.MarketPrice,OLD.Volume,NEW.Volume,OLD.OpeningPrice, OLD.ClosingPrice,NEW.OpeningPrice, NEW.ClosingPrice,NOW());
END//
DELIMITER ;

UPDATE MarketData SET MarketPrice = 8100.00 WHERE MarketdataID = 1001;

select * from MarketData;
select * from MarketData_Audit;
-- -------------------------  Trigger to audit updates in asset table  --------------------------------------



DELIMITER //
CREATE TRIGGER Trg_Asset_Update
AFTER UPDATE ON assets
FOR EACH ROW
BEGIN
    INSERT INTO Assets_Audit VALUES(
		OLD.AssetID,OLD.AssetName,OLD.AssetType,NEW.AssetName,NEW.AssetType,OLD.MarketValue,NEW.MarketValue,NOW());

END //  
DELIMITER ;
UPDATE assets
SET AssetType = "Equity",
AssetName = "Apple Inc."
WHERE AssetID = 2001;

select * from Assets_Audit;

-- -----------------Trigger to record the changes in the user table  -----------------


DELIMITER //
CREATE TRIGGER Trg_Audit_User_Update
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
	-- while updating the user record check for the length of the mobile number
    IF NEW.MobileNumber IS NOT NULL AND CHAR_LENGTH(NEW.MobileNumber) > 12 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Phone number exceeds the character limit.';
    END IF;

    -- Insert into audit table before update
    INSERT INTO users_audit (UserID, UserName, OldPassword,NewPassword, OldEmail, NewEmail,OldMobileNumber, NewMobileNumber, DateUpdated) 
    VALUES (OLD.UserID, OLD.UserName, OLD.Password,New.Password, OLD.Email,NEW.Email, OLD.MobileNumber, NEW.MobileNumber,NOW());
END;
//
DELIMITER ;

UPDATE users
SET Password = "Newpassword12"
WHERE UserId=1;
select * from users;
select * from users_audit;



-- --------------------------------------------FUNCTIONS---------------------------------------------------------------
-- stored function that calculates the total profit or loss for a given user and portfolio based on their investment history.
-- This function will take the userID and portfolioID as parameters and return the total profit or loss
-- Your CalculateTotalProfitLoss function appears to be well-defined for calculating the total profit or loss within a specific
-- user's portfolio. It sums up the total amount for sell transactions and subtracts the total amount for buy transactions.
DELIMITER //
CREATE FUNCTION CalculateTotalProfitLoss(userID INT, portfolioID INT) RETURNS DECIMAL(15, 2) READS SQL DATA
BEGIN
    DECLARE totalProfitLoss DECIMAL(15, 2);

    SELECT SUM(CASE WHEN TransactionType = 'Buy' THEN -TotalAmount ELSE TotalAmount END) INTO totalProfitLoss
    FROM transaction
    WHERE UserID = userID AND PortfolioID = portfolioID;

    RETURN totalProfitLoss;
END //

DELIMITER ;
-- In this function: We use a CASE statement to differentiate between buy and sell transactions,
--  as profit is calculated by subtracting the total amount for sell transactions.
-- The function sums up the total profit or loss for the specified user and portfolio.

SELECT CalculateTotalProfitLoss(1, 101);

-- Get User's Average Investment using stored functions 
-- This function will calculate the average investment amount per transaction for a specified user.

DELIMITER //

CREATE FUNCTION GetUserAverageInvestment(userID INT) RETURNS DECIMAL(15, 2) READS SQL DATA
BEGIN
    DECLARE averageInvestment DECIMAL(15, 2);

    SELECT AVG(TotalAmount) INTO averageInvestment
    FROM transaction
    WHERE UserID = userID;

    RETURN averageInvestment;
END //

DELIMITER ;


-- replace 1 with the actual user ID you're interested in.
--  This query will return the average investment amount for the specified user.
SELECT GetUserAverageInvestment(1);

-- stored function that retrieves the list of assets within a specific risk level for a given user's portfolio
-- This function can be useful if you want to analyze the composition of assets based on their risk levels.
DELIMITER //

CREATE FUNCTION GetAssetsByRiskLevel(userID INT, portfolioID INT, riskLevel VARCHAR(20)) RETURNS INT READS SQL DATA
BEGIN
    DECLARE assetCount INT;

    SELECT COUNT(ua.AssetID) INTO assetCount
    FROM userassets ua
    JOIN assets a ON ua.AssetID = a.AssetID
    WHERE ua.UserID = userID AND ua.PortfolioID = portfolioID AND a.RiskLevel = riskLevel;

    RETURN assetCount;
END //

DELIMITER ;

-- This function calculates and returns the count of assets within a specified risk level for a given user's portfolio. 
SELECT GetAssetsByRiskLevel(1, 101, 'Moderate');


-- stored function that calculates the total commission paid by a user for all transactions within a specific portfolio.

DELIMITER //

CREATE FUNCTION GetTotalCommissionForPortfolio(userID INT, portfolioID INT) RETURNS DECIMAL(15, 2) READS SQL DATA
BEGIN
    DECLARE totalCommission DECIMAL(15, 2);

    SELECT SUM(Commission) INTO totalCommission
    FROM transaction
    WHERE UserID = userID AND PortfolioID = portfolioID;

    RETURN totalCommission;
END //

DELIMITER ;

-- This function calculates the total commission paid by a user for all transactions within a specific portfolio

SELECT GetTotalCommissionForPortfolio(1, 101);


-- ----------------------------------------View: USER TRANSACTION HISTORY -------------------------------------------
CREATE VIEW user_transaction_history AS
SELECT
    t.TransactionID,
    t.UserID,
    t.PortfolioID,
    t.AssetID,
    a.AssetName,
    t.TransactionType,
    t.TransactionDate,
    t.Quantity,
    t.TransactionPrice,
    t.Commission,
    t.TotalAmount,
    t.Description
FROM
    transaction t
JOIN
    assets a ON t.AssetID = a.AssetID;
    
-- Example query to select data from the user_transaction_history view for a specific user
SELECT * FROM user_transaction_history WHERE UserID = 1;

    
    
-- ---------------------------View: USER INVESTMENT SUMMARY -------------------------------------

CREATE VIEW vw_UserInvestmentSummary AS
SELECT
    t.UserID,
    t.PortfolioID,
    t.AssetID,
    a.AssetName,
    t.Quantity,
    t.TransactionPrice AS PurchasePrice,
    acp.MarketPrice AS CurrentMarketPrice,
    (acp.MarketPrice - t.TransactionPrice) AS ProfitOrLossPerUnit,
    (acp.MarketPrice - t.TransactionPrice) * t.Quantity AS TotalProfitOrLoss,
    CASE
        WHEN (acp.MarketPrice - t.TransactionPrice) > 0 THEN 'You are in profit for this investment.'
        WHEN (acp.MarketPrice - t.TransactionPrice) < 0 THEN
            CASE
                WHEN (acp.MarketPrice - t.TransactionPrice) >= -5000 THEN 'Consider holding the investment.'
                WHEN (acp.MarketPrice - t.TransactionPrice) >= -10000 THEN 'Evaluate the market trends before making a decision.'
                ELSE 'It might be a good time to consider selling and cutting losses.'
            END
        ELSE 'No significant change in the market value.'
    END AS Summary
FROM
    transaction t
    
JOIN userassets ua ON t.UserID = ua.UserID AND t.PortfolioID = ua.PortfolioID AND t.AssetID = ua.AssetID
JOIN assets a ON t.AssetID = a.AssetID
JOIN (
    SELECT
        AssetID,
        MarketPrice,
        UpdateDate
    FROM AssetCurrentPrice acp1
    WHERE UpdateDate = (SELECT MAX(UpdateDate) FROM AssetCurrentPrice acp2 WHERE acp1.AssetID = acp2.AssetID)
) acp ON t.AssetID = acp.AssetID;

SELECT * FROM vw_UserInvestmentSummary Where Userid = 1;


   -- -------------------------  STORED PROCEDURE --------------------------------------
   
DELIMITER //

CREATE PROCEDURE InvestmentRecommendation(IN p_userID INT)
BEGIN
    DECLARE riskLevel VARCHAR(50);
    DECLARE shortTermPlan BOOLEAN;
    DECLARE longTermPlan BOOLEAN;
    DECLARE recommendationText TEXT;

    -- Get user's risk level, short-term plan status, and long-term plan status
    SELECT RiskLevel, Short_termplan, Long_termplan
    INTO riskLevel, shortTermPlan, longTermPlan
    FROM userplan
    WHERE UserID = p_userID;

    -- Investment recommendation logic
    IF shortTermPlan = TRUE AND longTermPlan = TRUE THEN
        SET recommendationText = 'Consider a balanced portfolio with both short-term and long-term investments.';
       
    ELSEIF shortTermPlan = TRUE THEN
        SET recommendationText = 'Consider low-risk short-term investment options.';
       
    ELSEIF longTermPlan = TRUE THEN
        SET recommendationText = 'Consider a diversified portfolio with a focus on long-term growth.';
       
    ELSE
        SET recommendationText = 'No investment plan is currently set.';
    END IF;

    -- Display recommendation
    SELECT recommendationText AS Recommendation;
END //

DELIMITER ;
CALL InvestmentRecommendation(3);

DELIMITER //

CREATE PROCEDURE SIP(IN p_userID INT)
BEGIN
    DECLARE userIncome DECIMAL(10, 2);
    DECLARE savingsAndInvestment DECIMAL(15, 2);
    DECLARE sipRecommendation TEXT;

    -- Get user's income
    SELECT Income INTO userIncome
    FROM userdemographics
    WHERE UserID = p_userID;

    -- Calculate 20% of the salary for savings and investment
    SET savingsAndInvestment = userIncome * 0.20;

    -- Recommend user to save and invest
    SET sipRecommendation = CONCAT('Consider saving and investing 20% of your salary, which is $', savingsAndInvestment);

    -- Display recommendation
    SELECT sipRecommendation AS Recommendation;
END //

DELIMITER ;
call SIP(2);

-- --------------------------------- Store procedure to get highest risk asset from user's profile --------------------------------

DELIMITER //

CREATE PROCEDURE GetHighestRiskAsset(
    IN p_UserID INT
)
BEGIN
    DECLARE highest_risk VARCHAR(20);
    DECLARE asset_name VARCHAR(255);

    -- Find the highest risk in the user's portfolio
    SELECT MAX(a.RiskLevel) INTO highest_risk
    FROM userassets ua
    JOIN assets a ON ua.AssetID = a.AssetID
    JOIN userportfolio up ON ua.PortfolioID = up.PortfolioID
    WHERE ua.UserID = p_UserID;

    -- Get the asset name with the highest risk
    SELECT a.AssetName INTO asset_name
    FROM userassets ua
    JOIN assets a ON ua.AssetID = a.AssetID
    JOIN userportfolio up ON ua.PortfolioID = up.PortfolioID
    WHERE ua.UserID = p_UserID AND a.RiskLevel = highest_risk
    LIMIT 1;

    -- Return the result
    SELECT asset_name AS HighestRiskAsset, highest_risk AS RiskLevel;
END //

DELIMITER ;

-- To retrieve information about the asset with the highest risk level in a specified user's portfolio
Call GetHighestRiskAsset(1);

Call GetHighestRiskAsset(11);




