CREATE TABLE Investor(
    ID INT PRIMARY KEY ,
    Name VARCHAR(100),
    BirthDate DATE,
    Email VARCHAR(100) UNIQUE ,
    RegistrationDate DATE,
    CHECK (YEAR(BirthDate) > 2004)
);

CREATE TABLE Premium(
    ID_Premium INT PRIMARY KEY ,
    Financial_Goal VARCHAR(100),
    RegistrationDate DATE,
    FOREIGN KEY (ID_Premium) REFERENCES Investor(ID),
    FOREIGN KEY (RegistrationDate) REFERENCES Investor(RegistrationDate),
    CHECK (MONTH(GETDATE()) - MONTH(RegistrationDate) > 12)
);

CREATE TABLE Lawyer(
    ID_Lawyer INT PRIMARY KEY ,
    Specialization VARCHAR(100),
    FOREIGN KEY (ID_Lawyer) REFERENCES Premium(ID_Premium)

);

CREATE TABLE Economist(
    ID_Economist INT PRIMARY KEY ,
    Specialization VARCHAR(100),
    FOREIGN KEY (ID_Economist) REFERENCES Premium(ID_Premium)

);

CREATE TABLE Beginner(
    ID_Beginner INT PRIMARY KEY ,
    ID_Guide INT,
    RegistrationDate DATE,
    FOREIGN KEY (ID_Beginner) REFERENCES Investor(ID),
    FOREIGN KEY (ID_Guide) REFERENCES Economist(ID_Economist),
    FOREIGN KEY (RegistrationDate) REFERENCES Investor(RegistrationDate),
    CHECK (MONTH(GETDATE()) - MONTH(RegistrationDate) < 3)
);

CREATE TABLE Transactions(
    Transaction_Date DATE PRIMARY KEY ,
    ID_Investor INT PRIMARY KEY ,
    Amount INT,
    FOREIGN KEY (ID_Investor) REFERENCES Investor(ID),
    CHECK (Amount > 1000)
);

CREATE TABLE Suspicious_Transactions(
    Transaction_Date DATE PRIMARY KEY ,
    ID_Investor INT PRIMARY KEY ,
    ID_Lawyer INT PRIMARY KEY ,
    Decision VARCHAR(100),
    FOREIGN KEY (ID_Investor) REFERENCES Investor(ID),
    FOREIGN KEY (ID_Lawyer) REFERENCES Lawyer(ID_Lawyer),
    FOREIGN KEY (Transaction_Date) REFERENCES Transactions(Transaction_Date)

);

CREATE TABLE Companies(
    Symbol VARCHAR(100) PRIMARY KEY ,
    Founded DATE,
    Location VARCHAR(100),
    Sector VARCHAR(100),
);

CREATE TABLE Rivalry(
    Symbol1 VARCHAR(100) PRIMARY KEY,
    Symbol2 VARCHAR(100) PRIMARY KEY,
    Cause VARCHAR(100),
    FOREIGN KEY (Symbol1) REFERENCES Companies(Symbol),
    FOREIGN KEY (Symbol2) REFERENCES Companies(Symbol),
    CHECK(Rivalry.Symbol1 > Rivalry.Symbol2)
);

CREATE TABLE Reviews(
    Symbol1 VARCHAR(100) PRIMARY KEY,
    Symbol2 VARCHAR(100) PRIMARY KEY,
    ID_Reviewer INT,
    FOREIGN KEY (Symbol1) REFERENCES Companies(Symbol),
    FOREIGN KEY (Symbol2) REFERENCES Companies(Symbol),
    FOREIGN KEY (ID_Reviewer) REFERENCES Economist(ID_Economist)
);

CREATE TABLE Stocks(
    Issued_Date DATE PRIMARY KEY ,
    cSymbol VARCHAR(100) PRIMARY KEY ,
    Price INT,
    FOREIGN KEY (cSymbol) REFERENCES Companies(Symbol)
);

CREATE TABLE Purchases(
    Issued_Date DATE PRIMARY KEY ,
    cSymbol VARCHAR(100) PRIMARY KEY ,
    ID_Investor INT PRIMARY KEY ,
    Amount INT,
    FOREIGN KEY (cSymbol) REFERENCES Stocks(cSymbol),
    FOREIGN KEY (Issued_Date) REFERENCES Stocks(Issued_Date),
    FOREIGN KEY (ID_Investor) REFERENCES Investor(ID)
);
