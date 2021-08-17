In this exercise, you will make code reusable, code that another programmer in your team wrote, but it's your job to turn it into functions.

## Create functions

You'll start by scaffolding a new F# project, then you'll take a piece of code and turn that into a function with parameters.

1. Create a new F# project by running `dotnet new`:

    ```bash
    dotnet new console --language F# -o Functions
    cd Functions
    ```

    Now you have a new project. Let's add have a look at the code next:

    Here's the code from your colleague:

    ```fsharp
    let no = card % 13
    if no = 14 || no = 1 then "Ace"
    elif no = 13 then "King"
    elif no = 12 then "Queen"
    elif no = 11 then "Jack"
    else string no
    ```

1. Above the `main()` method, place the following code:

    ```fsharp
    let cardFace card = 
       let no = card % 13
       if no = 14 || no = 1 then "Ace"
       elif no = 13 then "King"
       elif no = 12 then "Queen"
       elif no = 11 then "Jack"
       else string no
    ```

    The top part of this code `let cardFace card` makes it into a function. It's now a function called `cardFace` that takes parameter `card`.

1. Add the following code to the `main()` method:

    ```fsharp
    printfn "%s" (cardFace 11)
    ```

1. Run the project calling `dotnet run` in the console

   ```bash
   dotnet run
   ```

   You now see the output:

   ```output
   Jack
   ```

Congratulations! You've managed to take a piece of you want to make reusable and turn that into a function.

## Add types

You've turned your colleague's code into a function. To make this code extra readable, you decide to add type definitions to it.

1. Modify your existing function `cardFace()` to look like so:

   ```fsharp
   let cardFace (card:int) = 
       let no = card % 13
       if no = 14 || no = 1 then "Ace"
       elif no = 13 then "King"
       elif no = 12 then "Queen"
       elif no = 11 then "Jack"
       else string no
   ```

1. Now run the project `dotnet run`:

   ```bash
   dotnet run
   ```

   You get a long error message back that starts with text "error FS0001: The 'if' expression needs to have type 'int' to satisfy context type requirements. It currently has type 'string'".

   > [!TIP]
   > Stop here for second and think what you need to do, to make the code work.

1. Alter your `cardFace()` function to look like so:

   ```fsharp
   let cardFace (card:int) :string = 
       let no = card % 13
       if no = 14 || no = 1 then "Ace"
       elif no = 13 then "King"
       elif no = 12 then "Queen"
       elif no = 11 then "Jack"
       else string no
   ```

1. Run the project `dotnet run`

   ```bash
   dotnet run
   ```

   This time, you should see the following output:

   ```output
   Jack
   ```

   No more error message because you've added a return type to your function as well. Looking at the function header you now see this code `let cardFace (card:int) :string`, the input parameter is of type `int` and it returns `string`.

Congratulation! Your code has now types added to it.  
