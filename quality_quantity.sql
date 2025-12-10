select c.campaign_name, 
	round(count(distinct o.user_id)*100.0/count(distinct u.user_id), 2) as conversion_rate
from users u 
join campaigns c on u.campaign_id = c.campaign_id
left join orders o on u.user_id = o.user_id 
group by c.campaign_name 
order by conversion_rate desc


