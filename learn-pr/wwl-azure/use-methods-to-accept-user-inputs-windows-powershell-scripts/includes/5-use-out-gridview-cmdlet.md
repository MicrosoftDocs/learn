**Out-GridView** is primarily used to review data. However, you can also use **Out-GridView** to create a simple menu selection interface. When the user makes one or more selections in the window presented by **Out-GridView**, the data for those objects is either passed further through the pipeline or placed into a variable. The syntax for selecting an option in **Out-GridView** is:

```powershell
$selection = $users | Out-GridView -PassThru 
```

In the previous example, an array of user accounts is piped to **Out-GridView**. **Out-GridView** displays the user accounts on screen, and the user can select one or more rows in the **Out-GridView** window. When the user selects **OK**, the selected rows are stored in the `$selection` variable. You can then perform further processing on the users’ accounts.

To retain more control over the amount of data that users can select, you can use the *-OutputMode* parameter instead of the *-PassThru* parameter. The following table depicts the values that can be defined for the *-OutputMode* parameter.

*Table 1: Values that can be defined for the -OutputMode parameter*

| **Value** | **Description**                                              |
| --------- | ------------------------------------------------------------ |
| None      | This is the default value that doesn't pass any objects further down the pipeline. |
| Single    | This value allows users to select zero rows or one row in the **Out-GridView** window. |
| Multiple  | This value allows users to select zero rows, one row, or multiple rows in the **Out-GridView**  window. This value is equivalent to using the -PassThru  parameter. |

> [!NOTE]
> Because users aren't forced to select a row in the **Out-GridView** window, you must ensure that your script properly handles the scenario where a row isn't selected.

