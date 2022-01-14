-- view question 3
CREATE VIEW OldCompanies
AS
SELECT *
FROM Company
WHERE Founded < 1990;


CREATE VIEW OldCompaniesCounter
AS
SELECT Location, count(*) AS Numcompaniesinlocation
FROM OldCompanies
GROUP BY Location;


CREATE VIEW IndustrialCountry
AS
SELECT Location
FROM OldCompaniesCounter
WHERE Numcompaniesinlocation > 5;


CREATE VIEW CompanyInIndustrialCountries
AS
SELECT Company.*
FROM Company,
     IndustrialCountry
WHERE Company.Location = IndustrialCountry.Location;


CREATE VIEW HighestStocksOfCompanies
AS
SELECT Symbol, MAX(Price) AS MaxPrice
FROM Stock
GROUP BY Symbol;


CREATE VIEW HighestStocksOfCompaniesInIndustrialCountries
AS
SELECT CompanyInIndustrialCountries.Symbol, CompanyInIndustrialCountries.Location, HighestStocksOfCompanies.MaxPrice
FROM HighestStocksOfCompanies,
     CompanyInIndustrialCountries
WHERE (HighestStocksOfCompanies.Symbol = CompanyInIndustrialCountries.Symbol);


CREATE VIEW HighestPerLocation
AS
SELECT Location, MAX(MaxPrice) AS MaxOfCountry
FROM HighestStocksOfCompaniesInIndustrialCountries
GROUP BY Location;

-- view question 4
CREATE VIEW Comparison
AS
SELECT S1.Symbol AS Symbol  , S1.Price AS LowerPrice , S2.Price AS HigherPrice
FROM Stock S1 ,Stock S2
WHERE S1.Symbol = S2.Symbol AND S1.tDate < S2.tDate;

CREATE VIEW AllSymbols
AS
SELECT Symbol
FROM Stock
GROUP BY Symbol;

CREATE VIEW ImprovedCompany
AS
SELECT *
FROM AllSymbols
EXCEPT
SELECT Symbol
FROM Comparison
WHERE LowerPrice >= Comparison.HigherPrice
GROUP BY Symbol;

CREATE VIEW ImprovedCompanyWithSector
AS
SELECT Company.Symbol, Company.Sector
FROM Company , ImprovedCompany
WHERE Company.Symbol = ImprovedCompany.Symbol
GROUP BY Company.Symbol ,Company.Sector;

CREATE VIEW NumberOfImprovedCompaniesInSector
AS
SELECT Sector, COUNT(*) AS NUM
FROM ImprovedCompanyWithSector
GROUP BY Sector;


CREATE VIEW GlamorousCompany
AS
SELECT Symbol , ImprovedCompanyWithSector.Sector AS Sector
FROM NumberOfImprovedCompaniesInSector , ImprovedCompanyWithSector
WHERE NUM = 1 AND ImprovedCompanyWithSector.Sector = NumberOfImprovedCompaniesInSector.Sector;

CREATE VIEW MaxDate
AS
SELECT Stock.Symbol , MAX(tDate) AS LastDate
FROM Stock , GlamorousCompany
WHERE Stock.Symbol = GlamorousCompany.Symbol
GROUP BY Stock.Symbol;

CREATE VIEW MaxPrice
AS
SELECT Stock.Symbol AS Symbol, Price, LastDate
FROM Stock , MaxDate
WHERE MaxDate.Symbol = Stock.Symbol AND tDate = LastDate;

CREATE VIEW MinDate
AS
SELECT Stock.Symbol,  Min(tDate) AS firstDate
FROM Stock , GlamorousCompany
WHERE Stock.Symbol = GlamorousCompany.Symbol
GROUP BY Stock.Symbol;

CREATE VIEW MinPrice
AS
SELECT Stock.Symbol AS Symbol, Price, firstDate
FROM Stock , MinDate
WHERE MinDate.Symbol = Stock.Symbol AND tDate = firstDate;

CREATE VIEW ProfitPercentage
AS
SELECT MinPrice.Symbol, ROUND(((MaxPrice.Price - MinPrice.Price) * 100 / MinPrice.Price),3) AS ProfitPercentage
FROM MinPrice, MaxPrice
WHERE MaxPrice.Symbol = MinPrice.Symbol;
