In this exercise, you'll be made familiar with a C++ program and how to run it. You'll be writing a program "Hello World", which will print this phrase on the output screen. You'll also be learning a few basic terminologies and syntaxes from this exercise.

## Write your first code

To write code, you'll need some kind of text editor and a compiler. In this case, you'll use the compiler g++. g++ exist for all major operating systems.

### Step 1: Enter the code into the Editor

You'll use the Sandbox on your right to enter code. The Sandbox comes with a runtime for C++ and exposes a compiler g++. The sandbox also has an editor that you can use to type your code in.

Later, you'll graduate to use either Visual Studio Code editor, or the full Visual Studio IDE to build larger and more interesting code examples--even entire applications.

1. Run `code .` in the terminal, it will bring up an editor.

2. Enter this code into the Editor on the right:

    ```cpp
    #include <iostream>
    using namespace std;
    int main()
    {
        cout << "Hello World\n";
        return 0;
    }
    ```

    We'll explain how and why it works soon. But first, you should see it running, and ensure you didn't enter it incorrectly. To do that, you'll run your code.

3. Save the file as *hello.cpp*.

### Step 2: Build your code

To build your code, you'll use g++. Building your code will produce an executable, a program, that you can run.

> [!NOTE]
> A compiler converts your source code written in a language into another language. Here the compiler is converting the source code in C++ to machine code that is understandable to the computer by creating an executable program.

1. Run `g++` to build your program:

    ```bash
    g++ hello.cpp
    ```

2. Run `ls`, it will show you your files:

   ```bash
   ls
   ```

   You should now see *a.out*, as one of the files. That's the file the g++ compiler created for you like this:

   ```output
   PS /home/user> ls
   a.out  clouddrive  hello.cpp
   ```

### Step 3: Run your code

1. Run `ls -l`, it will list the permission levels on your files.

   ```bash
   ls -l
   ```

   You should see an output that looks like so:

   ```output
   -rwxr-xr-x  1 <user>  <group>  56120 18 Oct 13:21 a.out
   ```

   Note how you have the permission 'x', meaning *a.out* is a program, that you can run.

   > [!NOTE]
   > When you run g++ on a Windows machine, it produces a .exe file that you can run.

2. Run the program:

   ```bash
   ./a.out
   ```

   You should see "Hello World".

Congrats you've built and ran your first C++ program.

> [!NOTE]
> If you see any error, there are a few scenarios covered later in the unit.

### Step 4: Print a new message

Prefix the line of code you wrote inside main with `//`. This turns the line into a "comment", which is ignored by the compiler. Then add new lines of code to match the following snippet:

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
> You might have noticed that we did not use *\n* in these lines. As we can see, that while we have not used *\n*, the runtime environment did not know that it has to move to the next line for the next *cout* statement and it just continues all three strings one after the other in the same line. You create a code comment by prefixing a line of code with a two forward slashes `//`. A `//` instructs the compiler to ignore all the instructions on that line. Code comments are helpful when you're not ready to delete the code yet, but you want to ignore it for now.  You can also use code comments to add messages to yourself that reminds you what the code is doing. We'll talk about code comments in an upcoming module.