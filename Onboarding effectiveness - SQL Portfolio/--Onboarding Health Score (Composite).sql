--Onboarding Health Score (Composite)
--Which employees had the strongest overall onboarding?
With TaskScores AS 
(Select
    employee_id,
    Round(100.0 * SUM(CAST(is_completed as int)) / COUNT(employee_id), 2) as Task_Completion_Rate
    From OnboardingTasks
    Group by employee_id
),
 CheckinScores AS
(Select
    employee_id,
    Round(100.0 * SUM(CAST(manager_completed as int)) / COUNT(employee_id), 2) as Checkin_Completion_Rate
    From ManagerCheckins
    Group by employee_id
),
SurveyScores AS
(Select
    employee_id,
    Round(AVG(CAST(overall_satisfaction AS float)) * 20, 2) as Survey_Score_Rate
    From NewHireSurveys
    Group by employee_id
),
TrainingScores AS
(Select
    employee_id,
    Round(Avg(CAST(score as float)), 2) as Training_Score
    From TrainingRecords
    Where is_completed=1
    Group by employee_id
)
Select
    nh.employee_id,
    nh.department_id,
    ts.Task_Completion_Rate,
    cs.Checkin_Completion_Rate,
    ss.Survey_Score_Rate,
    tr.Training_Score,
    Round((ts.Task_Completion_Rate * 0.30 + cs.Checkin_Completion_Rate * 0.20 + ss.Survey_Score_Rate * 0.25 + tr.Training_Score * 0.25), 2) as Onboarding_Health_Score
    From NewHires as nh
    Left Join TaskScores as ts
    On nh.employee_id=ts.employee_id
    Left Join CheckinScores as cs
    On nh.employee_id=cs.employee_id
    Left Join SurveyScores as ss
    On nh.employee_id=ss.employee_id
    Left Join TrainingScores as tr
    On nh.employee_id=tr.employee_id
    Order by Onboarding_Health_Score desc;