In this exercise, you'll develop a task manager. You'll use it to connect to and deploy on the *Ropsten* test networks.

In the first part of this exercise, you'll focus on creating the project, adding a smart contract, and then deploying to a development network.

For this tutorial, you'll use:

- Visual Studio Code to create the project.
- [Truffle](https://www.trufflesuite.com/truffle?azure-portal=true) to compile and deploy.
- The [Ganache CLI](https://github.com/trufflesuite/ganache-cli?azure-portal=true) as the blockchain development server.

## Create a new Truffle project

1. In a terminal or command prompt window, create a new directory called *todolist* by entering `mkdir todolist`.

2. Go to the newly created directory by entering `cd todolist`.

3. Initialize the directory as a Truffle project by entering `truffle init`.

4. In Visual Studio Code, open the *todolist* folder.

5. In Visual Studio Code, create a file in the contracts directory. Name it *TodoList.sol*. In the new file, paste the following code.

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity >=0.4.22 <0.8.0;

   contract TodoList {
    uint public taskCount = 0;

    struct Task {
      uint id;
      string taskname;
      bool status;
    }

    mapping(uint => Task) public tasks;

    event TaskCreated(
      uint id,
      string taskname,
      bool status
    );

    event TaskStatus(
      uint id,
      bool status
    );

    constructor() public {
      createTask("Todo List Tutorial");
    }

    function createTask(string memory _taskname) public {
      taskCount ++;
      tasks[taskCount] = Task(taskCount, _taskname, false);
      emit TaskCreated(taskCount, _taskname, false);
    }

    function toggleStatus(uint _id) public {
      Task memory _task = tasks[_id];
      _task.status = !_task.status;
      tasks[_id] = _task;
      emit TaskStatus(_id, _task.status);
    }

   }
   ```

## Migrate and deploy to development

1. Create a migration for *TodoList.sol* in the *migrations/* folder. Begin by creating a new file called *2_deploy_contracts.js*. In the file, paste the following code to deploy the TodoList smart contract.

   ```javascript
    var TodoList = artifacts.require("./TodoList.sol");

    module.exports = function(deployer) {
     deployer.deploy(TodoList);
    };
    ```

1. In the main project directory, open *./truffle-config.js*. Uncomment the code to deploy on the development network on localhost port 8545. Your code should look as follows.

   ```javascript
    networks: {
      development: {
        host: "127.0.0.1",
        port: 8545,
        network_id: "*" // Match any network id
      }
    },
   ```

1. Open a terminal pane within Visual Studio Code. Use the Ganache CLI to start a development blockchain by entering `ganache-cli`.

1. In Visual Studio Code, open a terminal pane to compile and migrate the TodoList contract to the development network. Run the following commands.

   - `truffle compile`
   - `truffle migrate --reset`

These steps deploy the smart contracts to the development network. At this point, use the Truffle console to inspect and modify the smart contracts. You see that you created a single task when you initialized the task list.

In the Truffle console, you can continue to interact with the contract. For example, you can create and set tasks and change their status.
