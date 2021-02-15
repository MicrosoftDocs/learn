In this lab, you'll write the JavaScript in each of the exercises below in TypeScript, strongly typing each of the variables.

### Exercise 1: Modify existing JavaScript code to have strongly typed variables

1. Clone the starting repository by entering the following at the command prompt. 

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-typescript/tree/main/code/module-02/m02-start
    cd <folder name>
    code .
    ```

1. Open the file **module02.ts** and locate **Exercise 1**.
1. Modify the code to add types to the variable declarations. The compiled JavaScript code should look the same as the original example when you're done.

    ```javascript
    /*  EXERCISE 1
        TODO: Modify the code to add types to the variable declarations. 
        The resulting JavaScript should look the same as the original example when you're done. */
    
    let firstName;
    let lastName;
    let fullName;
    let age;
    let ukCitizen;
    
    firstName = 'Rebecca';
    lastName = 'Smith';
    age = 42;
    ukCitizen = false;
    fullName = firstName + " " + firstName;
    
    if (ukCitizen) {
        console.log("My name is " + fullName + ", I'm " + age + ", and I'm a citizen of the United Kingdom.");
    } else {
        console.log("My name is " + fullName + ", I'm " + age + ", and I'm not a citizen of the United Kingdom.");
    }
    ```

### Exercise 2: Modify existing JavaScript code that ensures operational outcomes using strongly typed variables

1. Locate **Exercise 2** in **module02.ts**.
1. You can use types to ensure operation outcomes. Run the code as is and then modify it to have strongly typed variables.
1. Address any errors you find so that the result returned to a is `12`.

    ```javascript
    /* EXERCISE 2
       TODO: Run the code as is and then modify it to have strongly typed variables. 
       Then, address any errors you find so that the result returned to a is 12. */
   
    let x;
    let y;
    let a;
    
    x = 'five';
    y = 7;
    a = x + y;
    
    console.log(a);
    ```

### Exercise 3: Implement an enum type

1. Locate **Exercise 3** in **module02.ts**.
1. Implement an `enum` type called `Season` that represents the constants `"Fall"`, `"Winter`", `"Spring`", and `"Summer`".
1. Update the function so you can pass in the season by referencing an item in the `enum`, for example `Season.Fall`, instead of the literal string `"Fall"`.

    ```javascript
    /* EXERCISE 3
       TODO: In the following code, implement an enum type called Season that represents 
       the constants "Fall", "Winter", "Spring", and "Summer". Then, update the function so 
       you can pass in the season by referencing an item in the enum, for example 
       Season.Fall, instead of the literal string "Fall". */
    
    function whichMonths(season) {
        let monthsInSeason: string;
        switch (season) {
            case "Fall":
                monthsInSeason = "September to November";
                break;
            case "Winter":
                monthsInSeason = "December to February";
                break;
            case "Spring":
                monthsInSeason = "March to May";
                break;
            case "Summer":
                monthsInSeason = "June to August";
        }
        return monthsInSeason;
    }
    
    console.log(whichMonths("Fall"));
    ```

### Exercise 4: Declare an array type

1. Locate **Exercise 4** in **module02.ts**.
1. Declare the array as the type to match the type of the items in the array.

    ```javascript
    /* EXERCISE 4
       TODO: Declare the array as the type to match the type of the items in the array. */
    
    let randomNumbers;
    let nextNumber;
    for (let i = 0; i < 10; i++) {
        nextNumber = Math.floor(Math.random() * (100 - 1)) + 1;
        randomNumbers.push(nextNumber);
    }
    
    console.log(randomNumbers);
    ```

## Challenge yourself!

For an added challenge, take some existing JavaScript that you may have written or that you find on the web and rewrite it adding basic types using TypeScript. You can copy and paste the JavaScript into the Playground and edit it or use another editor like Visual Studio Code.

## Lab solution

Clone the ending repository by entering the following at the command prompt. 

```bash
git clone https://github.com/MicrosoftDocs/mslearn-typescript/tree/main/code/module-02/m02-end
cd <folder name>
code .
```

Open the file **module02.ts** to see the solution to this lab. See the **Lab setup** section above for more information about setting up your development environment to run the solution.
