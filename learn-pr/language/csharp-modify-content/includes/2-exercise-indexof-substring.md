Let's begin by accessing parts of a string by identifying the position of one or more characters. Once you've located the position, you can then extract a specific part of the string.

## Exercise - Use the string's IndexOf() and Substring() helper methods

In this exercise, you'll use the `IndexOf()` method and its variants, including `IndexOfAny()` and `LastIndexOf()`, to locate the position of one character or string inside a larger string.

Once you've located the position, you can use the `Substring()` method to return the rest of the string after the position.

Or you can use an overloaded version of the `Substring()` method to set the number of characters (length) to return after the position.

### Step 1 - Write code to find an opening and closing parenthesis embedded in a string

In the .NET Editor, add the following code:

```csharp-interactive
string message = "Find what is (inside the parentheses)";

int openingPosition = message.IndexOf('(');
int closingPosition = message.IndexOf(')');

Console.WriteLine(openingPosition);
Console.WriteLine(closingPosition);
```

Run the code to get the following output:

```output
13
36
```

In this case, the index of the `(` character is 13. Remember, these values are zero-based, so it's the 14th character in the string. The index of the `)` character is `36`.

Now that you have the two indexes, you can use them as the boundaries to retrieve the value between them.

### Step 2 - Add code to retrieve the value between two parenthesis characters

Modify the code from step 1 to match the following code listing:

```csharp-interactive
string message = "Find what is (inside the parentheses)";

int openingPosition = message.IndexOf('(');
int closingPosition = message.IndexOf(')');

// Console.WriteLine(openingPosition);
// Console.WriteLine(closingPosition);

int length = closingPosition - openingPosition;
Console.WriteLine(message.Substring(openingPosition, length));
```

When you run the code this time, you'll get the following output:

```output
(inside the parentheses
```

The `Substring()` method needs the starting position and the number of characters (or length) to retrieve. So, you calculated the length in a temporary variable called `length`, and passed it with the `openingPosition` value to retrieve the string inside of the parenthesis.

The result is close; however, the output includes the opening parenthesis. In this particular situation, this isn't the desired result. To fix the result, we'll have to update our code to skip the index of the parenthesis itself.

### Step 3 - Update the code to modify the starting position of the sub string

Update the code from step 2 to match the following listing:

```csharp-interactive
string message = "Find what is (inside the parentheses)";

int openingPosition = message.IndexOf('(');
int closingPosition = message.IndexOf(')');

openingPosition += 1;

int length = closingPosition - openingPosition;
Console.WriteLine(message.Substring(openingPosition, length));
```

Run the code to get the following output:

```output
inside the parentheses
```

By increasing the `openingPosition` by `1`, you skip over the opening parenthesis character.

We're using the value `1` is because that's the length of the character. If we were attempting to locate a value starting after a longer string, for example, `<div>` or `---`, we'd use the length of that string instead.

The following snippet of code shows how to find the value inside an opening and closing `<span>` tag.

```csharp
string message = "What is the value <span>between the tags</span>?";

int openingPosition = message.IndexOf("<span>");
int closingPosition = message.IndexOf("</span>");

openingPosition += 6;
int length = closingPosition - openingPosition;
Console.WriteLine(message.Substring(openingPosition, length));
```

In this case, we're adding `6` to the `openingPosition` as the offset to calculate the length of the sub string.

### Avoid magic values

Hardcoded strings like `"<span>"` in the previous code listing are known as "magic strings", and hardcoded numeric values like `6` are known as "magic numbers". These "magic" values are undesirable for a number of reasons, and you should try to avoid them if possible.

In this specific case, consider how your code might break if you hardcoded the string `"<span>"` multiple times in your code, but misspelled one instance of it as `"<sapn>"`. The compiler won't catch this at compile time, because the value is in a string. The misspelling will likely cause problems at runtime, and depending on the complexity of your code, it might be difficult to track down. Furthermore, if you change the string `"<span>"` to `"<div>"`, but forget to change the number `6`, then your code will produce undesirable results.

Instead, you should use a constant with the `const` keyword. A constant allows you to define and initialize a variable whose value can never be changed. You'd then use that constant in the rest of the code whenever you needed that value. This ensures that the value is only defined once, and the compiler will catch misspelling the `const` variable.

The following code listing is a much safer way to write the same code:

```csharp
string message = "What is the value <span>between the tags</span>?";

const string openSpan = "<span>";
const string closeSpan = "</span>";

int openingPosition = message.IndexOf(openSpan);
int closingPosition = message.IndexOf(closeSpan);

openingPosition += openSpan.Length;
int length = closingPosition - openingPosition;
Console.WriteLine(message.Substring(openingPosition, length));
```

This time, if the value of `openSpan` changes, the line of code that uses the `Length` property will be valid.

### Step 4 - Write code to retrieve the last occurrence of a sub string

Next, let's increase the complexity of the `message` variable by adding many sets of parentheses, then write code to retrieve the content inside the **last** set of parentheses.

Update the code from step 3 to match the following listing:

```csharp-interactive
string message = "(What if) I am (only interested) in the last (set of parentheses)?";
int openingPosition = message.LastIndexOf('(');

openingPosition += 1;
int closingPosition = message.LastIndexOf(')');
int length = closingPosition - openingPosition;
Console.WriteLine(message.Substring(openingPosition, length));
```

