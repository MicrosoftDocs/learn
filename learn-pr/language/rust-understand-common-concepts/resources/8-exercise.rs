#[derive(PartialEq, Debug)]
// Declare Car struct to describe vehicle with four named fields
// TO DO: Replace "mileage" field from previous exercise with "age" field
// TO DO: "age" field should be tuple value of two fields: String, u32
struct Car {
    color: String,
    motor: Transmission,
    roof: bool,
    mileage: u32,
}

#[derive(PartialEq, Debug)]
// Declare enum for Car transmission type
enum Transmission { Manual, SemiAuto, Automatic }

//////////////////////////////////////////////////

// Get the car quality by testing the value of the input argument
// - miles (u32)
// Create a tuple for the car quality with the age ("New" or "Used") and miles
// Return a tuple with the arrow `->` syntax
fn car_quality (miles: u32) -> (String, u32) {

    // Declare and initialize the return tuple value
    // For a new car, set the miles to 0
    // TO DO: Correct the quality declaration so we can change the values later
    let mut quality: (String, u32) = ("New".to_string(), 0);

    // Use a conditional expression to check the miles
    // If the car has accumulated miles, then the car is used
    if miles > 0 {
        // TO DO: Add the code to set the quality value for a used car
        quality;
    }

    // TO DO: Return the completed tuple
    return 
}

//////////////////////////////////////////////////

// Build a new "Car" using the values of four input arguments
// - color (String)
// - motor (Transmission enum)
// - roof (boolean, true if the car has closed roof)
// - miles (u32)
// Call the car_quality(miles) function to get the car age
// Return an instance of a "Car" struct with the arrow `->` syntax
fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {

    // Create a new "Car" instance as requested
    // - Bind first three fields to values of input arguments
    // TO DO: Replace the "mileage" field from the previous exercise with an "age" field
    // TO DO: The "age" field calls the "car_quality" function with the "miles" input argument 
    let car = Car {
        color: color,
        motor: motor,
        roof: roof,
        mileage: miles
    };

    // Return new instance of "Car" struct
    return car
}

//////////////////////////////////////////////////

fn main() {
    // Create car color array
    // TO DO: Set the values: 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
    let colors;

    // Initialize variables
    let (mut index, mut order) = (1, 1);
    
    // Declare the car type and initial values
    // TO DO: Create "car" as a "Car" struct
    // TO DO: Create "engine" as a "Transmission" enum
    // TO DO: Initialize "roof" to the value when the car has a hard top
    let car = Car;
    let mut miles = 1000; // Start used cars with 1,000 miles
    let mut roof;  // convertible = false | hard top = true
    let engine = Transmission;
    
    //////////////////////////////////////////////////

    // Order 11 cars
    // TO DO: Replace "loop expression" - loop 11 times, use "order" variable
    loop expression {

        //////////////////////////////////////////////////

        // Set car transmission type
        engine = Transmission::Manual;

        // Order the cars, New are even numbers, Used are odd numbers
        // TO DO: Fix indexing into `colors` array, vary color for the orders
        if index % 2 != 0 {
            car = car_factory(colors().to_string(), engine, roof, miles);
        } else { 
            car = car_factory(colors().to_string(), engine, roof, 0);
        }

        //////////////////////////////////////////////////

        // Display car order details 
        println!("{}: {}, Closed roof, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
        
        //////////////////////////////////////////////////

        // Change values for next loop
        // TO DO: Increment "order" by 1, and "miles" by 1,000
        order;
        miles;
        
        // Adjust the index for the car details
        // Order 11 cars, use index range of 0 -- 4, then repeat from 0
        if index < 4 {
            index = index + 1;
        } else {
            index = 1;
        }
    }
}