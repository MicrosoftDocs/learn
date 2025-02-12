## Multiple Choice
What is a key benefit of using default implementations in interfaces?
(x) They allow for code reuse across different implementations. {{Correct. Default implementations enable sharing common functions across different classes without copying code, promoting code reuse.}}
( ) They automatically apply to all classes without any need for implementation. {{Incorrect. Classes must still implement the interface and can choose to use or override the default methods.}}
( ) They prevent any changes to the interface once defined. {{Incorrect. Default implementations actually allow adding new methods to interfaces without breaking existing implementations.}}

## Multiple Choice
What is the purpose of the IDisposable interface in C#?
(x) To release unmanaged resources. {{Correct. The IDisposable interface is used to release unmanaged resources, such as file handles and network connections.}}
( ) To compare objects. {{Incorrect. The IComparable interface is used for comparing objects, not releasing unmanaged resources.}}
( ) To iterate over collections. {{Incorrect. The IEnumerable interface is used for iterating over collections, not releasing unmanaged resources.}}

## Multiple Choice
What is the main advantage of using system-defined interfaces like IEnumerable and IDisposable in C#?
(x) They provide standard methods that ensure consistent behavior across different types. {{Correct. System-defined interfaces provide standard methods that can be implemented across different types, ensuring uniformity and predictability in behavior.}}
( ) They allow for the automatic generation of code. {{Incorrect. System-defined interfaces do not automatically generate code; they provide standard methods for consistent behavior.}}
( ) They prevent the need for any implementation in classes. {{Incorrect. Classes implementing system-defined interfaces must still provide implementations for the interface methods.}}
