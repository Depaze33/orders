/*1*/


/*2*/
select order_id , count(last_name) as commande_number
from order_line 
group by order_id 
order by order_id asc;

/*3*/
update order_line 
set total_price = quantity * unit_price ;

/*4*/
update customer_order co
set total_price_cache = 
(select sum(ol.total_price)
from order_line ol 
where ol.order_id = co.id)

select distinct co.id, co.purchase_date, 
concat( c.last_name, ' ', c.first_name),  co.total_price_cache 
from order_line ol 
join customer_order co 
on ol.order_id = co.id
join client c 
on c.id = co.client_id;

/*5*/
select extract (month from purchase_date ) "month", sum(total_price_cache) as total_price
from customer_order co 
group by extract (month from purchase_date ) ;

/*6*/
select client_id, total_price_cache 
from customer_order co  
order by total_price_cache desc
limit 10;

/*7*/
select purchase_date, sum(total_price_cache) as "total price per day"
from customer_order co 
group by purchase_date;

/*8*/
alter table order_line 
add column category int4;

/*9*/
update order_line 
set category = case 
    when total_price < 200 then 1
    when total_price > 200 and total_price < 500 then 2
    when total_price >500 and total_price <= 1000 then 3
    when total_price > 1000 then 4
    else category 
end;