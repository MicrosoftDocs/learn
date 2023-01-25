

Time dimension tables are a special type of table and store a record for each time interval based on the grain of the table. For example, a time dimension table at the *date* grain contains a record for each date between the earliest and latest dates referenced by the data in related fact tables.

One way to populate a time dimension table is to use a loop that generates the required attributes for each date incrementally. For example, you could use the following SQL code to populate a **DimDate** table:

```sql
-- Create a temporary table for the dates we need
CREATE TABLE #TmpStageDate (DateVal DATE NOT NULL)

-- Populate the temp table with a range of dates
DECLARE @StartDate DATE
DECLARE @EndDate DATE
SET @StartDate = '2019-01-01'
SET @EndDate = '2022-12-31' 
DECLARE @LoopDate DATE
SET @LoopDate = @StartDate
WHILE @LoopDate <= @EndDate
BEGIN
    INSERT INTO #TmpStageDate VALUES
    (
        @LoopDate
    ) 
    SET @LoopDate = DATEADD(dd, 1, @LoopDate)
END

-- Insert the dates and calculated attributes into the dimension table
INSERT INTO dbo.DimDate 
SELECT  CAST(CONVERT(VARCHAR(8), DateVal, 112) AS int) , -- date key
        DateVal, -- date alt key
        Day(DateVal),  -- day number of month
        datepart(dw, DateVal), -- day number of week
        datename(dw, DateVal), -- day name of week
        Month(DateVal), -- month number of year
        datename(mm, DateVal), -- month name
        datepart(qq, DateVal), -- calendar quarter
        Year(DateVal), -- calendar year
        CASE
            WHEN Month(DateVal) IN (1, 2, 3) THEN 3
            WHEN Month(DateVal) IN (4, 5, 6) THEN 4
            WHEN Month(DateVal) IN (7, 8, 9) THEN 1
            WHEN Month(DateVal) IN (10, 11, 12) THEN 2
        END, -- fiscal quarter (fiscal year runs from Jul to June)
        CASE
            WHEN Month(DateVal) < 7 THEN Year(DateVal)
            ELSE Year(DateVal) + 1
        END -- Fiscal year 
FROM #TmpStageDate
GO
```

> [!NOTE]
> As the data warehouse is populated in the future with new fact data, you periodically need to extend the range of dates in the **DimDate** table.

While the scripted loop approach can be an effective way to populate a time dimension table, it may take some time to run on an MPP system. In some cases, it may be more efficient to generate a sequence of date attributes using an external tool (such as Microsoft Excel) in a file, and using the `COPY` command to load the date data.
