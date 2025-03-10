-- 1. Display snum, sname, city, and comm of all salespeople.
SELECT snum, sname, city, comm FROM salespeople;

-- 2. Display all snum without duplicates from all orders.
SELECT DISTINCT snum FROM orders;

-- 3. Display names and commissions of all salespeople in London.
SELECT sname, comm FROM salespeople WHERE city = 'London';

-- 4. All customers with a rating of 100.
SELECT * FROM customers WHERE rating = 100;

-- 5. Produce orderno, amount, and date from all rows in the order table.
SELECT orderno, amount, odate FROM orders;

-- 6. All customers in San Jose, who have a rating of more than 200.
SELECT * FROM customers WHERE city = 'San Jose' AND rating > 200;

-- 7. All customers who were either located in San Jose or had a rating above 200.
SELECT * FROM customers WHERE city = 'San Jose' OR rating > 200;

-- 8. All orders for more than $1000.
SELECT * FROM orders WHERE amount > 1000;

-- 9. Names and cities of all salespeople in London with commission above 0.10.
SELECT sname, city FROM salespeople WHERE city = 'London' AND comm > 0.10;

-- 10. All customers excluding those with rating <= 100 unless they are located in Rome.
SELECT * FROM customers WHERE rating > 100 OR city = 'Rome';

-- 11. All salespeople either in Barcelona or in London.
SELECT * FROM salespeople WHERE city IN ('Barcelona', 'London');

-- 12. All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
SELECT * FROM salespeople WHERE comm > 0.10 AND comm < 0.12;

-- 13. All customers with NULL values in the city column.
SELECT * FROM customers WHERE city IS NULL;

-- 14. All orders taken on Oct 3rd and Oct 4th, 1994.
SELECT * FROM orders WHERE odate IN ('1994-10-03', '1994-10-04');

-- 15. All customers serviced by Peel or Motika.
SELECT * FROM customers WHERE snum IN (SELECT snum FROM salespeople WHERE sname IN ('Peel', 'Motika'));

-- 16. All customers whose names begin with a letter from A to B.
SELECT * FROM customers WHERE cname LIKE 'A%' OR cname LIKE 'B%';

-- 17. All orders except those with 0 or NULL value in amt field.
SELECT * FROM orders WHERE amt <> 0 AND amt IS NOT NULL;

-- 18. Count the number of salespeople currently listing orders in the order table.
SELECT COUNT(DISTINCT snum) FROM orders;

-- 19. Largest order taken by each salesperson, date-wise.
SELECT snum, MAX(amount) FROM orders GROUP BY snum;

-- 20. Largest order taken by each salesperson with order value more than $3000.
SELECT snum, MAX(amount) FROM orders WHERE amount > 3000 GROUP BY snum;

-- 21. Which day had the highest total amount ordered?
SELECT odate, SUM(amount) AS total FROM orders GROUP BY odate ORDER BY total DESC LIMIT 1;

-- 22. Count all orders for Oct 3rd.
SELECT COUNT(*) FROM orders WHERE odate = '1994-10-03';

-- 23. Count the number of different non-NULL city values in the customers table.
SELECT COUNT(DISTINCT city) FROM customers WHERE city IS NOT NULL;

-- 24. Select each customer’s smallest order.
SELECT cnum, MIN(amount) FROM orders GROUP BY cnum;

-- 25. First customer in alphabetical order whose name begins with G.
SELECT * FROM customers WHERE cname LIKE 'G%' ORDER BY cname LIMIT 1;

-- 26. Get the output like “For dd/mm/yy there are ___ orders.”
SELECT CONCAT('For ', DATE_FORMAT(odate, '%d/%m/%y'), ' there are ', COUNT(*), ' orders.') FROM orders GROUP BY odate;

-- 27. Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
SELECT orderno, snum, amount * 0.12 AS commission FROM orders;

-- 28. Find highest rating in each city. Put the output in this form: "For the city (city), the highest rating is: (rating)."
SELECT city, MAX(rating) FROM customers GROUP BY city;

-- 29. Display the totals of orders for each day and place the results in descending order.
SELECT odate, SUM(amount) FROM orders GROUP BY odate ORDER BY SUM(amount) DESC;

-- 30. All combinations of salespeople and customers who shared a city (i.e., same city).
SELECT s.sname, c.cname FROM salespeople s JOIN customers c ON s.city = c.city;

-- 31. Name all customers matched with the salespeople serving them.
SELECT c.cname, s.sname FROM customers c JOIN salespeople s ON c.snum = s.snum;

