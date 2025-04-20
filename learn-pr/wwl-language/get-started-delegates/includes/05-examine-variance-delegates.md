Variance in C# allows you to use more flexible method signatures with delegates. It enables you to assign methods to delegates even if their parameter types or return types are not exactly the same, as long as they follow certain rules. Variance is particularly useful when working with inheritance hierarchies.

## What is variance?

Variance is a concept in C# that allows you to use a more derived type than the one specified in a delegate or interface. It enables you to create more flexible and reusable code by allowing methods to be assigned to delegates even if their signatures do not match exactly.

There are two types of variance:

- Covariance: Allows a method to have a return type that is more derived than that defined in the delegate.
- Contravariance: Allows a method to accept parameters that are less derived than those in the delegate type.

Variance support includes generic and non-generic delegates.

## Variance with custom delegates

Custom delegates are user-defined delegate types. Variance can be applied to custom delegates to make them more flexible.

The following example demonstrates how to use variance with custom delegates:

```csharp

public class Animal { }
public class Dog : Animal { }

// Define a delegate that takes a Dog and returns an Animal
public delegate Animal AnimalDelegate(Dog dog);

// Method that matches the delegate signature
public static Animal GetAnimal(Dog dog) => new Animal();

// Method that uses covariance (returns a more derived type)
public static Dog GetDog(Dog dog) => new Dog();

// Method that uses contravariance (accepts a less derived type)
public static Animal GetAnimalFromAnimal(Animal animal) => new Animal();

public class Program
{
    public static void Main()
    {
        AnimalDelegate del;

        // Assign method with matching signature
        del = GetAnimal;
        Animal animal = del(new Dog());

        // Assign method with covariant return type
        del = GetDog;
        animal = del(new Dog());

        // Assign method with contravariant parameter type
        del = GetAnimalFromAnimal;
        animal = del(new Dog());
    }
}

```

In this example, `GetDog` can be assigned to `AnimalDelegate` because `Dog` is a more derived type than `Animal` (covariance). Similarly, `GetAnimalFromAnimal` can be assigned because `Animal` is a less derived type than `Dog` (contravariance).

## Variance with strongly-typed delegates

Variance also applies to strongly-typed delegates like `Action` and `Func`.

### Covariance with `Func`

The following example demonstrates covariance with `Func`:

```csharp

public class Person { }
public class Employee : Person { }

public static Employee FindEmployee(string title) => new Employee();

public class Program
{
    public static void Main()
    {
        // Func<string, Person> can hold a method that returns Employee
        Func<string, Person> func = FindEmployee;
        Person person = func("Manager");
    }
}

```

In this example, `FindEmployee` returns an `Employee`, which is more derived than `Person`, so it can be assigned to `Func<string, Person>`.

### Contravariance with `Action`

The following example demonstrates contravariance with `Action`:

```csharp

public class Animal { }
public class Dog : Animal { }

public static void HandleAnimal(Animal animal) { }

public class Program
{
    public static void Main()
    {
        // Action<Dog> can hold a method that takes Animal
        Action<Dog> action = HandleAnimal;
        action(new Dog());
    }
}

```

Here, `HandleAnimal` accepts an `Animal`, which is less derived than `Dog`, so it can be assigned to `Action<Dog>`.

## Variance in generics

Variance can also be applied to generic type parameters using the `in` and `out` keywords.

### Covariant generic type

The `out` keyword is used to declare a covariant generic type parameter. This allows you to use a more derived type as a return type.

The following example demonstrates covariance in generics:

```csharp

public interface ICovariant<out T> { T Get(); }

public class Animal { }
public class Dog : Animal { }

public class CovariantExample : ICovariant<Dog>
{
    public Dog Get() => new Dog();
}

public class Program
{
    public static void Main()
    {
        ICovariant<Animal> covariant = new CovariantExample();
        Animal animal = covariant.Get();
    }
}


```

In this example, `ICovariant<out T>` allows `ICovariant<Dog>` to be assigned to `ICovariant<Animal>` because `Dog` is more derived than `Animal`.

### Contravariant generic type

The `in` keyword is used to declare a contravariant generic type parameter. This allows you to use a less derived type as a parameter type.

The following example demonstrates contravariance in generics:

```csharp

public interface IContravariant<in T> { void Set(T value); }

public class Animal { }
public class Dog : Animal { }

public class ContravariantExample : IContravariant<Animal>
{
    public void Set(Animal value) { }
}

public class Program
{
    public static void Main()
    {
        IContravariant<Dog> contravariant = new ContravariantExample();
        contravariant.Set(new Dog());
    }
}

```

Here, `IContravariant<in T>` allows `IContravariant<Animal>` to be assigned to `IContravariant<Dog>` because `Animal` is less derived than `Dog`.

## Key points

- Variance allows you to use more flexible method signatures with delegates.
- Covariance allows a method to have a return type that is more derived than that defined in the delegate.
- Contravariance allows a method to accept parameters that are less derived than those in the delegate type.
- Custom and strongly-typed delegates can use variance to be more flexible.
- Generics can use variance with the `in` and `out` keywords to declare contravariant and covariant generic type parameters.
