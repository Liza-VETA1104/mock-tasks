--расчет CAC
with users_count as (select u.campaign_id, count(user_id) as users_from_camp
from users u 
group by campaign_id) --в подзапросе общее кол-во пользователей для каждой камании
select campaign_name, round(spent/users_from_camp, 0) as CAC -- затраты на каждую кампанию/общее кол-во пользователей каждой кампании
from campaigns c
join users_count u on u.campaign_id = c.campaign_id 
order by CAC desc
