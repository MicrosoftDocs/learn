In this lab, you will convert some JavaScript functions to TypeScript.

### Exercise 1: Convert a JavaScript function to a TypeScript with strongly typed parameters and return types

The following JavaScript code contains three functions:

- `BuildArray` builds an array of unique random numbers. It accepts an `items` parameter that determines the number of items in the array and a `sortOrder` parameter that determines whether the array is sorted in ascending or descending order.
- `sortDescending` and `sortAscending` are comparison functions that tell the `sort()` method how to sort numbers in ascending or descending order.

Convert the functions to TypeScript with strongly typed parameters and return types.

1. Clone the starting repository by entering the following at the command prompt. 

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-typescript/tree/main/code/module-04/m04-start
   cd <folder name>
   code .
   ```

1. Open the file **module04.ts**.
1. Locate `TODO: Update the BuildArray function`. 
1. In the `BuildArray` function, add types to parameter list, return value, and variables.

    ```typescript
    function buildArray(items: number, sortOrder: 'ascending' | 'descending'): number[] {
       let randomNumbers: number[] = [];
       let nextNumber: number;

       for (let counter = 0; counter < items; counter++) {
           nextNumber = Math.ceil(Math.random() * (100 - 1));
           if (randomNumbers.indexOf(nextNumber) === -1) {
             randomNumbers.push(nextNumber);
           } else {
             counter--;
           }
       }

       if (sortOrder === 'ascending') {
         return randomNumbers.sort(sortAscending);
       } else {
         return randomNumbers.sort(sortDescending);
       }
   }
   ```

1. Locate `TODO: Convert the sortDescending and sortAscending functions to anonymous functions`. 
1. Convert the `sortDescending` and `sortAscending` functions to anonymous functions and assign them to variables of the same name.

   ```typescript
   let sortDescending = (a, b) => {
      if (a > b) {
          return -1;;
      } else if (b > a) {
          return 1;;
      } else {
          return 0;
      }
   }

   let sortAscending = (a, b) => {
       if (a > b) {
         return 1;
       } else if (b > a) {
         return -1;
       } else {
         return 0;
       }
     }
   ```

1. Locate `TODO: Declare a new function type for the sortDescending and sortAscending functions`.
1. Declare a new function type for the `sortDescending` and `sortAscending` functions using either a type alias or an interface. 

   ```typescript
   type compareFunctionType = (a: number, b:number) => number;
   ```

1. In the variable declarations for `sortDescending` and `sortAscending`, apply the new function type as the variable type.

   ```typescript
   let sortDescending: compareFunctionType = (a, b) => {
      if (a > b) {
          return -1;;
      } else if (b > a) {
          return 1;;
      } else {
          return 0;
      }
   }

   let sortAscending: compareFunctionType = (a, b) => {
       if (a > b) {
         return 1;
       } else if (b > a) {
         return -1;
       } else {
         return 0;
       }
     }
   ```

1. Test your work by calling the `buildArray` function.

   ```typescript
   let myArray1 = buildArray(12, 'ascending');
   let myArray2 = buildArray(8, 'descending');
   console.log(myArray1);
   console.log(myArray2);
   ```

### Exercise 2: Convert a JavaScript function to a TypeScript using optional parameters

This JavaScript function returns the payment amount for a loan.

1. Locate `TODO: Update the LoanCalculator function`.
1. Convert the `loanCalculator` function to TypeScript with strongly typed parameters, variables, and return types.
1. Make the `months` parameter optional but assign it a default value of `12` months if omitted.

   ```typescript
   function loanCalculator (principle: number, interestRate: number, months = 12): string {
       let interest: number = interestRate / 1200;   // Calculates the monthly interest rate 
       let payment; Number;
       payment = principle * interest / (1 - (Math.pow(1/(1 + interest), months)));
       return payment.toFixed(2);
   }
   ```

1. Test your work by calling the `loanCalculator` function with only the required parameters.

   ```typescript
   let myLoan = loanCalculator(1000, 5);
   console.log(myLoan);
   ```

## Challenge yourself!

For an added challenge, take some existing JavaScript that you may have written or that you find on the web and rewrite it in TypeScript using what you've learned about functions. You can copy and paste the JavaScript into the Playground and edit it or use another editor like Visual Studio Code.

## Lab solution

Clone the ending repository by entering the following at the command prompt. 

```bash
git clone https://github.com/MicrosoftDocs/mslearn-typescript/tree/main/code/module-04/m04-end
cd <folder name>
code .
```

Open the file **module04.ts** to see the solution to this lab. See the **Lab setup** section above for more information about setting up your development environment to run the solution.
