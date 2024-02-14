--Question 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
FROM specs
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross
LIMIT 1;
--Answer: Semi-Tough, 1977, 37187139

--Question 2. What year has the highest average imdb rating?
SELECT specs.release_year, AVG(rating.imdb_rating) AS avg_rating
FROM specs
INNER JOIN rating
	ON specs.movie_id = rating.movie_id
GROUP BY specs.release_year
ORDER BY avg_rating DESC;
--Answer: 1991

--Question 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT specs.film_title, revenue.worldwide_gross, distributors.company_name
FROM specs
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
WHERE specs.mpaa_rating = 'G'
ORDER BY revenue.worldwide_gross DESC;
--Answer Toy Story 4, Walt Disney

--Question 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT distributors.company_name, COUNT(specs.*) AS count_films
FROM distributors
LEFT JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.company_name
ORDER BY count_films DESC;
--Answer: Table shows Walt Disney has the most films while Relativity Media and Legendary Entertainment have 0 films.

--Question 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, AVG(revenue.film_budget)
FROM distributors
INNER JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id
GROUP BY distributors.company_name
ORDER BY AVG(revenue.film_budget) DESC
LIMIT 5;
--Answer: Walt Disney, Sony Pictures, Lionsgate, DreamWorks, Warner Bros.

--Question 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT specs.film_title, rating.imdb_rating
FROM specs
INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN rating
	ON specs.movie_id = rating.movie_id
WHERE distributors.headquarters NOT LIKE '%CA'
ORDER BY rating.imdb_rating DESC;

--Answer 419 movies are distributed by a company not headquartered in California. The Dark Knight has the highest IMDB rating.

--Question 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT specs_left.length_in_min, rating_left.imdb_rating, specs_right.length_in_min, rating_left.imdb_rating
FROM specs AS specs_left
INNER JOIN specs AS specs_right
	ON specs_left.movie_id = specs_right.movie_id
INNER JOIN rating AS rating_left
	ON specs_left.movie_id = rating_left.movie_id
INNER JOIN rating AS rating_right
	ON specs_right.movie_id = rating_right.movie_id
WHERE specs_left.length_in_min > 120
--
--Trying Case--worked!
SELECT AVG(imdb_rating),
	CASE 
	WHEN length_in_min > 120 THEN 'Over Two Hours'
	WHEN length_in_min < 120 THEN 'Under Two Hours'
	ELSE 'Exactly Two Hours'
	END AS MovieLength, ROUND(AVG(imdb_rating),2)
FROM specs
LEFT JOIN rating
	ON specs.movie_id = rating.movie_id
GROUP BY movielength;
--Answer: Movies that are Over Two Hours have a higher average rating.


	




