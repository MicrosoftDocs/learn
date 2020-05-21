Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

You've been asked to add a feature to your company's software.  The feature is intended to improve the renewal rate of subscriptions to the software.  Your task is to display a renewal message when a user logs into the software system and their subscription will soon end.  You'll need to add a couple of decision statements to properly add branching logic to the application to satisfy the requirements.

### Step 1 - Delete all of the code in the .NET Editor from the earlier exercise.

Select all of the code in the .NET Editor then select the `del` or backspace key to delete it.

### Step 2 - Copy the following code as a starting point to the .NET Editor.

```csharp-interactive
Random random = new Random();
int daysUntilExpiration = random.Next(12);
int discountPercentage = 0;

// Your code goes here
```

> [!IMPORTANT]
> You can only remove the code comments.  In other words, you may remove the line of code that starts with `//`, but you may not remove any other code.  Furthermore, you must use all of the variables in your code.

### Step 3 - Use two if statements to implement the following business rules:

**Rule 1.**  If the user's subscription will expire in 10 days or less, output the message:

```output
Your subscription will expire soon.  Renew now!
```

**Rule 2.**  If the user's subscription will expire in five days or less, output the messages:

```output
Your subscription expires in _ days.
Renew now and save 10%!
```

Make sure to substitute _ for value stored in the variable `daysUntilExpiration`.

**Rule 3.**  If the user's subscription will expire in one day, output the message:

```output
Your subscription expires within a day!
Renew now and save 20%!
```

**Rule 4.**  If the user's subscription has expired, output the message:

```output
Your subscription has expired.
```

**Rule 5.** If the user's subscription doesn't expire in 10 days or less, output nothing.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.