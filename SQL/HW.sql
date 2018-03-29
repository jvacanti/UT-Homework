use sakila;

-- 1a. Display the first and last names of all actors from the table actor.
-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select first_name, last_name from actor;
select CONCAT(first_name, ' ' , last_name) as Actor_Name FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
select first_name, last_name, actor_id from actor
WHERE first_name IN ('Joe');

-- HELP 2b. Find all actors whose last name contain the letters GEN:
select first_name, last_name from actor
WHERE last_name LIKE '%GEN%';

-- HELP 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select last_name, first_name from actor
WHERE last_name LIKE '%LI%';

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country from country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
ALTER TABLE actor ADD middle_name VARCHAR(20) AFTER first_name;
select * from actor;

-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
ALTER TABLE actor
modify middle_name Blob;

-- 3c. Now delete the middle_name column.
ALTER TABLE actor
DROP middle_name;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT COUNT(last_name) AS COUNT, last_name
FROM actor
GROUP BY last_name;

-- HELP 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT COUNT(last_name) AS `Frequency`, last_name
FROM actor
GROUP BY last_name
HAVING `Frequency` > 1
ORDER BY COUNT(last_name) DESC;

-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor 
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';

-- HELP 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
update actor
SET first_name = CASE WHEN first_name = 'HARPO' THEN 'GROUCHO' ELSE 'MUCHO GROUCHO' END WHERE actor_id=172;


-- HELP 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;


-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select
	staff.first_name,
    staff.last_name,
    address.address
from staff
join address using (address_id)
;

-- HELP 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select
	staff.first_name,
    staff.last_name,
    SUM(payment.amount),
    staff.staff_id,
    payment.staff_id
from staff
join payment on (staff.staff_id = payment.staff_id)
WHERE month(payment.payment_date) = 08 AND year(payment.payment_date) = 2005
GROUP BY staff.staff_id
;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select
	film.title,
    COUNT(film_actor.actor_id) as actor_count
from film
join film_actor using (film_id)
GROUP BY film_id
;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select
    COUNT(film_id)
from 
    inventory
where film_id in (
    select
        film_id
    from
        film
    where
        title = 'Hunchback Impossible'
) 
;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select
	customer.first_name,
    customer.last_name,
    SUM(payment.amount)
from customer
join payment using (customer_id)
GROUP BY customer_id
ORDER BY last_name ASC
;

-- HELP 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT 
    title
FROM
    film
WHERE
    title LIKE 'Q%'
        OR title LIKE 'K%'
        AND language_id IN (SELECT 
            language_id
        FROM
            language
        WHERE
            name = 'ENGLISH')
;

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
select
    first_name, last_name
from 
    actor
where actor_id in (
    select
        actor_id
    from
        film
    where
        title = 'Alone Trip'
) 
;

-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select
 customer.first_name,
 customer.last_name,
 customer.email
from customer
where address_id in (
	select
		address_id
        from address
        where city_id in (
			select 
				city_id
			from city
			where country_id in (
				select
					country_id
				from 
					country
				where country = 'Canada')))
;

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
select
    *
from 
    film
where film_id in (
    select
        film_id
    from
		film_category
	where category_id in (
		select
			category_id
		from
			category
		where
			name = 'Family'
) )
;

-- 7e. Display the most frequently rented movies in descending order.
select title, COUNT(title) as 'Rental Count'
from film
join inventory on (film.film_id = inventory.film_id)
join rental on (inventory.inventory_id = rental.inventory_id)
GROUP BY title
ORDER BY `Rental Count` DESC
;


-- 7f. Write a query to display how much business, in dollars, each store brought in.
select 
	store.store_id,
    SUM(payment.amount)
from
	payment
JOIN rental on (payment.rental_id = rental.rental_id)
JOIN inventory on (rental.inventory_id = inventory.inventory_id)
JOIN store on (store.store_id = inventory.store_id)
GROUP BY store_id
;




-- HELP 7g. Write a query to display for each store its store ID, city, and country.

select
	store.store_id,
    city.city,
    country.country
FROM store
JOIN address ON (store.address_id = address.address_id)
JOIN city ON (address.city_id = city.city_id)
JOIN country ON (country.country_id = city.country_id)
;

    

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)



-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW Top_Five AS


-- 8b. How would you display the view that you created in 8a?


-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.