-- 32. List each order number followed by the name of the customer who made the order.
SELECT o.orderno, c.cname FROM orders o JOIN customers c ON o.cnum = c.cnum;

-- 33. Names of salesperson and customer for each order after the order number.
SELECT o.orderno, c.cname, s.sname FROM orders o JOIN customers c ON o.cnum = c.cnum JOIN salespeople s ON o.snum = s.snum;

-- 34. Produce all customers serviced by salespeople with a commission above 12%.
SELECT * FROM customers WHERE snum IN (SELECT snum FROM salespeople WHERE comm > 0.12);

-- 35. Calculate the amount of the salesperson’s commission on each order with a rating above 100.
SELECT orderno, amount * 0.12 FROM orders WHERE rating > 100;

-- 36. Find all pairs of customers having the same rating.
SELECT c1.cnum, c1.cname, c2.cnum, c2.cname FROM customers c1, customers c2 WHERE c1.rating = c2.rating AND c1.cnum <> c2.cnum;

-- 37. Find all pairs of customers having the same rating, each pair appearing once only.
SELECT DISTINCT LEAST(c1.cnum, c2.cnum), GREATEST(c1.cnum, c2.cnum) FROM customers c1, customers c2 WHERE c1.rating = c2.rating AND c1.cnum < c2.cnum;

-- 38. Policy is to assign three salespeople to each customer. Display all such combinations.
SELECT c.cnum, s1.snum, s2.snum, s3.snum FROM customers c, salespeople s1, salespeople s2, salespeople s3 WHERE s1.snum < s2.snum AND s2.snum < s3.snum;

-- 39. Display all customers located in cities where salesman Serres has customers.
SELECT * FROM customers WHERE city IN (SELECT DISTINCT city FROM customers c JOIN salespeople s ON c.snum = s.snum WHERE s.sname = 'Serres');

-- 40. Find all pairs of customers served by a single salesperson.
SELECT c1.cnum, c2.cnum FROM customers c1 JOIN customers c2 ON c1.snum = c2.snum AND c1.cnum <> c2.cnum;
-- 41. Produce all pairs of salespeople who live in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
SELECT s1.snum, s1.sname, s2.snum, s2.sname 
FROM salespeople s1, salespeople s2 
WHERE s1.city = s2.city AND s1.snum < s2.snum;

-- 42. Produce all pairs of orders by a given customer, naming that customer and eliminating duplicates.
SELECT o1.orderno, o2.orderno, c.cname 
FROM orders o1 
JOIN orders o2 ON o1.cnum = o2.cnum AND o1.orderno < o2.orderno 
JOIN customers c ON o1.cnum = c.cnum;

-- 43. Produce names and cities of all customers with the same rating as Hoffman.
SELECT cname, city FROM customers WHERE rating = (SELECT rating FROM customers WHERE cname = 'Hoffman');

-- 44. Extract all the orders of Motika.
SELECT * FROM orders WHERE snum = (SELECT snum FROM salespeople WHERE sname = 'Motika');

-- 45. All orders credited to the same salesperson who services Hoffman.
SELECT * FROM orders WHERE snum = (SELECT snum FROM customers WHERE cname = 'Hoffman');

-- 46. All orders that are greater than the average for Oct 4.
SELECT * FROM orders WHERE amount > (SELECT AVG(amount) FROM orders WHERE odate = '1994-10-04');

-- 47. Find the average commission of salespeople in London.
SELECT AVG(comm) FROM salespeople WHERE city = 'London';

-- 48. Find all orders attributed to salespeople servicing customers in London.
SELECT * FROM orders WHERE snum IN (SELECT snum FROM customers WHERE city = 'London');

-- 49. Extract commissions of all salespeople servicing customers in London.
SELECT comm FROM salespeople WHERE snum IN (SELECT snum FROM customers WHERE city = 'London');

-- 50. Find all customers whose cnum is 1000 above the snum of Serres.
SELECT * FROM customers WHERE cnum = (SELECT snum FROM salespeople WHERE sname = 'Serres') + 1000;

-- 51. Count the customers with a rating above San Jose’s average.
SELECT COUNT(*) FROM customers WHERE rating > (SELECT AVG(rating) FROM customers WHERE city = 'San Jose');

-- 52. Obtain all orders for the customer named Cisneros (Assume you don’t know his customer number).
SELECT * FROM orders WHERE cnum = (SELECT cnum FROM customers WHERE cname = 'Cisneros');

