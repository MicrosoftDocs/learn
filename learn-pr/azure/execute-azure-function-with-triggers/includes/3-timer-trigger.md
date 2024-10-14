It's common to execute a piece of logic at a set interval. Imagine you're a blog owner, and you notice that your subscribers aren't reading your most recent posts. You decide that the best action is to send an email once a week to remind them to check your blog. You implement this logic by creating a function app in Azure with a *timer trigger* to invoke your function weekly.

## What is a timer trigger?

A timer trigger is a trigger that executes a function at a consistent interval. To create a timer trigger, you need to supply two pieces of information.

1. A *Timestamp parameter name*, which is simply an identifier to access the trigger in code.
2. A *Schedule*, which is a CRON expression that sets the interval for the timer.

## What is a CRON expression?

A *CRON expression* is a string that consists of six fields that represent a set of times.

The order of the six fields in Azure is: `{second} {minute} {hour} {day} {month} {day of the week}`.

For example, a CRON expression to create a trigger that executes every five minutes looks like: `0 */5 * * * *`

At first, this string might look confusing. We'll come back and break down these concepts when we have a deeper look at CRON expressions.

To build a CRON expression, you need to have a basic understanding of some of the special characters.

| Special character | Meaning | Example |
| ------------- | ------------- | ------------- |
| *      | Selects every value in a field | An asterisk "*" in the day of the week field means *every* day. |
| ,      | Separates items in a list | A comma "1,3" in the day of the week field means just Mondays (day 1) and Wednesdays (day 3). |
| -      | Specifies a range | A hyphen "10-12" in the hour field means a range that includes the hours 10, 11, and 12. |
| /      | Specifies an increment | A slash "*/10" in the minutes field means an increment of every 10 minutes. |

Now we'll go back to the original CRON expression example. Let’s try to understand it better by breaking it down field by field.

```text
0 */5 * * * *
```

The **first field** represents seconds. This field supports the values 0-59. Because the field contains a zero, it selects the first possible value, which is one second.

The **second field** represents minutes. The value "*/5" contains two special characters. First, the asterisk (\*) means "select every value within the field." Because this field represents minutes, the possible values are 0-59. The second special character is the slash (/), which represents an increment. When you combine these characters together, it means for all values 0-59, select every fifth value. An easier way to say that is simply "every five minutes."

The **remaining four fields** numerically represent the hour in a 24-hour day, day in the month, month in a 12-month year, and day of the 7-day week. An asterisk for these fields means to select every possible value. In this example, we select "every hour of every day of every month."

When you put all the fields together, the expression is read as "the first second of every fifth minute of every hour, of every day, of every month".

## How to create a timer trigger

You can create a timer trigger in the Azure portal. In your function app, select **timer trigger** from the list of trigger templates. Enter the logic that you want to execute. Supply a **Timestamp parameter name** and the **CRON expression**.

In this module, we'll focus on creating triggers in the portal, but you can also create triggers programmatically using Core Tools, Visual Studio or Visual Studio Code.

A timer trigger invokes the function code on a consistent schedule. To define the schedule for a timer trigger, we build a CRON expression, which is a string that represents a set of times.
