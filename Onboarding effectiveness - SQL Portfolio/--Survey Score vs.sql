--Survey Score vs. Task Completion Correlation
--Do higher-satisfaction employees complete more tasks?
 WITH EmployeeMetrics AS (
     SELECT
         ot.employee_id,
         ROUND(
             100.0 * SUM(CAST(ot.is_completed AS INT)) / COUNT(ot.task_id), 2
         ) AS task_completion_rate,
         s.overall_satisfaction
     FROM OnboardingTasks ot
     JOIN NewHireSurveys s 
     ON ot.employee_id = s.employee_id
     GROUP BY ot.employee_id, s.overall_satisfaction
)
 SELECT
     overall_satisfaction,
     COUNT(*)  AS employee_count,
     ROUND(AVG(task_completion_rate), 2) AS avg_task_completion_rate
 FROM EmployeeMetrics
 GROUP BY overall_satisfaction
 ORDER BY overall_satisfaction DESC;