The developers at Tailwind Traders realize that they're about to put extensive resources into developing apps for the Node.js platform. These apps are going to need testing. After some analysis, they find that Node.js has limited testing capabilities. So they need to use a framework. They've found Jest in the npm registry. It seems to be widely used and promises to be a zero-config test framework. At this point, they just want you to install Jest, write a couple tests, and run them to see if Jest delivers on its promise. 

## Add a testing package by using the npm tool

You're given some code that parses an address from a string. Your task should be fairly straightforward. It involves installing the test framework, writing a couple tests, and running them.


1. In a new terminal window (<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>), change to the folder that has the cloned files for this exercise:

   ```bash
   cd node-dependencies/5-exercise-dependency
   ```

1. View the contents of the folder:

    ```bash
    ls -R
    ```

   In this folder, you should see two JavaScript files:

   ```output
   -| address-parser.js
   -| package.json
   ```

1. Open the **address-parser.js** file. It should look like this file:

   ```javascript
   exports.parse = function parseOrder(order) {
     const match = order.match(/order:\s(?<order>\w+\s\w+).*address:\s(?<address>\w+\s\w+\s\w+).*payment info:\s(?<payment>\w+)/)
   return match.groups;
   }
   ```

   This function takes a string and parses out information about what a customer orders, where it should be delivered, and how it will be paid for. We'll add Jest and write some tests for the function.

   Close the address-parser.js file.

1. Install the Jest library by running this command:

   ```bash
   npm install jest --save-dev
   ```

1. After the Jest library installs, open the package.json file and find the `devDependencies` section. You should see an entry that looks like this example:

   ```json
   "devDependencies": {
      "jest": "^29.6.3"
    }
   ```

   Notice that the Jest library has an identified development dependency.

1. In the package.json file, find the `scripts` section. Replace the existing `test` action entry with the following code:

   ```json
   "test": "jest"
   ```

   Save your changes and close the package.json file.

1. In the terminal, create a new subfolder named **\_\_tests\_\_**.

   ```bash
   mkdir __tests__
   ```

    > [!NOTE]
    > Make sure that you use double underscores when you create the *\_\_tests\_\_* folder.

1. In the \_\_tests\_\_ folder, create a file named **address-parser.js**, and then add the following content to the file:

   ```javascript
   const { parse } = require("../address-parser");

   describe('Address parser', () => {
     test('should parse correctly', () => {
       expect(
         parse(
            "I want to to order: 3 books to address: 112 street city here is my payment info: cardnumber"
         )
         ).toEqual({
           order: "3 books",
           address: "112 street city",
           payment: "cardnumber",
         });
     })
   })
   ```

   Save your changes and close the file.

   Your project structure should now look like this example:

   ```output
   -| package.json
   -| address-parser.js
   -| __tests__/
   ---| address-parser.js
   ```

   The test script checks the parsing ability of the address-parser.js function. The test ensures the function can correctly parse out the needed information.

1. Run the tests by entering this command in the terminal:

   ```bash
   npm run test
   ```

   You should get the following output:

   ```output
     PASS  __tests__/address-parser.js
      Address parser
        ✓ should parse correctly (2 ms)
    
    Test Suites: 1 passed, 1 total
    Tests:       1 passed, 1 total
    Snapshots:   0 total
    Time:        0.4 s
    Ran all test suites.
   ```

   Success! Your test passes, and you added testing by installing a dependency.

Congratulations. You successfully installed Jest as a dependency, wrote tests for application code, and ran the tests. Jest seems to deliver on its promise, and Tailwind Traders is likely to be happy with this evaluation.
