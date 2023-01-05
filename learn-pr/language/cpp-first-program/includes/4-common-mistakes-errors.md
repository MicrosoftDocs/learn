To be an efficient developer, it's crucial that you recognize programming errors and know how to fix them. In this unit, you become familiar with some common mistakes and the error codes they produce.

Here's a summary of common errors you're likely to encounter as you begin to learn C++:

- **Wrong uppercase**. C++ is case-sensitive, and casing matters. If you use the wrong case in your code, the compiler won't recognize the command you're trying to use.

- **Wrong stream operator**. It's important to use the correct operator. Examples are when you identify the stream to output or when reading information.

- **Wrong quote type**. A single character requires single quotes. String literals and words of more than one character require double quotes.

- **Missing semicolon**. All statements must end with a semicolon (`;`).

## Wrong uppercase

Uppercase letters, like capitalizing `c` in `cout` or `r` in `return`, causes an error. Using incorrect casing results in a compilation error.

```cpp
Return 0;  // incorrect
return 0; // correct 
```

## Wrong stream operator

Use stream operators to direct the stream in one of two directions, either reading from the stream (`>>`) or writing to the stream (`<<`). A common mistake is using the wrong stream operator, for example, using `a >>` instead of `a <<` in `cout`.

```cpp
cout >> "a string"; // incorrect
cout << "a string"; // correct
```

## Wrong quote type

It's important to remember whether to use single quotes or double quotes. Use single quotes (`''`) to represent a single character, for example, `'H'` in `"Hello World"`. Use double quotes (`""`) to represent more than one character used to form a word or string, for example, `"Hello"` or `"Hello World"`.

```cpp
cout << 'a string'; // incorrect
cout << "a string"; // correct 
```

## Missing semicolon

Use a semicolon to mark the end of a statement. If you forget to use a semicolon, the compiler thinks the statement continues. The result usually is a compilation error.

```cpp
cout << "a string" // incorrect
cout << 'a string'; // incorrect
cout << "a string"; // correct
```
