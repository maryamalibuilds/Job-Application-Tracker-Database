-- Job Application Tracker Database
-- Advanced SQL portfolio project

DROP DATABASE IF EXISTS job_application_tracker;
CREATE DATABASE job_application_tracker;
USE job_application_tracker;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(150) NOT NULL UNIQUE,
    industry VARCHAR(100),
    location_city VARCHAR(100),
    company_size VARCHAR(50),
    website VARCHAR(200)
);

CREATE TABLE job_roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_title VARCHAR(150) NOT NULL,
    department VARCHAR(100),
    employment_type VARCHAR(50),
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    currency VARCHAR(10) DEFAULT 'AED'
);

CREATE TABLE application_statuses (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    stage_order INT NOT NULL
);

CREATE TABLE application_sources (
    source_id INT PRIMARY KEY AUTO_INCREMENT,
    source_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    company_id INT NOT NULL,
    role_id INT NOT NULL,
    source_id INT,
    status_id INT NOT NULL,
    application_date DATE NOT NULL,
    referral_flag BOOLEAN DEFAULT FALSE,
    remote_flag BOOLEAN DEFAULT FALSE,
    expected_salary DECIMAL(10,2),
    priority_level VARCHAR(20),
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (role_id) REFERENCES job_roles(role_id),
    FOREIGN KEY (source_id) REFERENCES application_sources(source_id),
    FOREIGN KEY (status_id) REFERENCES application_statuses(status_id)
);

CREATE TABLE interviews (
    interview_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    interview_round INT NOT NULL,
    interview_type VARCHAR(50),
    interview_date DATE NOT NULL,
    outcome VARCHAR(50),
    interviewer_name VARCHAR(100),
    feedback_notes TEXT,
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);

CREATE TABLE follow_ups (
    follow_up_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    follow_up_date DATE NOT NULL,
    follow_up_method VARCHAR(50),
    response_received BOOLEAN DEFAULT FALSE,
    response_notes TEXT,
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);

