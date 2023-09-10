#DATA ANALYSIS OF ZOMATO DATASET
use ldatta;
select * from hoteldata;

#ROLLING/MOVING COUNT OF RESTAURANTS IN INDIAN CITIES
SELECT COUNTRYCODE,City,Locality,COUNT(Locality),
SUM(COUNT(Locality)) OVER(PARTITION BY City ORDER BY Locality DESC)
FROM hoteldata
WHERE COUNTRYCODE = 1
GROUP BY  COUNTRYCODE,City,Locality;

SELECT city,locality,count(locality),sum(COUNT(Locality)) OVER(PARTITION BY City ORDER BY Locality DESC)
FROM hoteldata
WHERE COUNTRYCODE = 1
group by city,locality;

#SEARCHING FOR PERCENTAGE OF RESTAURANTS IN ALL THE COUNTRIES
select countrycode,count(countrycode)/(select count(*) from hoteldata)
from hoteldata
group by countrycode;

#WHICH COUNTRIES AND HOW MANY RESTAURANTS WITH PERCENTAGE PROVIDES ONLINE DELIVERY OPTION
select countrycode,count(has_online_delivery='Yes')
from hoteldata
where has_online_delivery='Yes'
group by countrycode;

#FINDING FROM WHICH CITY AND LOCALITY IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
with ct1 as (select city,locality,count(restaurantid) as 'hotels_in_area'
from hoteldata
where countrycode=1
group by city,locality)
SELECT city,locality,hotels_in_area FROM ct1 WHERE hotels_in_area = (SELECT MAX(hotels_in_area) FROM ct1);

#TYPES OF FOODS ARE AVAILABLE IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
with 
ct1 as (select city,locality,count(restaurantid) as 'hotels_in_area'
from hoteldata
where countrycode=1
group by city,locality),
ct2 as (select city,locality,hotels_in_area from ct1 WHERE hotels_in_area = (SELECT MAX(hotels_in_area) FROM ct1)),
ct3 AS (SELECT restaurantid,Locality,Cuisines FROM hoteldata)
select *
FROM CT2 A  JOIN CT3 B 
ON A.Locality = B.Locality;

#HOW MANY RESTAURANTS OFFER TABLE BOOKING OPTION IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
with
ct1 as (select city,locality,count(restaurantid) as 'hotels_in_area'
from hoteldata
where countrycode=1
group by city,locality),
ct2 as (select city,locality,hotels_in_area from ct1 WHERE hotels_in_area = (SELECT MAX(hotels_in_area) FROM ct1)),
ct3 AS (SELECT restaurantid,has_table_booking,Locality,Cuisines FROM hoteldata)
select count(*) 
FROM CT2 A  JOIN CT3 B 
ON A.Locality = B.Locality
where has_table_booking='Yes';

#HOW RATING AFFECTS IN MAX LISTED RESTAURANTS WITH AND WITHOUT TABLE BOOKING OPTION (Connaught Place)
with ct1 as (select city,locality,count(restaurantid) as 'hotels_in_area'
from hoteldata
where countrycode=1
group by city,locality)

SELECT 'has table booking option',COUNT(Has_Table_booking) , ROUND(AVG(Rating),2) as 'AVG_RATING'
FROM hoteldata
WHERE Has_Table_booking = 'YES'
AND Locality = (SELECT locality FROM ct1 WHERE hotels_in_area = (SELECT MAX(hotels_in_area) FROM ct1))
union
SELECT 'no table booking option',COUNT(Has_Table_booking) , ROUND(AVG(Rating),2) as'AVG_RATING'
FROM hoteldata
WHERE Has_Table_booking = 'NO'
AND Locality = (SELECT locality FROM ct1 WHERE hotels_in_area = (SELECT MAX(hotels_in_area) FROM ct1));


#AVG RATING OF RESTS LOCATION WISE
select city,locality,count(restaurantid),round(avg(rating),2) as 'avg_rating'
from hoteldata
where countrycode=1 and locality != 'Connaught Place'
group by city,locality;

#FINDING THE BEST RESTAURANTS WITH MODRATE COST FOR TWO IN INDIA HAVING INDIAN CUISINES
SELECT *
FROM hoteldata
WHERE COUNTRYCODE = 1
AND Has_Table_booking = 'YES'
AND Has_Online_delivery = 'YES'
AND Price_range <= 3
AND Votes > 1000
AND Average_Cost_for_two < 1000
AND Rating > 4.00
AND Cuisines LIKE '%INDIA%';








