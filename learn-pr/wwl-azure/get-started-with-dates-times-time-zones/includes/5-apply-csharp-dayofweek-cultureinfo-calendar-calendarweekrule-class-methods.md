This learning unit covers the usage of various C# classes such as DayOfWeek, CultureInfo, Calendar, and CalendarWeekRule. These classes are essential for handling date and time information in a .NET application. The unit includes code samples to demonstrate how to retrieve and manipulate day of the week information, handle culture-specific data, perform calendar-related operations, and define rules for determining the first week of the year.

## DayOfWeek, CultureInfo, Calendar, and CalendarWeekRule samples

### DayOfWeek class methods

The `DayOfWeek` enumeration represents the days of the week in C#. It is used to retrieve and manipulate day of the week information in a C# application.

```csharp
DateTime today = DateTime.Now; // Get the current date and time
DayOfWeek day = today.DayOfWeek; // Retrieve the current day of the week
Console.WriteLine("Today is: " + day);

DateTime nextSunday = today.AddDays(7 - (int)day); // Calculate the next Sunday
Console.WriteLine("Next Sunday is on: " + nextSunday.ToShortDateString());

bool isWeekend = day == DayOfWeek.Saturday || day == DayOfWeek.Sunday; // Check if today is a weekend
Console.WriteLine("Is today a weekend? " + isWeekend);
```

Example output:

```console
Today is: Wednesday
Next Sunday is on: 10/15/2023
Is today a weekend? False
```

In this example, the `DayOfWeek` property retrieves the current day, calculates the next Sunday, and checks if the current day is a weekend.

### CultureInfo class methods

The `CultureInfo` class provides culture-specific information, such as language, country/region, calendar, and conventions associated with a particular culture. This class is essential for handling culture-specific data in a .NET application.

```csharp
// Retrieve the current culture and UI culture
CultureInfo currentCulture = CultureInfo.CurrentCulture;
CultureInfo currentUICulture = CultureInfo.CurrentUICulture;
Console.WriteLine("Current Culture: " + currentCulture.Name);
Console.WriteLine("Current UI Culture: " + currentUICulture.Name);

// Set a new culture and UI culture
CultureInfo newCulture = new CultureInfo("fr-FR");
CultureInfo.CurrentCulture = newCulture;
CultureInfo.CurrentUICulture = newCulture;
Console.WriteLine("New Culture: " + CultureInfo.CurrentCulture.Name);
Console.WriteLine("New UI Culture: " + CultureInfo.CurrentUICulture.Name);
```

Example output:

```console
Current Culture: en-US
Current UI Culture: en-US
New Culture: fr-FR
New UI Culture: fr-FR
```

### Calendar and CalendarWeekRule class methods

The `Calendar` class represents time in divisions such as weeks, months, and years. It provides methods to perform calendar-related operations like getting the number of days in a month or determining the week of the year. The `CalendarWeekRule` enumeration defines rules for determining the first week of the year, which can be used with the `Calendar.GetWeekOfYear` method.

```csharp
// Create a calendar instance
Calendar calendar = CultureInfo.InvariantCulture.Calendar;

// Get the number of days in February 2023
int daysInMonth = calendar.GetDaysInMonth(2023, 2);
Console.WriteLine("Days in February 2023: " + daysInMonth);

// Determine the week of the year for December 31, 2023
DateTime date = new DateTime(2023, 12, 31);
CalendarWeekRule rule = CalendarWeekRule.FirstDay;
DayOfWeek firstDayOfWeek = DayOfWeek.Sunday;
int weekOfYear = calendar.GetWeekOfYear(date, rule, firstDayOfWeek);
Console.WriteLine("Week of the year for December 31, 2023: " + weekOfYear);
```

Example output:

```console
Days in February 2023: 28
Week of the year for December 31, 2023: 53
```

This code demonstrates how to use the `Calendar` class to retrieve the number of days in a month and determine the week of the year for a specific date. The `CalendarWeekRule` and `DayOfWeek` values are used together to define how weeks are assigned in a calendar.

The `CalendarWeekRule` enumeration defines different rules for determining the first week of the year. It is used in conjunction with the `Calendar.GetWeekOfYear` method.

#### Define the first week of the year

The `CalendarWeekRule` enumeration has three values: `FirstDay`, `FirstFullWeek`, and `FirstFourDayWeek`. Here is an example of how to use these values:

Review the following code:

```csharp
DateTime date = new DateTime(2023, 1, 5);
CalendarWeekRule rule = CalendarWeekRule.FirstFourDayWeek;
DayOfWeek firstDayOfWeek = DayOfWeek.Sunday;
int weekOfYear = calendar.GetWeekOfYear(date, rule, firstDayOfWeek);
Console.WriteLine("Week of the year: " + weekOfYear);
```

In this example, the `FirstFourDayWeek` rule is used to determine the first week of the year. The week could be split between two years, so there is a standard that a week is at least 4 days for the first week of the year.

> [!NOTE]
> The `CalendarWeekRule` and `DayOfWeek` values are used together to determine how weeks are assigned in a calendar.

Now you can use classes like `DayOfWeek`, `CultureInfo`, `Calendar`, and `CalendarWeekRule` to manage dates and times in C#. Apply these skills to build culture-aware and calendar-based features in your applications.
