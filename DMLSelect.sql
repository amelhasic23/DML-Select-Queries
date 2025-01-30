-- 1. View: EmployeeJobCandidateInfo
CREATE VIEW EmployeeJobCandidateInfo AS
SELECT 
    LoginId, 
    JobTitle, 
    HumanResources.JobCandidate.Resume
FROM HumanResources.Employee
JOIN HumanResources.JobCandidate
    ON HumanResources.Employee.BusinessEntityID = HumanResources.JobCandidate.BusinessEntityID;

-- SELECT for EmployeeJobCandidateInfo
SELECT * FROM EmployeeJobCandidateInfo;

-- 2. View: CandidatePayHistory
CREATE VIEW CandidatePayHistory AS
SELECT 
    HumanResources.JobCandidate.Resume, 
    HumanResources.EmployeePayHistory.Rate
FROM HumanResources.JobCandidate
JOIN HumanResources.EmployeePayHistory
    ON HumanResources.JobCandidate.BusinessEntityID = HumanResources.EmployeePayHistory.BusinessEntityID
JOIN HumanResources.Employee
    ON HumanResources.Employee.BusinessEntityID = HumanResources.JobCandidate.BusinessEntityID;

-- SELECT for CandidatePayHistory
SELECT * FROM CandidatePayHistory;

-- 3. View: DepartmentJobCandidateInfo
CREATE VIEW DepartmentJobCandidateInfo AS
SELECT 
    HumanResources.Department.Name, 
    HumanResources.JobCandidate.Resume
FROM HumanResources.Department
JOIN HumanResources.EmployeeDepartmentHistory
    ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
JOIN HumanResources.Employee
    ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
JOIN HumanResources.JobCandidate
    ON HumanResources.JobCandidate.BusinessEntityID = HumanResources.Employee.BusinessEntityID;

-- SELECT for DepartmentJobCandidateInfo
SELECT * FROM DepartmentJobCandidateInfo;

-- 4. View: EmployeeShiftCount
CREATE VIEW EmployeeShiftCount AS
SELECT 
    HumanResources.EmployeeDepartmentHistory.BusinessEntityID, 
    HumanResources.EmployeeDepartmentHistory.ShiftID, 
    COUNT(*) AS ShiftCount
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY 
    HumanResources.EmployeeDepartmentHistory.BusinessEntityID, 
    HumanResources.EmployeeDepartmentHistory.ShiftID;

-- SELECT for EmployeeShiftCount
SELECT * FROM EmployeeShiftCount;

-- 5. View: EmployeeShiftDetails
CREATE VIEW EmployeeShiftDetails AS
SELECT 
    HumanResources.Employee.LoginId,
    HumanResources.EmployeeDepartmentHistory.BusinessEntityID,
    HumanResources.EmployeeDepartmentHistory.ShiftID, 
    COUNT(*) AS ShiftDetailCount
FROM HumanResources.EmployeeDepartmentHistory
JOIN HumanResources.Employee
    ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
WHERE HumanResources.EmployeeDepartmentHistory.ShiftID <> 1
GROUP BY 
    HumanResources.EmployeeDepartmentHistory.BusinessEntityID,
    HumanResources.EmployeeDepartmentHistory.ShiftID,
    HumanResources.Employee.LoginId
HAVING COUNT(*) > 1;

-- SELECT for EmployeeShiftDetails
SELECT * FROM EmployeeShiftDetails;

-- 6. View: MaxEmployeeAge
CREATE VIEW MaxEmployeeAge AS
SELECT 
    MAX(DATEDIFF(YEAR, BirthDate, GETDATE())) AS MaxAge
FROM HumanResources.Employee;

-- SELECT for MaxEmployeeAge
SELECT * FROM MaxEmployeeAge;

-- 7. View: MinEmployeeBirthDate
CREATE VIEW MinEmployeeBirthDate AS
SELECT 
    MIN(BirthDate) AS MinBirthDate
FROM HumanResources.Employee;

-- SELECT for MinEmployeeBirthDate
SELECT * FROM MinEmployeeBirthDate;

-- 8. View: MaxPayRateShift2
CREATE VIEW MaxPayRateShift2 AS
SELECT 
    MAX(Rate) AS MaxRate
FROM HumanResources.EmployeePayHistory
JOIN HumanResources.Employee
    ON HumanResources.EmployeePayHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory
    ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
WHERE HumanResources.EmployeeDepartmentHistory.ShiftID = 2;

-- SELECT for MaxPayRateShift2
SELECT * FROM MaxPayRateShift2;

-- 9. View: AvgEmployeePayRate
CREATE VIEW AvgEmployeePayRate AS
SELECT 
    AVG(Rate) AS AvgRate
FROM HumanResources.EmployeePayHistory;

-- SELECT for AvgEmployeePayRate
SELECT * FROM AvgEmployeePayRate;

-- 10. View: AvgEmployeePayRateWithDept
CREATE VIEW AvgEmployeePayRateWithDept AS
SELECT 
    AVG(Rate) AS AvgRate
FROM HumanResources.EmployeePayHistory
JOIN HumanResources.Employee
    ON HumanResources.EmployeePayHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory
    ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID;

-- SELECT for AvgEmployeePayRateWithDept
SELECT * FROM AvgEmployeePayRateWithDept;
