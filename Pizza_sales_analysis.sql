----Major KPI
--Total Revenue
select floor(sum(total_price)) as total_revenue from pizza_sales

--Total Orders
select count(distinct order_id) as total_orders from pizza_sales

--Total Pizzas Solds
select sum(quantity) from pizza_sales

--Total Averages Orders
select floor(floor(sum(total_price)) / count(distinct order_id)) as Total_avg_orders from pizza_sales

--Averages Pizza Order Per Orders
select avg(order_quantity) as Averages_Pizza_Order_Per_Orders from 
(select order_id , sum(quantity) as order_quantity  from pizza_sales 
group by order_id)

--Top 5 Pizzas By Revenue
select pizza_name,sum(total_price) as total_revenue  from pizza_sales
group by pizza_name
order by total_revenue desc 
limit 5

--Bottom 5 Pizzas By Revenue
with cte as (
select *,rank() over(order by total_revenue_by_pizzas ) from(
select pizza_name,sum(total_price) as total_revenue_by_pizzas from pizza_sales
group by pizza_name))
select pizza_name,total_revenue_by_pizzas from cte 
where rank <=5

--Top 5 Pizzas By quantity
select pizza_name,sum(quantity) as total_revenue  from pizza_sales
group by pizza_name
order by total_revenue desc 
limit 5

--Bottom 5 Pizzas By quantity
select pizza_name,sum(quantity) as total_revenue  from pizza_sales
group by pizza_name
order by total_revenue  
limit 5

--Top 5 Pizzas By Orders
select pizza_name,count(distinct order_id) as total_orders  from pizza_sales
group by pizza_name
order by total_orders desc 
limit 5

--Bottom 5 Pizzas By Orders
select pizza_name,count(distinct order_id) as total_orders  from pizza_sales
group by pizza_name
order by total_orders  
limit 5

---Total Pizzas Sold By Pizza Category
select pizza_category,sum(quantity) as Total_category_pizza_sold from pizza_sales
group by pizza_category
order by Total_category_pizza_sold desc

--% Of Quantity By Pizza Category
with cte as (
		select pizza_category,sum(quantity) as Total_category_pizza_sold from pizza_sales
				group by pizza_category),
	cte2 as	
	(select sum(quantity) as total_quantity from pizza_sales)
select pizza_category, round(((Total_category_pizza_sold / total_quantity)*100),2) as total_per_of_quantity_by_pizzacatgory from cte,cte2
	
--% Of Sales By Pizza Category
with cte as (
		select pizza_category,sum(total_price) as Total_category_pizza_sales from pizza_sales
				group by pizza_category),
	cte2 as	
	(select sum(total_price) as total_sales from pizza_sales)
select pizza_category, ((Total_category_pizza_sales / total_sales)*100) as total_sales_asper_pizzacatgory from cte,cte2

--% Of Sales By Pizza Size
with cte as (
		select pizza_size,sum(total_price) as Total_sales_as_per_size from pizza_sales
				group by pizza_size),
	cte2 as	
	(select sum(total_price) as total_sales from pizza_sales)
select pizza_size, ((Total_sales_as_per_size / total_sales)*100) as percentage_of_total_sales_as_per_size from cte,cte2

--Daily Trend For Total Orders
select to_char(order_date,'day') as weakdays,count(distinct order_id) from pizza_sales
group by to_char(order_date,'day')
order by weakdays

--Monthly Trend For Total Orders

select to_char(order_date,'month') as months,count(distinct order_id) from pizza_sales
group by to_char(order_date,'month')
order by months
