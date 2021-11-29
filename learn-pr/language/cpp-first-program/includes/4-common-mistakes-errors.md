To be an efficient developer, it's crucial that you recognize programming errors and know how to fix them. In this unit, you become familiar with some common mistakes and the error codes they produce.

Here's a summery of common errors you're likely to encounter as you begin to learn C++:

- **Wrong uppercase**. C++ is case-sensitive, and casing matters. If you use the wrong case in your code, the compiler won't recognize the command you're trying to use.

- **Wrong stream operator**. It's important to use the correct operator. Examples are when you identify the stream to output or when reading information.

- **Quotes**. String literals require double quotes. A single character requires a single quote. It's easy to mix them up.

- **Missing semicolon**. All statements must end with a semicolon (`;`).

## Wrong uppercase

Entering uppercase letters, like capitalizing *c* in *cout*, or the letter *r* in return. It's easy to think that casing doesn't matter, but it does. For example, typing `Cout` instead of `cout` or `Return` instead of `return`, like in the following code, ends in a compilation error:

```cpp
Return 0;  // incorrect
return 0; // correct 
```

## Wrong stream operator

Stream operators are using to direct the stream in one of two directions, reading from the stream `>>` or writing to it `<<`.  It's common to mistake what stream operator to use when, like, for example,  entering `a >>` instead of `a << in cout`.

```cpp
cout >> "a string"; // incorrect
cout << "a string"; // correct
```

## Wrong quote type

It is important to remember what quotes to use. For example, single characters use single quote, `` and string literals use double quote, "". Sometimes it is easy to forget to use  double-quotation marks, or using single-quotation to surround the phrase Hello World.

```cpp
cout << 'a string'; // incorrect
cout << "a string"; // correct 
```

> [!NOTE]
> Single quotes is used to represent on character, for example 'H', in "Hello world". Whereas, double quotes "" represent many characters forming a word "Hello" for example.

## Missing semi-colon

Semi-colon is used to mark the end of statement. Were you to forget it, the compiler thinks statement continues on. Forgetting the semicolon most often leads to a compilation error.

```cpp
cout << "a string" // incorrect, missing ;
cout << 'a string'; // incorrect
```
