## Multiple Choice
Which of the following is true about properties in an interface?
( ) They can have instance data fields. {{Incorrect. Properties in an interface do not declare instance data fields.}}
(x) They typically do not have a body. {{Correct. Interface properties typically do not have a body; they only define accessors.}}
( ) They must be static. {{Incorrect. Interface properties are not required to be static.}}

## Multiple Choice
You are implementing an interface in a class. What must you ensure?
(x) Provide public, non-static implementations for all interface members. {{Correct. When a class implements an interface, it must provide public, non-static implementations for all interface members.}}
( ) Provide private implementations for all interface members. {{Incorrect. Interface members must be implemented as public, not private.}}
( ) Provide static implementations for all interface members. {{Incorrect. Interface members should be implemented as non-static.}}

## Multiple Choice
In a scenario where you need to implement an interface in a class, what syntax is used?
(x) class ClassName : InterfaceName {{Correct. The correct syntax to implement an interface in a class is 'class ClassName : InterfaceName'.}}
( ) class ClassName implements InterfaceName {{Incorrect. The 'implements' keyword is not used in C#; the correct keyword is ':'.}}
( ) class ClassName extends InterfaceName {{Incorrect. The 'extends' keyword is not used in C#; the correct keyword is ':'.}}

## Multiple Choice
What is a key benefit of using interfaces in C# programming?
(x) They allow for better code organization and flexibility. {{Correct. Interfaces provide a way to define contracts for classes, enabling better code organization and flexibility.}}
( ) They allow classes to inherit from multiple base classes. {{Incorrect. Interfaces do not allow multiple inheritance of classes; they allow a class to implement multiple interfaces.}}
( ) They provide default implementations for all members. {{Incorrect. Interfaces may define default implementations for some members starting with C# 8.0, but this is not their primary benefit.}}