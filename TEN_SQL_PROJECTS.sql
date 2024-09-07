-- The queries we will be developing are: 

# 1) All films with PG-13 films with rental rate of 2.99 or lower

select * from sakila.film as f
where f.rental_rate <= 2.99
and f.rating = 'PG-13' ;


# 2) All films that have deleted scenes

select f.title,f.special_features,f.release_year from sakila.film as f
where f.special_features like '%Deleted Scenes%' and title like 'c%' 
;


# 3) All active customers

select * from sakila.customer
where active =1;


# 4) Names of customers who rented a movie on 26th July 2005

select 
r.rental_id,r.rental_date,r.customer_id,concat(c.first_name,'',c.last_name) as Full_name from sakila.rental as r
join sakila.customer as c on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-07-26';


# 5) Distinct names of customers who rented a movie on 26th July 2005

select distinct r.customer_id,
concat(c.first_name,'',c.last_name) as Full_name from sakila.rental as r
join sakila.customer as c 
on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-07-26';


# 6) How many rentals we do on each day?

select date(rental_date) as d,count(*) as Total_Coustumer_per_day from sakila.rental 
group by date(rental_date);

# 7) All Sci-fi films in our catalogue

SELECT fc.film_id,fc.category_id ,c.name,f.title ,f.release_year  FROM sakila.film_category as fc
join sakila.category as c on c.category_id=fc.category_id
join sakila.film as f on f.film_id
where name = 'Sci-Fi';


# 8) Customers and how many movies they rented from us so far?

SELECT r.customer_id,c.first_name,c.email,count(*) as 'Count'
FROM sakila.rental AS r 
join sakila.customer as c on c.customer_id = r.customer_id
group by r.customer_id
order by count(*) desc;

 
# 9) Which movies should we discontinue from our catalogue (less than 2 lifetime rentals)

with low_rentals as 
    (SELECT inventory_id, count(*) 
     FROM sakila.rental as r
     group by inventory_id
    having count(*) <=1 )
select low_rentals.inventory_id,i.film_id,f.title
  from low_rentals
join sakila.inventory as i on i.inventory_id = low_rentals.inventory_id
join sakila.film as f on f.film_id = i.film_id
;

# 10) Which movies are not returned yet?
 
SELECT rental_date,customer_id,i.film_id ,f.title 
FROM sakila.rental as r
join sakila.inventory as i on i.inventory_id = r.inventory_id
join sakila.film as f on f.film_id = i.film_id
where r.return_date is null 
order by f.title

# H1) How many distinct last names we have in the data?
#H2) How much money and rentals we make for Store 1 by day?  
# What are the three top earning days so far?
