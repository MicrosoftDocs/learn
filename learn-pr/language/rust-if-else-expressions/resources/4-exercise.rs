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
// - roof (boolean, true if the car has a hard top roof)
// - miles (u32)
// Call the car_quality(miles) function to get the car age
// Return an instance of a "Car" struct with the arrow `->` syntax
fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {

    // Use an if/else conditional expression to describe the car to build
    // - Call the car_quality(miles) function to help identify if the order is for a new or used car
    // TO DO:
    // - As part of the call, set the "quality" variable to the first element of the returned value
    // - Modify the first "if" condition to check if the order is for a used car
    // - Modify both "if" conditions for the "roof" to check if the order is for a hard top
    let quality = car_quality(miles);
    if <the ordered car is Used> {
        if <the ordered roof is a hard top> {
            println!("Preparing a used car: {:?}, {}, Hard top", motor, color);
        } else {
            println!("Preparing a used car: {:?}, {}, Convertible", motor, color);
        }
    } else <the ordered car is New> {
        if <the ordered roof is a hard top> {
            println!("Building a new car: {:?}, {}, Hard top", motor, color);
        } else {
            println!("Building a new car: {:?}, {}, Convertible", motor, color);
        }
    }

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

    // Initialize counter variable
    let mut order = 1;
    
    // Declare the car type and initial values
    // TO DO: Create "car" as a "Car" struct
    // TO DO: Create "engine" as a "Transmission" enum
    // TO DO: Initialize "roof" to the value when the car has a hard top
    let mut car: Car;
    let mut miles = 1000; // Start used cars with 1,000 miles
    let mut engine: Transmission;
    let roof = true;      // convertible = false | hard top = true
    
    //////////////////////////////////////////////////

    // Order 3 cars, one car for each type of transmission
    // Use "order" variable, initialize to 0, increment before each order
    // TO DO: Fix indexing into `colors` array, vary the color for each order
    
    // Car order #1: Used
    engine = Transmission::Manual;
    car = car_factory(colors().to_string(), engine, roof, miles);
    println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
    
    // Car order #2: Used
    order = order + 1;
    miles = miles + 1000;
    // TO DO: Adjust the Transmission value syntax
    engine = Transmission.SemiAuto;
    car = car_factory(colors().to_string(), engine, roof, miles);
    println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
 
    // Car order #3: New
    order = order + 1;
    // TO DO: Adjust the miles so the order is for a New car
    miles = ??;
    engine = Transmission::Automatic;
    car = car_factory(colors().to_string(), engine, roof, miles);
    println!("{}: {}, Hard top, {:?}, {}, {} miles", order, car.age.0, car.motor, car.color, car.age.1);
}