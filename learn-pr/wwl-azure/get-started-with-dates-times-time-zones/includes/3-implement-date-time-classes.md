Imagine you're a programmer working on a project centered around scheduling meetings and logging events across different time zones. Successfully navigating this task requires handling date and time in C# to ensure accurate scheduling and event logging within your application.

## DateOnly, TimeOnly, DateTime

These classes focus on basic date and time representation, suitable for common tasks like scheduling and logging.

- **`DateOnly`**: Use this class when you need to work with dates without considering the time of day, such as setting event dates.
- **`TimeOnly`**: Ideal for scenarios where only the time is relevant, like scheduling daily sessions.
- **`DateTime`**: The most versatile structure, combining both date and time, suitable for general scheduling tasks.

For these classes, you find methods that help with parsing, formatting, and comparing date and time values. For example, `DateTime` offers many methods for date and time manipulation, including addition, subtraction, and comparison.

Review the following code:

```csharp
TimeOnly meetingTime = new TimeOnly(14, 30); // 2:30 PM
Console.WriteLine($"Meeting Time: {meetingTime}");

// Console Output: Meeting Time: 14:30
```

This code snippet demonstrates how to create and display a `TimeOnly` object, which represents a specific time of day without a date. The constructor initializes the time using hours and minutes, and the `Console.WriteLine` method outputs it in a readable format.

## DateTimeOffset, TimeZoneInfo, TimeSpan

These classes handle more complex scenarios, such as time zone conversions and interval calculations, providing precision and flexibility.

- **`DateTimeOffset`**: Essential for applications that need to account for different time zones, as it includes an offset from UTC.
- **`TimeZoneInfo`**: Allows conversion of times between different time zones, ensuring accurate scheduling.
- **`TimeSpan`**: Represents durations or intervals, useful for calculating the length of events or breaks.

These classes come with methods for converting between time zones, adjusting offsets, and performing arithmetic on time intervals. For instance, `TimeSpan` offers methods for adding, subtracting, and comparing time intervals.

Review the following code:

```csharp
TimeSpan duration = new TimeSpan(2, 0, 0); // 2 hours
Console.WriteLine($"Event Duration: {duration}");

// Console Output: Event Duration: 02:00:00
```

This code snippet shows how to create and display a `TimeSpan` object, illustrating the concept of time intervals. It initializes a `TimeSpan` with hours, minutes, and seconds, and outputs the duration in a readable format.

## DayOfWeek, CultureInfo, Calendar, CalendarWeekRule

These classes support cultural-specific operations and specific date calculations which are essential for internationalization and calendar-based applications.

- **`DayOfWeek`**: An enumeration useful for determining or comparing specific days, aiding in weekly scheduling.
- **`CultureInfo`**: Provides information about specific cultures, including date and time formatting rules, essential for globalized applications.
- **`Calendar`**: Represents different calendar systems, allowing you to work with dates in various cultural contexts.
- **`CalendarWeekRule`**: Defines how the first week of the year is determined, useful for applications relying on week-based calculations.

These classes offer methods for formatting and parsing date and time according to cultural norms, and for date calculations within specific calendar systems.

Review the following code:

```csharp
DayOfWeek today = DateTime.Now.DayOfWeek;
Console.WriteLine($"Today is: {today}");

// Console Output: Today is: [Current Day of the Week]
```

This code snippet demonstrates how to retrieve and display the current day of the week using the `DayOfWeek` enumeration. It accesses the `DayOfWeek` property from the current date and time, and outputs the result in a readable format.

By understanding these classes and their basic methods, you begin to build a foundation for handling date and time in your applications. As you continue learning, you're able to apply these concepts to ensure accurate scheduling and logging across different time zones. Each section sets the stage for deeper exploration in future units, where you dive into more advanced methods and applications.
