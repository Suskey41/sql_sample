-- Database: Housing

-- DROP DATABASE IF EXISTS "Housing";

CREATE DATABASE "Housing"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;



-- Create  Database Housing
  
  CREATE DATABASE Housing ;
  
-- Table Structure For Housing
  
  CREATE TABLE housing 
  
  (
  price INT NOT NULL,
   area VARCHAR (20) NOT NULL,
    bedrooms INT NOT NULL,
     bathroom INT NOT NULL,
      stories INT NOT NULL,
       mainroad VARCHAR (20) NOT NULL,
        guestroom VARCHAR (10) NOT NULL,
         basement VARCHAR (10) NOT NULL,
        hotwaterheater VARCHAR (10),
      airconditioning VARCHAR (10) NOT NULL,
     parking INT NOT NULL,
    prefarea VARCHAR (10) NOT NULL,
  furnishingstatus VARCHAR (20)
  ) ;


/* Importing A CSV File from Kaggle Called Housing 
 To Populate Table Housing*/

--Creating Table Customer
	
	CREATE TABLE customer
	 (
	           id SERIAL PRIMARY KEY,
	         first_name VARCHAR (20) NOT NULL,
	       last_name VARCHAR (20) NOT NULL,
	     email_address VARCHAR (20) NOT NULL,
	 phone VARCHAR (20) NOT NULL,
  date TIMESTAMP NOT NULL
		
	  ) ;
	
-- Dumping Data For Customer

    INSERT INTO customer
  
                (id,first_name,last_name,email_address,phone,date)
 
    VALUES
      
	  (
		
	           1,'Linda','Franklin','Linda@gmail.com',07096594372,'2023-06-03'),
		     (2,'Ben','Adam','Ben@yahoo.com',090234956877,'2023-06-12'),
		    (3,'John','Williams','John@gmail.com',08069547384,'2023-06-06'),
		   (4,'Rejoice','Adam','Rejoice@yahoo.com',07065843562,'2023-06-06'),
		  (5,'Deric','Raymod','Deric@yahoo.com',09023456978,'2023-06-10'),
		 (6,'Kate','Everest','Kate@gmail.com',08045639456,'2023-06-19'),
		(7,'Ken','Adam','Ken@gmail.com',07069548340,'2023-06-13'),
		 (8,'David','Samuel','David@gmail.com',09023485679,'2023-06-18'),
		  (9,'James','Jude','James@yahoo.com',08086593845,'2023-06-03'),
		   (10,'Ruth','Benz','Ruth@gmail.com',08034928020,'2023-06-04'),
		    (11,'Kelvin','muth','Kelvin@gmail.com',08034928010,'2023-06-04'),
			 (12,'Lizzy','John','Lizzy@gmail.com',07034928020,'2023-06-02'
				  
		 ) ;
  
-- Table Structure Agent
  
    CREATE TABLE Agent
  
      (
	  
    id SERIAL PRIMARY KEY,
    first_name VARCHAR (20) NOT NULL,
    last_name VARCHAR (20) NOT NULL,
    email_address VARCHAR (20) NOT NULL
	  
     ) ;

-- Dumping Data For Agent Table

    INSERT INTO Agent
 
    (id,first_name,last_name,email_address)
 
    VALUES
  
    (
	 1,'Mark','Joseph','Mark@gmail.com'),
      (2,'Mary','Jane','Mary@gmail.com'),
    (4,'Anthony','Williams','Anthony@gmail.com'),
   (5,'Treasure','Owen','Tresure@gmail.com'
 
     ) ;
 
 
 --Create Table Sales
 
 
     CREATE TABLE Sales 
 
    ( 
	id SERIAL PRIMARY KEY NOT NULL,
      customer_id INT NOT NULL,
       Agent_id INT NOT NULL,
        House_id INT NOT NULL,
         price INT NOT NULL

     ) ;

      ALTER TABLE sales RENAME price TO sold_price ;

