In this exercise, you'll become familiar with a C++ program and how to run it. You'll write a "Hello World!" program that prints this phrase as output. You'll also learn some basic C++ terminology and syntax.

To write code, you need a text editor and a compiler. To write this program, you'll use the g++ compiler. g++ is available for all major operating systems.

## Create a code file

You'll use the sandbox on your right to create a code file that you can build and run. The sandbox comes with a runtime for C++ and exposes the g++ compiler. The sandbox also has an editor that you can use to type your code in.

Later, you can use either the Visual Studio Code editor or the full Visual Studio IDE to build larger and more interesting code examples, and even entire applications.

1. In the terminal, run `code .` to open an editor.

2. In the sandbox editor that opens, write or paste in this code:

    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
        cout << "Hello World!\n";
        return 0;
    }
    ```

    We'll explain how and why the code works soon. But first, you should see it running, so you can be sure that you didn't enter it incorrectly.

3. Save the file as *hello.cpp*.

## Build your code

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

   You should now see *a.out* as one of the files as shown in the following output example. *a.out* is the file the g++ compiler created for you.

   ```output
   <user>@Azure:~$ ls
   a.out  clouddrive  hello.cpp
   ```

## Run your code

Next, you'll run the executable file the compiler created. You'll use a few lines of code to run the code file you created.

1. Run `ls -l` to list the permission levels on your files:

   ```bash
   ls -l
   ```

   Your output should look like this example:

   ```output
   -rwxr-xr-x  1 <user>  <group>  56120 18 Oct 13:21 a.out
   ```

   You have the permission `x`, which means that *a.out* is an executable program you can run.

   When you run g++ on a computer running Windows, the compiler produces an .exe file you can run.

2. Run the program:

   ```bash
   ./a.out
   ```

   You should see the output "Hello World!".

   ```output
   <user>@Azure:~$ code hello.cpp
   <user>@Azure:~$ g++ hello.cpp
   <user>@Azure:~$ ./a.out
   Hello World!
   <user>@Azure:~$
   ```

Congrats! You've built and run your first C++ program.

> [!NOTE]
> If your code shows an error, don't worry. A few common error scenarios are covered later in this module.

## Print a message

Part of your code prints a line of output after it runs.

1. Inside `main` in your code, add `//` at the start of the line of code you wrote. This syntax turns the line into a *code comment*, which the compiler ignores. Then, create these lines of code or paste in the following snippet:

    > [!TIP]
    > To edit the previous hello.cpp, type `code hello.cpp` in the terminal. After you are done editing the file, be sure and save your changes.

    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
        // cout << "Hello World!\n" << endl;
        cout << "Congratulations!";
        cout << " ";
        cout << "You wrote your first lines of code in C++.\n";
        return 0;
    }
    ```

1. Build and run the code again. This time, you should see the following output:

    ```output
    <user>@Azure:~$ code hello.cpp
    <user>@Azure:~$ g++ hello.cpp
    <user>@Azure:~$ ./a.out
    Congratulations! You wrote your first lines of code in C++.
    <user>@Azure:~$
    ```

> [!NOTE]
> You might have noticed that you didn't use `\n` in your code. The runtime environment doesn't know that it must move to the next line for the next `cout` statement. It runs all three strings in the same line, one after the other.
>
> Also, in a code comment, the `//` syntax instructs the compiler to ignore all the instructions on that line. Code comments are helpful when you're not ready to delete a line of code, but you want the compiler to ignore it for now. You also can use code comments to add messages to yourself to remind you of what the code does.
