Let's briefly go over the terms and syntax you used in the *Hello World!* program. Breaking down the syntax can give you insight into the concepts behind the language and its structure.

## Break down the syntax

To better understand what's going on, let's go through the syntax of the program line by line, starting at the top row:

- `#include <iostream>`: `iostream` is part of a standard library. Many components in a program are defined either by standard libraries or by libraries that you or a third party writes. The code uses `iostream`, which is part of a standard library, to use the object `cout` to print something as output.

   :::code language="cpp" source="../code/include.cpp" range="1" highlight="1":::

- `using namespace std;`: You want to use the functionalities of namespace throughout the code without calling it repeatedly when it's required. So, you can declare it at the beginning of the code. *Namespaces* provide a method for preventing name conflicts in large projects. Also, when you're using `cout`, you have to write `std::cout` when you use it. But by adding the `using namespace std;` line, you don't need to use `std` repetitively.

   :::code language="cpp" source="../code/include.cpp" range="1-2" highlight="2":::

- `int main()`: `main()` is a global function and the designated start of a program. Every C++ program has a mandatory `main()` function. A function is a set of statements that perform a task together. The `int` mentioned before `main()` says that this function would expect an integer *return* type.

   :::code language="cpp" source="../code/include.cpp" highlight="3-6":::

- `cout`: `cout` prints a specific string as output. `std::cout` is part of a collection of data and operations of the `std::ostream` class.

   :::code language="cpp" source="../code/include.cpp" highlight="5":::

- `"Hello World"`: The output *Hello World* is written in double quotes (`""`). You can use `std::string` in many ways. The main two ways to use `std::string` are as *C-string(character array)* and *string class*. So, *char* is a part of primitive data types.

  We use different data types to express and store values, like integer, float, double, and char. For example, an integer might be `123`, a float might be `9.02`, and a char might be `'a'`.

- `\n`: Use `\n` to terminate the string and move to the next line. `\n` is called an *escape sequence*.

- `return 0`: When you declare the `int main()` function, you specify `int` to declare the function, which returns an integer. If the function is preceded by `int`, it would expect an integer in return. By writing `return 0`, you make sure that an integer is returned to complete the function. Here, `return` is the keyword and `0` is the integer.

   :::code language="cpp" source="../code/include.cpp" highlight="6":::