--Dumping Data For Sales

 
      INSERT INTO Sales
     (id,customer_id,agent_id,house_id,price)
 
      VALUES
 
    (
	 1,3,2,120,5950000),
      (2,5,5,399,3500000),
       (3,10,2,67,6930000),
        (4,1,1,54,7350000),
         (5,4,1,320,4060000),
          (6,2,4,469,3010000),
           (7,6,2,358,3773000),
            (8,8,4,291,4200000),
           (9,7,2,43,7700000),
          (10,9,1,20,8855000),
         (11,12,2,35,8120000),
       (12,11,4,512,2520000
    
      ) ;


 -- Add Constriant Housing
 
       ALTER TABLE HOUSING

       ADD COLUMN id SERIAL PRIMARY KEY ;
 
 
 --Add Constriant Customer
 
       ALTER TABLE customer
 
       ADD UNIQUE (email_address) ;
 
 
       ALTER TABLE Agent
 
       ADD UNIQUE (email_address) ;
 
 --Add Constriant For Sales Table
 
       ALTER TABLE Sales
 
 
	   ADD CONSTRAINT "fk_customer_id"
	   FOREIGN KEY ("customer_id")
	   REFERENCES "customer" ("id") ;
	 
	 
	   ALTER TABLE Sales 
	 
	   ADD CONSTRAINT "fk_agent_id"
	   FOREIGN KEY ("agent_id")
	   REFERENCES "agent" ("id") ;
	 
	   ALTER TABLE Sales
	
	   ADD CONSTRAINT "fk_house_id"
	   FOREIGN KEY ("house_id")
	   REFERENCES "housing" ("id") ;


-- Count Total House Listings

       SELECT COUNT (*) FROM housing ;
  
--Count Distinct Areas Of Listing
  
       SELECT COUNT(DISTINCT area) FROM housing ;
  
-- What Is The Most Expensive House Listed
  
       SELECT MAX(PRICE) FROM housing ;
  
/* SELECT Areas With No Mainroad, With Price Less Than 10000000
  Where House Is Unfurnished*/
  
      SELECT price FROM housing
      WHERE price <10000000
      AND furnishingstatus = 'unfurnished'
      AND (mainroad) = 'no'
  
      GROUP BY price
      ORDER BY price DESC ;
  
-- List The 10 Top Prefered Areas To Live
  
     SELECT area,prefarea FROM housing
     WHERE prefarea = 'yes'
     LIMIT 10 ;
  
--/* What Is The Average Price For A 3 And 2 Bedroom  Unfurnished Where Price Is Less Than 
5000000

	
	  SELECT round(AVG(price),0)AS Avg_price FROM housing
	
	  WHERE bedrooms IN (3,2)
	  AND furnishingstatus = 'unfurnished'
	
	  GROUP BY price 
	
	  HAVING price <5000000
	  ORDER BY Avg_price DESC ;
	
	
--What Agent Had The Higest Sale And Total.
	
	
	  SELECT DISTINCT (agent_id), SUM(sold_price) AS total_price FROM sales 
	  GROUP BY agent_id
	
	  ORDER BY total_price DESC 
	  LIMIT 1 ;
	
	
--/* Which Customer Made The Highest Purchase. List Customer Name, Area, Sold Price, And Date/*  

      SELECT first_name,last_name,sold_price,area,date FROM customer 
 
      INNER JOIN SALES 

      ON sales.id = customer.id 

      INNER JOIN housing
      ON customer.id = housing.id

      ORDER BY sold_price DESC 
      LIMIT 1 ;

--Rank The Top 10 Areas With The Highest Pricing.
 
     SELECT price,area,  
  
     RANK () OVER (ORDER BY PRICE DESC) area_rank
  
     FROM housing
  
     LIMIT 10 ;
  
--Categorize Price By Status From High To Low.
  
     SELECT price,
  
     CASE
  
     WHEN PRICE > 11000000 THEN 'high'
     WHEN price <= 5000000 THEN 'low'
   
     ELSE 'standard'
   
     END
  
     AS price_status
  
     FROM housing ;
  

--What Are The  Percentages By Total Sales For Each Customer Respectively? 


     SELECT customer_id,COUNT (*),round (sold_price *100.0/ SUM (sold_price) 
     OVER (),2) AS percentage 
     FROM sales

     GROUP BY customer_id, sold_price

     ORDER BY percentage DESC ;






											   
											   



