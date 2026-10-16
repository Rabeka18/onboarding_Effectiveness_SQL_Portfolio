 --Manager Check-In Frequency vs. Retention

 WITH CheckinCounts AS (
     SELECT
         mc.employee_id,
         COUNT(mc.checkin_id)                                        AS total_checkins,
         SUM(CAST(mc.manager_completed AS INT))                      AS completed_checkins
     FROM ManagerCheckins mc
     GROUP BY mc.employee_id
)
 SELECT
     CASE
         WHEN cc.completed_checkins >= 4 THEN 'High (4+)'
         WHEN cc.completed_checkins >= 2 THEN 'Medium (2-3)'
         ELSE 'Low (0-1)'
     END                                                             AS checkin_tier,
     COUNT(*)                                                        AS employee_count,
     SUM(CASE
             WHEN nh.termination_date IS NULL
               OR DATEDIFF(DAY, nh.hire_date, nh.termination_date) > 90
             THEN 1 ELSE 0
         END)                                                        AS retained_90_days,
     ROUND(
         100.0 * SUM(CASE
                         WHEN nh.termination_date IS NULL
                           OR DATEDIFF(DAY, nh.hire_date, nh.termination_date) > 90
                         THEN 1 ELSE 0
                     END) / COUNT(*), 2
     )                                                               AS retention_rate_pct
 FROM CheckinCounts cc
 JOIN NewHires nh ON cc.employee_id = nh.employee_id
 GROUP BY
     CASE
         WHEN cc.completed_checkins >= 4 THEN 'High (4+)'
         WHEN cc.completed_checkins >= 2 THEN 'Medium (2-3)'
         ELSE 'Low (0-1)'
    END
 ORDER BY retention_rate_pct DESC;