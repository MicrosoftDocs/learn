Recognizing errors and knowing how to fix them is crucial to make you an efficient developer. In this unit, you'll be made familiar with some common mistakes, and what error codes they produce.

Here's some common errors you're likely to make as you're starting out to learn C++.

- **Wrong uppercase**. Casing matters, with the wrong case, the compiler won't recognize what commands you are after.

- **Wrong operator**. For example when you deal with stream to output or reading information, it's important to use the correct operator.

- **Quotes**. String literals need a double quote, and a single character needs a single quote, it's easy to mix them up.

- **Missing semicolon**. All statements need to end with a semicolon, ";"

## Wrong uppercase 

Entering upper-case letters like capitalizing *c* in *cout*, or the letter *r* in return. It's easy to think that casing doesn't matter, but it does. For example, typing `Cout` instead of `cout`, or `Return` instead of `return`, like the below code, would lead to a compilation error:

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