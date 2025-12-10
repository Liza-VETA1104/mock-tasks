
with gross_profit as(select oi.order_id,
	sum(oi.total_price) - sum(oi.quantity * p."cost") as gross_profit
from products p
join order_items oi on p.product_id = oi.product_id 
group by oi.order_id)
select c.campaign_name,
	round((sum(g.gross_profit)-c.spent)/c.spent, 2) as romi
from users u 
join campaigns c on c.campaign_id = u.campaign_id 
left join orders o on o.user_id = u.user_id 
left join gross_profit g on o.order_id = g.order_id
group by c.campaign_name, c.spent 
order by romi desc




