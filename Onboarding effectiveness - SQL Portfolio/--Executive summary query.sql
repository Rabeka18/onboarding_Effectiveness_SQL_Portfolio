--Executive summary query
--One query that tells the whole story
SELECT
     d.department_name,
     ROUND(AVG(CAST(ot.is_completed AS FLOAT)) * 100, 2)   AS avg_task_completion,
     ROUND(
         100.0 * SUM(CASE
             WHEN nh.termination_date IS NULL
               OR DATEDIFF(DAY, nh.hire_date, nh.termination_date) > 90
             THEN 1 ELSE 0 END
         ) / COUNT(DISTINCT nh.employee_id), 2
     )                                                      AS retention_rate,
     ROUND(AVG(CAST(s.overall_satisfaction AS FLOAT)), 2)   AS avg_satisfaction
 FROM Departments d
 JOIN NewHires nh           ON d.department_id = nh.department_id
 JOIN OnboardingTasks ot    ON nh.employee_id  = ot.employee_id
 LEFT JOIN NewHireSurveys s ON nh.employee_id  = s.employee_id
 GROUP BY d.department_name
 ORDER BY avg_task_completion DESC;