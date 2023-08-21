The next step in the threat modeling process is to create a data-flow diagram.

## General assumptions

To build this diagram, we make the following assumptions:

- **Zero trust** - Data-flow begins in a zone that can't be trusted.
- **Context level** - The data-flow diagram begins with a high-level context diagram, followed by more in-depth diagrams as needed. Check out the [Provide context with the right depth layer](/training/modules/tm-provide-context-with-the-right-depth-layer/) module from the [Threat Modeling Security Fundamentals](/training/paths/tm-threat-modeling-fundamentals/) learning path to learn more.

## Elements

[!INCLUDE [Process Element](../includes/4-visualize-risk-process.md)]

</br>

---

[!INCLUDE [Data store Element](../includes/4-visualize-risk-data-store.md)]

</br>

---

[!INCLUDE [External entity Element](../includes/4-visualize-risk-external-entity.md)]

</br>

---

[!INCLUDE [Data-flow Element](../includes/4-visualize-risk-data-flow.md)]

</br>

---

[!INCLUDE [Trust boundary Element](../includes/4-visualize-risk-trust-boundary.md)]

> [!NOTE]
> Check out the [Create a threat model using data-flow diagram elements](/training/modules/tm-create-a-threat-model-using-foundational-data-flow-diagram-elements/) module from our [Threat Modeling Security Fundamentals](/training/paths/tm-threat-modeling-fundamentals/) learning path for an in-depth review of each element.

## Interactions

The next step is to capture the data-flow between each interaction:

### User

![User threat model.](../media/screenshots/user-threat-model.png)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![User External Entity to PAW Process.](../media/elements/external-entity-25.png)</br>User|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![PAW Process to User External Entity](../media/elements/process-25.png)</br>PAW|![Checkmark](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>Azure AD authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![User External Entity to Azure AD Process.](../media/elements/external-entity-25.png)</br>User|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![Azure AD Process to User External Entity](../media/elements/process-25.png)</br>Azure AD|![Checkmark](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>Phone authentication</li><li>2FA</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|

### Azure AD

![Azure AD threat model.](../media/screenshots/user-threat-model.png)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Azure AD Process to User External Entity.](../media/elements/process-25.png)</br>Azure AD|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![User External Entity to Azure AD Process](../media/elements/external-entity-25.png)</br>User|![Checkmark](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>Azure AD authentication</li><li>User credentials</li><li>Session tokens</li><li>Requests and responses</li></ul>|
|![Azure AD Process to PAW Process.](../media/elements/process-25.png)</br>Azure AD|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![PAW Process to Azure AD Process](../media/elements/process-25.png)</br>PAW|![Checkmark](../media/supporting-icons/check-25.png)</br>Yes|<ul><li>Authentication tokens and credentials</li><li>Requests and responses</li></ul>|

### PAW

![PAW threat model.](../media/screenshots/paw-threat-model.png)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![PAW Process to Azure AD Process.](../media/elements/process-25.png)</br>PAW|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![Azure AD Process](../media/elements/process-25.png)</br>Azure AD|![Checkmark](../media/supporting-icons/check-25.png)</br>Yes|*See **Azure AD** for details*|
|![PAW Process to User External Entity.](../media/elements/process-25.png)</br>PAW|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![User External Entity](../media/elements/external-entity-25.png)</br>User|![Checkmark](../media/supporting-icons/check-25.png)</br>Yes|*See **User** for details*|
|![PAW Process to Fourth Coffee Process.](../media/elements/process-25.png)</br>PAW|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![Fourth Coffee Process](../media/elements/process-25.png)</br>Fourth Coffee|![None](../media/supporting-icons/none-25.png)</br>No|<ul><li>Requests and responses</li></ul>|

### Fourth Coffee

![Fourth Coffee threat model.](../media/screenshots/fourth-coffee-threat-model.png)

|Element A|Data-flow|Element B|Crosses boundary|Details|
|---------|---------|---------|----------------|-------|
|![Fourth Coffee Process to PAW Process.](../media/elements/process-25.png)</br>Fourth Coffee|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![PAW Process to Fourth Coffee Process](../media/elements/process-25.png)</br>PAW|![None](../media/supporting-icons/none-25.png)</br>No|*See **PAW** for details*|
|![Fourth Coffee Process to Fourth Coffee Data Store.](../media/elements/process-25.png)</br>Fourth Coffee|![Bi-directional Flow](../media/elements/data-flow-25.png)</br>Bi-directional|![Fourth Coffee Data store to Fourth Coffee Process](../media/elements/data-store-25.png)</br>Fourth Coffee store|![None](../media/supporting-icons/none-25.png)</br>No|<ul><li>User credentials</li><li>Requests and responses</li></ul>|

## Finished diagram

![Application threat model for a secured environment.](../media/screenshots/secured-environment-application-threat-model.PNG)
