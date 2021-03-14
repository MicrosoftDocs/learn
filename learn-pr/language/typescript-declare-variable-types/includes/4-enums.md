Let's explore the different data types TypeScript makes available, and the impact they have on our code.

## The enum type

A helpful addition to the standard set of datatypes from JavaScript is the enumeration type, or `enum`.

Enumerations offer an easy way to work with sets of related constants. An `enum`, is a symbolic name for a set of values. Enumerations are treated as data types, and you can use them to create sets of constants for use with variables and properties.

Whenever a procedure accepts a limited set of variables, consider using an enumeration. Enumerations make for clearer and more readable code, particularly when meaningful names are used.

Using enumerations:

- Helps reduce errors caused by transposing or mistyping numbers.
- Makes it easy to change values in the future.
- Makes code easier to read, which means it is less likely that errors will creep into it.
- Ensures forward compatibility. With enumerations, your code is less likely to fail if in the future someone changes the values corresponding to the member names.

## Creating an enum

Enums allow you to specify a list of available options. They're extremely useful when you have a set of values a particular variable type may take. Let's imagine you have field in a external database called **ContractStatus**, which contains numbers 1, 2, or 3, that represent the following contact statuses: **Permanent**, **Temp**, and **Apprentice**. We will create an enum with these values, and explore the TypeScript support.

1. Open the [Playground](https://www.typescriptlang.org/play?azure-portal=true) and remove any existing code
1. Create an `enum` to represent our scenario by entering the following:

    ```typescript
    enum ContractStatus {
         Permanent,
         Temp,
         Apprentice
    }
    ```

1. Now, declare a variable for a new employee named `employeeStatus` of the type `ContractStatus` and assign `"Temp"`. Display the result to the console.

    ```typescript
    let employeeStatus: ContractStatus = ContractStatus.Temp;
    console.log(employeeStatus);
    ```

1. Select **Run**. Note the value displayed in the **Log** window. What value is returned?
1. By default, `enum` values begin with a value of 0, so `Permanent` is 0, `Temp` is 1, and `Apprentice` is 2. If you want the values to start with a different value, in this case 1, specify that in the `enum` declaration. Make the following edits to have the `enum` start the values at 1.

    ```typescript
    enum ContractStatus {
         Permanent = 1,
         Temp,
         Apprentice
    }
    ```

1. Rerun the code by selecting **Run**. Notice the value displayed is now **2**.
1. To display the name associated with the enum, we can use the indexer provided. Add the following to the bottom of your code:

    ```typescript
    console.log(ContractStatus[employeeStatus]);
    ```

1. Run the code. Notice the value **Temp** is displayed, which is the name of the enum for **Temp** or **2**.
