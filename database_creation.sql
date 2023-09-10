CREATE database ldatta; 
CREATE TABLE ldatta.hoteldata (
    RestaurantID BIGINT PRIMARY KEY,
    RestaurantName VARCHAR(255),
    CountryCode INTEGER,
    City VARCHAR(255),
    Address VARCHAR(255),
    Locality VARCHAR(255),
    LocalityVerbose VARCHAR(255),
    Cuisines VARCHAR(255),
    Currency VARCHAR(255),
    Has_Table_booking VARCHAR(255),
    Has_Online_delivery VARCHAR(255),
    Is_delivering_now VARCHAR(255),
    Switch_to_order_menu VARCHAR(255),
    Price_range INTEGER,
    Votes INTEGER,
    Average_Cost_for_two INTEGER,
    Rating FLOAT
);

load data infile '\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Zomato_Dataset.csv'
into table ldatta.hoteldata
fields terminated by ','
enclosed by '"'
lines terminated by '\n';

