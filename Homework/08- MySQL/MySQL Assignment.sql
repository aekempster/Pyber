USE SAKILA;

#Unit 10 Assignment - SQL
#Create these queries to develop greater fluency in SQL, an important database language.

#1a. You need a list of all the actors who have Display the first and last names of all actors from the table `actor`. 
SELECT first_name, last_name FROM actor

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 
ALTER TABLE actor
ADD actor_name VARCHAR(50)
UPDATE actor SET actor_name = CONCAT(first_name, ' ', last_name);
#Check to ensure new column added
SELECT * FROM actor

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";
  	
#2b. Find all actors whose last name contain the letters `GEN`:
SELECT * FROM actor WHERE last_name LIKE '%gen%'
	
#2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
SELECT * FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name, first_name

#2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a. Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.
ALTER TABLE actor
ADD middle_name VARCHAR(50) AFTER first_name;
#Check to ensure new column added
SELECT * FROM actor
  	
#3b. You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`. 
ALTER TABLE actor MODIFY middle_name BLOB;
#check to ensure data type changed
DESCRIBE actor

#3c. Now delete the `middle_name` column.
ALTER TABLE actor DROP COLUMN middle_name;
#Check to ensure column dropped
SELECT * FROM actor

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) AS 'Numer of Actors with This Last Name'
FROM actor
GROUP BY last_name;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
 SELECT last_name, COUNT(last_name) AS 'Numer of Actors with This Last Name'
FROM actor
GROUP BY last_name
HAVING COUNT(*)>1;

#4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
UPDATE actor SET first_name = 'HARPO' 
WHERE first_name = "groucho" AND last_name = "williams";
 
#4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. Otherwise, change the first name to `MUCHO GROUCHO`, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, HOWEVER! (Hint: update the record using a unique identifier.)
UPDATE actor
SET first_name = 
		CASE 
			WHEN first_name = 'HARPO'
				THEN 'GROUCHO'
			ELSE 'MUCHO GROUCHO'
		END
	WHERE actor_id = 172;

#* 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
DESCRIBE address;

#* 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT first_name, last_name, address FROM staff
JOIN address ON staff.address_id = address.address_id;

#* 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 
SELECT staff.staff_id, first_name, last_name, sum(amount) AS 'Total Amount Run Up' FROM staff 
INNER JOIN payment ON staff.staff_id = payment.staff_id
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) = 8
GROUP BY staff_id;

#* 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
#film_actor = actor_id, film_id
#film = film_id,title
Select film.title, COUNT(film_actor.actor_id) as'Number of Actors' FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

#* 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT film.title, COUNT(inventory.inventory_id) as '# of Copies in Inventory' FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.film_id
HAVING title = 'Hunchback Impossible';

#* 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT payment.customer_id, last_name, first_name, sum(amount) AS 'Total Paid' 
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY last_name;

#* 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 
SELECT title 
FROM film
WHERE language_id IN
	(
	SELECT language_id 
	FROM language
	WHERE name = 'English'
    )
	AND (title LIKE "K%") OR (title LIKE "Q%");

#* 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT actor_name
FROM actor 
WHERE actor_id IN
	(
	SELECT actor_id 
	FROM film_actor
	WHERE film_id IN
		(
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'
		)
	);

   
#* 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT cust.first_name, cust.last_name, cust.email, co.country FROM customer cust
INNER JOIN address ON cust.address_id = address.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country co ON co.country_id = city.country_id
WHERE country = "Canada";

#* 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title, description, rating FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Family';

#* 7e. Display the most frequently rented movies in descending order.
SELECT film.title, count(inventory.film_id) AS 'Rental Count' FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.inventory_id = film.film_id
GROUP BY rental.inventory_id
ORDER BY count(inventory.film_id) desc;

#* 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT country.country AS 'Store Location', sum(payment.amount) AS 'Total Sales' FROM payment 
JOIN rental ON payment.rental_id = rental.rental_id 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id 
JOIN country ON city.country_id = country.country_id
GROUP BY store.store_id order by country.country;

#* 7g. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city, country FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
  	
#* 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name, SUM(payment.amount) as 'Revenue by Genre' FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY SUM(payment.amount) DESC;
    
#* 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW Top_5_Movie_Genres AS 
SELECT category.name, SUM(payment.amount) as 'Revenue by Genre' FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;
    
#* 8b. How would you display the view that you created in 8a?
SELECT * FROM Top_5_Movie_Genres;

#* 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
DROP VIEW Top_5_Movie_Genres;