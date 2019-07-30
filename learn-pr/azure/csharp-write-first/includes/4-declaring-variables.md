A literal is *literally* a hard coded value.  However, to build applications, we'll want to work with values that vary, or are variable.  In other words, we will want to work with data that comes from users, from files or from the network.  To work with those values, we'll need to give them a name so we can reference them in our code understanding that their value may change.

## What is a variable?

A variable is a data item that may change its value during its lifetime.  You use variables to temporarily store values that you intend to use later in your code.  Behind the scenes, a variable is friendly name that we can assign to a computer memory address where the value will actually be stored.

### Declaring a variable

To create a new variable, you must first declare the data type of the variable, then give it a name.

```csharp
string firstName;
```

In this case, we're creating a new variable of type `string` called `firstName`.  From now on, this variable can only hold string values.

I can choose any name as long as it adheres to a few C# syntax rules for naming variables.

### Variable name rules and conventions

A software developer once famously said "The hardest part of software development is naming things."  Not only does the name of a variable have to follow certain syntax rules, it should also be used to make the code more human-readable and understandable.  That's a lot to ask of one line of code!

Variable names:

- Can contain alphanumeric characters and the understore character.  Special characters like the pound `#` or dollar sign `$` are forbidden.
- Must begin with an alphabetical letter or an underscore, not a number.  Developers use the underscore for a special purpose, so try to not use that for now.
- Must NOT be a C# keyword.  For example, you cannot do the following: `float float;` or `string string;`.
- Are case sensitive, meaning that `string Value;` and `string value;` are two different variables.
- Should use **camel case**, which is a style of writing that uses a lower-case letter at the beginning of the first word and an upper-case letter at the beginning of each subsequent word.  For example: `string thisIsCamelCase;`.
- Should be descriptive and meaningful in your application.  You should choose a name for your variable that represents the kind of data it will hold.
- Should be one or more entire words appended together.  Don't use contractions because the name of the variable (and therefore its purpose) may be unclear to others who are reading your code.
- Should not include the data type of the variable.  You might see some advice to use a style like `string strValue;`.  No one does that any more.

The example `string firstName;` follows all of these rules and conventions, assuming I want to use this variable to store data that represents someone's first name.

### Variable name examples

Here's a few examples of variable declarations using the data types we learned about previously.

```csharp
char userOption;

int gameScore;

float particlesPerMillion;

bool processedCustomer;
```

Now that we know how to declare a variable, let's learn how to set, retrieve and initialize the value of a variable.