In a previous module, we introduced a smart contract to capture the shipping status of an item from Pending to Shipped to Delivered. The contract also adds a counter which keeps track of the number of times that state of the shipping contract is updated and will display that in the frontend interface.

In this exercise, we'll wire up the contract to a simple dapp to see the status and the number of times that state has been updated.

## Add the shipping contract to the Drizzle project

The shipping contract that we'll be using in this example is displayed below. Copy this code into a new file in VS Code to the same project used in the last unit. The new file should be added in the **contracts/** folder in a file named **Shipping.sol**.

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

 Now, you need to modify **./migrations/2_deploy_contracts.js** to include the Shipping contract.

On line 4 add:

```javascript
const Shipping = artifacts.require("Shipping");
```

And in the body of the function add a line to deploy the Shipping contract on line 10:

```javascript
    deployer.deploy(Shipping);
```

You can now compile and migrate the contract. Going to the terminal, confirm that Ganache CLI is running. If it's not running in a terminal window, type: `ganache-cli`.

Open up another terminal window by right-clicking into the terminal and selecting **New Terminal**.

In that new terminal window, type:

- `truffle compile` to compile the Shipping contract
- `truffle migrate --network develop` to migrate the Shipping contract

## Wiring up the frontend to the Shipping contract

### Create a loading component

Next, create a loading component for the Shipping contract called **ShipComponent.js** in the folder **app/src/**. You can do that right-clicking on **app/src** and selecting to create a new file. Then copy the code below into the new file.

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

This loading component defines what the frontend looks like and what interaction it allows with users.

### Modify Drizzle's options

Navigate to **./app/src/drizzleOptions.js** to make a few changes.

On line 5, add the following to import **Shipping.json.**

```javascript
import Shipping from "./contracts/Shipping.json";
```

Then on line 12, insert `Shipping` in the contracts array so the line looks like:

```javascript
contracts: [SimpleStorage, ComplexStorage, TutorialToken, Shipping]
```

### Modify App.js

Then modify **/app/src/App.js** to replace **MyComponent** with **ShipComponent** on line 5:

```javascript
import ShipComponent from "./ShipComponent";
```

And also replace **ShipComponent** on line 22:

```javascript
<ShipComponent drizzle={drizzle} drizzleState={drizzleState} />
```

## Running the Shipping Example Code

You have now completed all the steps to wire up the shipping contract, so that means it's time to run the dapp and check out how it works.

Going back to the terminal, type the following commands:

- `cd app` to move to the app folder
- `npm rebuild` to run the build and recompile changes in the app/ folder
- `npm run start` to start the web-pack dev server for React and opens up a new browser window for the React project.

Your browser should now open at [http://localhost:3000](http://localhost:3000?azure-portal=true) showing a dapp where you can interact with the Shipping contract.

You should see the following:

:::image type="content" source="../media/shipping-dapp.png" alt-text="Image showing the dapp that is wired up to the shipping contract":::
