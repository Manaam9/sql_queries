use test
set names utf8;

-- 1. Select  all products (all fields)
select * from product

-- 2. Select the names of all automated warehouses
select name from store

-- 3. Calculate the total amount in money of all sales
select sum(total) from sale

-- 4. Get unique store_id of all warehouses from which there was at least one sale
select store_id from sale group by store_id


-- 5. Get unique store_id of all warehouses from which there was not a single sale
select store_id from store where store_id not in (select store_id from sale group by store_id)


-- 6. Get for each product the name and the average unit price avg (total / quantity), if the product is not sold, it is not included in the report.
select name, avg(total/quantity) from product join sale using(product_id) group by name DESC

-- 7. Get the names of all products that were sold only from a single warehouse
select name from (select distinct(name), store_id from product join sale using(product_id)) s group by name having count(store_id) = 1

-- 8. Get the names of all the warehouses from which only one product was sold
select name from (select distinct(store.name), product.name as pname from store join sale using(store_id) join product using(product_id)) s group by name having count(pname) = 1

-- 9. Select all rows (all fields) from sales in which the amount of sale (total) is maximum (equal to the maximum of all occurring)
select * from sale where total = (select max(total) from sale)

-- 10. Output the date of the most maximum sales, if there are several such dates, then the earliest of them
select ddate from (select date as ddate, sum(total) as ssum from sale group by date) t where ssum = (select max(ssum) as max_s from (select date as ddate, sum(total) as ssum from sale group by date) s)
