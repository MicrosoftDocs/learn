[!include[](../../includes/dotnet-maui-note.md)]

Renderers are a key part of how every control in Xamarin.Forms works, enabling Xamarin.Forms to display user-interface elements on all platforms. All the built-in controls already have renderers. We can customize these renderers if we need to change the out-of-the-box behavior. We can also create custom controls in Xamarin.Forms by creating new renderers.

Suppose you're creating a drawing app in Xamarin.Forms. Users will be able to create a drawing by tracing on the touchscreen with their finger. The design also calls for a drop shadow to be included on one of the labels. You realize that, because labels already exist in Xamarin.Forms, you'll just need to adjust the existing implementation. But drawing controls aren't built in, so you know you'll have to create that control from scratch.

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module you will:

- Modify an existing control's renderer
- Create a new control with a new renderer
- Send notifications between a Xamarin.Forms element and native controls

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
