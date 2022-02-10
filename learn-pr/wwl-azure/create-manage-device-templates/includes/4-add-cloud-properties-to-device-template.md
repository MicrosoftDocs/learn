Use cloud properties to store information about devices in IoT Central. Cloud properties are never sent to a device. For example, you can use cloud properties to store the name of the customer who has installed the device, or the device's last service date.

The following table shows the configuration settings for a cloud property:

:::row:::
  :::column:::
    **Field**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display Name
  :::column-end:::
  :::column:::
    The display name for the cloud property value used on dashboards and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    The name of the cloud property. IoT Central generates a value for this field from the display name, but you can choose your own value if necessary.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Semantic Type
  :::column-end:::
  :::column:::
    The semantic type of the property, such as temperature, state, or event. The choice of semantic type determines which of the following fields are available.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schema
  :::column-end:::
  :::column:::
    The cloud property data type, such as double, string, or vector. The available choices are determined by the semantic type.
  :::column-end:::
:::row-end:::
