Let's quickly go over the terms and syntaxes that we used in the *Hello World!* Program. The details about the concepts behind these terms are covered in this unit.

## Syntax break-down

To better understand what's going on, we'll go through the syntax of the program line by line. We'll be starting from the top row.
- `#include <iostream>` : *iostream* is part of a standard library. Many components we use in a program are defined by either standard libraries or libraries written by ourselves or a third party. We used ***iostream*** which is part of a ***standard library*** so that we can use the object ***cout*** to print something on the output screen.

   :::code language="cpp" source="../code/include.cpp" range="1" highlight="1":::

- `using namespace std;` : We want to use the functionalities of namespace through-out the code without calling it repeatedly whenever required. So, we declare it at the beginning of the code. **Namespaces** provide a method for preventing name conflicts in large projects. Additionally, when you are using `cout`, you have to write `std::cout` whenever you use it, but as we have added the `using namespace std;` line, we don't need to use std repetitively.

   :::code language="cpp" source="../code/include.cpp" range="1-2" highlight="2":::

- `int main()` : The *main()* is a global function, which is the designated start of a program. Every C++ program has a main() function mandatorily. A function is a set of statements that perform a task together. The *int mentioned before main() say that this function would expect an integer *return* type.

   :::code language="cpp" source="../code/include.cpp" highlight="3-6":::

- `cout` :`cout` is used to print a given string on the output screen. *std::cout* is a part of collection of data and operations of the *std::ostream* class.

   :::code language="cpp" source="../code/include.cpp" highlight="5":::

- `"Hello World"` : Here we see *Hello World* written inside "" (double quotes). We can use *std::string* in many ways, the main two ways are *C-string(character array)* and *string class*. So *char* is a part of primitive datatypes.

  We use different datatypes to express and store values like integer, float, double, char. Example: Integer - 123, float - 9.02, char - 'a'

- `\n`: We use *\n* to terminate the string and move to the next line. `\n` is called an **escape sequence**.

- `return 0` : When we declared the *int main()* function, we specified *int* to declare the function, which returns an integer. If the function has `int` preceding, it would expect an integer in return. So by writing *return 0* we make sure that an integer is returned to complete the function. Here *return* is the keyword and *0* is the integer.

   :::code language="cpp" source="../code/include.cpp" highlight="6":::