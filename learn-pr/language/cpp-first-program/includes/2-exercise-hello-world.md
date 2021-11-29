In this exercise, you'll become familiar with a C++ program and how to run it. You'll write a "Hello World" program, which will print this phrase as output. You'll also learn a few basic terminologies and syntaxes from this exercise.

## Write your first code

To write code, you need a text editor and a compiler. In this case, you'll use the compiler g++. g++ is available for all major operating systems.

### Enter code in the editor

You'll use the sandbox on your right to enter code. The sandbox comes with a runtime for C++ and exposes the g++ compiler. The sandbox also has an editor that you can use to type your code in.

Later, you'll use either the Visual Studio Code editor or the full Visual Studio IDE to build larger and more interesting code examples, and even entire applications.

1. In the terminal, run `code .` to bring up an editor.

2. In the editor that opens on the right, enter this code:

    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
        cout << "Hello World\n";
        return 0;
    }
    ```

    We'll explain how and why the code works soon. But first, you should see it running, so you can be sure that you didn't enter it incorrectly.

3. Save the file as *hello.cpp*.

### Build your code

To build your code, you'll use g++. Building your code produces an executable, which is a program that you can run.

> [!NOTE]
> A compiler converts source code that's written in one language into another language. Here, the compiler converts your C++ source code to machine code. The computer understands machine code, and it creates an executable program.

1. Run `g++` to build your program:

    ```bash
    g++ hello.cpp
    ```

2. Run `ls` to list your files:

   ```bash
   ls
   ```

   You should now see *a.out* as one of the files as shown in the following output example. That's the file the g++ compiler created for you.

   ```output
   PS /home/user> ls
   a.out  clouddrive  hello.cpp
   ```

### Run your code

1. Run `ls -l` to list the permission levels on your files:

   ```bash
   ls -l
   ```

   Your output should look like this example:

   ```output
   -rwxr-xr-x  1 <user>  <group>  56120 18 Oct 13:21 a.out
   ```

   You have the permission 'x', which means that *a.out* is an executable program you can run. When you run g++ on a computer running Windows, it produces an .exe file you can run.

2. Run the program:

   ```bash
   ./a.out
   ```

   You should see the output "Hello World".

Congrats! You've built and run your first C++ program.

> [!NOTE]
> If your code shows an error, don't worry. A few common error scenarios are covered later in this module.

### Print a new message

Inside `main` in your code, add `//` at the start of the line of code you wrote. This syntax turns the line into a *code comment*, which the compiler ignores. Then, add new lines of code to match the following snippet:

```cpp
#include <iostream>
using namespace std;
int main()
{
    // cout << "Hello World\n" << endl;
    cout << "Congratulations!";
    cout << " ";
    cout << "You wrote your first lines of code in C++!";
    return 0;
}
```

Run the code again.  This time, you should see the following output.

```output
Congratulations! You wrote your first lines of code in C++!
```

> [!NOTE]
> You might have noticed that you didn't use `\n` in your code. The runtime environment doesn't know that it must move to the next line for the next `cout` statement. It runs all three strings in the same line, one after the other.
>
> Also, in a code comment, the `//` syntax instructs the compiler to ignore all the instructions on that line. Code comments are helpful when you're not ready to delete a line of code, but you want the compiler to ignore it for now. You also can use code comments to add messages to yourself to remind you of what the code does.
