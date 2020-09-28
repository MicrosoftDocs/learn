In this unit, we'll add a new smart contract to the newSolidityProject we previously created.

## Create a shipping contract

The smart contract you will be creating is for tracking the status of items purchased from an online marketplace. When the contract is created, the shipping status will be set to `Pending`. Once shipped, the shipping status will be set to `Shipped` an event will be emitted. And once delivered, the shipping status is set to `Delivered` and another event will be emitted.

1. To get started with with this exercise, in the project you created earlier, under the **contracts/** directory, right-click on the folder and select to create a new file called **ShippingStatus.sol**.
2. Copy over the contents of this contract below into the file:

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

3. Take a look through the contract to get familiar with what's happening here.
4. Confirm that you can successfully build the contract. Right click on the contract name in the file explorer and select **Build Contracts** to compile the smart contract.

## Add a migration

Now let's add a migration so that we will be able to deploy the contract. To be able to deploy our smart contract to the Ethereum network we need to add another Migration file.

1. In the file explorer, hover over the **migrations/** folder and create a New File called **3_deploy_contracts.js**.
2. Add this code to the file:

```javascript
const Shipping = artifacts.require("ShippingStatus");
module.exports = function (deployer) {
  deployer.deploy(ShippingStatus);
};
```

## Deploy

Next, make sure that you can deploy the contract successfully before moving on. Right-click on the contract name and select to **Deploy Contracts**. Select development in the window that appears and wait for the deployment to complete.

Observe the information that is displayed in the output window. Look for a deployment of **3_deploy_contracts.js**.

:::image type="content" source="../media/shipping-status-migration.png" alt-text="Shipping status migration":::
