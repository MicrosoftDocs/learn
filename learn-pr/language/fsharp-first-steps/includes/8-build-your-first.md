In this exercise, use the .NET SDK console template to create, build, and run an F# project that prints **Hello World** to the console.

## Create F# console application

1. Open the terminal.
1. In the terminal, enter the `dotnet new console` CLI command.

    ```dotnetcli
    dotnet new console -o HelloWorld -lang F#
    ```

After a few seconds, a directory called *HelloWorld* appears with the code for your F# application.

## Run your application

1. Navigate to your *HelloWorld* project directory.
1. In the terminal, enter the following command from inside your *HelloWorld* directory.

    ```dotnetcli
    dotnet run
    ```

    The console displays the following output:

    ```console
    Hello world from F#
    ```

Congratulations! You've built and run your first F# console application.
