In this exercise, you'll add if/else test conditions to the car factory program to assign values based on expression results.

We'll revise the `car_quality` function to identify to the caller whether the ordered car is "New" or "Used." We'll add a conditional expression to check the mileage and update how the tuple value is assigned. In the `car_factory` function, we'll use several if/else expressions to control program flow and output.

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:

- Copy the code and edit it in your local development environment.
- Open the code in a prepared Rust Playground.

> [!Note]
> In the sample code, look for the `todo!` macro. This macro indicates code that needs to be completed or updated.

## Get the sample code

Start by opening the existing sample code in an editor.

1. Copy the following code and edit it in your local development environment, or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    #[derive(PartialEq, Debug)]
    // Declare Car struct to describe vehicle with four named fields
    struct Car { color: String, motor: Transmission, roof: bool, age: (Age, u32) }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission { Manual, SemiAuto, Automatic }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car age
    enum Age { New, Used }

    //////////////////////////////////////////////////

    // Get the car quality by testing the value of the input argument
    // - miles (u32)
    // Return tuple with car age ("New" or "Used") and mileage
    fn car_quality (miles: u32) -> (Age, u32) {

        todo!("Add conditional expression: If car has accumulated miles, return tuple for Used car with current mileage");
        
        todo!("Return tuple for New car with zero miles");
    }

    //////////////////////////////////////////////////

    // Build a new "Car" using the values of four input arguments
    // - color (String)
    // - motor (Transmission enum)
    // - roof (boolean, true if the car has a hard top roof)
    // - miles (u32)
    // Call the car_quality(miles) function to get the car age
    // Return an instance of a "Car" struct with the arrow `->` syntax
    fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {

        // Show details about car order
        // - Check if order is for Used or New car, then check the roof type 
        // - Print details for New or Used car based on roof type
        todo!("Add conditional expression: If car is Used age, then check roof type");
            todo!("Add conditional expression: If roof is a hard top, print details");
                // Call the `println!` macro to show the car order details
                println!("Prepare a used car: {:?}, {}, Hard top, {} miles\n", motor, color, miles);  

        // Create a new "Car" instance as requested
        // - Bind first three fields to values of input arguments
        // - Bind "age" to tuple returned from car_quality(miles)
        Car {
            color: color,
            motor: motor,
            roof: roof,
            age: car_quality(miles)
        }
    }

    fn main() {
        // Car order #1: New, Manual, Hard top
        car_factory(String::from("Orange"), Transmission::Manual, true, 0);
        
        // Car order #2: Used, Semi-automatic, Convertible
        car_factory(String::from("Red"), Transmission::SemiAuto, false, 565);

        // Car order #3: Used, Automatic, Hard top
        car_factory(String::from("White"), Transmission::Automatic, true, 3000);
    }
    ```

1. Build the program. Make sure the code compiles before you continue to the next section.

    The code doesn't display any output yet, but it needs to compile without any errors. You can ignore *warning* messages from the compiler. The warnings are because you declared enum and struct definitions, but haven't used them yet.

## Update the car_quality function

The `car_quality` function takes car mileage as an input argument. In the previous exercise, we created a tuple named `quality` for a "New" car with zero miles, and returned the tuple to the calling function.

We'll update the function to use a conditional expression to check the mileage and set the tuple based on the condition. Rather than storing the tuple in a declared variable, we'll send the correct tuple back to the calling function.

1. Add an `if/else` conditional expression to check if the ordered car can have accumulated miles. Return the correct tuple value based on the result of the condition.

    ```rust
        todo!("Add conditional expression: If car has accumulated miles, return tuple for Used car with current mileage");
    ```

    > [!Tip]
    > When the car has accumulated miles, we can return the tuple value early to the calling function.

1. When the car order is for a "New" car, the returned tuple value has mileage set to 0.

    ```rust
        todo!("Return tuple for New car with zero miles");
    ```

1. Build the program. Make sure the code compiles before you continue to the next section.

## Update the car_factory function

Now we'll update the `car_factory` function. Use an if/else conditional expression to describe the car to build and display the results. The expression checks if the order is for a new or used car, and also determines the roof type.

1. Add an `if/else` conditional expression to check if the order is for a new or used car, and then check the `roof` type. Print the details of the ordered car.

    ```rust
        // Show details about car order
        // - Check if order is for Used or New car, then check the roof type 
        // - Print details for New or Used car based on roof type
        todo!("Add conditional expression: If car is Used age, then check roof type");
            todo!("Add conditional expression: If roof is a hard top, print details");
                // Call the `println!` macro to show the car order details
                println!("Prepare a used car: {:?}, {}, Hard top, {} miles\n", motor, color, miles);                
    ```

    > [!Tip]
    > You can check the value of the `quality` variable and use the *is equal to* operator `==`.

1. Build your program. Make sure the code compiles without any errors. You can ignore any warning messages.

## Run the program

When the program is complete, you should see output similar to this example:

```output
Build a new car: Manual, Orange, Hard top, 0 miles
Prepare a used car: SemiAuto, Red, Convertible, 565 miles
Prepare a used car: Automatic, White, Hard top, 3000 miles
```

## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].

<!-- Links -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=a40675affa0ba94e277c9130c3718138?azure-portal=true

[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=69aebf7d2872c8803fe09568aed15a12?azure-portal=true