-- 53. Produce the names and ratings of all customers who have above-average orders.
SELECT cname, rating FROM customers WHERE cnum IN (SELECT cnum FROM orders GROUP BY cnum HAVING AVG(amount) > (SELECT AVG(amount) FROM orders));

-- 54. Find the total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT snum, SUM(amount) FROM orders GROUP BY snum HAVING SUM(amount) > (SELECT MAX(amount) FROM orders);

-- 55. Find all customers with an order on 3rd Oct.
SELECT DISTINCT c.* FROM customers c JOIN orders o ON c.cnum = o.cnum WHERE o.odate = '1994-10-03';

-- 56. Find names and numbers of all salespeople who have more than one customer.
SELECT s.snum, s.sname FROM salespeople s JOIN customers c ON s.snum = c.snum GROUP BY s.snum HAVING COUNT(c.cnum) > 1;

-- 57. Check if the correct salesperson was credited with each sale.
SELECT * FROM orders WHERE snum NOT IN (SELECT snum FROM customers WHERE cnum = orders.cnum);

-- 58. Find all orders with above-average amounts for their customers.
SELECT * FROM orders WHERE amount > (SELECT AVG(amount) FROM orders o2 WHERE o2.cnum = orders.cnum);

-- 59. Find the sums of the amounts from the order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT odate, SUM(amount) FROM orders GROUP BY odate HAVING SUM(amount) >= (SELECT MAX(amount) FROM orders) + 2000;

-- 60. Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT cnum, cname FROM customers WHERE rating = (SELECT MAX(rating) FROM customers c2 WHERE c2.city = customers.city);

-- 61. Find all salespeople who have customers in their cities who they don’t service (Both using Join and Correlated subquery).
SELECT DISTINCT s.snum, s.sname FROM salespeople s JOIN customers c ON s.city = c.city WHERE s.snum <> c.snum;
SELECT DISTINCT s.snum, s.sname FROM salespeople s WHERE EXISTS (SELECT 1 FROM customers c WHERE c.city = s.city AND c.snum <> s.snum);

-- 62. Extract cnum, cname, and city from the customer table if and only if one or more customers in the table are located in San Jose.
SELECT cnum, cname, city FROM customers WHERE EXISTS (SELECT 1 FROM customers WHERE city = 'San Jose');

-- 63. Find salespeople numbers who have multiple customers.
SELECT snum FROM customers GROUP BY snum HAVING COUNT(cnum) > 1;

-- 64. Find salespeople numbers, names, and cities who have multiple customers.
SELECT s.snum, s.sname, s.city FROM salespeople s JOIN customers c ON s.snum = c.snum GROUP BY s.snum, s.sname, s.city HAVING COUNT(c.cnum) > 1;

-- 65. Find salespeople who serve only one customer.
SELECT snum FROM customers GROUP BY snum HAVING COUNT(cnum) = 1;

-- 66. Extract rows of all salespeople with more than one current order.
SELECT * FROM salespeople WHERE snum IN (SELECT snum FROM orders GROUP BY snum HAVING COUNT(orderno) > 1);

-- 67. Find all salespeople who have customers with a rating of 300. (Use EXISTS)
SELECT * FROM salespeople WHERE EXISTS (SELECT 1 FROM customers WHERE customers.snum = salespeople.snum AND rating = 300);

-- 68. Find all salespeople who have customers with a rating of 300. (Use JOIN)
SELECT DISTINCT s.* FROM salespeople s JOIN customers c ON s.snum = c.snum WHERE c.rating = 300;

-- 69. Select all salespeople with customers located in their cities who are not assigned to them. (Use EXISTS)
SELECT * FROM salespeople s WHERE EXISTS (SELECT 1 FROM customers c WHERE s.city = c.city AND s.snum <> c.snum);

-- 70. Extract from the customers table every customer assigned to a salesperson who currently has at least one other customer (besides the customer being selected) with orders in the order table.
SELECT * FROM customers WHERE snum IN (SELECT snum FROM customers c2 JOIN orders o ON c2.cnum = o.cnum GROUP BY c2.snum HAVING COUNT(DISTINCT c2.cnum) > 1);

-- 71. Find salespeople with customers located in their cities (using both ANY and IN).
SELECT * FROM salespeople WHERE city IN (SELECT city FROM customers);
SELECT * FROM salespeople WHERE city = ANY (SELECT city FROM customers);

