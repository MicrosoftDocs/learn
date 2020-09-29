In this unit, we will write a new test for our shipping contract in JavaScript. We could also use Solidity to write tests, but JavaScript is what's used most commonly. To test our smart contract we will use **Truffle**.

## Let the testing begin

1. Let’s create our first test by creating a new test file. Go to Terminal -> New Terminal.
1. One the terminal is opened, type: `truffle create test ShippingStatus`. In our folder test a JavaScript file has been created called ShippingStatus.js. Remove the code in the file and replace it with:

```javascript
const ShippingStatus = artifacts.require("ShippingStatus");
contract('ShippingStatus', () => {
  
  it("should return the status Pending", async ()=> {
    // Instance of our deployed contract
    const instance = await ShippingStatus.deployed();
    // Checking the initial status in our contract
    const status = await instance.Status();
    // Checking if the status is initially Pending as set in the constructor
    assert.equal(status, "Pending");
  });
it("should return the status Shipped", async ()=> {
// Instance of our deployed contract
    const instance = await ShippingStatus.deployed();

    // Calling the Shipped() function
    await instance.Shipped();

    // Checking the initial status in our contract
    const status = await instance.Status();

    // Checking if the status is Shipped
    assert.equal(status, "Shipped");
  });

    it("should return the status Delivered", async ()=> {

    // Instance of our deployed contract
    const instance = await ShippingStatus.deployed();

    // Calling the Shipped() function
    await instance.Delivered();

    // Checking the initial status in our contract
    const status = await instance.Status();

    // Checking if the status is Delivered
    assert.equal(status, "Delivered");
  });
});
 ```

### Event test

We will use the package truffle-assertions to help us test our events. By using this package we can assert that our events are emitted during the transaction.

1. Go back to the terminal and install the library by typing: `npm install truffle-assertions`
2. Add this to the top of the test file on line 2 after requiring the ShippingStatus contract:

   ```javascript
   const truffleAssert = require('truffle-assertions');
   ```

1. And then add a test to confirm the event returns the expected description. Place this test after the last test in the file, in a new line, right before the last line (set of closing braces).

```javascript
    it('should return correct event description', async()=>{

    // Instance of our deployed contract
    const instance = await ShippingStatus.deployed();

    // Calling the Delivered() function
    const delivered = await instance.Delivered();

    // Check event description is correct
    truffleAssert.eventEmitted(delivered, 'LogNewAlert', (event) =>{
      return event.description == 'Your package has arrived';
    });
  });

```

#### Using async/await

The **.deployed()** function returns a promise. Because of this we use `await` in front of this, and also `async` in front of the test code. This means until the promise if fulfilled  when the contract is deployed, we will not move forward with our test. This pattern is very commonly used in tests since almost all smart contract transactions are asynchronous. This is because transactions need to be validated, or mined before they are added to the blockchain ledger.

Overall you should at least aim for 100% test coverage for your contract especially if you plan to deploy to the main Ethereum network, or main net.

## Run the test

From the terminal type: `truffle test`

You should see all tests successfully passing:

```output
  Contract: HelloBlockchain
    ✓ testing ResponseMessage of HelloBlockchain
    ✓ testing Responder of HelloBlockchain
    ✓ testing RequestMessage of HelloBlockchain
    ✓ testing State of HelloBlockchain
    ✓ testing Requestor of HelloBlockchain
    ✓ testing SendRequest of HelloBlockchain (51ms)
    ✓ testing SendResponse of HelloBlockchain (46ms)

  Contract: ShippingStatus
    ✓ should return the status Pending
    ✓ should return the status Pending
    ✓ should return the status Shipped (59ms)
    ✓ should return the status Delivered (58ms)
    ✓ should return correct event description (39ms)
```
