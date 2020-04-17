Most apps have *so-called* master-detail views. What that concept means is that we have the following views:

- `list view`, this view contains a list of items
- `detail view`, this view shows a specific item from a list

Master-detail views can come with a different set of functionalities though. Some versions just contain a list view and a detail view whereas some gives the user the capability to add, remove, update and even delete items.

## Our Sample app

Our Sample app is of type master-detail. It is limited in what it can do. It will contain the following views:

- list view, this view will display a list of dream vacations
- detail view, this view will display a detailed view over one specific vacation
- navigation, we will need to support how to navigate to the list view as well as the detail view. We should support navigating directly to a detail view given the items unique identifier. Additionally we should support selecting an item in the list view and be taken to the detail view as well.

Gatsby is static site generator and operates on static data. We will therefore generate the content of these views based on static data that we present to Gatsby. The app will be limited to view the static data in list form or in detail. We will not support other capabilities such as creating, updating, or deleting items.