When you run the code, you should get the following output:

```output
set of parentheses
```

The key to this example is the use of `LastIndexOf()`, which you can use to get the positions of the last opening and closing parentheses.

### Step 5 - Update the code example to retrieve any value between one or more sets of parentheses in a string

This time, we'll update the `message` to have three sets of parentheses, and we'll write code to extract any text inside of them. We'll be able to reuse portions of our previous work, but we'll need to add a `while` statement to iterate through the string until all sets of parentheses are discovered, extracted, and displayed.

Update the code from step 4 to match the following code listing:

```csharp-interactive
string message = "(What if) there are (more than) one (set of parentheses)?";
while (true)
{
    int openingPosition = message.IndexOf('(');
    if (openingPosition == -1) break;

    openingPosition += 1;
    int closingPosition = message.IndexOf(')');
    int length = closingPosition - openingPosition;
    Console.WriteLine(message.Substring(openingPosition, length));

    // Note how we use the overload of Substring to return only the remaining 
    // unprocessed message:
    message = message.Substring(closingPosition + 1);
}
```

When you run the code, you'll get the following output:

```output
What if
more than
set of parentheses
```

The key to understanding this technique is the last line of code inside the `while` loop:

```csharp
message = message.Substring(closingPosition + 1);
```

When you use `Substring()` without specifying a length input parameter, it'll return every character after the starting position you specify. We can use this to our advantage, removing the first set of parentheses from the value of `message`. What remains is then processed in the next iteration of the `while` loop.

What happens during the final iteration when all that's left is the final `?` character?

That's addressed by the following lines of code:

```csharp
int openingPosition = message.IndexOf('(');
if (openingPosition == -1) break;
```

The `IndexOf()` method will return `-1` if it can't find the input parameter in the string. We merely check for the value `-1` and `break` out of the loop.

Let's consider an even more advanced example. This time, we'll search for several different symbols, not just a set of parentheses.

### Step 6 - Update the code example to work with different types of symbol sets

This time, we'll update the `message` string, adding different types of symbols like square brackets and curly braces. We'll rely on `IndexOfAny()` to provide an array of characters representing the opening symbols. `IndexOfAny()` will return the first match it finds in the string.

Once we find a symbol, we'll need to find its matching closing symbol. When we've done that, the rest should look similar. We'll use a different tactic instead of modifying the original value of `message`. This time, we'll use the closing position of the previous iteration as the opening position of the current iteration.

Update the code from step 5 to match the following code:

```csharp-interactive
string message = "(What if) I have [different symbols] but every {open symbol} needs a [matching closing symbol]?";

// The IndexOfAny() helper method requires a char array of characters. 
// We want to look for:

char[] openSymbols = { '[', '{', '(' };

// We'll use a slightly different technique for iterating through the 
// characters in the string. This time, we'll use the closing position
// of the previous iteration as the starting index for the next open
// symbol. So, we need to initialize the closingPosition variable
// to zero:

int closingPosition = 0;

while (true)
{
    int openingPosition = message.IndexOfAny(openSymbols, closingPosition);

    if (openingPosition == -1) break;

    string currentSymbol = message.Substring(openingPosition, 1);

    // Now we must find the matching closing symbol
    char matchingSymbol = ' ';

    switch (currentSymbol)
    {
        case "[":
            matchingSymbol = ']';
            break;
        case "{":
            matchingSymbol = '}';
            break;
        case "(":
            matchingSymbol = ')';
            break;
    }

    // To find the closingPosition, we use an overload of the IndexOf method to specify 
    // that our search for the matchingSymbol should start at the openingPosition in the string. 
    
    openingPosition += 1;
    closingPosition = message.IndexOf(matchingSymbol, openingPosition);

    // Finally, use the techniques we've already learned to display the sub-string:

    int length = closingPosition - openingPosition;
    Console.WriteLine(message.Substring(openingPosition, length));
}
```

When you run the code, you'll get the following output:

```output
What if
different symbols
open symbol
matching closing symbol
```

In this example, we've added some comments to explain what's happening. Besides using `IndexOfAny()` to locate one of several possible symbols, the key is the following line of code:

```csharp
closingPosition = message.IndexOf(matchingSymbol, openingPosition);
```

The variable `closingPosition` is used in the `Substring()` method, but is also used to find the next `openingPosition` value.

```csharp
int openingPosition = message.IndexOfAny(openSymbols, closingPosition);
```

This is why the `closingPosition` variable is defined outside of the `while` loop and initialized to `0` for the first iteration.

## Recap

We covered significant ground in this unit. Here are the most important things to remember:

- `IndexOf()` gives us the first position of a character or string inside of another string.
- `IndexOf()` returns `-1` if it can't find a match.
- `Substring()` returns just the specified portion of a string, using a starting position and optional length.
- `LastIndexOf()` returns the last position of a character or string inside of another string.
- `IndexOfAny()` returns the first position of an array of `char` that occurs inside of another string.
- There's often more than one way to solve a problem. We used two separate techniques to find all instances of a given character or string.
- Avoid hardcoded magic values. Instead, define a `const` variable. A constant variable's value can't be changed after initialization.
