# Reference types

Another common type you'll deal with when writing contracts are reference types. Values of reference types can be modified through multiple different names.

While value types are alway pass an independent copy of the value, reference types provide a data location to the value. The three reference types are: **structs**, **arrays**, and **mappings**.

When using a reference type, you must explicitly provide the data area where the type is stored in a data location.

## Data location

Every reference type specifies a data location to where the data is stored. The three options for specifying the data area where the type is stored are:

- **memory:**  
  - The location where contains function arguments are stored
  - Has a lifetime limited to external function call
- **storage:**
  - The location where state variables are stored
  - Has a lifetime limited to the contract lifetime
- **calldata:**
  - The location where contains function arguments are stored
  - It is required for parameters of external functions but can also be used for other variables
  - Has a lifetime limited to external function call

The reference type always create an independent copy of the data.

Example:

```solidity
contract C {

    uint[] x;
    // the data location of values is memory
    function buy(unit[] memory values) public {
        x = value; // copies array to storage
        uint[] storage y = x; //data location of y is storage
        g(x); // calls g, handing over reference to x
        h(x); // calls h, and creates a temporary copy in memory
    }

    function g(uint[] storage) internal pure {}
    function h(uint[] memory) public pure {}
}
```

## Arrays

Arrays are a way to store similar data in a set data structure. They can either have a fixed or dynamic size. Their indices start at 0.

The type of an array of fixed size `k` and element type `T` is written as `T[k]`, and an array of dynamic size as `T[]`.

Array elements can be of any type like **uint**, **memory**, or **bytes**, and can also include **mappings** or **structs**.

Examples:

```solidity
uint[] itemIds; // Declare a dynamic sized array called itemIds
uint[3] prices = [1, 2, 3]; // initialize a fixed size array called prices, with prices 1, 2, and 3
uint[] prices = [1, 2, 3]; // same as above
```

### Array members

The following members are available to get information about and manipulate arrays:

- **length**: Get the length of an array
- **push()**: Append an element at the end of the array
- **pop**: Remove an element from the end of an array

Examples:

```solidity
// Create a dynamic byte array
bytes32[] itemNames;
itemNames.push(bytes32("computer")); // adds "computer" to the array
itemNames.length; // 1
```

## Structs

Structs are custom types that a user can define to represent real world objects. These are typically used as schema or represent records.

Examples:

```solidity

struct Items_Schema {
    uint256 _id:
    uint256 _price:
    string _name;
    string _description;
}
```

## Mapping types

Mappings are key value pairs that are encapsulated, or packaged together. These are closest to dictionaries or Objects in JavaScript. We typically use mappings to model real-world objects and do faster lookups of data. The values could take on various types, including complex types like structs, making this type flexible and human readable to work with.

Here is a code example that uses the struct Items_Schema and saves a list of items represented by the Items_Schema as a dictionary. This somewhat mimics a database.

Notice the mapping signature `uint256 => Items_Schema`. This indicates that the keys are of type unsigned integer and the values are Items_Schema struct.

```solidity
    contract Items {
    uint256 item_id = 0;

    mapping(uint256 => Items_Schema) public items;

    struct Items_Schema {
        uint256 _id:
        uint256 _price:
        string _name;
    }

    function listItem(uint 256 memory _price, string memory _name) public {
        item_id += 1;
        item[vehicle_id] = Items_Schema(item_id, _price, _name);
    }
}
```
