Finalizers (historically referred to as destructors) are used to perform any necessary final clean-up when a class instance is collected by the garbage collector (GC). In most cases, you can avoid writing a finalizer by using the `System.Runtime.InteropServices.SafeHandle` or derived classes to wrap any unmanaged handle.

Some things to keep in mind when using finalizers:

- Finalizers can't be defined in `struct` types. They're only used with classes.
- A class can only have one finalizer.
- Finalizers can't be inherited or overloaded.
- Finalizers can't be called. They're invoked automatically.
- A finalizer doesn't take modifiers or have parameters.

## Syntax of a finalizer

In C#, a finalizer is defined using a tilde (`~`) followed by the class name. It doesn't take any parameters and can't be called explicitly.

```csharp

class Car
{
    ~Car()  // finalizer
    {
        // cleanup statements...
    }
}

```

A finalizer can also be implemented as an expression body definition, as the following example shows.

```csharp

public class Destroyer
{
   public override string ToString() => GetType().Name;

   ~Destroyer() => Console.WriteLine($"The {ToString()} finalizer is executing.");
}

```

### Relationship between garbage collection and finalizers

The garbage collector in .NET automatically manages the allocation and release of memory for managed objects. When an object is no longer referenced, the GC marks it for collection and eventually reclaims its memory. If a class has a finalizer, the GC calls the finalizer before reclaiming the object's memory. The finalizer allows the object to release any unmanaged resources it holds.

The finalization process typically involves the following steps:

- When the GC detects that an object with a finalizer is no longer reachable, it moves the object to a finalization queue.
- The finalizer thread executes the finalizer method.
- After the finalizer runs, the object is moved to the GC's `freachable` queue, where it's eligible for garbage collection in the next GC cycle.

### Example of a finalizer

```csharp
public class ResourceHolder
{
    // Unmanaged resource
    private IntPtr unmanagedResource;

    // Constructor
    public ResourceHolder()
    {
        // Allocate unmanaged resource
        unmanagedResource = /* allocate resource */;
    }

    // Finalizer
    ~ResourceHolder()
    {
        // Release unmanaged resource
        if (unmanagedResource != IntPtr.Zero)
        {
            // Free the resource
            /* free resource */
            unmanagedResource = IntPtr.Zero;
        }
    }
}
```

## Implement a dispose pattern with a finalizer

Interfaces like `IDisposable` and `IAsyncDisposable` are used to release resources deterministically. The `Dispose` method is called explicitly to release resources, while the finalizer acts as a safety net to ensure that resources are released even if `Dispose` isn't called.

> [!IMPORTANT]
> Creating and using interfaces is beyond the scope of this module. The use of `IDisposable` is described here to provide context for the "dispose" pattern. Training that provides an introduction to interfaces is available on the Microsoft Learn platform.

Keep the following points in mind when using finalizers:

- Finalizers are nondeterministic, meaning you can't predict when the finalizer runs. It depends on the GC's schedule. This behavior can lead to delays in releasing unmanaged resources.
- Finalizers can impact performance because objects with finalizers take longer to be collected.
- Implementing the `IDisposable` interface and the `Dispose` method for deterministic cleanup of resources is recommended. The `Dispose` method can be called explicitly to release resources, and the finalizer can be used as a safety net.

Here's an example of a class that implements the `IDisposable` interface and a finalizer:

```csharp
public class ResourceHolder : IDisposable
{
    // Unmanaged resource
    private IntPtr unmanagedResource;
    private bool disposed = false;

    // Constructor
    public ResourceHolder()
    {
        // Allocate unmanaged resource
        unmanagedResource = /* allocate resource */;
    }

    // Dispose method
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }

    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // Free other managed objects
            }

            // Free unmanaged resources
            if (unmanagedResource != IntPtr.Zero)
            {
                /* free resource */
                unmanagedResource = IntPtr.Zero;
            }

            disposed = true;
        }
    }

    // Finalizer
    ~ResourceHolder()
    {
        Dispose(false);
    }
}
```

In this example:

- The `Dispose` method is called to release resources deterministically.
- The finalizer calls `Dispose(false)` to release unmanaged resources if `Dispose` was not called.
- `GC.SuppressFinalize(this)` is used to prevent the finalizer from running if `Dispose` has already been called.
