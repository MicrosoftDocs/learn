

One of the most important principles of object-oriented programming is that a class should encapsulate its internal state and implementation. One of the ways you can achieve encapsulation is to ensure that you always define fields that are used to store data as private, so they can't be accessed from outside the class. However, in some circumstances you might need to access the variables in a class. The solution to this problem is to define properties that provide controlled access to the field values.

## What is a property?

A property is a class member that provides a flexible mechanism to read, write, or compute the values of a variable. You can use properties as though they're public data members. However, they're special methods named accessors.

## Define properties

A property is a named block of code that can contain both a `get` accessor and a `set` accessor, as follows:

- The get accessor must return a value of the specified data type
- The set accessor receives a value parameter, indicating the new value for the property as passed in by the client code

The general syntax for properties is as follows:

```csharp
access-modifier return-type property-name
{
   get { code to return a value }
   set { code to use the implicit value parameter to set a value }
}
```

The following example shows you how to define a _houseStyle and _sqrFootage property in the House class. The property is public, and encapsulates access to the _houseStyle and _sqrFootage fields in the class. The term encapsulate is used here because the use of a property to access these values protects, or encapsulates, them.

```csharp
public class House
{
   private string _houseStyle;
   private int _sqrFootage;
   public int styleName
   {
       get { return _styleName; }
       set { _styleName = value; }
   }

   public int sqrFootage
   {
       get { return _sqrFootage; }
       set { _sqrFootage = value; }
   }

}
```

## Properties without Fields

As another point of interest, it's also possible to declare a property that doesn't require a field. For example, you could declare a property called DayOfWeek, which returns the current day of the week. This value is calculated behind the scenes and doesn't require a field.

```csharp
public integer DayOfWeek
{
   get { return Today.DayOfWeek;}
}
```