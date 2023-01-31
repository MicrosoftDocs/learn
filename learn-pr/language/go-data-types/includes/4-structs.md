There are times when you need to represent a collection of fields in one structure. For instance, when you need to write a payroll program, you need to use an employee data structure. In Go, you can use structs to group together different fields that could form a record.

A *struct* in Go is *another data type* that could contain zero or more fields of arbitrary types and represent them as a single entity.

In this section, we'll explore why structs are essential and how to use them.

## Declare and initialize a struct

To declare a struct, you need to use the `struct` keyword, along with the list of fields and their types that you want your new data type to have. For instance, to define an employee struct, you could use the following code:

```go
type Employee struct {
    ID        int
    FirstName string
    LastName  string
    Address   string
}
```

Then, you can declare a variable with the new type as you'd typically do with other types, like this:

```go
var john Employee
```

And if you want to declare and initialize a variable at the same time, you could do it this way:

```go
employee := Employee{1001, "John", "Doe", "Doe's Street"}
```

Notice that you have to specify a value for each of the fields from the struct. But that could be problematic sometimes. Alternatively, you can be more specific about the fields you want to initialize in a struct:

```go
employee := Employee{LastName: "Doe", FirstName: "John"}
```

Notice that from the previous statement, the order you assign values to each field doesn't matter. Also, it doesn't matter if you don't specify a value for any other field. Go will assign a default value depending on the field data type.

To access individual fields of a struct, you can do it by using the dot notation (`.`), like this example:

```go
employee.ID = 1001
fmt.Println(employee.FirstName)
```

Lastly, you can use the `&` operator to yield a pointer to the struct, like the following code demonstrates:

```go
package main

import "fmt"

type Employee struct {
    ID        int
    FirstName string
    LastName  string
    Address   string
}

func main() {
    employee := Employee{LastName: "Doe", FirstName: "John"}
    fmt.Println(employee)
    employeeCopy := &employee
    employeeCopy.FirstName = "David"
    fmt.Println(employee)
}
```

When you run the preceding code, you see the following output:

```output
{0 John Doe }
{0 David Doe }
```

Notice how the struct becomes mutable when you use pointers.

## Struct embedding

Structs in Go allow you to embed another struct within a struct. There are going to be times where you want to reduce repetition and reuse a common struct. For example, let's say that you want to refactor the previous code to have a data type for an Employee and another one for a Contractor. You could have a `Person` struct that holds common fields, like this example:

```go
type Person struct {
    ID        int
    FirstName string
    LastName  string
    Address   string
}
```

You can then declare other types that embed a `Person` type, like an `Employee` and a `Contractor`. To embed another struct, you create a new field, like this example:

```go
type Employee struct {
    Information Person
    ManagerID   int
}
```

But to reference a field from the `Person` struct, you'll need to include the `Information` field from an employee variable, like this example:

```go
var employee Employee
employee.Information.FirstName = "John"
```

If you're refactoring code like we're doing, that would break our code. Alternatively, you can include a new field with the same name of the struct you're embedding, like this example:

```go
type Employee struct {
    Person
    ManagerID int
}
```

As a demonstration, you could use the following code:

```go
package main

import "fmt"

type Person struct {
    ID        int
    FirstName string
    LastName  string
    Address   string
}

type Employee struct {
    Person
    ManagerID int
}

type Contractor struct {
    Person
    CompanyID int
}

func main() {
    employee := Employee{
        Person: Person{
            FirstName: "John",
        },
    }
    employee.LastName = "Doe"
    fmt.Println(employee.FirstName)
}
```

Notice how you access the `FirstName` field from an `Employee` struct without having to specify the `Person` field because it's embedding all its fields automatically. But, when you're initializing a struct, you have to be specific about which field you want to assign a value to.

## Encode and decode structs with JSON

Finally, you can use structs to encode and decode data in JSON. Go has excellent support for the JSON format, and it's already included in the standard library packages.

You can also do things like rename the name of a field from the struct. For instance, let's say that you don't want the JSON output to show `FirstName` but simply `name` or ignore empty fields. You could use field tags like this example shows:

```go
type Person struct {
    ID        int    
    FirstName string `json:"name"`
    LastName  string
    Address   string `json:"address,omitempty"`
}
```

Then, to encode a struct into JSON, you use the `json.Marshal` function. And to decode a JSON string into a data structure, you use the `json.Unmarshal` function. Here's an example that puts everything together, encoding an array of employees to JSON and decoding the output into a new variable:

```go
package main

import (
    "encoding/json"
    "fmt"
)

type Person struct {
    ID        int
    FirstName string `json:"name"`
    LastName  string
    Address   string `json:"address,omitempty"`
}

type Employee struct {
    Person
    ManagerID int
}

type Contractor struct {
    Person
    CompanyID int
}

func main() {
    employees := []Employee{
        Employee{
            Person: Person{
                LastName: "Doe", FirstName: "John",
            },
        },
        Employee{
            Person: Person{
                LastName: "Campbell", FirstName: "David",
            },
        },
    }

    data, _ := json.Marshal(employees)
    fmt.Printf("%s\n", data)

    var decoded []Employee
    json.Unmarshal(data, &decoded)
    fmt.Printf("%v", decoded)
}
```

When you run the preceding code, you see the following output:

```output
[{"ID":0,"name":"John","LastName":"Doe","ManagerID":0},{"ID":0,"name":"David","LastName":"Campbell","ManagerID":0}]
[{{0 John Doe } 0} {{0 David Campbell } 0}]
```
