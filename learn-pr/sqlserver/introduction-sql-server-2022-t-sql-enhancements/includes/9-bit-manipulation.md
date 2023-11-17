---
ms.custom:
  - build-2023
---
SQL Server 2022 introduces new functions for bit manipulation, making it easier to work with binary data. Common scenarios that benefit from bit manipulation could be Internet of Things (IoT) environments, cryptographic applications, data compression, and network protocols.

These functions provide a powerful and efficient way to manage binary data, helping to identify issues and make better decisions across different situations.

## GET_BIT

The `GET_BIT` function retrieves the value of a specific bit in a binary value. It's useful when accessing individual bits in binary data structures, such as sensor statuses in IoT systems.

## BIT_COUNT

The `BIT_COUNT` function counts the number of bits set to 1 in a binary value. It's helpful for analyzing data density or determining how many sensors have issues in a monitoring system.

## LEFT_SHIFT and RIGHT_SHIFT

The `LEFT_SHIFT` and `RIGHT_SHIFT` functions shift the bits of a binary value to the left or right by a specified number of positions. They're useful for operations like adding new sensors to existing data sets or dealing with data compression and network protocols.

## SET_BIT

The `SET_BIT` function sets the value of a specific bit in a binary value. It's useful for modifying particular bits in binary data structures, such as simulating sensor issues or toggling between different states in an IoT environment.

## Simplify bit manipulation is SQL queries with GET_BIT and BIT_COUNT

Imagine you're a DBA of a manufacturing company. The floor manager responsible for a network of IoT devices has approached you for help. They need to identify which sensors in which devices are experiencing issues. Your IoT database contains a DeviceSensorMonitor table that collects sensor status data from various devices. There are eight sensors per device, and the expected status for devices with no issues is 0x00. The table has the following values for devices that currently have issues:

DeviceId | CollectionDateTime | SensorStatus
---|---|---
235112 | 2/11/2023 12:51:22.421 | 0x42
412231 | 2/11/2023 12:51:31.860 | 0x80
795159 | 2/11/2023 12:51:48.592 | 0xFD
948705 | 2/11/2023 12:51:56.321 | 0x05

For this example, let's create the sample database, table and populate it. Obviously in a real world scenario, the database would already exist and automatically populated by your IoT devices. *Always make sure you use a test SQL Server to run these examples and don't run them on a production server*.

```sql
CREATE DATABASE SQL2022Workshop_BitDB;
GO
USE SQL2022Workshop_BitDB;
GO
CREATE TABLE DeviceSensorMonitor (DeviceId INT, CollectionDateTime DATETIME, SensorStatus VARBINARY(2));
GO
INSERT INTO DeviceSensorMonitor VALUES
(235112 , '2/11/2023 12:51:22.421' , 0x42),
(395862 , '2/11/2023 12:51:22.421' , 0x00),
(412231 , '2/11/2023 12:51:31.860' , 0x80),
(078930 , '2/11/2023 12:51:22.421' , 0x00),
(795159 , '2/11/2023 12:51:48.592' , 0xFD),
(009492 , '2/11/2023 12:51:22.421' , 0x00),
(948705 , '2/11/2023 12:51:56.321' , 0x05);
GO
```

Using the new bit manipulation functions in SQL Server 2022, you can easily check the status of each sensor, count the number of sensors with issues. You run the following queries in SQL Server Management Studio (SSMS) to get the data the floor manager needs.

```sql
SELECT DeviceId,
	SensorStatus,
    GET_BIT(SensorStatus, 7) AS Sensor8,
    GET_BIT(SensorStatus, 6) AS Sensor7,
    GET_BIT(SensorStatus, 5) AS Sensor6,
    GET_BIT(SensorStatus, 4) AS Sensor5,
    GET_BIT(SensorStatus, 3) AS Sensor4,
    GET_BIT(SensorStatus, 2) AS Sensor3,
    GET_BIT(SensorStatus, 1) AS Sensor2,
    GET_BIT(SensorStatus, 0) AS Sensor1,
	BIT_COUNT(SensorStatus) AS NumberOfIssues
FROM DeviceSensorMonitor
WHERE SensorStatus > 0x00
```

Let's cleanup the sample database we created.

```sql
USE tempdb;
GO
DROP DATABASE SQL2022Workshop_BitDB;
GO
```

Results:

DeviceId | SensorStatus | Sensor8 | Sensor7 | Sensor6 | Sensor5 | Sensor4 | Sensor3 | Sensor2 | Sensor1 | NumberOfIssues
---|---|---|---|---|---|---|---|---|---|---
235112 | 0x42 | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 2
412231 | 0x80 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1
795159 | 0xFD | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 7
948705 | 0x05 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 2

When you use these functions to real-world scenarios, such as monitoring sensor data in an IoT environment, we can quickly identify issues and make better-informed decisions. The addition of these functions to SQL Server 2022 makes it an even more powerful and versatile tool for managing and analyzing data.
