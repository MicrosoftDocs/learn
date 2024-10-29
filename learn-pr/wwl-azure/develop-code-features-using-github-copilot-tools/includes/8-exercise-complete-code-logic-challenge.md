Code challenges reinforce what you've learned and help you gain some confidence before proceeding.

## Challenge: Develop GitHub Copilot prompts that reference existing code logic

In this challenge exercise, you need to update your Quarterly Sales Report project. You'll be working on the `QuarterlySalesReport` method that generates a report of quarterly sales data. This method analyses sales data and displays a report in the console window.

## Prepare your coding environment

Load the project from the SampleApps folder:

1. Locate the SampleApps folder that contains the sample apps for this training.

1. Open the **APL2007M3SalesReport-CodeLogicChallenge** project folder in Visual Studio Code.

The project contains a `QuarterlySalesReport` method that generates a report of quarterly sales data. The method calculates the total sales for each quarter and displays the results in the console window.

## Instructions

You have three updates that need to be implemented:

1. Create a ConstructProductId method that constructs a product ID that's formatted using the pattern "DDDD-###-SS-CC-MMM", where the components of the ID are defined as follows:

    - a 4-character code representing the department.
    - a 3-digit number representing the product.
    - a 2-character code representing the product size.
    - a 2-character code representing the product color.
    - a 3-character code representing the manufacturing site

1. Create a DeconstructProductId method that extracts the product ID components from a product ID and returns the values in a 2-dimensional string array (`string[5, 2]`).

1. Update the `QuarterlySalesReport` method to report the three most profitable products per quarter. Use the DeconstructProductId method to get the 3-digit number representing the product (product serial number). For each of the top three products, report the product serial number, the sum of units sold, the sum of total sales, the calculated average unit cost, the sum of total profit, and the calculated average profit percentage.

### Create the ConstructProductId method

Here are the requirements and criteria details for this portion of the challenge:

1. You need to create a new method named ConstructProductId that replaces the following code in the `QuarterlySalesReport` method.

    ```csharp
    int indexOfDept = Array.IndexOf(ProdDepartments.departmentNames, salesData[i].departmentName);
    string deptAbb = ProdDepartments.departmentAbbreviations[indexOfDept];
    string firstDigit = (indexOfDept + 1).ToString();
    string nextTwoDigits = random.Next(1, 100).ToString("D2");
    string sizeCode = new string[] { "XS", "S", "M", "L", "XL" }[random.Next(0, 5)];
    string colorCode = new string[] { "BK", "BL", "GR", "RD", "YL", "OR", "WT", "GY" }[random.Next(0, 8)];
    string manufacturingSite = ManufacturingSites.manufacturingSites[random.Next(0, ManufacturingSites.manufacturingSites.Length)];
    
    salesData[i].productID = $"{deptAbb}-{firstDigit}{nextTwoDigits}-{sizeCode}-{colorCode}-{manufacturingSite}";
    ```

1. The call statement for the ConstructProductId method should pass the current record of the salesData array as an argument.

1. The ConstructProductId method should return a string value that represents the product ID.

1. The `QuarterlySalesReport` method should assign the value returned by the ConstructProductId method to `salesData[i].productID`.

Use the following steps to complete this portion of the challenge:

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

1. Create a prompt for GitHub Copilot Chat that describes the requirements and criteria details for the ConstructProductId method.

1. Submit the prompt to GitHub Copilot Chat and review the code suggestions that are generated.

1. Once you get a suggestion that meets the requirements, integrate the suggested code, and then save the changes to your Program.cs file.

1. Save the changes to your Program.cs file.

1. Run the application and verify that the output still matches the "before" output.

### Create the DeconstructProductId method

Here are the requirements and criteria details for this portion of the challenge:

1. You need to create a DeconstructProductId method that extracts the following items from a product ID: department abbreviation, product serial number, size code, color code, and manufacturing site.

