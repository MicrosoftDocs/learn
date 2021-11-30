It's helpful to practice identifying errors, and then fixing the code. What happens when you misspell a function name or type an incorrect symbol?

## Create the code

Before you can identify the errors, create the code and have a look at it:

1. In the terminal, run `code .` to open an editor.

1. In the editor, enter or paste in this code:

    ```cpp
    #include (iostream);
    using namespace std;
    int main()
    {
      cout >> 'Hello World'
    }
    ```

1. Save the code file as *hello.cpp*, and then close the editor.

> [!NOTE]
> To check whether the file was created successfully, in the terminal, enter the `ls` command for a list of files.

## Identify the errors

The code you ran has errors in it. Some error messages appear as you compile the code. Each error is explained and resolved next.

1. Run `g++` and the file name to build your program:

    ```bash
    g++ hello.cpp
    ```

    Have a look at the errors and see how many errors you can identify.

    ```output
    hello.cpp:1:10: error: #include expects "FILENAME" or <FILENAME>
    #include (iostream);
              ^
    hello.cpp:5:13: warning: character constant too long for its type
        cout >> 'Hello World'
                ^~~~~~~~~~~~~
    hello.cpp: In function ‘int main()’:
    hello.cpp:5:5: error: ‘cout’ was not declared in this scope
        cout >> 'Hello World'
        ^~~~
    hello.cpp:5:5: note: ‘std::cout’ is defined in header ‘<iostream>’; did you forget to ‘#include <iostream>’?
    hello.cpp:1:1:
    +#include <iostream>
    #include (iostream);
    hello.cpp:5:5:
        cout >> 'Hello World'
        ^~~~
    ```

    > [!NOTE]
    > The output lists many errors. Sometimes, resolving a single error might resolve other errors. Other times, you might have to resolve all the errors that are listed in the output. In most scenarios, the errors are explicitly explained and easy to understand.

## Resolve the errors

You've compiled the code, which resulted in many errors. But don't worry. You can resolve each error and end up with working code.

### First error: Parentheses instead of angle brackets

1. Look at the code to identify the first error:

    ```output
    hello.cpp:1:10: error: #include expects "FILENAME" or <FILENAME>
      #include (iostream)
               ^
    ```

    Here, `<iostream>` is expected instead of `(iostream)`. Let's run the following code and recompile it.

1. Run `code hello.cpp` to edit the code again:  

    ```bash
    code hello.cpp
    ```

1. Edit the first line to address the first error. Replace the parentheses around `iostream` with angle brackets:

    ```cpp
    #include <iostream>;              //(iostream) is incorrect. <iostream> is correct.
    using namespace std;
    int main()
    {
      cout >> 'Hello World'
    }
    ```

### Second error: An extra semicolon

1. Run `g++ hello.cpp` to build your program:

   ```bash
   g++ hello.cpp
   ```

   You see this output, already with fewer errors, thanks to your first fix:

   ```output
   PS /home/<user>> g++ hello.cpp
   hello.cpp:1:20: warning: extra tokens at end of #include directive
   #include <iostream>;
                        ^
   hello.cpp:5:13: warning: character constant too long for its type
        cout >> 'Hello World'
                ^~~~~~~~~~~~~
   hello.cpp: In function ‘int main()’:
   hello.cpp:5:10: error: no match for ‘operator>>’ (operand types are ‘std::ostream’ {aka ‘std::basic_ostream<char>’} and ‘int’)
        cout >> 'Hello World'
        ~~~~~^~~~~~~~~~~~~~~~
    ...
    ...
    ...
    ...
    ...
    ```

   > [!NOTE]
   > Despite the number of errors that were returned, resolve one error at a time, beginning at the top.

   Let's focus on the error that comes first in the recent execution.

   ```output
   hello.cpp:1:20: warning: extra tokens at end of #include directive
   #include <iostream>;
                       ^
   ```

   A semicolon (`;`) is added at the end of the filename/library *iostream*. You can't add a semicolon after an `#include` directive. Use a semicolon only at the end of a statement. 
  
1. Remove the semicolon from the end of `#include <iostream>` and see what happens.

   To edit the code again, run `code hello.cpp`:

    ```bash
    code hello.cpp
    ```

    Next, edit the code to make the correction, and then save it.

    ```cpp
    #include <iostream>              // Removed the semicolon.
    using namespace std;
    int main()
    {
      cout >> 'Hello World'
    }
    ```

