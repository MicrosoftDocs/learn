It's common to execute a piece of logic at a set interval. For example, imagine you're a blog owner and you notice that your subscribers are not reading your most recent posts. You decide that the best action is to send an email once a week to remind them to check your blog. You implement this logic using an Azure Function with a timer trigger to invoke your function every seven days.

Here, you'll learn how to create a timer trigger and instruct the trigger to run at a consistent interval.

## What is a timer trigger?

A timer trigger is a trigger that executes a function at a consistent interval. To create a timer trigger, you need to supply two pieces of information. The first requirement is a *Timestamp parameter name*, which is simply an identifier to access the trigger in code. The second requirement is a *Schedule*, which is a *CRON expression* that sets the interval for the timer.

## What is a CRON expression?

A *CRON expression* is a string that consists of six fields that represent a set of times.

The order of the six fields in Azure are: {second} {minute} {hour} {day} {month} {day of the week}.

For example, a *CRON expression* to create a trigger that executes every 5 minutes would look like this:

```
0 */5 * * * *
```
At first this may look confusing, however, we'll come back and break this down when we have a deeper look at *CRON expressions*.

To build a *CRON expression*, you need to have a basic understanding of some of the special characters.

| Special character | Meaning | Example |
| ------------- | ------------- | ------------- |
| *      | Selects every value within the field | A "*" in the day of the week field means every day. |
| ,      | Separates items of a list | A "1,3" in the day of the week field means just Mondays and Wednesdays. |
| -      | Specifies a range | A "10-12" in the hour field means select hours 10, 11, and 12. |
| /      | Specifies increments      | A "*/10" in the minutes field means every 10 minutes. |

Going back to the original example, let’s try to understand it better by breaking it down field by field.

```
0 */5 * * * *
```

The **first field** represents seconds. This field supports the values 0-59. Since the field contains a zero, it will select the first possible value, which is one second.

The **second field** represents minutes. The value "*/5" contains two special characters. First, the asterisk means select every value within the field. Since this is the minutes field, the possible values are 0-59. The second special character is the slash, which represents an increment. Putting these together it means, for all values 0-59, select every fifth value. An easier way to say that is simply every five minutes.

The **remaining four fields** represent hour, day, month, and day of the week. An asterisk for these fields means to select every possible value. In this example that means every hour of every day of every month.

Putting all the fields together, this expression is read as "on the first second of every fifth minute of every hour of every day of every month".

## How to create a timer trigger

A timer trigger can be created completely inside the Azure portal. Inside your Azure Function, select **timer trigger** from the list of predefined trigger types, enter your logic that you want to execute, and supply a *Timestamp parameter name* and *CRON expression*.

## Summary

A timer trigger invokes an Azure Function on a consistent schedule. To define a timer trigger's schedule, we have to build a *CRON expression*, which is a string that represents a set of times.

