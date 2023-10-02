Use cloud properties to store information about devices in IoT Central. Cloud properties are never sent to a device. For example, you can use cloud properties to store the name of the customer who has installed the device, or the device's last service date.

:::image type="content" source="../media/cloud-property.png" alt-text="Screenshot that shows a cloud property in a device template.":::

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
    Display name
  :::column-end:::
  :::column:::
    The display name for the cloud property value used on views and forms.
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
    Semantic type
  :::column-end:::
  :::column:::
    The semantic type of the property, such as none or state. The choice of semantic type determines which of the following fields are available.
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
:::row:::
  :::column:::
    Unit
  :::column-end:::
  :::column:::
    A unit for the cloud property value, such as **mph**, **%**, or **°C**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display unit
  :::column-end:::
  :::column:::
    A display unit for use on views and forms.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Comment
  :::column-end:::
  :::column:::
    Any comments about the cloud property capability.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Description
  :::column-end:::
  :::column:::
    A description of the cloud property capability.
  :::column-end:::
:::row-end:::
