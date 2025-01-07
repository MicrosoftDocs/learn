The Tailwind Traders team is planning to develop several Node.js apps. They've found Jest, a popular zero-config test framework, in the npm registry. They want you to install Jest, write a few tests, and run them to evaluate its effectiveness.

## Add a test package with npm CLI

You have some code that extracts an address from a string. Your job is simple: install the test framework, write a few tests, and run them.

1. In a new terminal window (<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>), change to the folder that has the files for this exercise:

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
    exports.addressParser = function parseOrder(order) {
      const match = order.match(/order:\s(?<order>\w+\s\w+).*address:\s(?<address>\w+\s\w+\s\w+).*payment info:\s(?<payment>\w+)/)
      return match.groups;
    }
   ```

   This function takes a string and parses out information about what a customer orders, where it should be delivered, and how it will be paid for. We'll add Jest and write some tests for the function.

1. Close the `address-parser.js` file.

1. Install the Jest package by running this command:

   ```bash
   npm install jest --save-dev
   ```

1. After the Jest package installs, open the `package.json` file and find the `devDependencies` section. You should see an entry that looks like this example where the value for the `jest` property is a semantic version number:

   ```json
   "devDependencies": {
      "jest": "<number.number.number>"
    }
   ```

1. In the package.json file, find the `scripts` section. Replace the existing `test` action entry with the following code:

   ```json
   "test": "jest"
   ```

1. Save your changes and close the package.json file.

1. In the terminal, create a new subfolder named **\_\_tests\_\_**.

   ```bash
   mkdir __tests__
   ```

    > [!NOTE]
    > Make sure that you use double underscores when you create the *\_\_tests\_\_* folder. The __tests__ folder is a naming convention used by Jest, the testing framework. Jest automatically recognizes any files in a __tests__ folder (or files with .test. or .spec. in their names) as test files and includes them when running tests. This convention helps keep test files organized and easily identifiable in your project.

1. In the \_\_tests\_\_ folder, create a file named **address-parser.spec.js**, and then add the following content to the file:

   ```javascript
    const { addressParser } = require('../address-parser');
    
    describe('Address Parser', () => {
        test('should parse correctly', () => {
            expect(addressParser("I want to to order: 3 books to address: 112 street city here is my payment info: cardnumber")
            ).toEqual({
                order: "3 books",
                address: "112 street city",
                payment: "cardnumber",
            });
        });
    });
   ```

    The test script:
    * Checks the parsing ability of the address-parser.js function.
    * Ensures the function can correctly parse out the needed information.

1. Save your changes and close the file.

1. Your project structure should now look like this example:

   ```output
   -| package.json
   -| address-parser.js
   -| __tests__/
   ---| address-parser.js
   ```

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
