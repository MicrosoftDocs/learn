Now, let's put together what we've learned into a complete smart contract.

In this example, you'll use Solidity to create a smart contract for a simple online marketplace. This contract will let users list an item for sale and buy an available item. There are two roles involved: a seller and a buyer.

## Simple marketplace example

```solidity
pragma solidity >0.7.0 <0.8.0;

contract Marketplace {
    address public seller;
    address public buyer;
    mapping (address => uint) public balances;

    event ListItem(address seller, uint price);
    event PurchasedItem(address seller, address buyer, uint price);

    enum StateType {
          ItemAvailable,
          ItemPurchased
    }

    StateType public State;

    constructor() public {
        seller = msg.sender;
        State = StateType.ItemAvailable;
    }

    function buy(address seller, address buyer, uint price) public payable {
        require(price <= balances[buyer], "Insufficient balance");
        State = StateType.ItemPurchased;
        balances[buyer] -= price;
        balances[seller] += price;

        emit PurchasedItem(seller, buyer, msg.value);
    }
}    
```

Let's dig into the main components of this smart contract:

- There are:
  - Three state variables: `buyer`, `seller`, and `balances`
  - Two events: `ListItem` and `PurchasedItem`
  - One enum with two values: `ItemAvailable` and `ItemPurchased`
- The constructor assigns the seller user as `msg.sender`, and sets the initial state to `ItemAvailable`. This constructor is called when the contract is created.
- The `buy` function takes three parameters: `seller`, `buyer`, and `price`. It has a requirement that the buyer has enough money for the purchase. Then it transfers money from the buyer to the seller, and finally a message is emitted.

## Next steps

Go to [Remix IDE](https://remix.ethereum.org/?azure-portal=true) to explore more smart contract examples in Solidity. Remix is an in-browser IDE that lets's you get started right away without having to create an account or sign in. You can immediately write, test, compile, and deploy contracts.

Copy and paste this smart contract to Remix in a new file named `Marketplace.sol`. Then compile and deploy the contract. While the contract has a function to buy an available item, you'll notice there is no way to give a buyer currency to make the purchase. For an extra challenge, use what you've learned to write a function to give the buyer a balance, providing an account address and an amount. If you want to see an example of how to do this, watch [Dr. G add a function to initialize a balance for participants](https://aka.ms/LearnWithDrG/Blockchain/Challenge1).
