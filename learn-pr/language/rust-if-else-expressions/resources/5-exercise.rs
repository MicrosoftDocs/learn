#[derive(PartialEq, Debug)]
// Declare Car struct to describe vehicle with four named fields
struct Car { color: String, motor: Transmission, roof: bool, age: (String, u32) }

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
    // TO DO: Correct the "quality" declaration so the value is changeable
    let mut quality: (String, u32) = (String::from("New"), miles);

    // TO DO: Add a conditional expression to check the miles
    // If the car has accumulated miles, then the car is used
    if <car has miles> {
        // TO DO: Set the "quality" value to a "Used" car
        quality;
    }

    // Return the completed tuple
    return quality
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

    // TO DO: Call the car_quality(miles) function to help identify if the order is for a new or used car
    // - As part of the call, set the "quality" variable to the first element of the returned value
    let quality = car_quality(miles);

    // TO DO: Use an if/else conditional expression to describe the car to build
    // - Modify the first "if" condition to check if the order is for a used car
    // - Modify both "if" conditions for the "roof" to check if the order is for a hard top
    if <the ordered car is Used> {
        if <the ordered roof is a hard top> {
            println!("Prepare a used car: {:?}, {}, Hard top, {} miles", motor, color, miles);
        } else {
            println!("Prepare a used car: {:?}, {}, Convertible, {} miles", motor, color, miles);
        }
    } else <the ordered car is New> {
        if <the ordered roof is a hard top> {
            println!("Build a new car: {:?}, {}, Hard top, {} miles", motor, color, miles);
        } else {
            println!("Build a new car: {:?}, {}, Convertible, {} miles", motor, color, miles);
        }
    }
    
    // Create a new "Car" instance as requested
    // - Bind first three fields to values of input arguments
    // - Bind "age" to tuple returned from car_quality(miles)
    let car = Car {
        color: color,
        motor: motor,
        roof: roof,
        age: car_quality(miles)
    };

    // Return new instance of "Car" struct, no semicolon needed
    return car
}

//////////////////////////////////////////////////

fn main() {
    // Car order #1: New, Manual, Hard top
    car_factory(String::from("Orange"), Transmission::Manual, true, 0);
    
    // Car order #2: Used, Semi-automatic, Convertible
    car_factory(String::from("Red"), Transmission::SemiAuto, false, 565);

    // Car order #3: Used, Automatic, Hard top
    car_factory(String::from("White"), Transmission::Automatic, true, 3000);
}