with for_ltv as(
	select u.user_id, 
		coalesce(o.total_amount, 0) as amount, 
		c.campaign_name
	from users u 
	left join orders o on u.user_id = o.user_id
	join campaigns c on c.campaign_id = u.campaign_id
	where u.campaign_id is not null),
users_count as (select u.campaign_id, count(user_id) as users_from_camp
from users u 
group by campaign_id),
cac as(
select campaign_name, round(spent/users_from_camp, 0) as CAC
from campaigns c
join users_count u on u.campaign_id = c.campaign_id 
order by CAC)	
select l.campaign_name, 
	round(sum(amount)/count(distinct l.user_id)/c.cac, 2) as ltv_cac_ratio
from for_ltv l
join cac c on c.campaign_name = l.campaign_name
group by l.campaign_name, c.cac 
order by 2 desc










