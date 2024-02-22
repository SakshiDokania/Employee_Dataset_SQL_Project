/*
Below are the codes that brings out some analysis on the employee dataset.
The codes have been written using DML and DCL statements.
*/
-- Question 1: Show the first five thousand employees in the employees table

SELECT EmployeeID   -- specifying the column we want to display
FROM Employees 	    -- specifying the table we want to select data from
ORDER BY EmployeeID -- sorting by EmployeeID
LIMIT 5000;         -- Displaying the first 5000 records.

-- Question 2: Display all employee first names in alphabetical order
SELECT DISTINCT EmployeeFirstName -- Distinct fucntion returns unique names.
FROM Employees                    
ORDER BY EmployeeFirstName;       -- order by lists the names in alphabetical order.

-- Question 3: Show employees who have worked at the University the shortest amount of time 
SELECT EmployeeID, EmployeeFirstName, EmployeeLastName
FROM Employees
-- The maximum value for the year indicates the most recent hire, hence the shortest amount of time worked.
WHERE yearHired = (SELECT MAX(yearHired) FROM Employees); 

-- Question 4: Display the names of all employees whose age is a palindrome  
SELECT EmployeeFirstName, EmployeeLastName, EXTRACT(YEAR FROM CURRENT_DATE) - BirthYear AS Age
FROM Employees
/* The first portion in the where clause extracts the age by subtracting the current year from the birth year.
The cast function converts the age into a string, and reverse finds the reverse of the CHAR string. If both sides are equal,
then the age is a pallindrome. */
WHERE
    (EXTRACT(YEAR FROM CURRENT_DATE) - BirthYear) = 
        REVERSE(CAST((EXTRACT(YEAR FROM CURRENT_DATE) - BirthYear) AS CHAR(3)))
ORDER BY Age; -- sorting by age.
        
/* Question 5: Write a query to display all male and female employees who were not born in 1993 and who 
 will not receive a performance bonus  */
SELECT EmployeeID, EmployeeFirstName, EmployeeLastName, Gender, birthYear, PerformanceBonus
FROM Employees
-- The where clause is used to filter the data by the conditions provided in the question.
WHERE
    birthYear != 1993 AND
    PerformanceBonus = 'F' AND
	Gender IN ('M', 'F')
;

/* Question 6: Add a new attribute called "EmployeeInitials" to the Employees table */
alter table Employees             -- Alter the Employees table.
add EmployeeInitials VARCHAR(10); -- Add a new column EmployeeInitials as VARCHAR(10)


/* Question 7: Display the first names of all employees who work in the department located in Sydney */
select EmployeeFirstName, d.Location  -- Select first name and location columns
from Employees e
inner join DepartmentEmployee de on e.EmployeeID = de.EmployeeID
inner join Departments d on de.DepartmentID = d.DepartmentID
where d.Location = 'Sydney';  -- Filter for location as Sydney.


/* Question 8: Display employee first and last names and work out the original salary for all employees and their new salary after their (10%) bonus is applied */
-- Select required columns and calculate bonus.
select EmployeeFirstName, EmployeeLastName, e.SalaryID, Salary, Salary*1.1 AS SalaryWithBonus 
from Employees e
inner join SalaryClass s on e.SalaryID = s.SalaryID;

/* Question 9: Display how many employees will not receive a performance bonus */
select COUNT(*)               -- Count number of rows
from Employees
where PerformanceBonus = 'F';   -- Where bonus is 'F', that is False.

 
/* Question 10: Write a query that returns the employees with initials that are a palindrome and also return employees without palindrome initials, but output 'not a palindrome!' */
select EmployeeFirstName, EmployeeLastName,   -- Select required columns.
case                                          -- Case statement to check for palindrome.
when upper(left(EmployeeFirstName, 1)) = upper(left(EmployeeLastName, 1)) then concat(upper(left(EmployeeFirstName, 1)), upper(left(EmployeeLastName, 1)))
else 'not a palindrome!' 
end as Initials  -- Output initials or 'not a palindrome.
from Employees;


/* Question 11: Write a query that populates EmployeeInitials, based off the existing stored names */
update Employees   -- Update the Employees table
set EmployeeInitials = concat(upper(left(EmployeeFirstName, 1)), upper(left(EmployeeLastName, 1)));  -- Set initials as concatenation of first letters.


