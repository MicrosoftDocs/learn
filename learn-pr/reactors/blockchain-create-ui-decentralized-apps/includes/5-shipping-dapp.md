In a previous module, we introduced a smart contract to capture the shipping status of an item from **Pending** to **Shipped** to **Delivered**. The contract also adds a counter, which keeps track of the number of times that the state of the shipping contract is updated. The counter displays that number in the front-end interface.

In this exercise, we'll wire up the contract to a simple dapp to see the status and the number of times that state has been updated.

## Add the shipping contract to the Drizzle project

The following code is the shipping contract that we'll use in this example. Copy this code into a new file in Visual Studio Code to the same project that we used in the last unit. Add the new file in the **contracts/** folder and name it **Shipping.sol**.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract Shipping
{
   // Our predefined values for shipping listed as enums
   enum ShippingStatus { Pending, Shipped, Delivered }
   enum ShipmentStatus { Pending, Shipped, Delivered }
  
   // Save enum ShippingStatus in variable status
   ShippingStatus private status;
   ShipmentStatus public shipstatus;
   uint256 public numupdates;

   // Event to launch when package has arrived
   event LogNewAlert(string description);
   // This initializes our contract state (sets enum to Pending once the program starts)
   constructor() public {
       status = ShippingStatus.Pending;
       numupdates = 0;
   }
   // Function to change to Shipped
   function Shipped() public {
       status = ShippingStatus.Shipped;
       shipstatus = ShipmentStatus.Shipped;
       numupdates = numupdates + 1;
   }
  
   // Function to change to Delivered
   function Delivered() public {
       status = ShippingStatus.Delivered;
       shipstatus = ShipmentStatus.Delivered;
       numupdates = numupdates + 1;
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

## Modify the migration

 Now, you need to modify **./migrations/2_deploy_contracts.js** to include the shipping contract.

On line 4, add:

```javascript
const Shipping = artifacts.require("Shipping");
```

In the body of the function, add a line to deploy the shipping contract on line 10:

```javascript
    deployer.deploy(Shipping);
```

You can now compile and migrate the contract. Go to the terminal and confirm that Ganache CLI is running. If it's not running in a terminal window, enter `ganache-cli`.

Next, you can use the Blockchain Development Kit to compile the contract. Focusing your attention on the project, right-click on the shipping contract and select **Build Contracts**. Wait for the build and compilation to successfully finish.

Then right-click on the shipping contract again and select **Deploy Contracts**. When the window for deploy destination appears, select the **develop** network. Wait a minute for the migration to complete successfully.

## Wire up the front end to the shipping contract

### Create a loading component

Next, create a loading component for the shipping contract called **ShipComponent.js** in the folder **app/src/**. You can do that by right-clicking **app/src** and selecting the option to create a new file. Then copy the following code into the new file.

```javascript
import React from "react";
import { newContextComponents } from "@drizzle/react-components";
const { ContractData, ContractForm } = newContextComponents;
export default ({ drizzle, drizzleState }) => {
  return (
    <div className="App">
      <div className="section">
        <h2>Shipping Test</h2>
        <h3>
          <strong>Shipping Status 1-Shipped 2-Delivered </strong>
          <strong>Ship State: </strong>
          <ContractData
            drizzle={drizzle}
            drizzleState={drizzleState}
            contract="Shipping"
            method="shipstatus"
          />
        </h3>
        <p>
          <strong>Total number of updates: </strong>
          <ContractData
            drizzle={drizzle}
            drizzleState={drizzleState}
            contract="Shipping"
            method="numupdates"
          />
        </p>
        <p>
          <strong>Ship: </strong>
          <ContractForm
            drizzle={drizzle}
            contract="Shipping"
            method="Shipped"
          />
        </p>
        <p>
          <strong>Deliver: </strong>
          <ContractForm
            drizzle={drizzle}
            contract="Shipping"
            method="Delivered"
          />
        </p>
      </div>
    </div>
  );
};
```

This loading component defines what the front end looks like and what interaction it allows with users.

### Modify Drizzle's options

Go to **./app/src/drizzleOptions.js** to make a few changes.

On line 5, add the following code to import **Shipping.json**.

```javascript
import Shipping from "./contracts/Shipping.json";
```

Then on line 12, insert `Shipping` in the contracts array so the line looks like:

```javascript
contracts: [SimpleStorage, ComplexStorage, TutorialToken, Shipping]
```

### Modify App.js

Modify **/app/src/App.js** to replace `MyComponent` with `ShipComponent` on line 5:

```javascript
import ShipComponent from "./ShipComponent";
```

And replace `ShipComponent` on line 22:

```javascript
<ShipComponent drizzle={drizzle} drizzleState={drizzleState} />
```

## Run the shipping example code

You've now completed all the steps to wire up the shipping contract. That means it's time to run the dapp and see how it works.

Go back to the terminal and enter the following commands:

- `cd app` to move to the app folder.
- `npm rebuild` to run the build and recompile changes in the **app/** folder.
- `npm run start` to start the web-pack development server for React. This command opens a new browser window for the React project.

Your browser should now open at `http://localhost:3000` and show a dapp where you can interact with the shipping contract.

You should see the following test information:

:::image type="content" source="../media/shipping-dapp.png" alt-text="Screenshot that shows the dapp that's wired up to the shipping contract.":::
