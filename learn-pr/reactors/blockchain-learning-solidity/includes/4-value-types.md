In this unit, you'll learn about the main value types in Solidity. Value types are passed by value and are copied when they're used. The primary value types that you'll use when writing contracts include **integer**, **boolean**, **:::no-loc text="string literal":::**, **address**, and **enum**. 

## Integers

Integers are used in every Solidity source file. They represent whole numbers and can either be signed or unsigned. Integers range in storage size from 8 bits to 256 bits.

- Signed: Includes negative and positive numbers. Can be represented as **int**.
- Unsigned: Includes positive numbers only. Can be represented as **uint**.

If the number of bits aren't specified, the default value is 256 bits.

The following operations can be applied to integers:

- Comparisons: `<=`, `<`, `==`, `!=`, `>=`, `>`
- Bit operators: `& (and)`, `| (or)`, `^ (bitwise exclusive)`, `~ (bitwise negation)`
- Arithmetic operators: `+ (addition)`,`- (subtraction)`, `* (multiplication)`, `/ (division)`, `% (modulo)`, `** (exponential)`

Here are some examples of integer definitions:

```solidity
int32 price = 25; // signed 32 bit integer
uint256 balance = 1000; // unsigned 256 bit integer

balance - price; // 975
2 * price; // 50
price % 2; // 1
```

## Booleans

Booleans are defined using the keyword **bool**. They always have a value of either `true` or `false`.

Here's how they can be defined:

```solidity
bool forSale; //true if an item is for sale
bool purchased; //true if an item has been purchased
```

Booleans are commonly used in comparison statements. For example:

```solidity
if(balance > 0 & balance > price) {
    return true;
}

if(price > balance) {
    return false;
}
```

And booleans can also be used in function parameters and return types.

```solidity
function buy(int price) returns (bool success) {
    // ...
}
```

## String literals

:::no-loc text="String literals"::: are also used in most contract files. They're characters or words surrounded by either double or single-quotes.

```solidity
    String shipped = "shipped"; // shipped
    String delivered = 'delivered'; // delivered
    String newItem = "newItem"; // newItem
```

Additionally, the following escape characters can be used with :::no-loc text="string literals":::.

- `\<newline>` escapes a new line
- `\n` new line
- `\r` carriage return
- `\t` tab

## Address

An address is a type with a 20-byte value that represents an Ethereum user account. This type can either be a regular **address** or an **address payable**.

The difference between the two is that an **address payable** type is an address that you can send Ether to, and it contains the additional members `transfer` and `send`.

```solidity
address payable public seller; // account for the seller
address payable public buyer; // account for the user

function transfer(address buyer, uint price) {
    buyer.transfer(price); // the transfer member transfers the price of the item
}
```

## Enums

In Solidity, you can use enums to create a user-defined type. It's called user-defined because the person creating the contract decides what values to include. Enums can be used to present many selectable choices, one of which is required.

An **enum** could be used, for example, to present different statuses for an item. You can think of enums as representing multiple-choice answers where all the values are pre-defined, and you have to select one. Enums can be declared in contract or library definitions.

```solidity
enum Status { 
    Pending,
    Shipped,
    Delivered 
}

Status public status;

constructor() public {
    status = Status.Pending;
}
```
