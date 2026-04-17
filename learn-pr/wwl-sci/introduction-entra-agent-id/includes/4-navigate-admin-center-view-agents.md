The Microsoft Entra admin center provides a centralized interface to view and manage your agent identities. This experience allows you to search, filter, sort, and take actions on agent identities across your organization.

## Prerequisites for viewing agent identities

To view agent identities in your Microsoft Entra tenant, you need:
- A Microsoft Entra user account

To manage agent identities, you need one of these roles:
- **Agent ID Administrator** role
- **Cloud Application Administrator** role

You can also be the owner of the specific agent identity you want to manage.

## Navigate to the agent identities list

To view agent identities in your tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com)
2. In the left-hand navigation pane, select **Entra ID** > **Agent ID** > **All agent identities**

This page displays a list of all agent identities in your organization, including both:
- **Agent identity objects**: Proper agent identities created using the Agent ID platform
- **Agents using application service principals**: Agents created before the Agent ID platform were introduced (for example, some agents from Microsoft Copilot Studio and Microsoft Foundry)

## Understanding the agent identities view

The **All agent identities** list provides comprehensive information about each agent identity in your tenant. By default, you see several columns of information for each agent.

### Default columns

The following columns are shown by default:

| Column Name | Description |
|-------------|-------------|
| **Name** | Display name of the agent identity. A human-friendly name that appears in various experiences. You can select a name to view full details. |
| **Status** | Current operational state: **Active** or **Disabled**. Disabled agents can't obtain tokens and users can't access them. |
| **Created On** | Date when the agent identity was created. |
| **Object ID** | Unique identifier for the agent identity within the Microsoft Entra tenant. |
| **Agent Blueprint ID** | Unique identifier for the agent identity blueprint that created this agent identity. This column is blank for agents using traditional service principals. |
| **Owners** | Direct link to view owners and sponsors for the agent identity. |

### Other columns available

To see all available columns, select the **Choose columns** button. Extra columns include:

- **View Access**: Direct link to the agent identity's permissions
- **Uses agent identity**: Indicates whether the agent has an agent identity object or uses a service principal

## Search for agent identities

The search box at the top of the list allows you to quickly find specific agent identities:

1. Enter either the **name** or **object ID** of the agent identity you want to find
2. The list filters in real time as you type

To search by **Agent Blueprint ID**:
1. Select the filter icon or **Add filter** option
2. Select **Agent Blueprint ID** from the available filters
3. Enter the blueprint ID to find all agent identities created from that blueprint

## Filter agent identities

You can refine the agent identities list using various filter criteria:

### Filter by status

1. Select the **Status** column header or add a status filter
2. Choose from:
   - **Active**: Agents that can currently obtain tokens and be accessed
   - **Disabled**: Agents that are blocked from obtaining tokens

### Filter by creation date

1. Select the **Created On** column header or add a created-on filter
2. Choose a time range such as "Last 7 days," "Last 30 days," or specify a custom date range

### Filter by identity type

1. Add the **Uses agent identity** filter
2. Select:
   - **Yes**: Show only agents using agent identity objects
   - **No**: Show only agents using traditional application service principals

This filter is useful to distinguish between modern agent identities and legacy agent implementations.

### Filter by agent blueprint

1. Add the **Agent Blueprint ID** filter
2. Enter a specific blueprint ID

The list shows only agent identities created from that blueprint. A list of blueprint aligned agents is helpful when you want to view all instances of a particular type of agent (for example, all "Sales Assistant Agents").

## Sort agent identities

Most columns support sorting to help you organize the list:

- Select any column header with a sort indicator
- Select once for ascending order
- Select again for descending order

### Sortable columns include:
- Name
- Status
- Created On

## View agent identity details

To see full details about a specific agent identity:

1. Select the agent identity's name from the list
2. The agent identity details pane opens, showing:
   - **Overview**: Name, description, logo, status, and link to parent agent identity blueprint
   - **Owners and Sponsors**: List of humans accountable for the agent
   - **Permissions**: Agent's granted permissions and Microsoft Entra roles
   - **Audit logs**: Historical activity performed by the agent
   - **Sign-in logs**: Authentication events for the agent identity

## Select multiple agent identities

You can select multiple agent identities to perform bulk actions:

1. Check the box next to each agent identity
2. The toolbar shows available actions for selected agents
3. Actions include:
   - **Disable**: Block selected agents from obtaining tokens
   - **Enable**: Re-enable previously disabled agents

## View agent identity blueprints

To view the blueprints that create agent identities:

1. From the **All agent identities** page, select **View agent blueprint** in the upper right of the command bar
2. The view switches to show agent identity blueprint principals in your tenant

The agent identity blueprint view includes similar columns:

| Column Name | Description |
|-------------|-------------|
| **Name** | Display name of the agent identity blueprint principal |
| **Agent identities** | Number of child agent identities created by this blueprint. Select to see linked agent identities. |
| **Status** | Operational state (Active or Disabled) |
| **Agent Blueprint ID** | Unique identifier for the blueprint |
| **Object ID** | Unique identifier for the blueprint principal |

## Practical scenarios

### Scenario 1: Find all agents of a specific type

To find all instances of a particular agent (for example, all "Contoso Sales Agents"):

1. Navigate to **All agent identities**
2. Add the **Agent Blueprint ID** filter
3. Enter the blueprint ID for "Contoso Sales Agent"
4. View all agent identities created from that blueprint

### Scenario 2: Disable all agents from a specific blueprint

To disable all agents of a particular type:

1. Filter by the **Agent Blueprint ID**
2. Select all agent identities in the filtered list (check the box next to each)
3. Select **Disable** in the toolbar

Alternatively, you can:
1. Navigate to **View agent blueprint**
2. Select the specific blueprint
3. Disable the blueprint, which prevents all its agent identities from authenticating

### Scenario 3: Review recently created agents

To see which agents were created in the last week:

1. Add or select the **Created On** filter
2. Choose "Last 7 days"
3. Review the list of newly created agent identities
4. Select any agent to view its details, owners, and permissions

### Scenario 4: Audit agent activity

To investigate what a specific agent has been doing:

1. Search for the agent by name or object ID
2. Open the agent details by **selecting** the agent
3. Navigate to the **Audit logs** or **Sign-in logs** tabs
4. Review the agent's authentication events and actions performed
