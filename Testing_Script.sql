create database hr;
use hr;
select *  from hr_data;
drop table hr_data;
select count(*) from hr_data;
select * from hr_data;


-- KPI- Employee Count
select sum(`Employee Count`) as "Employee Count" from hr_data;

-- KPI- Attrition Count
select count(Attrition) from hr_data
where Attrition = "Yes";

-- KPI- Attrition Rate
select round(((select count(Attrition) as Attrition_Count from hr_data
where Attrition = "Yes") / sum(`Employee Count`)) * 100,2) as "Attrition Rate" from hr_data;


-- KPI- Active Employee

select sum(`Employee Count`) - (select count(Attrition) as Attrition_Count from hr_data
where Attrition = "Yes") as 'Active Employees' from hr_data;

-- KPI- Average Age
select round(avg(Age),0) as "Average Age"
from hr_data;

-- Attrition by Gender
select gender, count(Attrition) as "Attrition Count" from hr_data
where Attrition = 'Yes'
group by gender;

-- Department wise Attrition
select department, count(Attrition) as "Attrition Count", round(cast(count(Attrition) as decimal) /
(select count(Attrition) from hr_data where Attrition = 'Yes')*100, 2) as pct 
 from hr_data
where Attrition = 'Yes'
group by department
order by pct desc;

-- No of Employee by Age Group
select `cf_age band`, count(`Employee Count`) as Employee_Count
from hr_data
group by `cf_age band`
order by Employee_count desc;


-- Education Field wise Attrition
select Education, count(Attrition), round(cast(count(Attrition) as decimal) / 
(select count(Attrition) from hr_data where Attrition = 'Yes')*100 , 2) as pct
from hr_data
where Attrition = 'Yes'
group by Education; 

-- Attrition Rate by Gender for different Age group
select `Job Role`,
sum(case when `job satisfaction` = 1 Then `Employee Count` else 0 End) as One,
sum(case when `job satisfaction` = 2 Then `Employee Count` else 0 End) as Two,
sum(case when `job satisfaction` = 3 Then `Employee Count` else 0 End) as Three,
sum(case when `job satisfaction` = 4 Then `Employee Count` else 0 End) as Four
from hr_data
group by `Job Role`
order by `Job Role`;