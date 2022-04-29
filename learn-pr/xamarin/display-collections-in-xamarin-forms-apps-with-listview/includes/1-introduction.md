[!include[](../../includes/dotnet-maui-note.md)]

Mobile applications often display lists of data in a scrollable panel. They use this style because mobile devices are small and screen space is limited.

Suppose you're building an educational app about the flags of various countries. Your UI will show a list of countries and their respective flags along with some extra information like the date the flag was adopted. The list of the countries can't fit on one screen.  You need a control to display the list in a scrollable panel. Xamarin.Forms provides the `ListView` control for this type of situation.

In this module, you'll use `ListView` to display a list of data. You'll start by populating the `ListView` control with simple string values. You'll add interactivity to respond when the user selects a row. Finally, you'll customize the appearance of each row to include an image and multiple labels. By the end of this module, you'll be able to build a Xamarin.Forms application that displays a dynamic set of data in a scrollable container.

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Create a `ListView` control and populate it with items
- Respond when the user interacts with the `ListView` control
- Customize the appearance of a `ListView` row by using built-in cell types

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
