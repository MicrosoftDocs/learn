Now that we've covered the major design principles, let's see how easy it is to create a data warehouse in Azure. We'll use some sample data for exploration, but you can start building your own data warehouse by using the principles that are shown in this exercise.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account or if you prefer not to do the exercise in your account, you can read through the instructions to understand the steps that are involved in creating a data warehouse in Azure SQL Data Warehouse.

Complete these steps to create a data warehouse that contains the *AdventureWorksDW* sample data:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the upper-left corner, select **+ Create a resource**.

1. Select **Databases**, search for and select **Dedicated SQL pool (formerly SQL DW)** to start the creation process. The **Dedicated SQL pool (formerly SQL DW)** panel appears.

1. Select **Create**. The **Create dedicated SQL pool (formerly SQL DW)** panel appears.

1. On the **Basics** tab, entering the following values for each setting.

    | Setting  | Value |
    |---|---|
    | **Project details** |
    | Subscription | Name of the subscription you are using in this lab |
    | Resource group | Select **Create new**, and in the **Name** field, enter **mslearn-demodw**, and then select **OK**. |
    | **SQL pool details** |
    | SQL pool name | **sampleDataWH** |
    | Server | Select **Create new**. The **New server** panel appears. Enter the following values for each setting. |

    | Setting  | Value |
    |---|---|
    | Server name | **SQLServicexx**, where *xx* are your initials |
    | Server admin login | **dwdbadmin** |
    | Password | **Pa55w.rd** |
    | Location | Select a location near to you |
    | Allow Azure services to access server | *check* |

1. Select **OK**. The **Create dedicated SQL pool (formerly SQL DW)** panel reappears. Continue entering the following value.

    | Setting  | Value |
    |---|---|
    | Performance level | **Gen2** |

1. Select the **Additional settings** tab. Enter the following values for each setting.

    | Setting  | Value |
    |---|---|
    | **Data source** |
    | Use existing data | **Sample** |

1. Select **Review + create**, and then select **Create**. Deployment takes a few minutes.

You can monitor the deployment process through the notification ("bell") icon in the top bar - it will animate while the deployment is occurring. When the data warehouse is deployed, you have successfully created a SQL pool in Azure Synapse Analytics.
