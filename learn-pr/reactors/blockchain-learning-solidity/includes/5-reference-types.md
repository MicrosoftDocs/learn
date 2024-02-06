When writing contracts, you should also understand reference types.

Unlike value types, which always pass an independent copy of the value, reference types provide a **data location** for the value. The three reference types are: **structs**, **arrays**, and **mappings**.

## Data location

When you use a reference type, you must explicitly provide the data storage location for the type. The following options can be used to specify the data location where the type is stored:

- `memory`:  
  - The location where function arguments are stored
  - Has a lifetime limited to the lifetime of an external function call
- `storage`:
  - The location where state variables are stored
  - Has a lifetime limited to the contract lifetime
- `calldata`:
  - The location where function arguments are stored
  - This location is required for parameters of external functions, but can also be used for other variables
  - Has a lifetime limited to the lifetime of an external function call

Reference types always create an independent copy of the data.

Here's an example of how to use a reference type:

```solidity
contract C {

  uint[] x;
  
  // the data location of values is memory
  function buy(uint[] memory values) public {
      x = values; // copies array to storage
      uint[] storage y = x; //data location of y is storage
      g(x); // calls g, handing over reference to x
      h(x); // calls h, and creates a temporary copy in memory
  }

  function g(uint[] storage) internal pure {}
  function h(uint[] memory) public pure {}
}
```

## Arrays

Arrays are a way to store similar data in a set data structure. Arrays can either have a fixed or dynamic size. Their indices start at 0.

To create an array of fixed size `k` and element type `T`, you'd write `T[k]`. For a dynamically sized array, you'd write `T[]`.

Array elements can be of any type. For example, they can contain **uint**, **memory**, or **bytes**. Arrays can also include **mappings** or **structs**.

The following examples show array creation:

```solidity
uint[] itemIds; // Declare a dynamically sized array called itemIds
uint[3] prices = [1, 2, 3]; // initialize a fixed size array called prices, with prices 1, 2, and 3
uint[] prices = [1, 2, 3]; // same as above
```

### Array members

The following members can both manipulate and get information about arrays:

- **length**: Get the length of an array.
- **push()**: Append an element at the end of an array.
- **pop**: Remove an element from the end of an array.

Here are some examples:

```solidity
// Create a dynamic byte array
bytes32[] itemNames;
itemNames.push(bytes32("computer")); // adds "computer" to the array
itemNames.length; // 1
```

## Structs

Structs are custom types that a user can define to represent real-world objects. Structs are typically used as a schema or to represent records.

Example of a structure declaration:

```solidity
struct Items_Schema {
    uint256 _id;
    uint256 _price;
    string _name;
    string _description;
}
```

## Mapping types

Mappings are key value pairs that are encapsulated or packaged together. Mappings are closest to dictionaries or objects in JavaScript. You typically use mappings to model real-world objects and perform faster data lookups. The values can include complex types like structs, which makes the mapping type flexible and human readable.

The following code example uses the struct `Items_Schema` and saves a list of items represented by the `Items_Schema` as a dictionary. In this way, the mapping mimics a database.

```solidity
contract Items {
    uint256 item_id = 0;

    mapping(uint256 => Items_Schema) public items;

    struct Items_Schema {
      uint256 _id:
      uint256 _price:
      string _name;
    }

    function listItem(uint256 memory _price, string memory _name) public {
      items[item_id] = Items_Schema(item_id, _price, _name);
      item_id += 1;
    }
}
```

> [!NOTE]
> The mapping signature `uint256 => Items_Schema` indicates that the keys are an unsigned integer type and the values are an `Items_Schema` struct type.
