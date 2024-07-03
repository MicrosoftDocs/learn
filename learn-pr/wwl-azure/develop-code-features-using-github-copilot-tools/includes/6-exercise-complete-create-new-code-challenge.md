Code challenges reinforce what you've learned and help you gain some confidence before proceeding.

## Challenge: Add new features to an existing codebase

In this challenge exercise, you need to update your Quarterly Sales Report project. You'll be working on the `QuarterlySalesReport` method that generates a report of quarterly sales data. This method analyses sales data and displays a report in the console window.

## Prepare your coding environment

Load the project from the SampleApps folder:

1. Locate the SampleApps folder that contains the sample apps for this training.

1. Open the **APL2007M3SalesReport-NewCodeChallenge** project folder in Visual Studio Code.

The project contains a `QuarterlySalesReport` method that generates a report of quarterly sales data. The method calculates the total sales for each quarter and displays the results in the console window.

## Instructions

You have two updates that need to be implemented:

1. Update the report format to display the department sales information as a table. Before and after sample output is provided in the task details. You need to match the "after" output format as closely as possible.

1. Identify the three largest sales orders for each quarter and include them in the quarterly sales report. For each of the three top sales, list the product ID, the quantity sold, the unit price, the total sales amount, the profit, and the profit percentage. Format the information for the top 3 sales as a table. Before and after sample output is provided in the task details. You need to match the "after" output format as closely as possible.

### Format the department sales information

Here are the requirements and criteria details for this portion of the challenge:

1. Format the department sales information as a table.

1. Place the "By department" sales information into the table.

1. Include a header row for the table.

1. The "after" sample output is provided in the task steps below. Try to match the "after" output format as closely as possible.

    > [!NOTE]
    > Extended ASCII characters can be used to create borders lines for your table.

Use the following steps to complete this challenge:

