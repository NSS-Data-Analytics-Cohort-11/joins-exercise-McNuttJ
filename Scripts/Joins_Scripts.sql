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



