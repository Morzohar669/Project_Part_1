SELECT HighestPerLocation.Location, Symbol, MaxPrice
FROM HighestPerLocation, HighestStocksOfCompaniesInIndustrialCountries
WHERE (HighestPerLocation.MaxOfCountry = HighestStocksOfCompaniesInIndustrialCountries.MaxPrice)
   AND (HighestPerLocation.Location = HighestStocksOfCompaniesInIndustrialCountries.Location)
ORDER BY Location ASC;








