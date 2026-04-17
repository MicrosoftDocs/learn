Creating and publishing a sensitivity label allows organizations to consistently classify and protect sensitive information according to defined security policies. This process ensures that confidential data is handled appropriately across all environments. This process also enables targeted control by making sure only authorized users or departments can access or apply specific labels, which enhances data governance and compliance efforts.

## Step 1: Create sensitivity labels

Customizable [sensitivity labels](/purview/sensitivity-labels#what-sensitivity-labels-can-do) can be created to "tag" content in various environments. These labels enable organizations to classify and protect sensitive information, ensuring the information is handled according to defined policies.

- **Label portability**: Sensitivity labels [travel with the document](/purview/sensitivity-labels#what-a-sensitivity-label-is), maintaining protection and classification even when files are shared outside the organization.

- When you configure a default sensitivity label for SharePoint document libraries and opt to extend protection to unencrypted files, SharePoint protection is applied to files upon download.

  - As a result, the current SharePoint permissions remain in place and integrate with the labeled file when the file is downloaded.

## Step 2: Assign labels by department

Labels can be prioritized and assigned (published) to specific departments, allowing for targeted control of sensitive data. This crucial step is often missed.

- Organizations with groups like HR and regular users need to manage different data types. As highlighted in module 1, defining boundaries and stakeholders helps clarify this split. Publishing labels via label policies ensures only relevant labels are available to users according to their roles or departments.

- Each sensitivity label can be configured with its own unique set of permissions, allowing organizations to tailor access controls for different types of data. These permissions are then applied to groups or departments through specific labeling policies, ensuring that only authorized users can interact with the labeled content.

- Administrators can select custom permissions based on business requirements, or utilize built-in options such as Owner, Editor, Restricted Editor, and Viewer roles. This flexibility supports precise policy enforcement and helps safeguard sensitive information across various environments.

## Sample labeling matrix

The sample labeling matrix provides examples of using custom permissions to assign labels to certain groups.

| Permissions/Others | General | Internal FTE | Internal Legal/HR | Confidential FTE | Confidential - Legal/HR | Highly Confidential FTE | Highly Confidential (personal data) | Presales Model |
|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| **Description** | Generic, nonsensitive file that can be shared outside of organization | To share only with Full Time Employees inside this organization.  | To share only with individuals working with legal or human resources not containing personal data. | To share confidential documents only with FTE. Users aren't allowed to change the label, forward the file, or use Save As. | To share confidential documents only with Legal and HR. Users aren't allowed to change the label, forward the file, or use Save As. | To share highly confidential information only with FTE. Only view and save permissions | To share highly confidential information only with approved user groups. Only view and save permissions | Rights permissions: read, edit, save, and allowed macros<br>Expiration: Never<br>Only online access |
| **View content (VIEW)** | Unprotected | X | X | X | X | X | X | X |
| **View rights (VIEWRIGHTSDATA)**  | Unprotected | X | X | X | X | - | - | - |
| **Edit content (DOCEDIT)**  | Unprotected | X | X | X | X | - | - | X |
| **Save (EDIT)** | Unprotected | X | X | X | X | X | X | X |
| **Print (PRINT)**  | Unprotected | X | X | X | X | - | - | - |
| **Copy and extract content (EXTRACT)**  | Unprotected | X | X | X | X | - | - | - |
| **Reply (REPLY)**  | Unprotected | X | X | X | X | - | - | - |
| **Reply all (REPLY ALL)**  | Unprotected | X | X | X | X | - | - | - |
| **Forward (FORWARD)**  | Unprotected | - | - | - | - | - | - | - |
| **Edit rights (EDITRIGHTSDATA)**  | Unprotected | X | X | - | - | - | - | - |
| **Export content (EXPORT)**  | Unprotected | X | X | - | - | - | - | - |
| **Allow macros (OBJMODEL)**  | Unprotected | X | X | X | X | X | X | X |
| **Full control (OWNER)**  | Unprotected | - | - | - | - | - | - | - |
| **Users / Groups (Encryption)** | Unprotected | FTE | Legal and Human resources | FTE | Legal and Human resources | FTE | Legal and Human resources | Marketing |
| **Offline access** | Unprotected | 7 days | 7 days | 7 days | 7 days | 7 days | 7 days | Never |
| **Content expiration** | Unprotected | Never | Never | Never | Never | Never | Never | Never |
| **Visual marking** | Footer | Footer | Footer | Footer | Footer | Footer, Watermark | Footer, Watermark | Footer |
| **Policy** | Global | Global | HR User Group Policy | Global | HR User Group Policy | Global | HR User Group Policy | Marketing Group Policy |

For a full description of all the permissions, see the [usage rights and descriptions documentation](/azure/information-protection/configure-usage-rights#usage-rights-and-descriptions).

Looking for more use cases surrounding label usage? See the [common scenarios for sensitivity labels table](/purview/get-started-with-sensitivity-labels#common-scenarios-for-sensitivity-labels).

Once labels are configured and assigned to the correct user groups, the next step is to move to what is automatically labeled versus manually (user initiated) labeled.
