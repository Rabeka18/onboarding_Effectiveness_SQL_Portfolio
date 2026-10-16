--Rolling 30-Day Hire Trend
--How did hiring volume change month by month?
SELECT
Format(hire_date, 'MMMM') as Hire_Month,
Count(employee_id)as Total_Hires
FROM NewHires
Group by Format(hire_date, 'MMMM')
order by Format(hire_date, 'MMMM') 