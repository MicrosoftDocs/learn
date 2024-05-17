As a Software as a Service, there are fewer things that you need to worry about outside of ***authentication*** and ***authorization*** which relate to who has access to your system and what they have access to. Microsoft manages the necessary sizes of clusters or starts and stops nodes that are in use behind the scenes. This service allows you to focus on what is necessary to gain valuable business insights from your data and information.

There are still some best practices to follow to help your users understand your dashboards, feeds, and other objects within Microsoft Fabric Real-Time Intelligence.


- **Clarity and Simplicity**: Keep the dashboard simple and avoid clutter.
    - Use clear labels for tiles and visuals. 
    - Use more pages for navigation or subject area when necessary.
- **Relevance**: Ensure that the data displayed is relevant to the dashboard's purpose and the audience's needs.
- **Refresh Rate**: Set an appropriate autorefresh rate to ensure data is up-to-date without overloading the system.
    - Be sure to work with your users
    - Ensure refresh rates are within their expectations.
- **Accessibility**: Design dashboards that are accessible to all users, including those with viewer permissions.
- **Interactivity**: Include features that allow users to interact with the data, such as filters and drill-down capabilities.
    - Elicit feedback regularly to ensure that the reports continue to provide value.
    - As users become more familiar with the products, the introduction of new features can enhance their productivity.
    - Use Copilot when possible to increase productivity.
- **Performance**: Optimize queries and visuals for performance to ensure a smooth user experience.
    - Include parameters, which apply filters at the query and are executed during the rendering of the Real-Time Dashboard.
    - Don't query more than you use in the visualization to meet the customer requirements.
- **Security**: Implement proper security measures 
    - Protect sensitive data.
    - Remember, Fabric is a Software as a Service (SaaS) solution, and it's critical that you properly manage who has access to the system (Authentication), and what they have access too (Authorization).
- **Testing**: Regularly test the dashboard for functionality and performance issues.
    - Testing should include user-acceptance testing and feedback loops.