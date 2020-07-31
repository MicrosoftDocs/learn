The developers at Tailwind Traders realize that they're about to put extensive resources into developing apps for the Node.js platform. These apps are going to need testing. After some analysis, they find that Node.js has limited testing capabilities. So they need to use a framework. They've found Jest in the npm registry. It seems to be widely used and promises to be a zero-config test framework. At this point, they just want you to install Jest, write a couple tests, and run them to see if Jest delivers on its promise. 

## Add a testing package by using the npm tool

You're given some code that parses an address from a string. Your task should be fairly straightforward. It involves installing the test framework, writing a couple tests, and running them.

1. Clone `https://github.com/MicrosoftDocs/node-essentials/` by running this command:

   ```bash
   git clone `https://github.com/MicrosoftDocs/node-essentials/`
   ```

1. Go to your files by running this command:

   ```bash
   cd node-essentials/node-dependencies/5-exercise-dependency
   ```

   You should now have access to these files:

   ```bash
   -| address-parser.js
   -| package.json
   ```

1. Open address-parser.js. It should look like this file:

   ```javascript
   exports.parse = function parseOrder(order) {
     const match = order.match(/order:\s(?<order>\w+\s\w+).*address:\s(?<address>\w+\s\w+\s\w+).*payment info:\s(?<payment>\w+)/)
    return match.groups;
   }
   ```

   The preceding function takes a string and parses out information about what a customer orders, where it should be delivered, and how it will be paid for. Let's add Jest and write some tests for the function.

1. Install the Jest library by running this command:

   ```bash
   npm install jest --save-dev
   ```

   Open the package.json file and find the `devDependencies` section. You should now have an entry that looks like this one:

   ```json
   "devDependencies": {
      "jest": "^25.4.0"
    }
   ```

1. Create a \_\_tests\_\_ folder. Inside of it, create an address-parser.js file.

   Your project structure should now look like this one:

   ```bash
   -| package.json
   -| address-parser.js
   -| __tests__/
   ---| address-parser.js
   ```

1. Add the following content to \_\_tests\_\_\/address-parser.js:

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

   The preceding test is written to test the parsing of address-parser.js and ensure it correctly parses out the needed information.

1. Open the package.json file and find the `scripts` section. Add this entry:

   ```json
   "test": "jest"
   ```

1. Run the tests by typing this command in the terminal:

   ```bash
   npm run test
   ```

   You should get the following output:

   ```output
   Address parser
    ✓ should parse correctly (2 ms)

   Test Suites: 1 passed, 1 total
   Tests:       1 passed, 1 total
   Snapshots:   0 total
   Time:        1.216 s
   Ran all test suites.
   ```

   Success! Your test passes, and you've added testing by installing a dependency.

Congratulations. You've managed to successfully install Jest as a dependency, write tests for application code, and run the tests. Jest seems to deliver on its promise, and Tailwind Traders is likely to be happy with this evaluation.
