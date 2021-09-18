In this exercise, you'll modify a car factory program to use a hash map.

We'll use hash map key, value pairs to track details about the car orders and to display output. Once again, your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

> [!Note]
> In the sample code, look for the `todo!` macro. This macro indicates code that needs to be completed or updated.


## Load the current program

The first step is to get the existing program code.

1. Open the existing program code for editing. The code includes data type declarations, and definitions for the `car_quality`, `car_factory`, and `main` functions.

    Copy the following code and edit it in your local development environment,<br>
    or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    #[derive(PartialEq, Debug)]
    struct Car { color: String, motor: Transmission, roof: bool, age: (Age, u32) }

    #[derive(PartialEq, Debug)]
    enum Transmission { Manual, SemiAuto, Automatic }

    #[derive(PartialEq, Debug)]
    enum Age { New, Used }

    // Get the car quality by testing the value of the input argument
    // - miles (u32)
    // Return tuple with car age ("New" or "Used") and mileage
    fn car_quality (miles: u32) -> (Age, u32) {

        // Check if car has accumulated miles
        // Return tuple early for Used car
        if miles > 0 {
            return (Age::Used, miles);
        }
        
        // Return tuple for New car, no need for "return" keyword or semicolon
        (Age::New, miles)
    }

    // Build "Car" using input arguments
    fn car_factory(order: i32, miles: u32) -> Car {
        let colors = ["Blue", "Green", "Red", "Silver"];

        // Prevent panic: Check color index for colors array, reset as needed
        // Valid color = 1, 2, 3, or 4
        // If color > 4, reduce color to valid index
        let mut color = order as usize;
        if color > 4 {        
            // color = 5 --> index 1, 6 --> 2, 7 --> 3, 8 --> 4
            color = color - 4;
        }
            
        // Add variety to orders for motor type and roof type
        let mut motor = Transmission::Manual;
        let mut roof = true;
        if order % 3 == 0 {          // 3, 6, 9
            motor = Transmission::Automatic;
        } else if order % 2 == 0 {   // 2, 4, 8, 10
            motor = Transmission::SemiAuto;
            roof = false;
        }                            // 1, 5, 7, 11

        // Return requested "Car"
        Car {
            color: String::from(colors[(color-1) as usize]),
            motor: motor,
            roof: roof,
            age: car_quality(miles)
        }
    }

    fn main() {
        // Initialize counter variable
        let mut order = 1;
        // Declare a car as mutable "Car" struct
        let mut car: Car;
            
        // Order 6 cars, increment "order" for each request
        // Car order #1: Used, Hard top
        car = car_factory(order, 1000);
        println!("{}: {:?}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);
        
        // Car order #2: Used, Convertible
        order = order + 1;
        car = car_factory(order, 2000);
        println!("{}: {:?}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);    

        // Car order #3: New, Hard top
        order = order + 1;
        car = car_factory(order, 0);
        println!("{}: {:?}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);

        // Car order #4: New, Convertible
        order = order + 1;
        car = car_factory(order, 0);
        println!("{}: {:?}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);

        // Car order #5: Used, Hard top
        order = order + 1;
        car = car_factory(order, 3000);
        println!("{}: {:?}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);

        // Car order #6: Used, Hard top
        order = order + 1;
        car = car_factory(order, 4000);
        println!("{}: {:?}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);
    }
    ```

1. Build the program. Make sure the code compiles and runs before you continue to the next section.

You should see the following output:

```output
1: Used, Hard top = true, Manual, Blue, 1000 miles
2: Used, Hard top = false, SemiAuto, Green, 2000 miles
3: New, Hard top = true, Automatic, Red, 0 miles
4: New, Hard top = false, SemiAuto, Silver, 0 miles
5: Used, Hard top = true, Manual, Blue, 3000 miles
6: Used, Hard top = true, Automatic, Green, 4000 miles
```


## Add a hash map to track order details

The current program fulfills each car order and prints a summary after each order is complete. Each call to the `car_factory` function fulfills an order by returning a `Car` struct with the order details. The result is stored in the `car` variable. 

As you probably noticed, the program lacks some important functionality. We aren't keeping track of all orders. The `car` variable holds only the details for the current order. Whenever the `car` variable is updated with the result from the `car_factory` function, details for the previous order are overwritten. 

We need to update the program to keep track of all the orders like in a filing system. For this purpose, we'll define a hash map with \<K, V> pairs. The hash map keys will correspond to the car order numbers. The hash map values will be the order details for each as defined in a `Car` struct.

1. To define the hash map, add the following code at the beginning of the `main` function, right after the opening curly brace `{`:

    ```rust
        // Initialize a hash map for the car orders
        // - Key: Car order number, i32
        // - Value: Car order details, Car struct
        use std::collections::HashMap;
        let mut orders: HashMap<i32, Car> = HashMap;
    ```

1. Fix the syntax issues in the statement that creates the `orders` hash map.

    > [!Tip]
    > You're creating a hash map from scratch, so you probably want to use the `new()` method.

1. Build the program. Make sure the code compiles before you continue to the next section. You can ignore warning messages from the compiler.


## Add values to the hash map

The next step is to add each fulfilled car order to the hash map. 

In the `main` function, we call the `car_factory` function for each car order. After the order is fulfilled, we call the `println!` macro to show the order details stored in the `car` variable:

```rust
    // Car order #1: Used, Hard top
    car = car_factory(order, 1000);
    println!("{}: {}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);

    ...

    // Car order #6: Used, Hard top
    order = order + 1;
    car = car_factory(order, 4000);
    println!("{}: {}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);
```

We're going to revise these code statements to work with our new hash map:

- We'll keep the calls to the `car_factory` function. Each returned `Car` struct will be stored as part of the \<K, V> pair in the hash map.
- We'll update the calls to the `println!` macro to show the order details as they're stored in the hash map.

1. In the `main` function, locate the calls to the `car_factory` function, and the accompanying calls to the `println!` macro:

    ```rust
        // Car order #1: Used, Hard top
        car = car_factory(order, 1000);
        println!("{}: {}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);

        ...

        // Car order #6: Used, Hard top
        order = order + 1;
        car = car_factory(order, 4000);
        println!("{}: {}, Hard top = {}, {:?}, {}, {} miles", order, car.age.0, car.roof, car.motor, car.color, car.age.1);
    ```

1. Replace the full set of statements for all car orders with the following revised code:

    ```rust
        // Car order #1: Used, Hard top
        car = car_factory(order, 1000);
        orders(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));
        
        // Car order #2: Used, Convertible
        order = order + 1;
        car = car_factory(order, 2000);
        orders(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));
    
        // Car order #3: New, Hard top
        order = order + 1;
        car = car_factory(order, 0);
        orders(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));

        // Car order #4: New, Convertible
        order = order + 1;
        car = car_factory(order, 0);
        orders(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));

        // Car order #5: Used, Hard top
        order = order + 1;
        car = car_factory(order, 3000);
        orders(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));

        // Car order #6: Used, Hard top
        order = order + 1;
        car = car_factory(order, 4000);
        orders(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));
    ```
    
1. If you try to build your program now, you'll see compilation errors. There's a syntax problem in the statements that add the \<K, V> pairs to the `orders` hash map. Do you see the problem? Go ahead and fix the issue in each statement that adds an order to the hash map.

    > [!Tip]
    > We can't assign values to the `orders` hash map directly. We need to use a method to do the insertions.


## Run the program

After your program builds successfully, you should see the following output:

```output
Car order 1: Some(Car { color: "Blue", motor: Manual, roof: true, age: ("Used", 1000) })
Car order 2: Some(Car { color: "Green", motor: SemiAuto, roof: false, age: ("Used", 2000) })
Car order 3: Some(Car { color: "Red", motor: Automatic, roof: true, age: ("New", 0) })
Car order 4: Some(Car { color: "Silver", motor: SemiAuto, roof: false, age: ("New", 0) })
Car order 5: Some(Car { color: "Blue", motor: Manual, roof: true, age: ("Used", 3000) })
Car order 6: Some(Car { color: "Green", motor: Automatic, roof: true, age: ("Used", 4000) })
```

Notice the output for the revised code is different. The `println!` macro displays the contents of the `Car` struct by showing each value and the corresponding field name.

In the next exercise, we'll use loop expressions to reduce the redundancy in the code.


## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=1beae42faca82582685832194ee83195?azure-portal=true

[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=a33ead60a515eb2de50334c6b85d3858?azure-portal=true

