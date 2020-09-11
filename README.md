# Pewlett-Hackard-Analysis

## Project Overview
Analyze Pewlett Hackard employee database using PostgreSQL to help the company anticipate the "silver tsunami" as many current employees will leave to retirement.\
For this analysis we will:
1. determine the number of retiring employees per title,
2. identify employees who are eligible to participate in a mentorship program.

## Resources
- Data Source: departments.csv, dept_manager.csv, dept_emp.csv, employees.csv, salaries.csv, titles.csv
- Software: PostgreSQL 11.9, Visual Studio Code 1.48.2

## Results

### Number of retiring employees per title
Using the [ERD](https://github.com/cedoula/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png) created previously, the following Retirement Titles table was created and it holds all the titles of employees who were born between January 1st, 1952 and December 31st, 1955.
<br/><br/>
<p align="center">
  <img src="https://user-images.githubusercontent.com/68669675/92820926-2207d400-f390-11ea-8927-a897ea3c5ec8.png">
</p>
<br/>

- 90,398 employees or 37.7% of the company's total current employees will be retiring soon.
- Senior Engineer, Senior Staff and Engineer will be the most impacted positions with respectively 29,414, 28,254 and 14,222 futures retirees, which corresponds to 12.3%, 11.8% and 5.92% of the company's workforce.
<br/><br/>

### Employees eligible for the mentorship program
Using the [ERD](https://github.com/cedoula/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png) created previously, the following Mentorship Eligibility table was created and it holds all the current employees who were born between January 1st, 1965 and December 31st, 1965.
<br/><br/>
<p align="center">
  <img src="https://user-images.githubusercontent.com/68669675/92817992-cee05200-f38c-11ea-8026-ea08d219edbe.png">
  Extract of the mentorship eligibility table 
</p><br/>
<p align="center">
  <img src="https://user-images.githubusercontent.com/68669675/92822282-98f19c80-f391-11ea-9b9c-0b49533a7c79.png">
</p>
<p align="center">Eligible mentors per job title</p><br/>

- There are 1,549 employees eligible to participate in the mentorship program.
- 294 Senior Engineers, 422 Senior Staffs and 395 Engineers are eligbible mentors.
<br/><br/>

## Summary
- 90,398 roles will need to be filled as the "silver tsunami" begins to make an impact.
- There are 1,549 eligible mentors in the company.\
 If we assume that they will all be willing to participate in the mentorship program, it will imply that each mentor would have an average of 58 mentees, so we can conclude that there is not enough mentors to prepare the next generation of Pewlett Hackard employees.
 - The following tables give us the number of retirement-ready employees and the number of eligible mentors per department. It shows that all departments are lacking mentors.<br/><br/>
<p align="center">
  <img src="https://user-images.githubusercontent.com/68669675/92842941-cb0ef880-f3a9-11ea-9ccc-9d68b00d28a3.png">
</p>
<p align="center">Retiring employees per department</p><br/>
<p align="center">
  <img src="https://user-images.githubusercontent.com/68669675/92842962-d06c4300-f3a9-11ea-94d7-d7a1edcc0c0e.png">
</p>
<p align="center">Eligible mentors per department</p><br/>

- Reviewing the criteria to qualify for the mentorship program would be needed by the company to be able to prepare for the coming "silver tsunami".