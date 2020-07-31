Tailwind Traders realize that they're about to put extensive development resources on developing apps for the Node.js platform. One thing all these apps is going to need is testing. After some analysis, they've found Node.js to have limited testing capabilities. You will therefore need to depend on a framework. They've found Jest at the NPM registry, it seems widely used and promises to be a zero-config test framework. All they want from you at this point is to install Jest, write a couple of tests and run them to see if it delivers on its promise. 

## Add a testing package using the NPM tool

You've been given some app code that parses an address from a string. So your task should be fairly straightforward and involve installing the test framework, write a couple of tests and run them.

1. Clone the following `https://github.com/MicrosoftDocs/node-essentials/` by typing the following command:

   ```bash
   git clone `https://github.com/MicrosoftDocs/node-essentials/`
   ```

1. Navigate to your files by typing the following command:

   ```bash
   cd node-essentials/node-dependencies/5-exercise-dependency
   ```

1. You should now have access to the following files:

   ```bash
   -| address-parser.js
   -| package.json
   ```

1. Open up `address-parser.js`, it should look like so:

   ```javascript
   exports.parse = function parseOrder(order) {
     const match = order.match(/order:\s(?<order>\w+\s\w+).*address:\s(?<address>\w+\s\w+\s\w+).*payment info:\s(?<payment>\w+)/)
    return match.groups;
   }
   ```

   The above function takes a string and parses out information on what a customer orders, where it should be delivered to an how to pay for it. Let's add Jest and write some tests for it next.

1. Install the Jest library with the following command

   ```bash
   npm install jest --save-dev
   ```

   Open up `package.json` and locate the `devDependencies` section. You should now have an entry that looks like this:

   ```json
   "devDependencies": {
      "jest": "^25.4.0"
    }
   ```

1. Create the directory `__tests__` and inside of it the file `address-parser.js`

   Your project structure should now look like so:

   ```bash
   -| package.json
   -| address-parser.js
   -| __tests__/
   ---| address-parser.js
   ```

1. Add the following content to `__tests__/address-parser.js`:

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

   The above is test written to test the parsing of `address-parser.js` and ensure it correctly parses out the needed information.

1. Open up the package.json file and locate the `scripts` section. Add the following entry:

   ```json
   "test": "jest"
   ```

1. Run the tests by typing the following command in the terminal:

   ```bash
   npm run test
   ```

   You should get the following output

   ```output
   Address parser
    ✓ should parse correctly (2 ms)

   Test Suites: 1 passed, 1 total
   Tests:       1 passed, 1 total
   Snapshots:   0 total
   Time:        1.216 s
   Ran all test suites.
   ```

   Success, your test passes and you've added a new capability *testing* by installing a dependency.

Congrats you've managed to successfully install Jest, a dependency, write tests for application code and run the tests. Jest seems to deliver in on its promise and Tailwind Traders are likely to be happy with this evaluation.
