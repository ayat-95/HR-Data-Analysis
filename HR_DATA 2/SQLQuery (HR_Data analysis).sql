select* from Absenteeism_at_work
select* from compensation
select* from Reasons



--============KPIs===============
--======Total Num Of Absence

selEct  count (id)  as Total_num_Of_absence   from Absenteeism_at_work
Where Absenteeism_time_in_hours >0 

--======Total Num Of not_Absence======

selEct  count (id)  as Total_num_Of_non_absence   from Absenteeism_at_work
Where Absenteeism_time_in_hours =0

--======= AVG absence time in hours=====

select avg( Absenteeism_time_in_hours) as AVG_absence_time_in_hours  from Absenteeism_at_work
where Absenteeism_time_in_hours>0

--======== Avg absence in day

select avg(day_of_the_week) as avg_day_of_week  from Absenteeism_at_work


--==============Health & best_employ===========

select  count (ID)  as Health_best_employ from Absenteeism_at_work
where Social_drinker=0 and Social_smoker=0 and Body_mass_index <25 and Absenteeism_time_in_hours< 
(select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

--===================================================Trend============================(2)

 --======= age & absence per hour 

 select age
 , sum(Absenteeism_time_in_hours) as absence_per_hours from Absenteeism_at_work
 group by age

 --============= distance & Absenteeism_time_in_hours===========

  select Distance_from_Residence_to_Work, sum(Absenteeism_time_in_hours) as Absence_hours
   from Absenteeism_at_work
   group by  Distance_from_Residence_to_Work
   order by sum(Absenteeism_time_in_hours) desc

   --=========== employee & comp.hr ==============
   
    select (comp_hr) As Comp_hr , COUNT (A.ID) as #_of_employee from Absenteeism_at_work as A
 join compensation as o
 on A.ID =o.ID
 group by Comp_hr
 ORDER BY  COUNT (A.ID) DESC

--======== count of Absence per Months==========
select 
case when Month_of_absence=1 then 'Jan'
when Month_of_absence=2 then 'Feb'
when Month_of_absence=3 then 'Mar'
when Month_of_absence=4 then 'Apr'
when Month_of_absence=5 then 'May'
when Month_of_absence=6 then 'Jun'
when Month_of_absence=7 then 'Jul'
when Month_of_absence=8 then 'Aug'
when Month_of_absence=9 then 'Sep'
when Month_of_absence=10then 'Oct'
when Month_of_absence=11 then 'Nov'
when Month_of_absence=12 then 'Dec'
end as Month, 
count (id) as count_of_absence
from Absenteeism_at_work
where Absenteeism_time_in_hours >0
group by Month_of_absence
having Month_of_absence >0
order by  Month_of_absence 


--======== count of Absence per weeks ============

selEct 
case 
when Day_of_the_week=2 then 'Mon'
when Day_of_the_week=3 then 'Tus'
when Day_of_the_week=4 then 'Wend'
when Day_of_the_week=5 then 'Thur'
when Day_of_the_week=6 then 'Fri'
end as day_of_week, count (id)  as Total_num_Of_absence 

from Absenteeism_at_work
Where Absenteeism_time_in_hours >0 
group by Day_of_the_week
order by Day_of_the_week

--==========Absence per seasons==============
 
 select  case
 when Seasons=1 then 'winter'
 when Seasons=2 then 'spring'
 when Seasons=3 then 'summer'
 else 'Autoum'
 end as seasons
 ,count (id) as count_of_absence  from Absenteeism_at_work
 where Absenteeism_time_in_hours>0
 group by Seasons
 order by count (id) desc

--=============== Age Group & Absence time
 WITH NEWtABLE (age_group,Absenteeism_time_in_hours ) AS (
  select 
   case when age between 20 AND 30 Then '20-30'
  when age between 31 and 40 then '31-40'
  when age between 41 and 50 then  '41-50'
  else '>50' end as  age_group
 ,Absenteeism_time_in_hours from Absenteeism_at_work
 ) 
 select age_group, sum(Absenteeism_time_in_hours)  FROM NEWtABLE
  group by age_group

 --========= Education and Absence Time in hours

  select Education
 , sum(Absenteeism_time_in_hours) as absence_per_hours from Absenteeism_at_work
 group by Education
 order by absence_per_hours desc

  --========= Education and Absence employee

  select Education
 , count(id) as employee_Absence from Absenteeism_at_work
 where Absenteeism_time_in_hours>0
 group by Education
 order by employee_Absence desc

  --===================distance from worke and absence Time in hour=======
  with distance_group ( categorydistance ,Absenteeism_time_in_hours) as (
 select
 case when Distance_from_Residence_to_Work < 6then'near'
  when Distance_from_Residence_to_Work between  6 and 26  then 'medile'
   when Distance_from_Residence_to_Work between 27and 47 then 'far'
   else 'too far'
   end as  categorydistance , Absenteeism_time_in_hours
   from Absenteeism_at_work)
   select categorydistance , sum( Absenteeism_time_in_hours ) as Absence_Time from distance_group
   group by categorydistance
  

   --===============Hit_target and count (id)========================

 select Disciplinary_failure,count(Disciplinary_failure) as count from Absenteeism_at_work
 group by Disciplinary_failure


 --=========service time & absecnce hours

 select  Service_time,sum(Absenteeism_time_in_hours)  as absence_hour from Absenteeism_at_work
 where Absenteeism_time_in_hours>0
 group by Service_time
 order by Service_time desc

   --========== Top (10)The reason of highest absence hours

  select  Top (10) Reason  ,    sum(Absenteeism_time_in_hours) as Total_Absence_by_hours from Absenteeism_at_work as A 
 join Reasons AS R
 on A.Reason_for_absence=R.Number
 group by Reason
 order by sum( Absenteeism_time_in_hours) desc

--==============Health & best_employ===========

select  top (10) id as emloyee,Service_time,Education,Disciplinary_failure from Absenteeism_at_work
where Social_drinker=0 and Social_smoker=0 and Body_mass_index <25 and Absenteeism_time_in_hours >0 and Absenteeism_time_in_hours< 
(select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)
order by Absenteeism_time_in_hours asc


 select Distance_from_Residence_to_Work,Absenteeism_time_in_hours

   from Absenteeism_at_work