1. The DeconstructProductId method needs return a 2-dimensional string array (`string[5, 2]`) containing the description and value for each component the productID.

Use the following steps to complete this portion of the challenge:

1. Create a prompt for GitHub Copilot Chat that describes the requirements and criteria details for the DeconstructProductId method.

1. Submit the prompt to GitHub Copilot Chat and review the code suggestions that are generated.

1. Once you get a suggestion that meets the requirements, integrate the suggested code, and then save the changes to your Program.cs file.

1. Run the application and verify that the output still matches the "before" output.

### Update the QuarterlySalesReport method to identify the most profitable product

Here are the requirements and criteria details for this portion of the challenge:

1. You need a dictionary that uses calendar quarters as the key and another dictionary as the value. The inner dictionary should contain unique product serial numbers as the key and the following value types: integer (units sold), double (total sales), double (average unit cost), double (total profit), and double (average profit percentage).

1. You need to use the DeconstructProductId method to get components of the product ID that can be used to identify unique product serial numbers. For the product serial numbers, ignore the size, color, and manufacturing site components of the product ID. Use only the department abbreviation and product serial number. The other components of the product ID should be represented using "-ss-cc-mmm".

1. For each quarter of the calendar year, use a dictionary of unique product serial numbers to store the following values:

    - the sum of units sold (integer)
    - the sum of total sales (double)
    - the calculated average unit cost (double)
    - the sum of total profit (double)
    - the calculated average profit percentage (double)

1. For each quarterly section of the report, display the three most profitable products. For each of the top three products, report the product serial number, the sum of units sold, the sum of total sales, the calculated average unit cost, the sum of total profit, and the calculated average profit percentage. Display the product information in descending order of profit (highest to lowest).

1. Format the top three products section as a table. The table format should match the style of the existing tables in the report.

Use the following steps to complete this portion of the challenge:

1. Create a prompt that can be used to create the dictionary structure for the QuarterlySalesReport method. Use the first three requirements as the basis for the prompt.

    > [!NOTE]
    > Review the existing code in the `QuarterlySalesReport` method for help on how the dictionary can be constructed. The prompt that you create for GitHub Copilot Chat should reflect the existing code logic as well as the challenge requirements and criteria details.

1. Submit the prompt to GitHub Copilot Chat and review the code suggestions that are generated.

1. If the suggestions appear to meet the requirements, integrate the suggested code into the application.

1. Review the updated code and use GitHub Copilot to help fix any errors or issues.

    > [!NOTE]
    > GitHub Copilot may struggle when generating the code that extracts the product correct product ID components. You may need to manually  : `departmentAbbreviation + "-" + productSerialNumber + "-ss-cc-mmm"`.

1. Save the changes to your Program.cs file.

1. Create a prompt that can be used to identify the three products with highest profit during each quarter and display the associated information in the quarterly report.

1. Submit the prompt to GitHub Copilot Chat and review the code suggestions that are generated.

1. If the suggestions appear to meet the requirements, integrate the suggested code into the application.

1. Review the updated code and use GitHub Copilot to help fix any errors or issues.

1. Save the changes to your Program.cs file, and then run the application

1. Review the output to ensure that the report displays the three most profitable products for each quarter.

    > [!NOTE]
    > At this point, the top three most profitable products should be listed in your report for each quarter. GitHub Copilot may have used the existing code in your application to order the products by profit and format the information as a table.

1. Compare your output with the "after" output provided below. If your output matches the "after" output, you have successfully completed the challenge. If your output for the top three most profitable products is not ordered correctly or isn't in a table, complete the remaining steps.

1. Create a prompt that can be used to order the top three most profitable products by profit and format the information as a table.

1. Submit the prompt to GitHub Copilot Chat and review the code suggestions that are generated.

1. If the suggestions appear to meet the requirements, integrate the suggested code into the application.

1. Review the updated code and use GitHub Copilot to help fix any errors or issues.

