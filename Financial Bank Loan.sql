SELECT * 
FROM Financial_Bank_loan

--Total Loan Application
SELECT COUNT(ID_No) AS Total_Loan_Application
FROM Financial_Bank_loan

--Month-To-Date (MTD) Loan Application (November)
SELECT COUNT(ID_No) AS MTD_Total_Loan_Application
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date)= 11 AND YEAR(Issue_Date) = 2021

--Previous_Month-To-Date (PMTD) Loan Application (October)
SELECT COUNT(ID_No) AS PMTD_Total_Loan_Application
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date)= 10 AND YEAR(Issue_Date) = 2021

--Month over Month (MoM) Loan Application = (MTD-PMTD)/PMTD


--Total Funded Amount
SELECT SUM (Loan_Amount) AS Total_Funded_Amount
FROM Financial_Bank_loan

--MTD Total Funded Amount (November)
SELECT SUM (Loan_Amount) AS MTD_Total_Funded_Amount
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 11 AND YEAR(Issue_Date) = 2021


--PMTD Total Funded Amount (October)
SELECT SUM (Loan_Amount) AS PMTD_Total_Funded_Amount
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 10 AND YEAR(Issue_Date) = 2021


--Month over Month (MoM) Total Funded Amount = (MTD-PMTD)/PMTD


--Total Amount Received
SELECT SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan

--MTD Total Amount Received (November)
SELECT SUM(Total_Payment) AS MTD_Total_Amount_Received
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 11 AND YEAR(Issue_Date) = 2021


--PMTD Total Amount Received (October)
SELECT SUM(Total_Payment) AS PMTD_Total_Amount_Received
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 10 AND YEAR(Issue_Date) = 2021


--Month over Month (MoM) Total Amount Received = (MTD-PMTD)/PMTD


--Average Interest Rate
SELECT AVG(Interest_Rate)*100 AS Average_Interest_Rate
FROM Financial_Bank_loan

-- MTD Average Interest Rate (November)
SELECT AVG(Interest_Rate)*100 AS MTD_Average_Interest_Rate
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 11 AND YEAR(Issue_Date) = 2021


-- PMTD Average Interest Rate (October)
SELECT AVG(Interest_Rate)*100 AS PMTD_Average_Interest_Rate
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 10 AND YEAR(Issue_Date) = 2021


--Month over Month (MoM) Average Interest Rate = (MTD-PMTD)/PMTD


--Average Debt-to-Income Ratio (DTI)
SELECT AVG(DTI)*100 AS Average_DTI
FROM Financial_Bank_loan

--MTD Average Debt-to-Income Ratio (DTI)
SELECT AVG(DTI)*100 AS MTD_Average_DTI
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 11 AND YEAR(Issue_Date) = 2021


--PMTD Average Debt-to-Income Ratio (DTI) to 5 decimal place 
SELECT ROUND(AVG(DTI), 5)*100 AS PMTD_Average_DTI
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 10 AND YEAR(Issue_Date) = 2021


--Month over Month (MoM) Average DTI = (MTD-PMTD)/PMTD


--GOOD_LOAN_ISSUED:Good Loan Percentage
SELECT
(COUNT(CASE WHEN Loan_Status = 'Fully Paid' OR Loan_Status = 'Current' 
       THEN ID_No
	    END)*100.00)
/
COUNT(ID_No) AS Good_Loan_Percentage
FROM Financial_Bank_loan

--Good_Loan_Applications
SELECT COUNT(ID_No) AS Good_Loan_Application
FROM Financial_Bank_loan
WHERE Loan_Status = 'Fully Paid' OR Loan_Status = 'Current' 

--Good_Loan_Funded_Amount
SELECT SUM(Loan_Amount) AS Good_Loan_Funded_Amount
FROM Financial_Bank_loan
WHERE Loan_Status = 'Fully Paid' OR Loan_Status = 'Current' 

--Good_Loan_Amount_Received
SELECT SUM(Total_Payment) AS Good_Loan_Amount_Received
FROM Financial_Bank_loan
WHERE Loan_Status = 'Fully Paid' OR Loan_Status = 'Current' 


--BAD_LOAN_ISSUED:Bad_Loan_Percentage
SELECT
(COUNT(CASE WHEN Loan_Status = 'Charged Off' 
       THEN ID_No
	    END)*100.00)
/
COUNT(ID_No) AS Bad_Loan_Percentage
FROM Financial_Bank_loan

--Bad_Loan_Applications
SELECT COUNT(ID_No) AS Bad_Loan_Application
FROM Financial_Bank_loan
WHERE Loan_Status = 'Charged Off' 

--Bad_Loan_Funded_Amount
SELECT SUM(Loan_Amount) AS Bad_Loan_Funded_Amount
FROM Financial_Bank_loan
WHERE Loan_Status = 'Charged Off'

--Bad_Loan_Amount_Received
SELECT SUM(Total_Payment) AS Bad_Loan_Amount_Received
FROM Financial_Bank_loan
WHERE Loan_Status = 'Charged Off'

--Loan_Status_Grid_View
SELECT Loan_Status, 
       COUNT(ID_No) AS Loan_Count, 
	   SUM(Loan_Amount) AS Total_Funded_Amount,
       SUM(Total_Payment) AS Total_Amount_Received,
       AVG(Interest_Rate * 100) AS Interest_Rate,
        AVG(DTI * 100) AS DTI
FROM Financial_Bank_loan
GROUP BY Loan_Status


--MTD Loan_Status_Grid_View (August)
SELECT Loan_Status, 
	   SUM(Loan_Amount) AS MTD_Total_Funded_Amount,
       SUM(Total_Payment) AS MTD_Total_Amount_Received
FROM Financial_Bank_loan
WHERE MONTH(Issue_Date) = 8
GROUP BY Loan_Status

--Bank Loan Report Overview By Month
SELECT 
	MONTH(Issue_Date) AS Month_Number, 
	DATENAME(MONTH, Issue_Date) AS Month_Name, 
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
GROUP BY MONTH(Issue_Date), DATENAME(MONTH, Issue_Date)
ORDER BY MONTH(Issue_Date)


--Bank Loan Report Overview By State
SELECT 
	Address_State AS State,
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
GROUP BY Address_State
ORDER BY Address_State


--Bank Loan Report Overview By Bank Loan Terms
SELECT 
	Term AS Term,
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
GROUP BY Term
ORDER BY Term


--Bank Loan Report Overview By Employee Length
SELECT 
	Employment_Length AS Employment_Length,
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
GROUP BY Employment_Length
ORDER BY Employment_Length


--Bank Loan Report Overview By Purpose
SELECT 
	Purpose AS Purpose,
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
GROUP BY Purpose
ORDER BY Total_Loan_Applications DESC


--Bank Loan Report Overview By Home Ownership
SELECT 
	Home_Ownership AS Home_Ownership,
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
GROUP BY Home_Ownership
ORDER BY Home_Ownership



--Bank Loan Report Overview By Purpose Where Grade = A
SELECT 
	Purpose AS Purpose,
	COUNT(ID_No) AS Total_Loan_Applications,
	SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM Financial_Bank_loan
WHERE Grade = 'A'
GROUP BY Purpose
ORDER BY Total_Loan_Applications DESC