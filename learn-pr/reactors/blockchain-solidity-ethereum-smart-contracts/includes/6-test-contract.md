In this part, we write a new JavaScript test for our shipping contract. We could instead use Solidity to write the test, but JavaScript is used more commonly. To test our smart contract, we use Truffle.

## Begin the testing

Let's begin by creating a new test file.

1. Go to **Terminal** > **New Terminal**.
1. In the new terminal, type `truffle create test Shipping`. This creates a new file in the test folder called *Shipping.js*.  
1. Replace the code in the file by pasting the following code:

    ```javascript
    const ShippingStatus= artifacts.require("Shipping");
    contract('Shipping', () => {
      
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

We'll use the truffle-assertions package to test the events that are sent in the contract. By using this package, we can assert that our events are emitted during the transaction.

1. In the terminal, install the library by typing `npm install truffle-assertions`.
1. Add the following code to the test file on line 2, after you require the ShippingStatus contract:

   ```javascript
   const truffleAssert = require('truffle-assertions');
   ```

1. Add a test to confirm that the event returns the expected description. Place this test after the last test in the file. Add it in a new line, right before the last line's set of closing braces.

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

### Using async/await

The **.deployed()** function returns a promise. So we use `await` in front of the function, and we use `async` in front of the test code. This setup means that after the contract is deployed, we won't move forward with our test until the promise is fulfilled.

This pattern is commonly used in tests because almost all smart contract transactions are asynchronous. They're asynchronous because transactions need to be validated or mined before they're added to the blockchain ledger.

Overall, you should aim for 100 percent test coverage for your contract, especially if you plan to deploy to the main Ethereum network, or *Main Net*.

## Run the test

In the terminal, type: 

`truffle test`

You should see that all tests pass successfully:

```output
  Contract: HelloBlockchain
    ✓ testing ResponseMessage of HelloBlockchain
    ✓ testing Responder of HelloBlockchain
    ✓ testing RequestMessage of HelloBlockchain
    ✓ testing State of HelloBlockchain
    ✓ testing Requestor of HelloBlockchain
    ✓ testing SendRequest of HelloBlockchain (51ms)
    ✓ testing SendResponse of HelloBlockchain (46ms)

  Contract: Shipping
    ✓ should return the status Pending
    ✓ should return the status Shipped (59ms)
    ✓ should return the status Delivered (58ms)
    ✓ should return correct event description (39ms)
```
