In the introduction, we described a scenario that required us to match a number representing the employee's level to a title. In this exercise, we'll use a `switch-case` construct implement this branching logic.

## What is the switch statement?

`switch` is a selection statement that chooses a single switch section to execute from a list of candidates, based on a pattern match with the match expression. A switch statement includes one or more switch sections. Each switch section contains one or more case labels (either a case or default label) followed by one or more statements. The switch statement may include at most one default label placed in any switch section.

The switch is best used when:

- You have a single value you want to match against many possible values, but;
- For any given match, you need to execute a couple of lines of code at most.

It's possible that multiple cases apply. However, C# will select the first matching expression.

### Step 1 - Create the switch statement

Add the following code into the .NET Editor:

```csharp-interactive
int employeeLevel = 200;
string employeeName = "John Smith";

string title = "";

switch (employeeLevel)
{
    case 100:
        title = "Junior Associate";
        break;
    case 200:
        title = "Senior Associate";
        break;
    case 300:
        title = "Manager";
        break;
    case 400:
        title = "Senior Manager";
        break;
    default:
        title = "Associate";
        break;
}

Console.WriteLine($"{employeeName}, {title}");
```

Now, run the code. You should get the following output:

```output
John Smith, Senior Associate
```

The `switch` keyword defines the purpose of the code block below. Next to the keyword, the match expression in parenthesis `(employeeLevel)`.

Inside the code block, there are one or more *switch sections*. Each switch section has one or more labels. A label begins with the keyword `case` and a matching pattern. The runtime compares the value of the match expression with each matching pattern until it finds a match.

Once the runtime finds a matching label, it performs the code in that particular switch section.

Only one switch section can be executed. The `break` keyword is one of several ways to end a switch section and literally break out of the switch statement. If you forget the `break` keyword (or, optionally, the `return` keyword), the compiler will generate an error.

If there are no matching labels, the optional `default` label will be matched. If there's no `default` defined, then the `switch` statement only executes when one of its cases match.

The optional `default` label is not required to be defined after the rest of the cases. However, most developers choose to put it last, because logically it makes sense as the "default" or "last option".

### Step 2 - Change the level variable value to see how the switch statement evaluates it

To exercise the default case, let's change the employee's level by modifying the following line of code:

```csharp
int employeeLevel = 201;
```

Now, when you run the code, the more generic title should appear:

```output
John Smith, Associate
```

Since the `employeeLevel` doesn't match any labels, the `default` label is matched.

### Step 3 - Modify the application to use fall through

Our company decided to give all level 100 employees the title "Senior Associate", the same title as level 200 employees. As the developer, you decide to implement this by removing the first switch section belonging to the label `case 100:`, and instead allow both the `case 100:` and `case 200:` labels execute the same switch section.

Modify the code to set the `employeeLevel` to `100`:

```csharp
int employeeLevel = 100;
```

Next, edit the code to:

```csharp
    case 100:
    case 200:
        title = "Senior Associate";
        break;
```

When you're finished making changes, your modifications should match the following code:

```csharp-interactive
int employeeLevel = 100;
string employeeName = "John Smith";

string title = "";

switch (employeeLevel)
{
    case 100:
    case 200:
        title = "Senior Associate";
        break;
    case 300:
        title = "Manager";
        break;
    case 400:
        title = "Senior Manager";
        break;
    default:
        title = "Associate";
        break;
}

Console.WriteLine($"{employeeName}, {title}");
```

Now, run the application. You should get the following output:

```output
John Smith, Senior Associate
```

Both of the case labels `100` and `200` are now paired with the switch section that sets the title to the string value `Senior Associate`.

## Recap

Here are the main takeaways you learned about the switch statement:

- Use the `switch` statement when you have one value with many possible matches, with each match requiring a branch in your code logic.
- A single switch section containing code logic can be matched using one or more labels defined by the `case` keyword.
- Use the optional `default` keyword to create a label and a switch section to be used when no other case labels match.
