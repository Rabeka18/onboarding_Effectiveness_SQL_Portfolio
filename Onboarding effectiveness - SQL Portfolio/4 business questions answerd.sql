--Answered 4 business questions
--Business question: What percentage of onboarding tasks were completed overall? By department?
Select 
Department_name,
Count(*) as total_tasks,
Count(CASE WHEN is_completed = 1 THEN 1 END) as completed_tasks,
Concat(round(Count(CASE WHEN is_completed = 1 THEN 1 END) * 100.0 / Count(*), 2), '%') as percent_completed
From OnboardingTasks as OT
join newhires as NH on OT.employee_id = NH.employee_id
join departments as D on NH.department_id = D.department_id
Group by D.department_name
order by percent_completed desc;

--Manager checkins completion rate
Select
count(case when manager_completed = 1 then 1 end) as completed_checkins,
count(*) as total_checkins,
concat(round(count(case when manager_completed = 1 then 1 end) * 100.0 / count(*), 2), '%') as percent_completed
From ManagerCheckins

--Training completion rate by category
--Business question: Which training categories have the lowest completion rates?
Select
training_category,
count(case when is_completed = 1 then 1 end) as completed_trainings,
count(*) as total_trainings,
concat(round(count(case when is_completed = 1 then 1 end) * 100.0 / count(*), 2), '%') as percent_completed
From TrainingRecords
Group by training_category
order by percent_completed desc;

--Average Survey Scores by Department
--Business question: How satisfied are new hires with onboarding, by department?
SELECT
     d.department_name,
     ROUND(AVG(CAST(s.overall_satisfaction AS FLOAT)), 2)  AS avg_overall,
     ROUND(AVG(CAST(s.manager_support AS FLOAT)), 2)       AS avg_manager_support,
     ROUND(AVG(CAST(s.training_quality AS FLOAT)), 2)      AS avg_training_quality,
     ROUND(AVG(CAST(s.onboarding_clarity AS FLOAT)), 2)    AS avg_clarity
 FROM NewHireSurveys s
 JOIN NewHires nh ON s.employee_id = nh.employee_id
 JOIN Departments d  ON nh.department_id = d.department_id
 GROUP BY d.department_name
 ORDER BY avg_overall DESC;