### Third error: The wrong quote type for a string literal

1. Run `g++ hello.cpp` to build your program.

   You should see the following output from the compilation:

   ```output
   PS /home/<user>> g++ hello.cpp
   hello.cpp:5:13: warning: character constant too long for its type
       cout >> 'Hello World'
               ^~~~~~~~~~~~~
   hello.cpp: In function ‘int main()’:
   hello.cpp:5:10: error: no match for ‘operator>>’ (operand types are ‘std::ostream’ {aka ‘std::basic_ostream<char>’} and ‘int’)
       cout >> 'Hello World'
          ~~~~~^~~~~~~~~~~~~~~~
   ...
   ...
   ...
   ...
   ...
   ```

   Look at the first error in the output:

   ```output
   hello.cpp:5:13: warning: character constant too long for its type
       cout >> 'Hello World'
               ^~~~~~~~~~~~~
   ```

   The code uses single quotes instead of double quotes. Use single quotes only for a single character. For a string literal (character array), use double quotes.

1. Replace the single quotes with double quotes. Ensure that your program looks like this code:

    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
      cout >> "Hello World"     //Use double quotes instead of single quotes.
    }
    ```

### Fourth error: Wrong stream operator

1. Run `g++ hello.cpp` to build your program.

   Here's what the output looks like. The error output is less as you resolve issues. Next, resolve the remaining issues.

   ```output
   PS /home/<user>> g++ hello.cpp
   hello.cpp: In function ‘int main()’:
   hello.cpp:5:10: error: no match for ‘operator>>’ (operand types are ‘std::ostream’ {aka ‘std::basic_ostream<char>’} and ‘const char [12]’)
       cout >> "Hello World"
       ~~~~~^~~~~~~~~~~~~~~~
   In file included from /usr/include/c++/8/string:53,
                   from /usr/include/c++/8/bits/locale_classes.h:40,
                   from /usr/include/c++/8/bits/ios_base.h:41,
                   from /usr/include/c++/8/ios:42,
                   from /usr/include/c++/8/ostream:38,
                   from /usr/include/c++/8/iostream:39,
                   from hello.cpp:1:
   ...
   ...
   ...
   ...
   ...
   ```

1. In the preceding output, you can see an operator issue. Replace the `>>` operator with the `<<` operator.

   ```cpp
   #include <iostream>
   using namespace std;
   int main()
   {
     cout << "Hello World"     //Replacing the >> operator with the << operator.
   }
   ```

   > [!NOTE]
   > Use `<<` for the `cout` object.
   >
   > Use `>>` for the `cin` object. The `cin` object is discussed in more detail in another module.  

### Fifth error: Missing semicolon

1. Run `g++ hello.cpp` to build your program:

   ```bash
   g++ hello.cpp
   ```

   Here's the output. You're almost there. There are just a few errors left to fix.

   ```output
   PS /home/<user>> g++ hello.cpp
   hello.cpp: In function ‘int main()’:
   hello.cpp:5:34: error: expected ‘;’ before ‘}’ token
       cout << "Hello World"
                            ^
                            ;
   }
   ~
   ```

   A semicolon is required at the end of the statement.

1. Edit your code so that it looks like this code:

   ```cpp
   #include <iostream>
    using namespace std;
    int main()
    {
      cout << "Hello World";     //Added a missing semicolon
    }
   ```

### Are we done?

1. Run `g++ hello.cpp` to build your program:

   ```bash
    g++ hello.cpp
    ```

    If you type `ls` in your terminal, you should now see *a.out* as one of your files. *a.out* is the file the g++ compiler created for you.

1. In the terminal, run the `a.out` file:

   ```bash
    ./a.out
   ```
  
   And finally, you have the output you want to see:
  
   ```output
     PS /home/<user>> ./a.out
     Hello World
   ```
  
   Your code has no more errors. You've debugged the code step by step and resolved all issues.

> [!NOTE]
> The code doesn't include `return 0` at the end, but no error was thrown. The reason is that the runtime assumes an implicit return type as integer for `main`. The return type primarily is used as an exit status. Here, returning 0 or returning nothing automatically makes the runtime assume that the code exited successfully.
