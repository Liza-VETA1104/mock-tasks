with for_ltv as(
	select u.user_id, 
		coalesce(o.total_amount, 0) as amount, 
		c.campaign_name
	from users u 
	left join orders o on u.user_id = o.user_id
		and o.order_date between u.registration_date  and u.registration_date + interval '30 days'
	join campaigns c on c.campaign_id = u.campaign_id
	where u.campaign_id is not null)
select campaign_name, 
	round(sum(amount)/count(distinct user_id), 2) as ltv_30d
from for_ltv 
group by campaign_name
order by ltv_30d desc

