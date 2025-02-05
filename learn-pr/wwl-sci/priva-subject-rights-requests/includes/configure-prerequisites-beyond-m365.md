Subject rights requests for data beyond Microsoft 365 allow organizations to manage privacy-related requests across multicloud and on-premises environments. To get started, you need to ensure the solution is properly configured with essential prerequisites.

## Confirm access to the Data Map

The Microsoft Purview Data Map is a foundational tool for managing subject rights requests. It enables the service to search for data classifications and helps data owners locate and act on personal data. Verify that your organization has access to the [Microsoft Purview Data Map](/purview/concept-elastic-data-map?azure-portal=true) to use these capabilities effectively.

## Register assets in the Unified Catalog

To fully utilize subject rights requests, register your organization's data assets in the [Microsoft Purview Unified Catalog](/purview/unified-catalog-search?azure-portal=true). Registered assets must include classifications and data owners, which ensures:

- Relevant classifications can be searched efficiently.
- Tasks are automatically assigned to the appropriate data owners.

Registering assets improves the task creation process and ensures a streamlined workflow for fulfilling requests.

## Assign roles and permissions

Roles determine the tasks users can perform within the subject rights requests solution. Assign roles based on the responsibilities required for managing requests:

| Role | Access | Description |
|-----|-----|-----|
| **Data Reader** | Read-only access | Allows access to Data Map classifications and Unified Catalog details for scoped assets. |
| **Privacy Curator** | Read-write access | Enables creation and management of subject rights requests. |
| **Privacy Reader** | Read-only access | Provides view-only access to requests and tasks but doesn't allow modifications. |

For more information, see [Microsoft Purview governance roles and permissions](/purview/roles-permissions?azure-portal=true).

## Set up request forms and templates

To process subject rights requests, your organization must first create request forms and templates. These components define how requests are submitted and processed.

### Create request forms

Request forms are publicly available web forms that data subjects use to submit requests. These forms are customized with:

- **Contact details**: Include a privacy contact and organization privacy statement.
- **Questionnaire**: Add fields such as name, email address, and additional identifiers to locate the data subject's information.
- **Validation steps**: Implement identity validation, such as a one-time PIN (OTP) sent to the data subject's email.

Follow these steps to build a request form in the Microsoft Purview portal:

1. Navigate to **Subject Rights Requests** in the Microsoft Purview portal (preview).
1. Under **Data beyond Microsoft 365**, select **Request forms and templates**.
1. On the **Request forms** tab, select **New** and complete the required fields, such as form name, description, and privacy contact.
1. Customize the layout and questionnaire, then preview and finalize the form.

### Create templates

Templates establish the parameters for fulfilling subject rights requests. Each template defines:

- **Fulfillment deadlines**
- **Connected request forms**
- **Workflow requirements**

Templates define the fulfillment workflow for requests submitted through connected forms, ensuring that the request process aligns with organizational requirements and deadlines.

Steps to create a template:

1. Navigate to **Request forms and templates** in the Microsoft Purview portal.
1. On the **Templates** tab, select **New** and provide a name, description, and contacts.
1. Define the request workflow, including identity validation and storage locations for export packages.
1. Save and publish the template.

Once completed, templates and forms enable seamless request submission and processing.

## Ensure a strong data governance foundation

For subject rights requests to be effective, your organization needs a well-structured data governance solution. Strong governance ensures data is classified, understood, and actionable, which directly impacts your ability to manage requests efficiently. Key steps include:

- **Establishing glossary terms**: Use business-friendly terms to make data more discoverable and understandable for stakeholders.
- **Defining objectives and outcomes (OKRs)**: Align data usage with organizational goals to enhance compliance and decision-making.
- **Improving data quality**: Address issues like accuracy, consistency, and completeness to build trust in your data.

Implementing these practices helps your team maximize the value of subject rights requests and ensures a sustainable approach to managing data privacy.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
