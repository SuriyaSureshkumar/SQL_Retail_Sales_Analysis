-- Drop table
drop table if exists retail_sales;
-- Create a table
create table retail_sales
	(
	transactions_id int primary key,	
	sale_date date,
	sale_time time,	
	customer_id int,
	gender varchar(10),
	age int,	
	category varchar(15),	
	quantiy int,
	price_per_unit float,	
	cogs float,
	total_sale float
	);

-- Summoning the table
select * from retail_sales;

-- get total rows from table
select count(*) from retail_sales as total_count;

-- Data Cleaning
-- delete null value rows
delete from retail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;

-- Count unique customers in the data
select count(distinct customer_id) as Unique_customers
from retail_sales

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales
where
	category = 'Clothing'
	and
	to_char(sale_date,'YYYY-MM') = '2022-11'
	and
	quantiy >= 4;

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) as Total_sales
from retail_sales
group by 1
order by 2 desc;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select category, round(avg(age),2) as Average_age
from retail_sales
where category = 'Beauty'
group by 1;

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select transactions_id, total_sale
from retail_sales
where total_sale > 1000
order by 2 desc;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select gender, category, count(transactions_id) as number_of_transactions
from retail_sales
group by 1,2
order by 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select
	extract(year from sale_date) as Year,
	extract(month from sale_date) as Month,
	avg(total_sale) as average_sales,
	rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as Ranking
from retail_sales
group by 1,2
order by 4
limit 2;

-- OR
select * from
(
	select
		extract(year from sale_date) as Year,
		extract(month from sale_date) as Month,
		avg(total_sale) as average_sales,
		rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as Ranking
	from retail_sales
	group by 1,2
) as t1
where Ranking = 1;

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, sum(total_sale) as Total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
select category, count(distinct customer_id) as total_unique_customers
from retail_sales
group by 1;

-- Write a SQL query to create each shift and number of orders 
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select
	case
		when sale_time < '12:00:00' then 'Morning'
		when sale_time > '17:00:00' then 'Evening'
		else 'Afternoon'
	end as Shift,
	count(*) as Number_of_orders
from retail_sales
group by 1;

-- End of Project
