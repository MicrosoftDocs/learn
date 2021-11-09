In this module, we'll be covering about fixing the code. What happens when you've mis-spelled something or you've typed an incorrect symbol?

## Create the code

Before we can identify the errors, let's create a code and have a look at it.

1. Run `code .` in the terminal, it will bring up an editor.

2. Enter this code into the Editor on the right:

    ```cpp
    #include (iostream);
    using namespace std;
    int main()
    {
      cout >> 'Hello World'
    }
    ```

3. Save the code as hello.cpp, enter the file name as hello.cpp, and close the editor.

> [!Note]
> To check if the file was created successfully, put the `ls` command in the terminal and you can see your hello.cpp file there.

## Identify the errors

The code you've written has errors in it. You'll see some error messages as you compile the code. Each error will be addressed below.

1. Run `g++` command to build your program:

    ```bash
    g++ hello.cpp
    ```

    Let's have a look at the errors below and see how many errors you can identify.

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
    > Your output screen will be loaded with many errors. There will be times when maybe solving a single error might automatically solve other errors, but there might be times when you have to solve all the errors that are mentioned in the output screen.
    In most scenarios, the errors are explicitly explained and easy to understand.

## Solving the errors step by step

You've compiled the code, which resulted in many errors. Don't worry, we'll now address each of the errors and you'll end up with working code.

1. Let's take the first error:

    ```output
    hello.cpp:1:10: error: #include expects "FILENAME" or <FILENAME>
      #include (iostream)
               ^
    ```

    Here `<include>` is expected instead of (include). Let's run the following code and recompile it.

2. Run `code hello.cpp`, to edit the code again:  

    ```bash
    code hello.cpp
    ```

3. Edit the first top line to address the first error. Remove the parenthesis () around `iostream`:

    ```cpp
    #include <iostream>;              //(iostream) is incorrect. <iostream> is correct
    using namespace std;
    int main()
    {
      cout >> 'Hello World'
    }
    ```

4. Run `g++ hello.cpp` command to build your program.

   ```bash
   g++ hello.cpp
    This is the output you get (you already see less errors in the error output thanks to your fix):
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
    > [!Note]
    > You might have received a huge plethora of errors. But we will focus only on the one which is at the top and ignore the rest for now. One error at a time.
   Let's focus on the error that comes first in the recent execution.
    ```output
    hello.cpp:1:20: warning: extra tokens at end of #include directive
    #include <iostream>;
                       ^
    ```
    Here we can see a 'semicolon', ';' is added at the end of the filename/library *iostream*. We don't add semicolons after `#include` directives.  
  
5. Remove the semicolon from `#include <iostream>;`  and see what happens.
   To edit the code again. Run `code hello.cpp`
    ```bash
    code hello.cpp
    ```
    Now edit the code and do the correction and save it.
    ```cpp
    #include <iostream>              // We have removed the semicolon here
    using namespace std;
    int main()
    {
      cout >> 'Hello World'
    }
    ```
6. Run `g++ hello.cpp` command to build your program.
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
   Let's look at the first error in the above output and rectify it.
    ```output
    hello.cpp:5:13: warning: character constant too long for its type
        cout >> 'Hello World'
                ^~~~~~~~~~~~~
    ```
    You can see that we have used single quotation instead of double quotation symbol. We use single quotation only when we have a single character. For a string literal(character array), we use double quotation.
7. Replace the single quotation with double quotation. Ensure your program looks like the below code:
    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
      cout >> "Hello World"     //Double quotes instead of single quotes
    }
    ```
8. Run `g++ hello.cpp` command to build your program.
    Here's what the output looks like, see how the error output is less and less. We do have some issues left, so lets work on those next issues.
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
   In the above output we can see that there's an operator issue, so we have to replace it with the correct operator. Replace `>>` with the `<<` operator.
    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
      cout << "Hello World"     //replacing >> operators with the << operator
    }
    ```
    > [!NOTE]
    > We use `<<` for `cout` object  
    > We use `>>` for `cin` object, which we will learn later  
9. Run `g++ hello.cpp` command to build your program.

   ```bash
   g++ hello.cpp
    Here's the output, you're almost there, just a few errors left:
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

   A semicolon is expected at the end of the statement to complete it.

10. Edit the code to make it look like this:

   ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
      cout << "Hello World";     //Added a missing semi-colon
    }
    ```

1. Run `g++ hello.cpp` command to build your program.

   ```bash
    g++ hello.cpp
    ```

Congratulations! You've solved all the errors and you can continue further to execute your file.

You should now see *a.out*, as one of the files if you type `ls` in your terminal. That's the file the g++ compiler created for you.

12. Run the `a.out` file in the terminal.

   ```bash
    ./a.out
   ```
  
  And finally you have the desired output.
  
  ```output
    PS /home/<user>> ./a.out
    Hello World
  ```
  
  As you can see, there are no more errors in the code. We've debugged the code step by step and solved the issues, which eliminated all the errors.

> [!NOTE]
> Increase in the number of errors doesn't mean that your problems have increased. It might be possible that some other syntax is the cause of those errors and a small correction will eliminate those errors.  

> [!NOTE]
> You might have observed that we did not type the `return 0` at the end of the code, and still no error was thrown. The reason is that run-time assumes an implicit return type as integer for main. The return type is mainly used as an Exit status. Here returning 0 or returning nothing automatically makes the run-time assume that the code exited successfully.