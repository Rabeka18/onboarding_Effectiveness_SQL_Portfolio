--At Risk new hire identification
--Which current employees show early warning signs?
With TaskScore AS (
    SELECT
        employee_id,
        COALESCE(Round(100.0*Sum(Cast(is_completed as int))/Count(task_id),2),0) as Task_Completion_Rate
        FROM OnboardingTasks
        Group by employee_id),
    CheckinScore AS (
    SELECT
        employee_id,
        Round(100*Sum(Cast(manager_completed as int))/Count(checkin_id),2) as Checkin_Completion_Rate
        FROM ManagerCheckins
        Group by employee_id)
    Select
    nh.employee_id,
    nh.department_id,
    ts.Task_Completion_Rate,
    cs.Checkin_Completion_Rate,
    CASE
        WHEN ts.Task_Completion_Rate is null THEN 'No Survey Yet'
        WHEN overall_satisfaction <2 THEN 'Low Satisfaction'
        Else 'Satisfied'
    END as Survey_Flag,
    CASE 
        WHEN ts.Task_Completion_Rate < 70 AND cs.Checkin_Completion_Rate < 70 THEN 'High Risk'
        When ts.Task_Completion_Rate < 70 OR cs.Checkin_Completion_Rate < 70 THEN 'Medium Risk'
        ELSE 'On Track' end AS Risk_Flag
    FROM NewHires as nh
    LEFT JOIN TaskScore as ts
    ON nh.employee_id=ts.employee_id
    LEFT JOIN CheckinScore as cs
    ON nh.employee_id=cs.employee_id
    Left JOIN NewHireSurveys as nhs
    ON nh.employee_id=nhs.employee_id
    WHERE nh.termination_date is null
    ORDER BY Risk_Flag ASC;