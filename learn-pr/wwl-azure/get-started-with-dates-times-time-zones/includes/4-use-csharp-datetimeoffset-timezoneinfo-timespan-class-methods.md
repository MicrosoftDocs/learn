In this learning unit, you explore how to use various methods of the DateTimeOffset, TimeZoneInfo, and TimeSpan classes in a .NET application using Visual Studio Code. These classes are essential for handling date and time information accurately and efficiently in your applications.

## Date and time with offsets, zone conversions, and interval samples

### DateTimeOffset methods

The `DateTimeOffset` structure represents a date and time along with an offset showing the difference from UTC. It's ideal for applications that require precise identification of a specific moment, perform date and time calculations, and maintain various related times.

- Use the `DateTimeOffset` type to log transaction times, system or application events, and file creation and modification times.
- Perform arithmetic operations with `DateTimeOffset` values to manipulate dates and times while considering their offsets.

Review the following code:

```csharp
DateTimeOffset now = DateTimeOffset.Now; // Get the current date and time with offset
Console.WriteLine($"Current date and time with offset: {now}");

DateTimeOffset utcNow = DateTimeOffset.UtcNow; // Get the current UTC date and time with offset
Console.WriteLine($"Current UTC date and time with offset: {utcNow}");

DateTimeOffset futureDate = now.AddDays(10); // Add 10 days to the current date and time
Console.WriteLine($"Date 10 days from now: {futureDate}");

DateTimeOffset pastDate = now.AddHours(-5); // Subtract 5 hours from the current date and time
Console.WriteLine($"Date 5 hours ago: {pastDate}");

TimeSpan difference = futureDate - now; // Calculate the time difference between two dates
Console.WriteLine($"Difference between now and future date: {difference}");
```

Example output:

```console
Current date and time with offset: 10/25/2025 2:30:45 PM +00:00
Current UTC date and time with offset: 10/25/2025 2:30:45 PM +00:00
Date 10 days from now: 11/4/2025 2:30:45 PM +00:00
Date 5 hours ago: 10/25/2025 9:30:45 AM +00:00
Difference between now and future date: 10.00:00:00
```

This code demonstrates how to create a `DateTimeOffset` object for the current time, retrieve the UTC equivalent, perform arithmetic operations like adding days or subtracting hours, and calculate the difference between two `DateTimeOffset` values. These methods make `DateTimeOffset` a versatile choice for handling date and time data in applications.

### TimeZoneInfo methods

The `TimeZoneInfo` class represents any of the Earth's time zones and enables the conversion of any date and time in one time zone to its equivalent in another time zone. It supports the creation of custom time zones and the serialization and deserialization of time zone information.

- Use `TimeZoneInfo` to convert times between different time zones, ensuring that date and time values unambiguously identify a single point in time.
- Create custom time zones and serialize them for later use.

Review the following code:

```csharp
DateTime utcNow = DateTime.UtcNow; // Get current UTC time
Console.WriteLine($"UTC Now: {utcNow}");

DateTime estNow = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(utcNow, "Eastern Standard Time"); // Convert UTC to EST
Console.WriteLine($"EST Now: {estNow}");

TimeZoneInfo localZone = TimeZoneInfo.Local; // Get local time zone
Console.WriteLine($"Local Time Zone: {localZone.DisplayName}");

DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(utcNow, localZone); // Convert UTC to local time
Console.WriteLine($"Local Time: {localTime}");

TimeZoneInfo pstZone = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time"); // Find PST time zone
DateTime pstTime = TimeZoneInfo.ConvertTime(utcNow, pstZone); // Convert UTC to PST
Console.WriteLine($"PST Time: {pstTime}");
```

Example output:

```console
UTC Now: 10/10/2023 14:00:00
EST Now: 10/10/2023 10:00:00
Local Time Zone: (UTC-05:00) Eastern Time (US & Canada)
Local Time: 10/10/2023 10:00:00
PST Time: 10/10/2023 07:00:00
```

This code demonstrates how to convert UTC time to various time zones, retrieve the local time zone, and find a specific time zone by its ID.

### TimeSpan class methods

The `TimeSpan` structure represents a time interval and is typically used to reflect the time interval between two date and time values or to measure elapsed time.

- Use `TimeSpan` to calculate the difference between two `DateTime` values or to measure elapsed time with the `Stopwatch.Elapsed` property.
- Replace `DateTime` values with `TimeSpan` when representing a time without reference to a particular day.

Review the following code:

```csharp
TimeSpan duration = new TimeSpan(2, 14, 18); // 2 hours, 14 minutes, 18 seconds
Console.WriteLine($"Duration: {duration}");

TimeSpan fromDays = TimeSpan.FromDays(1.5); // Create TimeSpan from 1.5 days
Console.WriteLine($"From Days: {fromDays}");

TimeSpan fromHours = TimeSpan.FromHours(5.75); // Create TimeSpan from 5.75 hours
Console.WriteLine($"From Hours: {fromHours}");

TimeSpan difference = TimeSpan.FromHours(10) - TimeSpan.FromMinutes(30); // Subtract intervals
Console.WriteLine($"Difference: {difference}");

TimeSpan multiplied = TimeSpan.FromMinutes(15) * 2; // Multiply interval
Console.WriteLine($"Multiplied: {multiplied}");
```

Example output:

```console
Duration: 02:14:18
From Days: 1.12:00:00
From Hours: 05:45:00
Difference: 09:30:00
Multiplied: 00:30:00
```

This code demonstrates creating `TimeSpan` objects using constructors and factory methods, performing arithmetic operations, and displaying results in a readable format.

Now you can use `DateTimeOffset` to log times with UTC offsets, `TimeZoneInfo` to convert between time zones, and `TimeSpan` to work with time intervals. These tools help you manage date and time data accurately in your .NET applications.
