The final basic operation you'll learn in this module is how to increment and decrement values using special operators that are combinations of symbols.

## Increment and decrement

Frequently, you'll need to increment and decrement a value, especially when you work with any looping logic or code that interacts with a data structure that houses multiple elements of data.

The `+=` operator adds and assigns the value on the right of the operator to the value on the left of the operator, so lines two and three in the following code snippet are the same:

```csharp-interactive
int value = 0;
value = value + 5;
value += 5;
```

The `++` operator increments the value of the variable by 1, so lines two and three in the following code snippet are the same:

```csharp-interactive
int value = 0;
value = value + 1;
value++;
```

You can use these techniques for subtraction, multiplication and more. The following exercise steps will highlight a few.

> [!NOTE]
> Operators like `+=`, `-=`, `*=`, `++`, and `--` are known as *compound assignment* operators, because they compound some operation in addition to assigning the result to the variable. The `+=` operator is specifically termed the *addition assignment* operator.

### Step 1 - Write code to increment and decrement a value

Enter the following code in the code editor:

```csharp-interactive
int value = 1;

value = value + 1;
Console.WriteLine("First increment: " + value);

value += 1;
Console.WriteLine("Second increment: " + value);

value++;
Console.WriteLine("Third increment: " + value);

value = value - 1;
Console.WriteLine("First decrement: " + value);

value -= 1;
Console.WriteLine("Second decrement: " + value);

value--;
Console.WriteLine("Third decrement: " + value);
```

If you run the code, you'll get the following output:

```output
First increment: 2
Second increment: 3
Third increment: 4
First decrement: 3
Second decrement: 2
Third decrement: 1
```

> [!NOTE]
> In the "second increment", we used `value += 1;`. However, we could've used any literal `int` value (or a variable) to increment that amount. The same holds true for the "second decrement": `value -= 1;`.

## Positioning the increment and decrement operators

Both the increment and decrement operators have an interesting quality: depending on their position, they perform their operation before or after they retrieve their value. In other words, if you use the operator before the value (as in `++value`), the increment will happen *before* the value is retrieved. Likewise, `value++` will increment the value *after* the value has been retrieved.

### Step 2 - Use the increment operator before and after the value

Delete or comment out the code in the previous example, then add the following lines of code:

```csharp-interactive
int value = 1;
value++;
Console.WriteLine("First: " + value);
Console.WriteLine("Second: " + value++);
Console.WriteLine("Third: " + value);
Console.WriteLine("Fourth: " + (++value));
```

When you run the code, you'll get the following output:

```output
First: 2
Second: 2
Third: 3
Fourth: 4
```

Notice this line of code:

```csharp
Console.WriteLine("Second: " + value++);
```

There are two steps to this line:

1. Retrieve the current value of the variable `value` and use that in the string concatenation operation.
2. Increment the value.

The next line of code confirms that the value was, in fact, incremented:

```csharp
Console.WriteLine("Third: " + value);
```

In contrast, consider the last line of code:

```csharp
Console.WriteLine("Fourth: " + (++value));
```

Here, the order of operations is switched, because the `++` operator is placed before the operand `value`.

1. Increment the value.
2. Retrieve the new incremented value of the variable `value` and use that in the string concatenation operation.

While not strictly necessary, we added parenthesis around the expression `(++value)` to improve readability. Seeing so many `+` operators next to each other seems like it could be misunderstood by other developers. Stylistic decisions like this are subjective. However, since you'll write the code once but read it many times, you should prioritize readability.

## Recap

- Use compound assignment operators like `+=`, `-=`, `*=`, `++`, and `--` to perform a mathematical operation like increment or decrement, then assign the result into the original variable.
- Increment and decrement operators perform differently depending on whether the operator is before or after the operand.
