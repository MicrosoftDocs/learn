In this lab, you'll apply what you've learned about classes to convert a TypeScript function to a class.

## Exercise 1: Convert three TypeScript functions to a class definition

The following TypeScript code contains three functions:

- `buildArray` builds an array of unique random numbers. It accepts an `items` parameter that determines the number of items in the array and a `sortOrder` parameter that determines whether the array is sorted in ascending or descending order.
- `sortDecending` and `sortAscending` are comparison functions that tell the `sort()` method how to sort numbers in ascending or descending order.

Convert the functions to a TypeScript class.

1. Clone the starting repository by entering the following at the command prompt. 

   ```bash
   git clone https://github.com/MicrosoftDocs/mslearn-typescript/tree/main/code/code/module-05/m05-start
   cd <folder name>
   code .
   ```

1. Open the file **module05.ts**. This file contains an empty class named `BuildArray` and the `buildArray`, `sortDecending`, and `sortAscending` functions.
1. Locate `TODO Define the properties`. 
1. Define the properties in the class: `_items` and `_sortOrder`.

    ```typescript
    // TODO Define the properties
    private _items: number;
    private _sortOrder: 'ascending' | 'descending';
    ```

1. Locate `TODO Define the constructor`.
1. Define the `constructor` for the properties.

    ```typescript
    // TODO Define the constructor
    constructor (items: number, sortOrder: 'ascending' | 'descending') {
        this._items = items;
        this._sortOrder = sortOrder;
    }
    ```

1. Locate `TODO Define the accessors`.
1. Define the accessors that `get` and `set` the value of the `items` and `sortOrder` parameters.

    ```typescript
    // TODO Define the accessors
    get items() {
        return this._items;
    }
    set items(items) {
        this._items = items;
    }
    get sortOrder() {
        return this._sortOrder;
    }
    set sortOrder(sortOrder) {
        this._sortOrder = sortOrder;
    }
    ```

1. Locate `TODO Define the methods`.
1. Move the `sortAscending` and `sortDescending` functions into the class and make them both `private` methods of the class.

    ```typescript
    // TODO Define the methods.
    private sortDescending = (a: number, b: number) => {
        if (a > b) {
            return -1;
        } else if (b > a) {
            return 1;
        } else {
            return 0;}
    }
    private sortAscending = (a: number, b: number) => {
        if (a > b) {
            return 1;
        } else if (b > a) {
            return -1;
        } else {
            return 0; }
    }
    ```

1. Move the `buildArray` function into the class and make it a `public` method of the class.

    ```typescript
    buildArray(): number[] {
        let randomNumbers: number[] = [];
        let nextNumber: number;
        for (let counter = 0; counter < this.items; counter++) {
            nextNumber = Math.ceil(Math.random() * (100 - 1));
            if (randomNumbers.indexOf(nextNumber) === -1) {
                randomNumbers.push(nextNumber);
            } else {
                counter--;
            }
        }
        if (this._sortOrder === 'ascending') {
            return randomNumbers.sort(this.sortAscending);
        } else {
            return randomNumbers.sort(this.sortDescending);
        } 
    }
    ```

1. Locate `TODO: Instantiate the BuildArray objects`.
1. Update the `testArray1` and `testArray2` variable declarations to instantiate new `BuildArray` objects.

    ```typescript
    let testArray1 = new BuildArray(12, 'ascending');
    let testArray2 = new BuildArray(8, 'descending');
    ```

1. Test your work by calling the `buildArray` method on the objects and return the results to the console.

    ```typescript
    console.log(testArray1.buildArray());
    console.log(testArray2.buildArray());
    ```

## Challenge yourself!

For an added challenge, take some existing JavaScript that you may have written or that you find on the web and rewrite it in TypeScript using what you've learned about classes. You can copy and paste the JavaScript into the Playground and edit it or use another editor like Visual Studio Code.

## Lab solution

Clone the ending repository by entering the following at the command prompt. 

```bash
git clone https://github.com/MicrosoftDocs/mslearn-typescript/tree/main/code/module-05/m05-end
cd <folder name>
code .
```

Open the file **module05.ts** to see the solution to this lab. See the **Lab setup** section above for more information about setting up your development environment to run the solution.