1. Save the changes to your Program.cs file, and then run the application

1. Review the output and verify the following "after" output:

    > [!NOTE]
    > The application uses randomly generated data, so your output uses different sales data.

    ```output
    Quarterly Sales Report
    ----------------------
    Q1: Sales: $2,046,471.91, Profit: $268,374.21, Profit Percentage: 14.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $262,360.84 │        $33,672.32 │              6.00 │
    │ Children's Clothing   │       $249,637.52 │        $31,881.64 │             18.00 │
    │ Footwear              │       $246,810.44 │        $34,699.27 │             14.00 │
    │ Men's Clothing        │       $200,303.87 │        $23,155.88 │             16.00 │
    │ Outerwear             │       $266,171.28 │        $38,996.99 │             17.00 │
    │ Sportswear            │       $409,590.58 │        $52,995.40 │             14.00 │
    │ Undergarments         │       $179,960.22 │        $21,745.04 │             16.00 │
    │ Women's Clothing      │       $231,637.16 │        $31,227.69 │             19.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ ACCS-417-XS-GR-JP2    │                93 │           $298.39 │        $27,750.08 │         $5,550.02 │             20.00 │
    │ OUTR-615-XS-BL-US2    │                86 │           $295.39 │        $25,403.94 │         $5,080.79 │             20.00 │
    │ OUTR-662-XL-GR-UK3    │                82 │           $280.64 │        $23,012.41 │         $4,602.48 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Quarterly Top Profit for Product Numbers:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │   Product Serial No   │    Units Sold     │   Total Sales     │    Unit Cost      │     Total Profit  │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ ACCS-417-ss-cc-mmm    │                93 │        $27,750.08 │           $238.71 │         $5,550.02 │             20.00 │
    │ OUTR-615-ss-cc-mmm    │                88 │        $25,733.79 │           $292.43 │         $5,097.28 │             19.81 │
    │ OUTR-662-ss-cc-mmm    │                82 │        $23,012.41 │           $224.51 │         $4,602.48 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q2: Sales: $2,073,212.82, Profit: $254,245.33, Profit Percentage: 19.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $216,777.64 │        $25,348.81 │             10.00 │
    │ Children's Clothing   │       $247,375.44 │        $30,004.30 │             19.00 │
    │ Footwear              │       $278,075.54 │        $36,354.47 │             14.00 │
    │ Men's Clothing        │       $269,673.93 │        $32,717.13 │             10.00 │
    │ Outerwear             │       $269,093.53 │        $31,675.56 │             20.00 │
    │ Sportswear            │       $181,996.62 │        $21,981.49 │              5.00 │
    │ Undergarments         │       $251,783.24 │        $29,223.87 │             11.00 │
    │ Women's Clothing      │       $358,436.89 │        $46,939.69 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ OUTR-699-XS-RD-JP3    │                92 │           $239.97 │        $22,077.70 │         $4,194.76 │             19.00 │
    │ WOMN-202-XL-BK-UK2    │                93 │           $271.37 │        $25,237.56 │         $4,038.01 │             16.00 │
    │ FOOT-545-M-GY-CA1     │                83 │           $267.46 │        $22,199.19 │         $3,995.85 │             18.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Quarterly Top Profit for Product Numbers:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │   Product Serial No   │    Units Sold     │   Total Sales     │    Unit Cost      │     Total Profit  │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ WOMN-202-ss-cc-mmm    │               156 │        $39,610.84 │           $253.92 │         $6,912.67 │             17.45 │
    │ FOOT-564-ss-cc-mmm    │               148 │        $32,027.56 │           $216.40 │         $4,570.72 │             14.27 │
    │ OUTR-611-ss-cc-mmm    │                99 │        $24,456.19 │           $247.03 │         $4,533.38 │             18.54 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q3: Sales: $2,228,194.40, Profit: $272,519.25, Profit Percentage: 19.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $224,551.39 │        $29,970.65 │             17.00 │
    │ Children's Clothing   │       $269,285.73 │        $32,570.79 │             11.00 │
    │ Footwear              │       $253,189.85 │        $34,584.68 │             16.00 │
    │ Men's Clothing        │       $219,295.97 │        $24,249.60 │             19.00 │
    │ Outerwear             │       $297,984.37 │        $34,476.61 │             16.00 │
    │ Sportswear            │       $335,337.84 │        $43,052.23 │              5.00 │
    │ Undergarments         │       $361,734.10 │        $44,551.10 │             20.00 │
    │ Women's Clothing      │       $266,815.15 │        $29,063.60 │             16.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ SPRT-783-L-RD-UK1     │                91 │           $268.73 │        $24,454.85 │         $4,646.42 │             19.00 │
    │ FOOT-538-M-RD-JP3     │                96 │           $238.45 │        $22,890.97 │         $4,578.19 │             20.00 │
    │ SPRT-730-L-YL-JP3     │                94 │           $276.73 │        $26,012.95 │         $4,422.20 │             17.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Quarterly Top Profit for Product Numbers:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │   Product Serial No   │    Units Sold     │   Total Sales     │    Unit Cost      │     Total Profit  │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ SPRT-716-ss-cc-mmm    │               173 │        $43,745.92 │           $252.87 │         $6,364.81 │             14.55 │
    │ SPRT-783-ss-cc-mmm    │               116 │        $31,367.19 │           $270.41 │         $5,545.03 │             17.68 │
    │ UNDR-823-ss-cc-mmm    │               152 │        $28,428.74 │           $187.03 │         $4,827.34 │             16.98 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Q4: Sales: $2,156,746.80, Profit: $272,203.05, Profit Percentage: 13.00%
    By Department:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Department       │       Sales       │       Profit      │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ Accessories           │       $342,135.74 │        $40,127.25 │              5.00 │
    │ Children's Clothing   │       $193,558.01 │        $27,030.43 │             14.00 │
    │ Footwear              │       $278,261.11 │        $35,686.93 │             20.00 │
    │ Men's Clothing        │       $195,951.21 │        $26,141.40 │             20.00 │
    │ Outerwear             │       $257,567.95 │        $37,989.46 │             11.00 │
    │ Sportswear            │       $327,149.00 │        $41,481.49 │             13.00 │
    │ Undergarments         │       $250,330.84 │        $28,238.37 │             15.00 │
    │ Women's Clothing      │       $311,792.93 │        $35,507.72 │             11.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Top 3 Sales Orders:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │      Product ID       │   Quantity Sold   │    Unit Price     │   Total Sales     │      Profit       │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ UNDR-843-XL-WT-CA1    │                93 │           $287.37 │        $26,725.48 │         $5,345.10 │             20.00 │
    │ ACCS-418-XL-WT-US3    │                94 │           $245.46 │        $23,073.45 │         $4,614.69 │             20.00 │
    │ ACCS-454-S-WT-US3     │                94 │           $268.47 │        $25,236.25 │         $4,542.53 │             18.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘
    
    Quarterly Top Profit for Product Numbers:
    ┌───────────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┬───────────────────┐
    │   Product Serial No   │    Units Sold     │   Total Sales     │    Unit Cost      │     Total Profit  │ Profit Percentage │
    ├───────────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┼───────────────────┤
    │ UNDR-843-ss-cc-mmm    │                93 │        $26,725.48 │           $229.90 │         $5,345.10 │             20.00 │
    │ ACCS-454-ss-cc-mmm    │               145 │        $35,062.39 │           $241.81 │         $5,132.09 │             14.64 │
    │ ACCS-418-ss-cc-mmm    │                94 │        $23,073.45 │           $196.37 │         $4,614.69 │             20.00 │
    └───────────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┴───────────────────┘

    ```
