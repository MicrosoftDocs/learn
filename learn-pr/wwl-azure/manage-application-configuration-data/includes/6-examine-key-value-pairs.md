
Azure App Configuration stores configuration data as key-value pairs.

## Keys

Keys serve as the name for key-value pairs and are used to store and retrieve corresponding values.

It's common to organize keys into a hierarchical namespace by using a character delimiter, such as `/` or `:`. Use a convention that's best suited for your application.

App Configuration treats keys as a whole. It doesn't parse keys to figure out how their names are structured or enforce any rule on them.

Keys stored in App Configuration are case-sensitive, Unicode-based strings.

The keys *app1* and *App1* are distinct in an App Configuration store.

When you use configuration settings within an application, keep it in mind because some frameworks handle configuration keys case-insensitively.

You can use any Unicode character in key names entered into App Configuration except for `*`, `,`, and `\`.

These characters are reserved. If you need to include a reserved character, you must escape it by using `\{Reserved Character}`.

There's a combined size limit of 10,000 characters on a key-value pair.

This limit includes all characters in the key, its value, and all associated optional attributes.

Within this limit, you can have many hierarchical levels for keys.

### Design key namespaces

There are two general approaches to naming keys used for configuration data: flat or hierarchical.

These methods are similar from an application usage standpoint, but hierarchical naming offers several advantages:

 -  Easier to read. Instead of one long sequence of characters, delimiters in a hierarchical key name function as spaces in a sentence.
 -  Easier to manage. A key name hierarchy represents logical groups of configuration data.
 -  Easier to use. It's simpler to write a query that pattern-matches keys in a hierarchical structure and retrieves only a portion of configuration data.

Below are some examples of how you can structure your key names into a hierarchy:

 -  Based on component services
    
    ```
    AppName:Service1:ApiEndpoint
    AppName:Service2:ApiEndpoint
    
    ```
 -  Based on deployment regions
    
    ```
    AppName:Region1:DbEndpoint
    AppName:Region2:DbEndpoint
    
    ```

### Label keys

Key values in App Configuration can optionally have a label attribute.

Labels are used to differentiate key values with the same key.

A key *app1* with labels *A* and *B* forms two separate keys in an App Configuration store.

By default, the label for a key value is empty or null.

Label provides a convenient way to create variants of a key. A common use of labels is to specify multiple environments for the same key:

```
Key = AppName:DbEndpoint & Label = Test
Key = AppName:DbEndpoint & Label = Staging
Key = AppName:DbEndpoint & Label = Production

```

### Version key values

App Configuration doesn't version key values automatically as they're modified.

Use labels as a way to create multiple versions of a key value.

For example, you can input an application version number or a Git commit ID in labels to identify key values associated with a particular software build.

### Query key values

Each key value is uniquely identified by its key plus a label that can be `null`. You query an App Configuration store for key values by specifying a pattern.

The App Configuration store returns all key values that match the pattern and their corresponding values and attributes.

## Values

Values assigned to keys are also Unicode strings. You can use all Unicode characters for values.

There's an optional user-defined content type associated with each value.

Use this attribute to store information, for example, an encoding scheme, about a value that helps your application process it properly.

Configuration data stored in an App Configuration store, which includes all keys and values, is encrypted at rest and in transit.

App Configuration isn't a replacement solution for Azure Key Vault. Don't store application secrets in it.
