use ig_clone;
-- 1.Identify the five oldest users on Instagram from the provided database.
select * from users
order by created_at asc
limit 5;

-- 2.Identify users who have never posted a single photo on Instagram. 
select * from users left join  photos on users.id=photos.user_id
where photos.image_url is null;

-- 3.Determine the winner of the contest and provide their details to the team. 
select p.user_id,p.id,count(l.user_id) as likes_count from photos p
join likes l on p.id=l.photo_id
group by p.id
order by  likes_count desc
limit 1;

-- 4. Identify and suggest the top five most commonly used hashtags on the platform. 
select tags.tag_name,count(photo_tags.tag_id) as common_id from photo_tags 
inner join tags on photo_tags.tag_id=tags.id
group by  tags.tag_name
order by common_id desc
limit 5;

-- 5. Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign 
SELECT dayname(created_at)AS day_of_week,count(username) as count_users FROM users 
group by dayname(created_at)
order by count_users desc 
limit 1;


-- B) Investor Metrics:
-- 1.Calculate the average number of posts per user on Instagram. 
-- Also, provide the total number of photos on Instagram divided by the total number of users.

with ct as (select users.id as userid,count(photos.id) as no_of_photos from users
left join photos on photos.user_id=users.id group by  users.id)
select sum(no_of_photos) as total_no_of_photos,count(userid) as total_no_of_users,sum(no_of_photos)/count(userid) as 
average_no_of_post  from ct;

-- 2.Identify users (potential bots) who have liked every single photo on the site, 
-- as this is not typically possible for a normal user.


select * from photos;
 with ct as (select users.username ,count(likes.photo_id) as lks  from likes inner join 
 users on likes.user_id=users.id group by users.username)
 select username,lks as total_likes from ct where lks =(select count(*) from photos) ;