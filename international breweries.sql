create database International_Breweries;

create table breweries_sales_data (
Sales_id int,
Sales_Rep varchar,
Emails varchar,
Brands varchar,
Plant_Cost int,
Unit_Price int,
Quantity int,
Cost int,
Profit int,
Countries text,
Region text,
Months varchar,
Years int
);


COPY Breweries_sales_data 
FROM 'C:\Users\ADMIN\Downloads\International_Breweries.csv'
DELIMITER ',' CSV 
HEADER;

select * from breweries_sales_data


--Session A
--PROFIT ANALYSIS

--1. Within the space of the last three years, what was the profit worth of the breweries,
--inclusive of the anglophone and the francophone territories?

select sum(profit) as profit_worth from breweries_sales_data

--2. Compare the total profit between these two territories in order for the territory manager,
--Mr. Stone made a strategic decision that will aid profit maximization in 2020.

select distinct countries from breweries_sales_data

select case
when (countries = 'Ghana' or countries = 'Nigeria') then 'Anglophone'
else 'Francophone'
end as territory,
sum (profit) as total_profit from breweries_sales_data
group by 1
order by 2


--3. Country that generated the highest profit in 2019

select countries, sum(profit) as profit, years as year from breweries_sales_data
where years = 2019
group by 1, 3
order by 2 desc
limit 1


--4. Help him find the year with the highest profit.

select years as year, sum(profit) as highest_profit from breweries_sales_data
group by 1
order by 2 desc
limit 1

--5. Which month in the three years was the least profit generated?

select (months) as month, years as year, sum(profit) as least_profit from breweries_sales_data
group by 1, 2
order by 3
limit 1


--6. What was the minimum profit in the month of December 2018?

select months, years, min(profit) as profit from breweries_sales_data
where years = 2018 and months = 'December'
group by 1,2 

--7. Compare the profit in percentage for each of the month in 2019

select months, sum(profit) * 100/sum(cost) as profit_percentage from breweries_sales_data
where years = 2019
group by 1
order by 2 desc

--8. Which particular brand generated the highest profit in Senegal?

select brands, sum(profit), countries from breweries_sales_data
where countries = 'Senegal'
group by 1, 3
order by 2 desc
limit 1


--Session B
--BRAND ANALYSIS
--1. Within the last two years, the brand manager wants to know the top three brands
--consumed in the francophone countries 

select brands, sum(quantity) as Quantity_consumed from breweries_sales_data
where years in ('2018', '2019')
and countries in ('Senegal', 'Togo', 'Benin')
group by 1 
order by 2 desc
limit 3


--2. Find out the top two choice of consumer brands in Ghana

select brands, sum(quantity) as Quantity_consumed from breweries_sales_data
where countries in ('Ghana')
group by 1
order by 2 desc
limit 2


--3. Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa.

select brands as beers, sum(quantity) as Quantity_consumed, countries from breweries_sales_data
where not brands like '%malt%'
and countries = 'Nigeria'
group by 1, 3
order by 2 desc

--4. Favorites malt brand in Anglophone region between 2018 and 2019

select brands, sum(quantity)as brand_consumption from breweries_sales_data
where brands like '%malt%'
and years in ('2018', '2019')
and countries in ('Ghana', 'Nigeria')
group by 1
order by 2 desc
limit 1


--5. Which brands sold the highest in 2019 in Nigeria?

select brands, sum(quantity) as Quantity_sold from breweries_sales_data
where years = 2019
and countries = 'Nigeria'
group by 1
order by 2 desc
limit 3


--6. Favorites brand in South_South region in Nigeria

select brands, sum(quantity) as Quantity_consumed from breweries_sales_data
where countries in ('Nigeria')
and region = 'southsouth'
group by 1
order by 2 desc
limit 3

--7. Bear consumption in Nigeria

select brands as Beer, sum(quantity) as Quantity_consumed from breweries_sales_data
where brands not like '%malt%'
and countries in ('Nigeria')
group by 1
order by 2 desc


--8. Level of consumption of Budweiser in the regions in Nigeria

select brands, region, sum(quantity) as Quantity_consumed from breweries_sales_data
where brands = 'budweiser'
and countries in ('Nigeria')
group by 1, 2
order by 3 desc

--9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)

select brands, region, years, sum(quantity) as Quantity_consumed from breweries_sales_data
where brands = 'budweiser'
and countries in ('Nigeria')
and years = 2019
group by 1, 2, 3
order by 4 desc


--Session C
--COUNTRIES ANALYSIS

--1. Country with the highest consumption of beer.

select countries, brands as Beer, sum(quantity) as Quantity_consumed from breweries_sales_data
where brands not like '%malt%'
group by 1, 2
order by 3 desc
limit 1


--2. Highest sales personnel of Budweiser in Senegal

select sales_Rep, brands, sum(quantity) as Budweiser_sold from breweries_sales_data
where countries = 'Senegal'
and brands = 'budweiser'
group by 1, 2
order by 3 desc
limit 1

--3. Country with the highest profit of the fourth quarter in 2019

select countries, sum(profit) as profit from breweries_sales_data
where years = 2019
and months in ('October', 'November', 'December') 
group by 1
order by 2 desc
limit 1
																		
																		