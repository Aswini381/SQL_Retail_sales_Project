/* sql project */
create database sql_project_p1;
drop table if exists retail_sales;
create table retail_sales(
	transactions_id int,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(20),
	age int,
	category varchar(50),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
);
select * from retail_sales limit 10;

select count(*) from retail_sales;

/* Data Cleaning */
select * from retail_sales
where transactions_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
where transactions_id is null
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

delete from retail_sales
where transactions_id is null
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

/* Data  Exploration */

/* How many sales we have ? */
select count(*) as total_sale from retail_sales;

/* How many customer we have ? */
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category from retail_sales;

/* Data Analysis & Business key problem and answer */
/* Question 1 : Write a write a query to retrieve all columns for sales made on '2022-11-05' */

select * from retail_sales
where sale_date='2022-11-05';

/* Question 2 : Write a SQL query to retrieve all transactions where the category is clothing and the quatity sold is more than 3 in the month of nov-2022*/
select * from retail_sales
where category='clothing'
and date_format(sale_date, '%Y-%m') = '2022-11'
and quantiy>3 ;

/* Question 3 : Write a SQL query to calculate the total sales for each category */
select category, 
sum(total_sale) as sale,
count(*) as total_orders
from retail_sales
group by 1;

/* Question 4 : Write a query to find the average age of customers who purchased from the 'Beauty' category */
select round(avg(age),2) as avg_age
from retail_sales
where category='Beauty';

/* Question 5 : Write a sql query to find all transactions where the total_sale is greater than 1000. */
select * from retail_sales 
where total_sale>1000;

/* Question 6 : write a sql query to find the total number of transaction (transaction_id) made by each gender in each category */
select category, gender, count(*) as total_transaction
from retail_sales
group by category,gender
order by 1;

/* Question 7 : Write a sql query to calculate the average sale for each month. Find out best selling month in each year */
select year,month,avg_total_sale from
(
select year(sale_date) as year,
month(sale_date) as month,
avg(total_sale) as avg_total_sale,
rank() over (partition by year(sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
group by 1,2
) as t
where rnk=1;

/* Question 8 : Write a query to find the top 5 customers based on the highest total sales */

select customer_id, sum(total_sale) as total_sales from retail_sales
group by 1
order by 2 desc
limit 5;

/* Question 9 :  Write a sql query find the number of unique customer who purchased items from each category */

select category, count(distinct customer_id) as unique_customer
from retail_sales
group by category;

/* Question 10 : Write a sql query to create each shift and number of orders like morning<=12..*/
with hourly_sale as (
select *,
case
when hour(sale_time)<12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales
)
select 
count(*) as total_orders
from hourly_sale
group by shift;

/* end of projects */




