1. Run the application and verify the following "before" format:

    Verify the format, not the numeric data.

    ```output
    Quarterly Sales Report
    ----------------------
    Q1: Sales: $2,043,493.57, Profit: $262,571.72, Profit Percentage: 14.00%
    By Department:
    Department: Accessories, Sales: $188,977.90, Profit: $25,229.53, Profit Percentage: 14.00%
    Department: Children's Clothing, Sales: $186,552.49, Profit: $25,511.74, Profit Percentage: 13.00%
    Department: Footwear, Sales: $293,706.49, Profit: $39,224.99, Profit Percentage: 19.00%
    Department: Men's Clothing, Sales: $301,385.47, Profit: $36,756.06, Profit Percentage: 19.00%
    Department: Outerwear, Sales: $238,099.65, Profit: $24,371.92, Profit Percentage: 15.00%
    Department: Sportswear, Sales: $251,349.38, Profit: $34,142.40, Profit Percentage: 8.00%
    Department: Undergarments, Sales: $297,690.60, Profit: $35,305.13, Profit Percentage: 9.00%
    Department: Women's Clothing, Sales: $285,731.58, Profit: $42,029.95, Profit Percentage: 19.00%
    
    Q2: Sales: $1,925,948.90, Profit: $232,929.95, Profit Percentage: 17.00%
    By Department:
    Department: Accessories, Sales: $251,572.42, Profit: $33,250.17, Profit Percentage: 11.00%
    Department: Children's Clothing, Sales: $311,862.99, Profit: $36,537.33, Profit Percentage: 8.00%
    Department: Footwear, Sales: $203,148.87, Profit: $23,041.46, Profit Percentage: 11.00%
    Department: Men's Clothing, Sales: $229,781.14, Profit: $26,226.68, Profit Percentage: 9.00%
    Department: Outerwear, Sales: $211,610.47, Profit: $23,684.65, Profit Percentage: 9.00%
    Department: Sportswear, Sales: $204,083.63, Profit: $20,750.56, Profit Percentage: 8.00%
    Department: Undergarments, Sales: $264,733.26, Profit: $35,155.66, Profit Percentage: 15.00%
    Department: Women's Clothing, Sales: $249,156.13, Profit: $34,283.45, Profit Percentage: 17.00%
    
    Q3: Sales: $2,113,223.50, Profit: $256,591.16, Profit Percentage: 7.00%
    By Department:
    Department: Accessories, Sales: $288,161.91, Profit: $32,279.54, Profit Percentage: 10.00%
    Department: Children's Clothing, Sales: $198,313.55, Profit: $24,146.72, Profit Percentage: 7.00%
    Department: Footwear, Sales: $205,840.60, Profit: $27,630.49, Profit Percentage: 5.00%
    Department: Men's Clothing, Sales: $229,279.26, Profit: $26,618.62, Profit Percentage: 13.00%
    Department: Outerwear, Sales: $353,696.46, Profit: $44,634.82, Profit Percentage: 14.00%
    Department: Sportswear, Sales: $229,490.12, Profit: $27,697.91, Profit Percentage: 5.00%
    Department: Undergarments, Sales: $316,942.44, Profit: $40,518.71, Profit Percentage: 5.00%
    Department: Women's Clothing, Sales: $291,499.15, Profit: $33,064.35, Profit Percentage: 10.00%
    
    Q4: Sales: $1,896,279.88, Profit: $248,226.28, Profit Percentage: 15.00%
    By Department:
    Department: Accessories, Sales: $336,698.68, Profit: $44,714.55, Profit Percentage: 11.00%
    Department: Children's Clothing, Sales: $193,345.18, Profit: $23,261.33, Profit Percentage: 13.00%
    Department: Footwear, Sales: $215,183.23, Profit: $29,616.00, Profit Percentage: 15.00%
    Department: Men's Clothing, Sales: $171,663.38, Profit: $24,299.37, Profit Percentage: 5.00%
    Department: Outerwear, Sales: $229,791.52, Profit: $28,211.17, Profit Percentage: 15.00%
    Department: Sportswear, Sales: $230,031.90, Profit: $32,732.40, Profit Percentage: 8.00%
    Department: Undergarments, Sales: $300,824.19, Profit: $34,649.79, Profit Percentage: 6.00%
    Department: Women's Clothing, Sales: $218,741.80, Profit: $30,741.67, Profit Percentage: 20.00%

1. Use GitHub Copilot Chat to implement code updates required to format the department sales information as a table.

1. Run the application and verify that your updated application produces the following "after" format:

    ```output
    Quarterly Sales Report
    ----------------------
    Q1: Sales: $2,098,948.87, Profit: $266,548.80, Profit Percentage: 7.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $227,101.75 │        $31,619.50 │             11.00 │
    │ Children's Clothing   │       $242,999.83 │        $32,129.93 │              9.00 │
    │ Footwear              │       $309,579.27 │        $37,846.03 │              7.00 │
    │ Men's Clothing        │       $256,699.00 │        $31,627.33 │             11.00 │
    │ Outerwear             │       $259,274.20 │        $27,614.65 │              5.00 │
    │ Sportswear            │       $261,332.33 │        $35,702.48 │             10.00 │
    │ Undergarments         │       $291,343.22 │        $38,740.59 │              9.00 │
    │ Women's Clothing      │       $250,619.28 │        $31,268.29 │             14.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q2: Sales: $2,035,550.16, Profit: $253,516.25, Profit Percentage: 11.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $284,685.66 │        $34,442.28 │             17.00 │
    │ Children's Clothing   │       $285,753.69 │        $36,672.14 │             20.00 │
    │ Footwear              │       $232,121.77 │        $28,406.40 │              9.00 │
    │ Men's Clothing        │       $269,787.82 │        $33,061.27 │             11.00 │
    │ Outerwear             │       $190,096.90 │        $25,230.19 │             13.00 │
    │ Sportswear            │       $263,685.51 │        $31,183.94 │             20.00 │
    │ Undergarments         │       $246,857.39 │        $29,287.72 │             18.00 │
    │ Women's Clothing      │       $262,561.42 │        $35,232.32 │             11.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q3: Sales: $1,959,738.57, Profit: $249,994.39, Profit Percentage: 12.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $268,249.09 │        $33,662.40 │             16.00 │
    │ Children's Clothing   │       $262,402.85 │        $32,550.39 │              7.00 │
    │ Footwear              │       $268,383.13 │        $33,416.99 │             14.00 │
    │ Men's Clothing        │       $246,654.07 │        $33,440.20 │             12.00 │
    │ Outerwear             │       $216,239.78 │        $28,683.07 │             16.00 │
    │ Sportswear            │       $244,253.22 │        $29,269.02 │             13.00 │
    │ Undergarments         │       $237,058.27 │        $31,402.88 │             19.00 │
    │ Women's Clothing      │       $216,498.16 │        $27,569.42 │              9.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q4: Sales: $2,056,371.76, Profit: $273,122.03, Profit Percentage: 8.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $329,926.72 │        $49,008.34 │             18.00 │
    │ Children's Clothing   │       $161,918.53 │        $23,062.50 │              9.00 │
    │ Footwear              │       $255,455.17 │        $33,934.76 │              8.00 │
    │ Men's Clothing        │       $221,264.27 │        $24,772.73 │              8.00 │
    │ Outerwear             │       $299,514.01 │        $41,179.09 │              8.00 │
    │ Sportswear            │       $314,023.68 │        $42,038.11 │             20.00 │
    │ Undergarments         │       $202,815.48 │        $23,954.48 │              7.00 │
    │ Women's Clothing      │       $271,453.91 │        $35,172.04 │             16.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    ```

    > [!NOTE]
    > Since the data is randomly generated, the values you see in the table won't match exactly. It's the format of the table that's important.

