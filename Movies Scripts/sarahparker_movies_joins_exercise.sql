SELECT *
FROM specs;

SELECT *
FROM distributors;

SELECT *
FROM rating;

SELECT *
FROM revenue;

--


--Question 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue ON revenue.movie_id = specs.movie_id
ORDER BY worldwide_gross
LIMIT 1;

--answer: Semi-Tough, released in 1977, grossed $37,187,139


--Question 2. What year has the highest average imdb rating?
SELECT release_year, AVG(imdb_rating)
FROM specs
INNER JOIN rating ON rating.movie_id = specs.movie_id
GROUP BY release_year
ORDER BY AVG(imdb_rating) DESC
LIMIT 1;

--answer: The year with the highest average IMDB rating is 1991.


--Question 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT mpaa_rating, worldwide_gross, company_name, film_title
FROM specs
	INNER JOIN revenue ON revenue.movie_id = specs.movie_id
	INNER JOIN distributors ON distributors.distributor_id = specs.domestic_distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

--answer: The highest grossing G-rated movie is Toy Story 4, and it was distributed by Walt Disney.


--Question 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies 
--associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have 
--any movies in the movies table.
SELECT company_name, COUNT(movie_id)
FROM distributors
LEFT JOIN specs ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name;


--Question 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT company_name, AVG(worldwide_gross)
FROM distributors
	INNER JOIN specs ON distributors.distributor_id = specs.domestic_distributor_id
	INNER JOIN revenue ON specs.movie_id = revenue.movie_id
GROUP BY company_name
ORDER BY AVG(worldwide_gross) DESC
LIMIT 5;


--Question 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT company_name, film_title, imdb_rating
FROM distributors
	INNER JOIN specs ON distributors.distributor_id = specs.domestic_distributor_id
	INNER JOIN rating ON rating.movie_id = specs.movie_id
WHERE headquarters NOT LIKE '%, CA';

--answer: Two movies in the dataset were distributed by a company not headquarted in California. Of the two, Dirty Dancing had the higher IMDB rating.


--Question 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT AVG(imdb_rating)
FROM specs
INNER JOIN rating ON rating.movie_id = specs.movie_id
WHERE length_in_min < 120;

SELECT AVG(imdb_rating)
FROM specs
INNER JOIN rating ON rating.movie_id = specs.movie_id
WHERE length_in_min > 120;

--answer: Movies that are over two hours long have a higher average IMDB rating.