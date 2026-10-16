HR Onboarding Analytics — SQL Portfolio Project

Project Overview
End-to-end SQL analysis of new hire onboarding effectiveness using a relational database with 6 tables: NewHires, Departments, OnboardingTasks, ManagerCheckins, NewHireSurveys, and TrainingRecords.

Business Questions Answered

Which new hires are at risk of early attrition?

Which departments have the strongest onboarding outcomes?

How do task completion rates correlate with 90-day retention?

What does the rolling hire trend look like over time?

Queries Included
1. Rolling 30-Day Hire Trend

• Business Question: How many new hires joined each month over the past 30 days?

• Key SQL Concepts: DATEDIFF, COUNT, GROUP BY, date filtering

2. Onboarding Health Score (Composite)

• Business Question: Which new hires have the strongest overall onboarding performance?

• Key SQL Concepts: CTEs, AVG, CAST, ROUND, weighted scoring

3. At-Risk New Hire Identification

• Business Question: Which new hires are showing early warning signs of attrition?

• Key SQL Concepts: CTEs, multi-condition CASE WHEN, LEFT JOIN, NULL handling

4. Department Onboarding Scorecard

• Business Question: Which departments are delivering the best onboarding outcomes?

• Key SQL Concepts: RANK() window function, GROUP BY, AVG, ROUND

5. Executive Summary

• Business Question: What is the overall state of onboarding across the organization?

• Key SQL Concepts: CTEs, UNION ALL, aggregation, CAST

6. 90-Day Retention Rate by Department

• Business Question: What percentage of new hires stay past 90 days per department?

• Key SQL Concepts: DATEDIFF, AVG, CAST on BIT columns, GROUP BY

7. Onboarding Completion vs. Retention

• Business Question: Does higher task completion correlate with better retention?

• Key SQL Concepts: AVG, CAST, ROUND, correlation logic

8. Time to First Independent Work

• Business Question: How long does it take new hires to complete all onboarding tasks?

• Key SQL Concepts: DATEDIFF, MIN, MAX, GROUP BY

9. Survey Score vs. Task Completion

• Business Question: Do higher satisfaction scores align with higher task completion?

• Key SQL Concepts: LEFT JOIN, AVG, COALESCE, NULL handling

10. Manager Check-In Frequency vs. Retention

• Business Question: Do more frequent manager check-ins improve 90-day retention?

• Key SQL Concepts: COUNT, AVG, CAST on BIT, GROUP BY

Tools Used
• SQL Server (T-SQL)

• VS Code with SQL extension

• Docker (local database environment)

Key Findings
• 5 departments achieved 100% 90-day retention, yet satisfaction scores ranged from 3.5 to 4.33 — showing retention alone doesn't capture onboarding quality.

• 5 employees flagged with NULL task completion rates, indicating missing onboarding task assignments — an operational gap worth surfacing to HR leadership.

• 3 departments tied at task_rank 6, suggesting uniform mid-tier onboarding quality across those teams.