-- 72. Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT * FROM salespeople WHERE sname < ANY (SELECT cname FROM customers);
SELECT * FROM salespeople WHERE EXISTS (SELECT 1 FROM customers WHERE salespeople.sname < customers.cname);
-- 73. Select customers who have a greater rating than any customer in Rome.
SELECT * FROM customers WHERE rating > ANY (SELECT rating FROM customers WHERE city = 'Rome');

-- 74. Select all orders that had amounts that were greater than at least one of the orders from Oct 6th.
SELECT * FROM orders WHERE amount > ANY (SELECT amount FROM orders WHERE odate = '1994-10-06');

-- 75. Find all orders with amounts smaller than any amount for a customer in San Jose.
SELECT * FROM orders WHERE amount < ANY (SELECT amount FROM orders WHERE cnum IN (SELECT cnum FROM customers WHERE city = 'San Jose'));

-- 76. Select those customers whose ratings are higher than every customer in Paris.
SELECT * FROM customers WHERE rating > ALL (SELECT rating FROM customers WHERE city = 'Paris');

-- 77. Select all customers whose ratings are equal to or greater than ANY of the Seeres.
SELECT * FROM customers WHERE rating >= ANY (SELECT rating FROM salespeople WHERE sname = 'Seeres');

-- 78. Find all salespeople who have no customers located in their city.
SELECT * FROM salespeople WHERE city NOT IN (SELECT city FROM customers);

-- 79. Find all orders for amounts greater than any for the customers in London.
SELECT * FROM orders WHERE amount > ANY (SELECT amount FROM orders WHERE cnum IN (SELECT cnum FROM customers WHERE city = 'London'));

-- 80. Find all salespeople and customers located in London.
SELECT * FROM salespeople WHERE city = 'London' UNION SELECT * FROM customers WHERE city = 'London';
-- 81. For every salesperson, dates on which highest and lowest orders were brought.
SELECT snum, MAX(odate) AS highest_order_date, MIN(odate) AS lowest_order_date FROM orders GROUP BY snum;

-- 82. List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT s.snum, s.sname, s.city, 
       CASE WHEN c.city IS NULL THEN 'No Customers' ELSE 'Has Customers' END AS customer_status
FROM salespeople s LEFT JOIN customers c ON s.city = c.city;

-- 83. Append strings to the selected fields, indicating whether or not a given salesperson was matched to a customer in his city.
SELECT s.snum, s.sname, s.city, 
       CASE WHEN c.city IS NULL THEN CONCAT(s.sname, ' - No Customers') ELSE CONCAT(s.sname, ' - Has Customers') END AS status
FROM salespeople s LEFT JOIN customers c ON s.city = c.city;

-- 84. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
SELECT cname, city, rating, 'High Rating' AS rating_status FROM customers WHERE rating >= 200
UNION
SELECT cname, city, rating, 'Low Rating' AS rating_status FROM customers WHERE rating < 200;

-- 85. Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT s.snum, s.sname FROM salespeople s WHERE s.snum IN (SELECT snum FROM orders GROUP BY snum HAVING COUNT(*) > 1)
UNION
SELECT c.cnum, c.cname FROM customers c WHERE c.cnum IN (SELECT cnum FROM orders GROUP BY cnum HAVING COUNT(*) > 1)
ORDER BY sname;

-- 86. Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries but eliminate redundancies between either of them and the first.
SELECT snum FROM salespeople WHERE city = 'San Jose'
UNION
SELECT cnum FROM customers WHERE city = 'San Jose'
UNION ALL
SELECT onum FROM orders WHERE odate = '1994-10-03';

-- 87. Produce all the salesperson in London who had at least one customer there.
SELECT * FROM salespeople WHERE city = 'London' AND snum IN (SELECT snum FROM customers WHERE city = 'London');

-- 88. Produce all the salesperson in London who did not have customers there.
SELECT * FROM salespeople WHERE city = 'London' AND snum NOT IN (SELECT snum FROM customers WHERE city = 'London');

-- 89. We want to see salespeople matched to their customers without excluding those salespeople who were not currently assigned to any customers. (Use OUTER JOIN and UNION)
SELECT s.snum, s.sname, s.city, c.cnum, c.cname FROM salespeople s LEFT JOIN customers c ON s.snum = c.snum
UNION
SELECT s.snum, s.sname, s.city, c.cnum, c.cname FROM salespeople s RIGHT JOIN customers c ON s.snum = c.snum;
