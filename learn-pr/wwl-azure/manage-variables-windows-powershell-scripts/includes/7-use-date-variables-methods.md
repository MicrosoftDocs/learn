Many of the scripts that you create will need to reference the current date or a previous point in time. For example, to ensure uniqueness, you might want to create a log file name based on the current date. Additionally, you might be searching for users in AD DS that haven't signed in for an extended period of time. You can use DateTime variables to accomplish these tasks.

## DateTime properties

A DateTime variable contains both the date and the time. You can use the DateTime variable properties to access specific parts of the date or time. The following table lists some of the properties available for a DateTime variable.

*Table 1: Properties available for a DateTime variable*

| Property    | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| **Hour**      | Returns the hours of the time in 24-hour format.             |
| **Minute**    | Returns the minutes of the time.                             |
| **Second**    | Returns the seconds of the time.                             |
| **TimeOfDay** | Returns detailed information about the time of day, including hours, minutes, and seconds. |
| **Date**      | Returns only the date and not the time.                      |
| **DayOfWeek** | Returns the day of the week, such as Monday.                 |
| **Month**     | Returns the month as a number.                               |
| **Year**      | Returns the year.                                            |

## DateTime methods

A DateTime variable also has many methods available that allow you to manipulate the time. Methods provide ways to add or subtract time. There also are methods to manipulate the output of a DateTime variable in specific ways. The following table lists some of the DateTime variable methods.

*Table 2: DateTime variable methods*

| Method                     | Description                                   |
| -------------------------- | --------------------------------------------- |
| **AddDays(double value)**    | Adds the specified number of days.            |
| **AddHours(double value)**   | Adds the specified number of hours.           |
| **AddMinutes(double value)** | Adds the specified number of minutes.         |
| **AddMonths(int months)**    | Adds the specified number of months.          |
| **AddYears(int value)**      | Adds the specified number of years.           |
| **ToLongDateString()**       | Returns the date in long format as a string.  |
| **ToShortDateString()**      | Returns the date in short format as a string. |
| **ToLongTimeString()**       | Returns the time in long format as a string.  |
| **ToShortTimeString()**      | Returns the time in short format as a string. |

> [!NOTE]
> If you need to subtract time from a DateTime variable, use one of the methods for adding time with a negative number as its parameter. An example is `$date.AddDays(-60)`.

