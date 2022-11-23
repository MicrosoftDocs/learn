When you run a command such as **Get-Process** on your local computer, the command returns object or objects of the type System.Diagnostics.Process and adds them to the Windows PowerShell pipeline. These objects have properties, methods, and frequently, events. Methods provide the ability to perform task. For example, the **Kill()** method of a Process object terminates the process that this object represents.

> [!NOTE]
> The process of converting an object into a form that can be readily transported is known as *serialization*. Serialization takes an object's state and transforms it into serial data format, such as XML or binary format. *Deserialization* converts the formatted XML or binary data into an object type.

When a command runs on a remote computer, that computer serializes the results in XML, and transmits that XML text to your computer. You do this to put the object’s information into a format that can be transmitted over a network. However, for complex objects the serialization process can use only static information about an object&mdash;in other words, its properties.

When your computer receives the XML, it's deserialized back into objects that are put in the Windows PowerShell pipeline. When you have a **Process** object, by piping it to **Get-Member**, you know it's now of the type **Deserialized.System.Diagnostics.Process**, a related, but different, kind of object. The deserialized object has no methods and no events.

Given the serialization and deserialization which is part of PowerShell remoting, you should consider any objects that are obtained in this manner to be a static snapshot. The values of object properties are not updatable, and the objects cannot be used to perform any actions. Therefore, any tasks that require interacting with remote objects should be performed on the remote computer as part of the PowerShell remoting session. 

For example, here is an example of a command that will not yield the desired results:

```powershell
Invoke-Command –Computer LON-DC1 –ScriptBlock { Get-Process –Name Note* } |
Stop-Process
```

In this example, you're retrieving Process objects, but the task of stopping processes takes place on the local computer rather than the remote one. This will result in stopping any local processes that happen to have the names matching the remote ones.

The proper way to accomplish the intended outcome would be to run:

```powershell
Invoke-Command –Computer LON-DC1 –ScriptBlock { Get-Process –Name Note* |
Stop-Process }
```

In this case, the processing has occurred entirely on the remote computer, with only the final results being serialized and sent back. The difference between these two commands is subtle but important to understand.
