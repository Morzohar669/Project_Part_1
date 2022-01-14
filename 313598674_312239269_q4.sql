SELECT GlamorousCompany.Symbol AS Symbol , Sector , ProfitPercentage AS Yield
FROM ProfitPercentage,GlamorousCompany
WHERE GlamorousCompany.Symbol = ProfitPercentage.Symbol
ORDER BY ProfitPercentage DESC;








