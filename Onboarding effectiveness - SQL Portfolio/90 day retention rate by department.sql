--90-Day Retention Rate by Department — Which departments are losing new hires in the first 90 days?
SELECT
     d.department_name,
     COUNT(nh.employee_id) AS total_hires,
     SUM(CASE
             WHEN nh.termination_date IS NULL
               OR DATEDIFF(DAY, nh.hire_date, nh.termination_date) > 90
             THEN 1 ELSE 0
         END) AS retained_90_days,
     ROUND(
         100.0 * SUM(CASE
                         WHEN nh.termination_date IS NULL OR DATEDIFF(DAY, nh.hire_date, nh.termination_date) > 90
                         THEN 1 ELSE 0
                     END) / COUNT(nh.employee_id), 2) AS retention_rate_pct
 FROM NewHires nh
 JOIN Departments d ON nh.department_id = d.department_id
 GROUP BY d.department_name
 ORDER BY retention_rate_pct ASC;