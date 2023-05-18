

Application deployment planning consists of three phases: managing application inventory and compatibility, packaging applications, and providing life-cycle support.

### **Application inventory and compatibility**

Application compatibility can have a far-reaching impact on your organization. You can significantly reduce that impact by adequately planning your application compatibility project. Updates to Windows rarely affect application compatibility; however, they can happen. Most applications will function as expected when upgrading from a previous OS, such as Windows 10, to Windows 11. However, there are typically always some applications (such as Anti-virus) that will require attention.

Gathering an application inventory is the first step in understanding the effect of application compatibility changes in your environment. Microsoft offers tools to perform asset inventories, such as the **Microsoft Intune Suite**. For environments with thousands of managed applications, you can undertake an application compatibility project to reduce the number of applications in the environment, which will reduce the costs associated with application proliferation. An easy, immediate way to reduce the number of applications within an environment is to standardize the application versions across an organization.

Newer applications might supersede many older applications that provide similar functionality, thus enabling you to remove older applications. You eliminate corresponding licensing and support costs every time you remove an application. During an application compatibility project, you can analyze application compatibility across your entire enterprise.

### **Application packaging**

Application packaging and automated installation involve using silent installation commands from vendors. You can find these commands in installation guides, on Internet forums, or by launching the setup application with the /help or /? Command-line options.
Silent installation commands may not be available for applications that you develop in-house. If this occurs, you'll either need to package or repackage those applications if the installer package doesn't work. You can create Windows Installer packages. Microsoft Application Virtualization (App-V) provides a packaging mechanism with the application sequencing it uses to create virtual applications. 
 
>[!Note]
>Application Virtualization will be **end of life in April 2026**. We recommend looking at Azure Virtual Desktop with MSIX app attach. We'll cover Azure virtual Desktop later in this course.

### **Application life-cycle support**
Application life-cycle support usually involves deploying new applications, installing new versions of existing applications, and updating applications.

- **Deploying new applications:** It's best practice to test new applications for compatibility issues with existing applications.
- **Installing new versions of existing applications:** Version upgrades are usually significantly more complex than updates, and comprehensive planning and testing are fundamental to ensuring that the upgrade release occurs appropriately.
- **Updating applications:** Updates are far more frequent and require less testing than version upgrades.

### **Application Delivery**

Organizations have several options for choosing how to deliver applications. Applications can be installed automatically (such as during deployment, based on user group memberships) or through a portal where users can install applications On Demand. It would be best to consider whether the organization will support access to applications and data on personal devices. Most common scenarios include accessing work e-mail using Outlook on a mobile phone. Still, they can also have the ability for users to install line-of-business (LOB) apps on personal devices.

### **Microsoft Intune**
Microsoft Intune is a suite of centralized device deployment and management tools. Customers can manage their app deployments using Microsoft Intune. Intune supports a wide variety of application installation types. These deployments include common apps such as Office, application package deployment, line-of-business (LOB) apps, and curation of built-in apps. Intune also supports application policies to protect data in BYOD scenarios and ensures that only devices that meet compliance rules can access application data.

### **Virtual Application Delivery**
Virtual application delivery can be beneficial when the client can't run the application. Applications are installed on a server or Cloud PC and delivered remotely. Azure Virtual Desktop and Windows 365 can provide a client desktop experience. These solutions are excellent in scenarios where installing the application could be more practical or desired, such as providing temporary access to a contractor.

>[!Note]
>Azure Virtual Desktop and Windows 365 will be covered in more detail later in this course.
