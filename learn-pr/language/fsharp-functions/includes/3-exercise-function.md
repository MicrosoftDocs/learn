In this exercise, you make your code reusable. It's code that another programmer on your team wrote, but your job is to turn it into functions.

## Create functions

Start by scaffolding a new F# project, and then take a piece of code and turn that into a function with parameters.

1. Create a new F# project by running `dotnet new`.

   ```bash
   dotnet new console --language F# -o Functions
   cd Functions
   ```

   Now that you have a new project, let's look at the code.

   Here's the code from your colleague.

   ```fsharp
   let no = card % 13
   if no = 1 then "Ace"
   elif no = 0 then "King"
   elif no = 12 then "Queen"
   elif no = 11 then "Jack"
   else string no
   ```

1. Replace the default code in the _Program.fs_ file with the following code:

   ```fsharp
   let cardFace card = 
      let no = card % 13
      if no = 1 then "Ace"
      elif no = 0 then "King"
      elif no = 12 then "Queen"
      elif no = 11 then "Jack"
      else string no
   ```

    The first line of this code `let cardFace card` makes it into a function. It's now a function called `cardface()` that takes the parameter `card`.

1. Add the following code below the `cardface()` function.

   ```fsharp
   printfn "%s" (cardFace 11)
   ```

1. Run the project by calling `dotnet run` in the console.

   ```bash
   dotnet run
   ```

   You now see the following output:

   ```output
   Jack
   ```

Congratulations! You've taken a piece of code that you wanted to make reusable and turned it into a function.

## Add types

You've turned your colleague's code into a function. To make this code more readable, you decide to add type definitions to it.

1. Modify your existing `cardface()` function  to look like so:

   ```fsharp
   let cardFace (card:int) = 
       let no = card % 13
       if no = 1 then "Ace"
       elif no = 0 then "King"
       elif no = 12 then "Queen"
       elif no = 11 then "Jack"
       else string no
   ```

1. Now run the project `dotnet run`.

   ```bash
   dotnet run
   ```

   You now see the following output:

   ```output
   Jack
   ```

   The code still works and you've made it clearer by adding a type to the input parameter.

1. Alter your `cardface()` function to look like so:

   ```fsharp
   let cardFace (card:int) :string = 
       let no = card % 13
       if no = 14 || no = 1 then "Ace"
       elif no = 13 then "King"
       elif no = 12 then "Queen"
       elif no = 11 then "Jack"
       else string no
   ```

   At this point, you've added a return type to the function `:string`, means the function returns a string.

1. Run the project `dotnet run`.

   ```bash
   dotnet run
   ```

   Once again, you should see the following output:

   ```output
   Jack
   ```

Congratulations! Your code now has types added to it.
