--Time to First Independent Work by Department
--Business question: How long does it take new hires to become self-sufficient?
SELECT
D.Department_Name,
AVG(Datediff(day,NH.hire_date,NH.First_independent_work_date)) AS Avg_Days_to_Independent_Work
FROM NewHires AS NH
left join Departments AS D
on NH.Department_ID=D.department_ID
Group by D.Department_Name
order by Avg_Days_to_Independent_Work asc