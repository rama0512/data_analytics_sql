# DATA EXPLORATION OF ZOMATO DATA SET AND DATA CLEANING 
use ldatta;
select * from hoteldata;
# finding all the colums and their data type in the table hoteldata
SELECT COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'hoteldata';

# finding duplicate
SELECT RestaurantID,COUNT(RestaurantID) as 'ui' 
FROM hoteldata
GROUP BY RestaurantID
order by RestaurantID desc;

#country code
select distinct(CountryCode)
from hoteldata;

#city column
select distinct(City)
from hoteldata
where City like ("%?%") or City like ("%&%");

#
select REPLACE(CITY,'?','i') FROM hoteldata WHERE CITY ='?stanbul' or CITY ='Bras?lia'; #temprary changes in the column 
#updating the city column with the replace proper names of the city which had ? in their name.
UPDATE hoteldata SET hoteldata.city=REPLACE(CITY,'?','i') where city="?stanbul" or CITY ='Bras?l?a';#proper permanent changes in the column when update function is used
UPDATE hoteldata SET hoteldata.city=REPLACE(CITY,'?','a') where city="S?o paulo" ;                     
select * from hoteldata
where CITY ='Brasilia' or city="istanbul" or city="Sao paulo";

#cuisines column
SELECT Cuisines, COUNT(Cuisines) FROM hoteldata
WHERE Cuisines IS NULL OR Cuisines = ' '
GROUP BY Cuisines;        #no null values

#currency column
SELECT Currency, COUNT(Currency) FROM hoteldata
GROUP BY Currency;

# yes/no columns
SELECT DISTINCT Has_Table_booking FROM hoteldata;
SELECT DISTINCT Has_Online_delivery FROM hoteldata;
SELECT DISTINCT Is_delivering_now FROM hoteldata;
SELECT DISTINCT Switch_to_order_menu FROM hoteldata;  #all are no 

#removing Switch_to_order_menu
ALTER TABLE hoteldata DROP COLUMN Switch_to_order_menu;

# price_range column
select distinct(price_range)
from hoteldata;

#votes column
select min(votes), max(votes), avg(votes) from hoteldata;

#rating 
select min(rating),max(rating),round(avg(rating),1)
from hoteldata;

#adding verrating to categorise the rating that lies within a specific data range
alter table hoteldata add column verrating varchar(255);

#
UPDATE hoteldata SET verrating = (case
when rating >=1.0 and rating <2.5 then 'POOR'
WHEN rating >=2.5 and rating <3.5 then 'GOOD'
WHEN rating >=3.5 and rating <4.5 then 'GREAT'
WHEN rating >=4.5 then 'EXCELLENT'
END);

select * from hoteldata;









