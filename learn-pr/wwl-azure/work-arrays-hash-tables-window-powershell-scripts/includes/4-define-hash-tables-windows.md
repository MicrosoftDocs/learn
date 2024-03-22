A hash table represents a similar concept to an array since it stores multiple items. However, unlike an array which uses an index number to identify each item, a hash table uses for this purpose a unique key. The _key_ is a string that's a unique identifier for the item. Each key in a hash table is associated with a value.

The following table depicts how an array can store a list of IP addresses.

*Table 1: How an array stores a list of IP addresses*

| Index number | Value       |
| ------------ | ----------- |
| 0            | 172.16.0.10 |
| 1            | 172.16.0.11 |
| 2            | 172.16.0.40 |

If the array is named `$ip`, then you access the first item in the array by using:

```powershell
$ip[0]
```

You can use a hash table to store both IP addresses and the computer names as the following table depicts.

*Table 2: Using a hash table to store IP addresses and computer names*

| Key      | Value        |
| -------- | ------------ |
| LON-DC1  | 192.168.0.10 |
| LON-SRV1 | 192.168.0.11 |
| LON-SRV2 | 192.168.0.12 |

If the hash table is named `$servers`, then you access the first item in the hash table by using either of the following options:

```powershell
$servers.'LON-DC1'
$servers['LON-DC1']
```

> [!NOTE]
> You only need to use single quote marks to enclose keys that contain special characters. In the previous example, the hyphen in the computer names is a special character, which requires the key name to be enclosed in single quote marks.
