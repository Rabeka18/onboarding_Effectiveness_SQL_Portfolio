--Department Onboarding Scorecard with RANK()
--How does each department rank across all metrics?
 WITH DeptMetrics AS (
     SELECT
         d.department_name,
         ROUND(AVG(CAST(ot.is_completed AS FLOAT)) * 100, 2) AS avg_task_completion,
         ROUND(100 * SUM(CASE 
                 WHEN nh.termination_date IS NULL OR DATEDIFF(DAY, nh.hire_date, nh.termination_date) > 90 THEN 1 ELSE 0 END) / COUNT(nh.employee_id), 2) AS Retention_Rate,
         ROUND(AVG(CAST(s.overall_satisfaction AS FLOAT)), 2) AS avg_satisfaction
     FROM Departments d
     JOIN NewHires nh        
     ON d.department_id = nh.department_id
     JOIN OnboardingTasks ot 
     ON nh.employee_id  = ot.employee_id
     LEFT JOIN NewHireSurveys s 
     ON nh.employee_id  = s.employee_id
     GROUP BY d.department_name
 )
SELECT
     department_name,
     avg_task_completion,
     retention_rate,
     avg_satisfaction,
     RANK() OVER (ORDER BY avg_task_completion DESC) AS task_rank,
     RANK() OVER (ORDER BY retention_rate DESC)      AS retention_rank,
     RANK() OVER (ORDER BY avg_satisfaction DESC)    AS satisfaction_rank
 FROM DeptMetrics
 ORDER BY retention_rank ASC;