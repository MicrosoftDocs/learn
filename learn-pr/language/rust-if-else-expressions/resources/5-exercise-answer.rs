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

    // Corrected code: Check if car has accumulated miles
    // Corrected code: Return tuple early for Used car
    if miles > 0 {
        return (Age::Used, miles);
    }
    
    // Corrected code: Return tuple for New car, no need for "return" keyword or semicolon
    (Age::New, miles)
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
    // Corrected code: If order is for Used car, check roof type, print details
    // Corrected code: Else, order is for New car, check roof tye, print details
    // Call the `println!` macro to show the car order details
    if quality == Age::Used {
        if roof {
            println!("Preparing a used car: {:?}, {}, Hard top, {} miles", motor, color, miles);
        } else {
            println!("Preparing a used car: {:?}, {}, Convertible, {} miles", motor, color, miles);
        }
    } else {
        if roof {
            println!("Building a new car: {:?}, {}, Hard top, {} miles", motor, color, miles);
        } else {
            println!("Building a new car: {:?}, {}, Convertible, {} miles", motor, color, miles);
        }
    }

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

//////////////////////////////////////////////////

fn main() {
    // Car order #1: New, Manual, Hard top
    car_factory(String::from("Orange"), Transmission::Manual, true, 0);
    
    // Car order #2: Used, Semi-automatic, Convertible
    car_factory(String::from("Red"), Transmission::SemiAuto, false, 565);

    // Car order #3: Used, Automatic, Hard top
    car_factory(String::from("White"), Transmission::Automatic, true, 3000);
}