CREATE TABLE skill_tags (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE role_skills (
    role_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (role_id, skill_id),
    FOREIGN KEY (role_id) REFERENCES job_roles(role_id),
    FOREIGN KEY (skill_id) REFERENCES skill_tags(skill_id)
);

INSERT INTO users (full_name, email, city) VALUES
('Maryam Ali', 'maryamali.builds@gmail.com', 'Dubai');

INSERT INTO companies (company_name, industry, location_city, company_size, website) VALUES
('Careem', 'Technology', 'Dubai', 'Large', 'https://www.careem.com'),
('Noon', 'E-commerce', 'Dubai', 'Large', 'https://www.noon.com'),
('Talabat', 'Food Delivery', 'Dubai', 'Large', 'https://www.talabat.com'),
('Emirates Group', 'Aviation', 'Dubai', 'Enterprise', 'https://www.emirates.com'),
('Kitopi', 'Cloud Kitchens', 'Dubai', 'Large', 'https://www.kitopi.com'),
('Property Finder', 'Real Estate Tech', 'Dubai', 'Large', 'https://www.propertyfinder.ae'),
('Deriv', 'FinTech', 'Dubai', 'Large', 'https://www.deriv.com'),
('Bayut', 'Property Tech', 'Dubai', 'Large', 'https://www.bayut.com'),
('Mashreq', 'Banking', 'Dubai', 'Enterprise', 'https://www.mashreq.com'),
('InstaShop', 'E-commerce', 'Dubai', 'Large', 'https://www.instashop.com');

INSERT INTO job_roles (role_title, department, employment_type, salary_min, salary_max, currency) VALUES
('Data Analyst Intern', 'Data', 'Internship', 3000, 6000, 'AED'),
('Junior Software Engineer', 'Engineering', 'Full-time', 8000, 14000, 'AED'),
('Business Intelligence Analyst', 'Analytics', 'Full-time', 9000, 15000, 'AED'),
('Machine Learning Intern', 'AI', 'Internship', 3500, 6500, 'AED'),
('Frontend Developer Intern', 'Engineering', 'Internship', 3000, 5500, 'AED'),
('Product Analyst', 'Product', 'Full-time', 10000, 17000, 'AED'),
('SQL Developer', 'Data', 'Full-time', 9000, 16000, 'AED'),
('Operations Analyst', 'Operations', 'Full-time', 7000, 12000, 'AED');

INSERT INTO application_statuses (status_name, stage_order) VALUES
('Applied', 1),
('Screening', 2),
('Interview', 3),
('Final Interview', 4),
('Offer', 5),
('Rejected', 6),
('Withdrawn', 7);

INSERT INTO application_sources (source_name) VALUES
('LinkedIn'),
('Company Website'),
('Referral'),
('Indeed'),
('Bayt');

INSERT INTO skill_tags (skill_name) VALUES
('Python'),
('SQL'),
('JavaScript'),
('HTML'),
('CSS'),
('Power BI'),
('Machine Learning'),
('Data Analysis'),
('Tableau'),
('Git');

INSERT INTO role_skills (role_id, skill_id) VALUES
(1, 1), (1, 2), (1, 8),
(2, 1), (2, 3), (2, 10),
(3, 2), (3, 6), (3, 8),
(4, 1), (4, 7), (4, 8),
(5, 3), (5, 4), (5, 5),
(6, 1), (6, 2), (6, 8),
(7, 2), (7, 10),
(8, 2), (8, 8);

INSERT INTO applications (
    user_id, company_id, role_id, source_id, status_id, application_date,
    referral_flag, remote_flag, expected_salary, priority_level, notes
) VALUES
(1, 1, 1, 1, 3, '2026-03-01', FALSE, TRUE, 5000, 'High', 'Strong match for analytics internship'),
(1, 2, 2, 2, 1, '2026-03-04', FALSE, FALSE, 11000, 'Medium', 'Applied through careers page'),
(1, 3, 6, 1, 2, '2026-03-06', FALSE, TRUE, 13000, 'High', 'Interested in product analytics'),
(1, 4, 3, 2, 6, '2026-03-08', FALSE, FALSE, 12000, 'Medium', 'Rejected after screening'),
(1, 5, 4, 1, 3, '2026-03-10', FALSE, TRUE, 5500, 'High', 'Technical interview scheduled'),
(1, 6, 5, 3, 5, '2026-03-12', TRUE, FALSE, 5000, 'High', 'Offer received'),
(1, 7, 7, 1, 2, '2026-03-14', FALSE, TRUE, 14500, 'High', 'Awaiting next round'),
(1, 8, 1, 4, 1, '2026-03-16', FALSE, FALSE, 5500, 'Low', 'Backup internship option'),
(1, 9, 8, 2, 6, '2026-03-18', FALSE, FALSE, 9000, 'Low', 'Not shortlisted'),
(1, 10, 6, 1, 4, '2026-03-20', FALSE, TRUE, 14000, 'High', 'Final interview coming up');

INSERT INTO interviews (
    application_id, interview_round, interview_type, interview_date,
    outcome, interviewer_name, feedback_notes
) VALUES
(1, 1, 'Phone', '2026-03-05', 'Passed', 'Amina Khan', 'Strong communication'),
(1, 2, 'Technical', '2026-03-11', 'Pending', 'Omar Saeed', 'SQL and Python round'),
(3, 1, 'HR', '2026-03-09', 'Passed', 'Layla Noor', 'Good product thinking'),
(5, 1, 'Technical', '2026-03-15', 'Passed', 'M. Rahman', 'Good ML basics'),
(6, 1, 'Managerial', '2026-03-17', 'Passed', 'Sara Ali', 'Positive feedback'),
(10, 1, 'Final', '2026-03-25', 'Pending', 'Nadine Yusuf', 'Awaiting decision');

INSERT INTO follow_ups (
    application_id, follow_up_date, follow_up_method, response_received, response_notes
) VALUES
(2, '2026-03-09', 'Email', FALSE, 'No response yet'),
(3, '2026-03-11', 'LinkedIn', TRUE, 'Recruiter replied with screening update'),
(7, '2026-03-18', 'Email', TRUE, 'Application under review'),
(8, '2026-03-21', 'Call', FALSE, 'No callback yet'),
(10, '2026-03-27', 'Email', TRUE, 'Final decision expected soon');

-- Portfolio queries

SELECT
    a.application_id,
    c.company_name,
    r.role_title,
    s.status_name,
    src.source_name,
    a.application_date,
    a.priority_level
FROM applications a
JOIN companies c ON a.company_id = c.company_id
JOIN job_roles r ON a.role_id = r.role_id
JOIN application_statuses s ON a.status_id = s.status_id
LEFT JOIN application_sources src ON a.source_id = src.source_id
ORDER BY a.application_date;

SELECT
    s.status_name,
    COUNT(*) AS total_applications
FROM applications a
JOIN application_statuses s ON a.status_id = s.status_id
GROUP BY s.status_name
ORDER BY total_applications DESC;

SELECT
    c.company_name,
    r.role_title,
    s.status_name,
    a.application_date
FROM applications a
JOIN companies c ON a.company_id = c.company_id
JOIN job_roles r ON a.role_id = r.role_id
JOIN application_statuses s ON a.status_id = s.status_id
WHERE s.stage_order >= 3 AND s.stage_order <= 5
ORDER BY s.stage_order, a.application_date;

SELECT
    c.company_name,
    COUNT(*) AS applications_sent
FROM applications a
JOIN companies c ON a.company_id = c.company_id
GROUP BY c.company_name
ORDER BY applications_sent DESC, c.company_name;

SELECT
    r.role_title,
    ROUND(AVG(a.expected_salary), 2) AS avg_expected_salary
FROM applications a
JOIN job_roles r ON a.role_id = r.role_id
GROUP BY r.role_title
ORDER BY avg_expected_salary DESC;

SELECT
    DATE_FORMAT(application_date, '%Y-%m') AS application_month,
    COUNT(*) AS total_sent
FROM applications
GROUP BY DATE_FORMAT(application_date, '%Y-%m')
ORDER BY application_month;

SELECT
    interview_type,
    COUNT(*) AS total_interviews,
    SUM(CASE WHEN outcome = 'Passed' THEN 1 ELSE 0 END) AS passed_count,
    SUM(CASE WHEN outcome = 'Failed' THEN 1 ELSE 0 END) AS failed_count,
    SUM(CASE WHEN outcome = 'Pending' THEN 1 ELSE 0 END) AS pending_count
FROM interviews
GROUP BY interview_type
ORDER BY total_interviews DESC;

SELECT
    r.role_title,
    c.company_name,
    s.status_name
FROM applications a
JOIN job_roles r ON a.role_id = r.role_id
JOIN companies c ON a.company_id = c.company_id
JOIN application_statuses s ON a.status_id = s.status_id
JOIN role_skills rs ON r.role_id = rs.role_id
JOIN skill_tags st ON rs.skill_id = st.skill_id
WHERE st.skill_name = 'SQL'
ORDER BY c.company_name;

SELECT
    c.company_name,
    r.role_title,
    f.follow_up_date,
    f.follow_up_method,
    f.response_received
FROM follow_ups f
JOIN applications a ON f.application_id = a.application_id
JOIN companies c ON a.company_id = c.company_id
JOIN job_roles r ON a.role_id = r.role_id
WHERE f.response_received = FALSE
ORDER BY f.follow_up_date;

SELECT
    c.company_name,
    r.role_title,
    s.status_name,
    a.referral_flag
FROM applications a
JOIN companies c ON a.company_id = c.company_id
JOIN job_roles r ON a.role_id = r.role_id
JOIN application_statuses s ON a.status_id = s.status_id
WHERE a.referral_flag = TRUE;

SELECT
    c.company_name,
    r.role_title,
    r.salary_max,
    s.status_name
FROM applications a
JOIN companies c ON a.company_id = c.company_id
JOIN job_roles r ON a.role_id = r.role_id
JOIN application_statuses s ON a.status_id = s.status_id
WHERE s.status_name NOT IN ('Rejected', 'Withdrawn')
ORDER BY r.salary_max DESC
LIMIT 1;

CREATE OR REPLACE VIEW application_summary_view AS
SELECT
    a.application_id,
    u.full_name,
    c.company_name,
    c.industry,
    r.role_title,
    r.department,
    s.status_name,
    src.source_name,
    a.application_date,
    a.priority_level,
    a.expected_salary,
    a.referral_flag,
    a.remote_flag
FROM applications a
JOIN users u ON a.user_id = u.user_id
JOIN companies c ON a.company_id = c.company_id
JOIN job_roles r ON a.role_id = r.role_id
JOIN application_statuses s ON a.status_id = s.status_id
LEFT JOIN application_sources src ON a.source_id = src.source_id;

SELECT *
FROM application_summary_view
ORDER BY application_date DESC;
