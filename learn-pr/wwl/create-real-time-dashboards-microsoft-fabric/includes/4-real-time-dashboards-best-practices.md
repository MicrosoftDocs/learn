As a Software as a Service, there are fewer things that you need to worry about outside of ***authentication*** and ***authorization*** which relate to who has access to your system and what they have access to. Microsoft manages the necessary sizes of clusters or starts and stops nodes that are in use behind the scenes. This service allows you to focus on what is necessary to gain valuable business insights from your data and information.

There are still some best practices to follow to help your users understand your dashboards, feeds, and other objects within Microsoft Fabric Real-Time Intelligence.


1. **Clarity and Simplicity**: Keep the dashboard simple and avoid clutter. 
    1. Use clear labels for tiles and visuals. 
    1. Use more pages for navigation or subject area when necessary.
1. **Relevance**: Ensure that the data displayed is relevant to the dashboard's purpose and the audience's needs.
1. **Refresh Rate**: Set an appropriate autorefresh rate to ensure data is up-to-date without overloading the system.
    1. Be sure to work with your users
    1. Ensure refresh rates are within their expectations.
1. **Accessibility**: Design dashboards that are accessible to all users, including those with viewer permissions.
1. **Interactivity**: Include features that allow users to interact with the data, such as filters and drill-down capabilities.
    1. Elicit feedback regularly to ensure that the reports continue to provide value.
    1. As users become more familiar with the products, the introduction of new features can enhance their productivity.
    1. Use Copilot when possible to increase productivity.
1. **Performance**: Optimize queries and visuals for performance to ensure a smooth user experience.
    1. Include parameters, which apply filters at the query and are executed during the rendering of the Real-Time Dashboard.
    1. Don't query more than you use in the visualization to meet the customer requirements.
1. **Security**: Implement proper security measures 
    1. Protect sensitive data.
    2. Remember, Fabric is a Software as a Service (SaaS) solution, and it's critical that you properly manage who has access to the system (Authentication), and what they have access too (Authorization).
1. **Testing**: Regularly test the dashboard for functionality and performance issues.
    1. Testing should include user-acceptance testing and feedback loops.

