Inheritance-based polymorphism is based on a class hierarchy where derived classes inherit behavior and properties from a base class. The inheritance relationship enables you to treat objects of derived classes as objects of the base class. Being able to treat derived class objects as base class objects enables you to write code that works with multiple types of objects without knowing the specific type at compile time.

The following code sample demonstrates inheritance-based polymorphism in C#:

```csharp

// Base class
public class Animal
{
    public virtual void MakeSound()
    {
        Console.WriteLine("The animal makes a sound.");
    }
}

// Derived class Dog
public class Dog : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("The dog barks.");
    }
}

// Derived class Cat
public class Cat : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("The cat meows.");
    }
}

// Derived class Cow
public class Cow : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("The cow moos.");
    }
}

class Program
{
    static void Main()
    {
        // Create an array of Animal objects
        Animal[] animals = new Animal[3];

        Animal animal1 = new Dog();
        Animal animal2 = new Cat();
        Animal animal3 = new Cow();

        animals[0] = animal1;
        animals[1] = animal2;
        animals[2] = animal3;

        // Demonstrate polymorphism
        foreach (Animal animal in animals)
        {
            animal.MakeSound();
        }
    }
}

```

In this sample code, notice that the `Program` class creates an array of `Animal` objects and assigns instances of `Dog`, `Cat`, and `Cow` to the array elements. The `MakeSound` method is called on each object in the array, demonstrating polymorphism. The `MakeSound` method is overridden in the derived classes to provide specific behavior for each animal type.

## Cast an object of a base class to a derived class

Casting in C# is the process of converting an object of one type to another type. Casting is often used when implementing polymorphism using inheritance hierarchies, where you have a base class and one or more derived classes.

There are two main types of casting:

- Implicit Casting: This occurs automatically when converting a derived class to a base class. It is safe because every instance of a derived class is also an instance of the base class.

    ```csharp

    BankAccount account = new CheckingAccount();

    ```

- Explicit Casting: This requires a cast operator and is used when converting a base class to a derived class. It's not always safe because not every instance of a base class is an instance of the derived class.

    ```csharp

    CheckingAccount checkingAccount = (CheckingAccount)account;

    ```

### Cast objects by using the `is` and `as` keywords

- Using the `is` keyword with pattern matching:


    ```csharp

    if (account is CheckingAccount checkingAccount)
    {
    // Use checkingAccount as a CheckingAccount
    }

    ```

    - This syntax checks if `account` is of type `CheckingAccount`.
    - If the check is successful, it casts `account` to `CheckingAccount` and assigns it to the variable `checkingAccount`.
    - This approach is concise and safe, as it combines the type check and cast in one step.

- Using the `is` keyword followed by explicit casting:

    ```csharp

    if (account is CheckingAccount)
    {
    CheckingAccount checkingAccount = (CheckingAccount)account;
    // Use checkingAccount as a CheckingAccount
    }

    ```
	- This syntax checks if `account` is of type `CheckingAccount`.
    - If the check is successful, it explicitly casts `account` to `CheckingAccount` and assigns it to the variable `checkingAccount`.
    - This approach is more verbose than the pattern matching syntax but provides more control over the casting process.

- Using the `as` keyword:


    ```csharp

    CheckingAccount checkingAccount = account as CheckingAccount;

    if (checkingAccount != null)
    {
    // Use checkingAccount as a CheckingAccount
    }

    ```
    - This syntax attempts to cast `account` to `CheckingAccount` and assigns the result to `checkingAccount`.
    - If the cast is successful, `checkingAccount` contains the cast object; otherwise, it is null.
    - This approach is useful when you want to check the cast result before using the cast object. For example, when you want to avoid exceptions and handle the failure case gracefully.

- When implementing casting, consider the following guidelines:

    - ​Using pattern matching with `is`: Combines type check and cast in one step.
    - Using the `is` keyword with explicit cast: Separates type check and cast into two steps, providing more control over the casting process.
    - Using the `as` keyword: Attempts cast and handles failure gracefully by returning null.

Understanding these casting techniques is essential for working with polymorphism and inheritance in C#.

## Avoid common pitfalls when implementing polymorphism

When your goal is inheritance-based polymorphism, here are some things to avoid and some things to ensure:

- Avoid using sealed classes and methods: Sealed classes and methods can't be inherited or overridden, which limits the ability to use polymorphism. If you seal a class or method, you prevent further extension and customization. For example:

    ```csharp
    public sealed class BankAccount { } // This class can't be inherited
    ```

- Avoid overusing static methods. Static methods belong to the class itself rather than an instance of the class. They can't be overridden, which means they do not participate in polymorphism.

    ```csharp
    public static void PrintMessage() { } // This method can't be overridden
    ```

- Avoid tight coupling. Tight coupling occurs when classes or components in a system are highly dependent on each other. This means that changes in one class can directly affect other classes, making the system less flexible and harder to maintain. Tight coupling can lead to difficulties in testing, extending, and modifying the code.

    ```csharp
    public class BankAccount
    {
        public void TransferFunds(SavingsAccount savingsAccount)
        {
            // Tight coupling with SavingsAccount
        }
    }
    ```

- Avoid using the 'new' keyword without a good reason. The 'new' keyword hides the base class method in the derived class, which can lead to confusion and unexpected behavior. Only use the 'new' keyword when you intend to hide the base class method intentionally.

    ```csharp
    public class Dog : Animal
    {
        public new void MakeSound() // Hides the base class method. Better to use 'override'
        {
            Console.WriteLine("The dog barks.");
        }
    }
    ```

- Ensure consistent method signatures. Ensure that overridden methods in derived classes have the same signature as the base class method. Changing the method signature will result in method hiding rather than overriding.

    ```csharp

    public class Animal
    {
        public virtual void MakeSound(string sound)
        {
            Console.WriteLine("The animal makes a sound.");
        }
    }

    public class Dog : Animal
    {
        // Method signature doesn't match the base class
        public override void MakeSound()
        {
            Console.WriteLine("The dog barks.");
        }
    }

    ```

## Summary

Inheritance-based polymorphism in C# allows you to create a hierarchy of classes where derived classes inherit behavior and properties from a base class. This inheritance mechanism enables you to treat objects of derived classes as objects of the base class. The ability to treat derived class objects as members of a base class allows you to write code that works with multiple types of objects without knowing the specific type at compile time. By understanding casting techniques, avoiding common pitfalls, and following best practices, you can effectively implement polymorphism in your C# applications.
