In this unit, we'll add a new smart contract to the newSolidityProject we previously created.

## Create a shipping contract

The smart contract that you'll create tracks the status of items purchased from an online marketplace. When the contract is created, the shipping status is set to `Pending`. When an item is shipped, the shipping status is set to `Shipped` and an event is emitted. Upon delivery, the item's shipping status is set to `Delivered` and another event is emitted.

To start this exercise:

1. In the project that you created, in the *contracts* directory, right-click the folder and choose to create a new file called *ShippingStatus.sol*.
2. Copy the following contract contents, and paste them into the new file.

    ```solidity
    pragma solidity >=0.5.12<=0.7.0;
    
    contract ShippingStatus
    {
        // Our predefined values for shipping listed as enums
        enum ShippingStatus { Pending, Shipped, Delivered }
    
        // Save enum ShippingStatus in variable status
        ShippingStatus private status;
    
        // Event to launch when package has arrived
        event LogNewAlert(string description);
    
        // This initializes our contract state (sets enum to Pending once the program starts)
        constructor() public {
            status = ShippingStatus.Pending;
        }
        // Function to change to Shipped
        function Shipped() public {
            status = ShippingStatus.Shipped;
            emit LogNewAlert("Your package has been shipped");
        }
    
        // Function to change to Delivered
        function Delivered() public {
            status = ShippingStatus.Delivered;
            emit LogNewAlert("Your package has arrived");
        }
    
        // Function to get the status of the shipping
        function getStatus(ShippingStatus _status) internal pure returns (string memory) {
         // Check the current status and return the correct name
         if (ShippingStatus.Pending == _status) return "Pending";
         if (ShippingStatus.Shipped == _status) return "Shipped";
         if (ShippingStatus.Delivered == _status) return "Delivered";
        }
    
       // Get status of your shipped item
        function Status() public view returns (string memory) {
             ShippingStatus _status = status;
             return getStatus(_status);
        }
    
    }
    ```

3. Look through the contract to see what's happening. Confirm that you can successfully build the contract.
4. In the Explorer pane, right-click the contract name and then select **Build Contracts** to compile the smart contract.

## Add a migration

Now let's add a migration file so that we can deploy the contract to the Ethereum network.

1. In the Explorer pane, hover over the **migrations** folder and choose **New File**. Name the file *3_deploy_contracts.js*.
2. Add this code to the file:

    ```javascript
    const Shipping = artifacts.require("ShippingStatus");
    module.exports = function (deployer) {
      deployer.deploy(ShippingStatus);
    };
    ```
    
## Deploy

Next, make sure that you can deploy the contract successfully before you move on. Right-click the contract name and then select **Deploy Contracts**. In the window that appears, select **development** and then wait for the deployment to finish.

Watch the information in the output window. Look for a deployment of **3_deploy_contracts.js**.

:::image type="content" source="../media/shipping-status-migration.png" alt-text="Screenshot showing the output window for the shipping status migration.":::
