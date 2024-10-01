To create a maintenance configuration schedule, specify the following PUT request:

<!--- raw content start --->
PUT on `/subscriptions/<subscriptionId>/resourceGroups/<resourceGroup>/providers/Microsoft.Maintenance/maintenanceConfigurations/<maintenanceConfigurationsName>?api-version=2021-09-01-preview`
<!--- raw content end --->

#### Request body

The following table describes the elements of the request body:

| **Property**                                    | **Description**                                                                                                                                                                                                                                                                                          |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ID                                              | Fully qualified identifier of the resource                                                                                                                                                                                                                                                               |
| location                                        | Gets or sets location of the resource                                                                                                                                                                                                                                                                    |
| name                                            | Name of the resource                                                                                                                                                                                                                                                                                     |
| properties.extensionProperties                  | Gets or sets extensionProperties of the maintenanceConfiguration                                                                                                                                                                                                                                         |
| properties.maintenanceScope                     | Gets or sets maintenanceScope of the configuration                                                                                                                                                                                                                                                       |
| properties.maintenanceWindow.duration           | Duration of the maintenance window in HH:mm format. The default value will be used based on maintenance scope provided. Example: 05:00.                                                                                                                                                                  |
| properties.maintenanceWindow.expirationDateTime | Effective expiration date of the maintenance window in YYYY-MM-DD hh:MM format. The window is created in the time zone provided to daylight savings according to the zone. You must set the expiration date to a future date. The default value will be set to the maximum datetime 9999-12-31 23:59:59. |
| properties.maintenanceWindow.recurEvery         | Rate at which a Maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules.                                                                                                                                                                               |
| properties.maintenanceWindow.startDateTime      | Effective start date of the maintenance window in YYYY-MM-DD hh:mm format. You can set the start date to either the current date or future date. The window will be created in the time zone provided and adjusted to daylight savings.                                                                  |
| properties.maintenanceWindow.timeZone           | Name of the timezone. You can obtain the list of timezones by executing \[System.TimeZoneInfo\]:GetSystemTimeZones() in PowerShell. Example: Pacific Standard Time, UTC, W. Europe Standard Time, Korea Standard Time, Central Australia Standard Time.                                                  |
| properties.namespace                            | Gets or sets namespace of the resource                                                                                                                                                                                                                                                                   |
| properties.visibility                           | Gets or sets the visibility of the configuration. The default value is 'Custom'                                                                                                                                                                                                                          |
| systemData                                      | Azure Resource Manager metadata containing createdBy and modifiedBy information.                                                                                                                                                                                                                         |
| tags                                            | Gets or sets tags of the resource                                                                                                                                                                                                                                                                        |
| type                                            | Type of the resource                                                                                                                                                                                                                                                                                     |

```azurecli
az maintenance configuration create \
    --resource-group myMaintenanceRG \
    --resource-name myConfig \
    --maintenance-scope InGuestPatch \
    --location eastus \
    --maintenance-window-duration "02:00" \
    --maintenance-window-recur-every "20days" \
    --maintenance-window-start-date-time "2022-12-30 07:00" \
    --maintenance-window-time-zone "Pacific Standard Time" \
    --install-patches-linux-parameters package-name-masks-to-exclude="ppt" package-name-masks-to-include="apt" classifications-to-include="Other" \
    --install-patches-windows-parameters kb-numbers-to-exclude="KB123456" kb-numbers-to-include="KB123456" classifications-to-include="FeaturePack" \
    --reboot-setting "IfRequired" \
    --extension-properties InGuestPatchMode="Use"
```
