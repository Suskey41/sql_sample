 
 --basic query --table structure for customer--


 
 CREATE TABLE customer (
   id serial  not null,
    first_name varchar (20) not null,
	 last_name varchar (20) not null,
	   email_address varchar (20) not null,
	    phone varchar (20) not null,
	 primary key (id)
   );
		
		--dumping data for table customer
		
		INSERT INTO customer
		 (id,first_name,last_name,email_address,phone)
		 
		   VALUES
		      (1,'Linda','Franklin','Linda@gmail.com',07096594372),
		         (2,'Ben','Adam','Ben@yahoo.com',090234956877),
				  (3,'John','Williams','John@gmail.com',08069547384),
				    (4,'Rejoice','Adam','Rejoice@yahoo.com',07065843562),
				       (5,'Deric','Raymod','Deric@yahoo.com',09023456978),
				  (6,'Kate','Everest','Kate@gmail.com',08045639456),
				(7,'Ken','Adam','Ken@gmail.com',07069548340),
			(8,'David','Samuel','David@gmail.com',09023485679),
			   (9,'James','Jude','James@yahoo.com',08086593845),
				  (10,'Ruth','Benz','Ruth@gmail.com',08034928020);
		
	--table structure for payment	

		
		
     CREATE TABLE payment
  (
   id serial not null,
     customer_id int not null,
	  subscription_type varchar (20) not null,
       subscription_medium varchar (20) not null,
	  actual_price numeric,
        discount_price numeric , 
        payment_date timestamp not null,
	     country varchar (20) not null,
	  primary key (id)
   );
		 
		
		
		 --dumping data for table payment 
	  
	  
	   INSERT INTO payment
	(id,customer_id,subscription_type,subscription_medium,actual_price,
	 discount_price,payment_date,country)
		
		VALUES
		(1,1,'Basic','Website',3500,0.2,'2023-06-03','Nigeria'),
		  (2,2,'Premium','Website',5000,0.2,'2023-06-05','Nigeria'),
		    (3,3,'Basic','APP',3500,0.2,'2023-06-10','Nigeria'),
			  (4,4,'Standard','APP',4200,0.2,'2023-06-12','Ghana'),
			    (5,5,'Basic','Website',3500,0.2,'2023-06-20','Nigeria'),
				  (6,6,'Premium','APP',5000,0.2,'2023-06-22','Ghana'),
				    (7,7,'Basic','Website',3500,0.2,'2023-06-25','Nigeria'),
				(8,8,'Basic','APP',3500,0.2,'2023-06-27','Nigeria'),
			(9,9,'Standard','APP',4200,0.2,'2023-06-27','South_Africa'),
		(10,10,'Basic','APP',3500,0.2,'2023-06-29','Nigeria');
		
		
		--constraint for table customer
		
		ALTER TABLE customer
		
	ADD UNIQUE (email_address); 
	
	--constraint for table payment
	
	ALTER TABLE payment
	
	 ADD CONSTRAINT "fk_customer_id"
	 FOREIGN KEY ("customer_id")
	 REFERENCES "customer" ("id");
	 
     
	 --update discount_price column with price after 20% discount 

     UPDATE payment
	 SET discount_price  = (actual_price - actual_price * discount_price);
	 
	 --how amny customers subscribed in the month of june?
	 
	 SELECT COUNT(*) FROM customer
	 
    --how many customers subscribed with 4000 or more and what country ?
	
	SELECT COUNT(customer_id),country,discount_price AS cal_discount_price
	             FROM payment 
				 WHERE discount_price >=4000
				 GROUP BY cal_discount_price, country;
				 
				 
	--list the first 5 customers to subscribe. return customer's name,email,country, and payment date.
	
	SELECT DISTINCT (customer_id),first_name,last_name,email_address,Country,payment_date
	FROM customer
	LEFT JOIN payment ON payment.customer_id = customer. id
	ORDER BY customer_id ASC
	LIMIT 5;
	
	
	--how many subscribers are from Ghana subscribers
	
	SELECT COUNT(*) FROM payment
	
	WHERE country LIKE '%Ghana'
	
	
	 
   --What meduim was least used  for payment
   
  
   SELECT DISTINCT subscription_medium,COUNT(*)  FROM payment
   
    GROUP BY subscription_medium
	
	ORDER BY COUNT ASC
	LIMIT 1;
   
   
   -- list customer id's with discount price = 2800 (subquery)
   
    
	
	
	
	
	 
  
   
   
		 
		
		
		
		
		
		
		

		
		  
	
   
	  
	  
	   
   
   