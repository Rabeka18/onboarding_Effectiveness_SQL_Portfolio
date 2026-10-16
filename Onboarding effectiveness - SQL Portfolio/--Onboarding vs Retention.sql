--Onboarding vs Retention
--Do employees who completed onboarding tasks actually stay longer?
 WITH TaskCompletion AS (
     SELECT
         nh.employee_id,
         nh.hire_date,
         nh.termination_date,
         COUNT(ot.task_id) AS total_tasks,
         SUM(CAST(ot.is_completed AS INT)) AS completed_tasks,
         ROUND(
             100.0 * SUM(CAST(ot.is_completed AS INT)) / COUNT(ot.task_id), 2
         ) AS completion_pct
     FROM NewHires nh
     JOIN OnboardingTasks ot ON nh.employee_id = ot.employee_id
     GROUP BY nh.employee_id, nh.hire_date, nh.termination_date
 )
SELECT
     CASE
         WHEN completion_pct >= 90 THEN 'High (90-100%)'
         WHEN completion_pct >= 70 THEN 'Medium (70-89%)'
         ELSE 'Low (<70%)'
     END AS completion_tier,
     COUNT(*) AS employee_count,
     SUM(CASE
             WHEN termination_date IS NULL
               OR DATEDIFF(DAY, hire_date, termination_date) > 90
             THEN 1 ELSE 0
         END) AS retained_90_days,
     ROUND(
         100.0 * SUM(CASE
                         WHEN termination_date IS NULL
                           OR DATEDIFF(DAY, hire_date, termination_date) > 90
                         THEN 1 ELSE 0
                     END) / COUNT(*), 2
     ) AS retention_rate_pct
 FROM TaskCompletion
 GROUP BY
     CASE
         WHEN completion_pct >= 90 THEN 'High (90-100%)'
         WHEN completion_pct >= 70 THEN 'Medium (70-89%)'
         ELSE 'Low (<70%)'
     END
ORDER BY retention_rate_pct DESC;