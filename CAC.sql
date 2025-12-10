with users_count as (select u.campaign_id, count(user_id) as users_from_camp
from users u 
group by campaign_id)
select campaign_name, round(spent/users_from_camp, 0) as CAC 
from campaigns c
join users_count u on u.campaign_id = c.campaign_id 
order by CAC desc

