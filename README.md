# Job Application Tracker Database

An advanced SQL portfolio project that models a real-world job application tracking system.

## Project Focus
This project simulates a realistic workflow for managing internship and job applications.  
It tracks companies, roles, statuses, interviews, follow-ups, and skills while supporting reporting through practical SQL queries.

## Features
- Relational database schema with multiple linked tables
- Application tracking by company, role, and status
- Interview stage management
- Follow-up tracking
- Skill mapping for job roles
- Practical reporting queries
- Aggregation, joins, filtering, grouping, and a summary view

## Database Tables
- `users`
- `companies`
- `job_roles`
- `application_statuses`
- `application_sources`
- `applications`
- `interviews`
- `follow_ups`
- `skill_tags`
- `role_skills`

## SQL Concepts Demonstrated
- Database and table creation
- Primary keys and foreign keys
- One-to-many and many-to-many relationships
- `JOIN`
- `GROUP BY`
- `ORDER BY`
- `AVG`, `COUNT`, `SUM`
- `CASE WHEN`
- Views
- Filtering by business logic

## Example Insights
The included queries allow analysis such as:
- total applications by status
- top companies by application volume
- interview performance summary
- roles that require SQL
- follow-ups that still need attention
- highest salary active opportunity
- monthly application activity

## Files
- `job_application_tracker.sql` — full database schema, seed data, and analysis queries

## How to Run
1. Open MySQL Workbench, phpMyAdmin, or another SQL environment.
2. Run the full `job_application_tracker.sql` script.
3. Execute the included queries section by section.
4. Use the generated tables and view for reporting.

## Why This Project Is Strong
This project goes beyond a basic academic database by modeling a practical workflow with business-style reporting.  
It demonstrates both database design and analysis skills relevant to internship and entry-level data roles.
