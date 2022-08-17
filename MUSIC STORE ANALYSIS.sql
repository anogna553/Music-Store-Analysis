/* City with best customers*/
SELECT customer.city,SUM(total) AS total_amount FROM customer
INNER JOIN invoice 
ON invoice.customerid = customer.customerid
GROUP BY customer.city
ORDER BY SUM(total) DESC
LIMIT 1;

/*Country with maximum number of Invoices */
SELECT customer.country,count(invoice.invoiceid) AS total_invoices FROM customer
INNER JOIN invoice 
ON invoice.customerid = customer.customerid
GROUP BY customer.country
ORDER BY count(invoice.invoiceid) DESC
LIMIT 1;

/*most popular genre*/
SELECT genre.name,COUNT(genre.name) AS albums_sold FROM track
INNER JOIN genre
ON genre.genreid = track.genreid
GROUP BY genre.name
ORDER BY COUNT(genre.name) DESC
LIMIT 15;


/* Name of Best customer */
SELECT customer.firstname || ' '|| customer.lastname AS best_customer,SUM(total) AS customer_total FROM customer
INNER JOIN invoice 
ON invoice.customerid = customer.customerid
GROUP BY customer.firstname || ' '|| customer.lastname
ORDER BY SUM(total)  DESC
LIMIT 1; 

/* Analized the city with most rock music listeners and Finalized city to conduct Rock concert which gives profit  */
SELECT customer.city ,COUNT(genre.name) AS numof_genre_concerts FROM customer
INNER JOIN invoice
ON invoice.customerid = customer.customerid
INNER JOIN invoiceline 
ON invoiceline.invoiceid = invoice.invoiceid
INNER JOIN track 
ON track.trackid = invoiceline.trackid
INNER JOIN genre
ON genre.genreid = track.genreid
WHERE genre.name = 'Rock'
GROUP BY customer.city
ORDER BY COUNT(genre.name) DESC
LIMIT 1;

/* If you want to know which artists the store should invite,
   find out who is the highest-paid and most-listened-to. */
SELECT artist.name AS artist_name,SUM(invoiceline.unitprice) AS total_paid ,COUNT(DISTINCT(customer.customerid)) AS num_of_listeners FROM customer
INNER JOIN invoice
ON invoice.customerid = customer.customerid
INNER JOIN invoiceline 
ON invoiceline.invoiceid = invoice.invoiceid
INNER JOIN track 
ON track.trackid = invoiceline.trackid
INNER JOIN album
ON album.albumid = track.albumid
INNER JOIN artist
ON album.artistid = artist.artistid
GROUP BY artist.name
ORDER BY COUNT(DISTINCT(customer.customerid)) DESC
LIMIT 1;

/* Solution 2 */
SELECT artist.name AS artist_name,track.genreid,COUNT(DISTINCT(customer.customerid))  FROM customer
INNER JOIN invoice
ON invoice.customerid = customer.customerid
INNER JOIN invoiceline 
ON invoiceline.invoiceid = invoice.invoiceid
INNER JOIN track 
ON track.trackid = invoiceline.trackid
INNER JOIN album
ON album.albumid = track.albumid
INNER JOIN artist
ON album.artistid = artist.artistid
WHERE track.genreid ='1'
GROUP BY artist.name,track.genreid
ORDER BY COUNT(DISTINCT(customer.customerid)) DESC;

/* Choosing Artist for Rock concert by Analyzing highest listeners and highest paid artist in rock genre */

SELECT artist.name AS artist_name, COUNT(DISTINCT(customer.customerid)) AS rock_listeners,
SUM(invoiceline.unitprice) Total_sales_of_Artist_in_genre  FROM customer
INNER JOIN invoice
ON invoice.customerid = customer.customerid
INNER JOIN invoiceline 
ON invoiceline.invoiceid = invoice.invoiceid
INNER JOIN track 
ON track.trackid = invoiceline.trackid
INNER JOIN album
ON album.albumid = track.albumid
INNER JOIN artist
ON album.artistid = artist.artistid
WHERE track.genreid ='1'
GROUP BY artist.name
ORDER BY COUNT(DISTINCT(customer.customerid)) DESC;


/* Choosing Artist for Rock concert who wrote highest tracks in Rock Genre   */
SELECT artist.name ,COUNT(track.trackid) FROM album 
INNER JOIN track
ON album.albumid = track.albumid
INNER JOIN artist 
ON artist.artistid = album.artistid
WHERE track.genreid = '1'
GROUP BY artist.name
ORDER BY COUNT(track.trackid) DESC
LIMIT 1;


/* compared total_sales to average sales in each country and analysed countries with total_sales greater than avg_sales  */
SELECT billingcountry , SUM(total)AS total_sales,AVG(total) AS avg_sales
FROM invoice
GROUP BY billingcountry;


/* Analysed famous genre in each country to conduct concerts in all countries in that genre to get profit   */
SELECT customer.country ,MAX(genre.name) AS famous_genre,COUNT(DISTINCT(customer.customerid))  FROM customer
INNER JOIN invoice
ON invoice.customerid = customer.customerid
INNER JOIN invoiceline 
ON invoiceline.invoiceid = invoice.invoiceid
INNER JOIN track 
ON track.trackid = invoiceline.trackid
INNER JOIN genre
ON genre.genreid = track.genreid
GROUP BY customer.country
ORDER BY COUNT(DISTINCT(customer.customerid)) DESC;

/* Analyzing city for next potential investment */
SELECT billingcountry ,COUNT(distinct(customer.customerid)) AS potential_customers,AVG(total) AS avg_sales
FROM invoice
INNER JOIN customer
ON customer.customerid = invoice.customerid
INNER JOIN invoiceline
ON invoice.invoiceid= invoiceline.invoiceid
GROUP BY billingcountry
ORDER BY COUNT(distinct(customer.customerid))  DESC;


/*country with more rock music listners and total sales*/
SELECT customer.country,COUNT(DISTINCT customer.customerid) AS number_listeners,SUM(invoiceline.unitprice) AS total_rock_sales FROM customer
INNER JOIN invoice 
ON customer.customerid = invoice.customerid
INNER JOIN invoiceline
ON invoice.invoiceid= invoiceline.invoiceid
INNER JOIN track
ON track.trackid= invoiceline.trackid
WHERE genreid='1'
GROUP BY customer.country
ORDER BY COUNT(DISTINCT customer.customerid) DESC
LIMIT 5;






































