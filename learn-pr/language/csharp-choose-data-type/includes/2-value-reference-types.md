With so many different data types available in C#, choosing the right one to use means that you'll need to understand what each one does and when you might choose one data type over another.

But before we can discuss *why* you might choose one type over another, first you need to understand how data and data types work in C# and .NET, and learn about more data types, including key differentiations between similar data types.

## What's data?

Answering the question "what's data" depends on who you ask and the context in which context you're asking.  

In software development, data is essentially a value that is stored in the computer's memory as a series of bits. A **bit** is a simple binary switch represented as a `0` or `1`; or rather, "off" and "on", respectively. A single bit doesn't seem useful. However, when you combine eight bits together in a sequence, they form a **byte**. When used in a byte, each bit takes on a meaning in the sequence. In fact, you can represent 256 different combinations with just 8 bits if you use a binary (or rather, base-2) numeral system.

For example, in a binary numeral system, you can represent the number `195` as `11000011`. The following table will help you visualize how this works. The first row has eight columns that correspond to a position in a byte. Each position represents a different numeric value. The second row can store the value of an individual bit, either `0` or `1`.

| 128 | 64 | 32 | 16 | 8 | 4 | 2 | 1 |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 1 | 1 | 0 | 0 | 0 | 0 | 1 | 1 |

If you add up the number from each column in the first row that corresponds to a `1` in the second row, you'll get the decimal equivalent to the binary numeral system representation. In this case, it would be `128 + 64 + 2 + 1 = 195`.

To work with larger values beyond `255`, the computer would need to store more bytes. If you're working with millions of large numbers in a scientific setting, you may need to consider more carefully which data types you're using. Your code could require much more memory to run.

### What about textual data?

If a computer only understands `0`s and `1`s, then how does it allow us to work with text? Using a system like ASCII, you can use a single byte to represent upper and lowercase letters, numbers, tabs, backspaces, newlines, and many mathematical symbols, blocks, lines, and so on.

For example, if you wanted to store a lower-case letter `a` as a value in your application, the computer would only understand the binary form of that value. If you wanted to better understand how it's handled by the computer, you'd first need to locate an ASCII table that provides a lookup of ASCII values and their decimal equivalents. You can search for the terms "ASCII lookup decimal" to locate such a resource online.

In this case, the lower-case letter `a` is equivalent to the decimal value `97`. Then, you'd use the same binary numeral system in reverse to find how an ASCII letter `a` is stored by the computer.

| 128 | 64 | 32 | 16 | 8 | 4 | 2 | 1 |
|-----|-----|-----|-----|-----|-----|-----|-----|
| 0 | 1 | 1 | 0 | 0 | 0 | 0 | 1 |

Or rather, `64 + 32 + 1 = 97`.

It's likely that you'll never need to perform these types of conversions on your own, but understanding the computer's perspective of data is a foundational concept, especially as we're considering data types.

## What's a data type?

A data type is a programming language construct that defines how much memory to reserve for a value. That's why we have so many data types, because the designers of the programming language understand that it will be used for many different applications and sizes of data.

Given the type of applications you'll build in your career, you'll come to realize that you settle on a small subset of all the available data types. However, it's still vital to know others exist and why.

## Value vs. reference types

There are two basic categories of data types: *value types* and *reference types*. The fundamental difference between value and reference types concerns where those values are temporarily stored in memory as your application executes. Where the value is stored affects how the .NET runtime manages the life of the value, including its declaration (birth), assignment and retrieval (life), and finalization (death). This, in turn, impacts the syntax you use when working with either a value type or a reference type.

This module will focus on simple value and reference types. As you learn more about C#, new details will emerge related to the fundamental difference between value and reference types.

### Simple value types

Simple value types are a set of predefined types provided by C# as keywords. These keywords are merely aliases for predefined types defined in the .NET Class Library. For example, the C# keyword `int` is an alias of a value type defined in the .NET Class Library as `System.Int32`.

Simple value types include many of the data types that you may have used already, like `char` and `bool`. There are also many **integral** and **floating-point** value types to represent a wide range of whole and fractional numbers.

> [!NOTE]
> Besides simple value types, other value types include enums and structs. However, we'll cover those in other modules.

## Recap

- Values are stored as bits, which are simple on/off switches. Combining enough of these switches allows you to store just about any possible value.
- There are two basic categories of data types: value and reference types. The difference is in how and where the computer stores the values as your program executes.
- Simple value types include signed and unsigned integral numeric types and floating-point numeric types.