1. Continue using GitHub Copilot Chat to implement code updates until your quarterly sales report output matches the "after" output format as closely as possible.

### Display the top three sales orders by quarter

You need to identify the three largest sales orders for each quarter and include them in the quarterly sales report. For each of the three top sales orders, display the product ID, the quantity sold, the unit price, the total sales amount, the profit, and the profit percentage. Format the information for the top 3 sales as a table.

Here are the requirements and criteria details for this portion of the challenge:

1. The array of `SalesData` objects received by the `QuarterlySalesReport` method must be used to define the sales orders. Each object in the `SalesData` array represents a sales order.

1. The top three sales orders for a quarter are the three orders with the largest total sales value (units sold * unit price).

1. For each of the top three orders, the quarterly sales report must list the product ID, the quantity sold, the unit price, the total sales amount, the profit, and the profit percentage.

1. The order in which the top three sales orders are list must be based on profit in descending order (highest to lowest).

1. The information for the top sales orders must be formatted as a table format in the quarterly sales report.

1. The "after" sample output is provided in the task steps below. Try to match the "after" output format as closely as possible.

Use the following steps to complete this challenge:

1. Use GitHub Copilot Chat to implement code updates required to report the top three sales orders for each quarter.

1. Run the application and verify that your updated application produces the following "after" output:

    ```output
    Quarterly Sales Report
    ----------------------
    Q1: Sales: $2,147,913.85, Profit: $259,780.34, Profit Percentage: 6.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $250,965.22 │        $32,137.16 │             10.00 │
    │ Children's Clothing   │       $240,996.59 │        $30,624.26 │             20.00 │
    │ Footwear              │       $350,495.72 │        $44,661.94 │             17.00 │
    │ Men's Clothing        │       $179,416.69 │        $19,491.29 │             13.00 │
    │ Outerwear             │       $341,525.29 │        $47,556.50 │             16.00 │
    │ Sportswear            │       $216,901.82 │        $21,858.47 │              7.00 │
    │ Undergarments         │       $298,357.33 │        $35,451.12 │              6.00 │
    │ Women's Clothing      │       $269,255.19 │        $27,999.61 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ SPRT-702-S-BK-CA1     │                96 │           $295.33 │        $28,351.45 │         $4,536.23 │             16.00 │
    │ OUTR-609-M-GR-JP1     │                92 │           $243.62 │        $22,412.59 │         $4,482.52 │             20.00 │
    │ ACCS-437-S-GY-JP1     │                96 │           $268.76 │        $25,800.68 │         $4,128.11 │             16.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q2: Sales: $2,003,845.44, Profit: $244,961.30, Profit Percentage: 5.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $209,829.83 │        $26,133.08 │             12.00 │
    │ Children's Clothing   │       $262,972.68 │        $34,363.99 │             15.00 │
    │ Footwear              │       $362,836.17 │        $43,653.95 │              5.00 │
    │ Men's Clothing        │       $259,752.19 │        $29,271.83 │             15.00 │
    │ Outerwear             │       $196,229.55 │        $22,143.81 │             14.00 │
    │ Sportswear            │       $304,231.54 │        $36,642.49 │             10.00 │
    │ Undergarments         │       $159,844.19 │        $20,731.42 │             19.00 │
    │ Women's Clothing      │       $248,149.28 │        $32,020.74 │              6.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ CHLD-368-XL-WT-UK2    │                87 │           $290.23 │        $25,250.21 │         $4,292.54 │             17.00 │
    │ SPRT-732-S-YL-UK2     │                86 │           $265.58 │        $22,839.86 │         $3,882.78 │             17.00 │
    │ MENS-128-XL-WT-JP1    │                87 │           $222.23 │        $19,334.37 │         $3,673.53 │             19.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q3: Sales: $2,261,407.77, Profit: $277,077.73, Profit Percentage: 18.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $291,046.00 │        $36,782.43 │              9.00 │
    │ Children's Clothing   │       $221,364.18 │        $26,993.37 │              7.00 │
    │ Footwear              │       $237,884.17 │        $32,777.70 │             18.00 │
    │ Men's Clothing        │       $332,047.47 │        $41,620.56 │              7.00 │
    │ Outerwear             │       $217,888.26 │        $24,129.85 │             17.00 │
    │ Sportswear            │       $325,778.95 │        $43,229.56 │             17.00 │
    │ Undergarments         │       $292,301.79 │        $36,193.42 │              5.00 │
    │ Women's Clothing      │       $343,096.95 │        $35,350.83 │             12.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ MENS-120-XL-BK-UK3    │                98 │           $235.28 │        $23,057.74 │         $4,611.55 │             20.00 │
    │ OUTR-609-XS-OR-JP1    │                96 │           $270.57 │        $25,975.01 │         $4,156.00 │             16.00 │
    │ WOMN-225-XS-RD-UK3    │                95 │           $247.99 │        $23,559.14 │         $3,533.87 │             15.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q4: Sales: $2,076,474.81, Profit: $255,995.79, Profit Percentage: 20.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $230,203.59 │        $26,018.53 │             20.00 │
    │ Children's Clothing   │       $208,243.96 │        $24,647.41 │              5.00 │
    │ Footwear              │       $333,552.70 │        $37,319.89 │             15.00 │
    │ Men's Clothing        │       $265,576.45 │        $29,605.44 │              9.00 │
    │ Outerwear             │       $221,220.08 │        $31,250.72 │              6.00 │
    │ Sportswear            │       $310,761.93 │        $39,728.56 │             16.00 │
    │ Undergarments         │       $260,660.71 │        $36,903.27 │             19.00 │
    │ Women's Clothing      │       $246,255.40 │        $30,521.98 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ UNDR-819-XS-BL-US2    │                87 │           $293.23 │        $25,510.94 │         $4,847.08 │             19.00 │
    │ SPRT-710-S-OR-JP1     │                87 │           $279.28 │        $24,297.67 │         $4,130.60 │             17.00 │
    │ SPRT-726-L-BL-JP1     │                94 │           $198.53 │        $18,662.13 │         $3,732.43 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘

    ```

1. Continue using GitHub Copilot Chat to implement code updates until the quarterly sales report output matches the "after" output format as closely as possible.
