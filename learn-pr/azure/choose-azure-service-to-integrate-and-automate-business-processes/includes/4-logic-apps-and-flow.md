You want to choose a technology to automate the booking process for your bike rental business.

You want to streamline and modernize this process as it is performed on your original campus. You also want to integrate a bike tracking technology that is used on the new campus where you've recently obtained the rights to operate the existing bike rental business.

In this exercise, we'll examine this scenario in detail and choose which technology to use.

## Scenario

On your original campus, you have five bike rental shops. Each shop has a list of bikes for rent and its own database that records the bikes, their features, and whether they're already rented or in the shop.

Currently, each bike can only be rented from its home shop. When a customer returns a bike to another shop, your staff moves it back to the shop where it's listed on the database. You'd like to change the process so that each bike can be rented from any shop. However, you want to ensure staff can find out quickly where each bike is.

At the university in the next state, the bike rental business invested in a third party system to track bike locations. When a bike arrives back at a store, a unique barcode on the bike is scanned. The bike tracking database is automatically updated with the name of the shop that scanned the barcode. When a bike leaves a shop with a customer, the location is changed to "On Hire" and the customer name is recorded in a separate column. 

This system has proved helpful when a customer asks for a bike with specific frame size and/or specific features, such as an electric motor or all-terrain suspension. If a shop doesn't have a bike with the right equipment, the shop can quickly find out where such a bike is and get it or send the customer to the right shop. This bike location database has a REST API that you can call from other systems.

Your managing director wants to be able to clearly understand the workflow that you develop. There were problems in the past when documentation hasn't been kept in-sync with custom code and your director wants to see the process as it's implemented. 

## Business process

You want to update the bike reservation and rental process on both campuses to the following workflow:

:::image type="content" source="../media/4-bike-hire-workflow.png" alt-text="Decision flow diagram detailing the logic for the bike booking and rental process.":::

The details are as follows:

1. A customer requests a bike on the phone, in person, or through the website.
1. Shop staff record the customer's details and frame size.
1. Does the customer need specific features such as an electric motor, suspension, or a child trailer? If so what are those features?
1. Where are all the bikes with that frame size and  those features? This information is obtained from the bike location database and is kept up-to-date by the barcode scanning system.
1. Is there a bike with the right features and frame size in the right shop? If yes book that bike.
    1. If not, where is the nearest bike? Reserve that bike.
    1. Send an email to staff to move the bike to the customer.
    1. Scan barcode in new location.
1. Give the bike to the customer and update location to "On Hire".
1. Take payment from the customer.

This is a simplification of the entire process. For simplicity, we've omitted edge cases such as no bike with the desired frame size or feature is available for rent. Perhaps you can think of other cases not covered by this simplified process.

## Choose a technology

Let's look at the Azure technologies available to implement the business process and integrate with the bike location database:

- Microsoft Power Automate
- Azure Logic Apps
- Azure Functions
- Azure App Service WebJobs

You could use any of these technologies and others to build a workflow for this business process. Each technology can also integrate with any REST API, so you could also use any of these technologies to integrate with the bike location system. How do you choose from these options?

### Design-first or code-first?

We know that your Managing Director and her staff want to understand the workflow at a higher level than examining the code and implementation. She also doesn't like separate documents describing a process, because they so easily become out-of-date when the process changes.

If you choose a design-first approach, the workflow is visualized in an easy-to-understand design surface. In addition, that diagram isn't a separate document, but a picture of the process as it is implemented. The benefit is that the diagram will be updated when the process is changed.

For this reason, choose a design-first approach.

### Microsoft Power Automate or Azure Logic Apps?

Now you must choose from the two design-first technologies:

- Microsoft Power Automate
- Azure Logic Apps

There's no suggestion in the scenario that shop staff should be able to modify the business process. In addition, to connect to the bike location database through its REST API, you will need to create a custom connector. This is a developer task.

It seems sensible that the development of the custom connector and the workflow should be done by the same person or team. Since these must be developers, it's best to use Azure Logic Apps.

As this exercise shows, we can narrow down the technology to use for a given solution just by understanding the business process and the audience.
