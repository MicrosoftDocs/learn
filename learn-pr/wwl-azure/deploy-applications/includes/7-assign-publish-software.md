Two deployment types are available for delivering software to clients. Administrators can either install software for users or computers in advance by assigning the software, or give users the option to install the software when they require it by publishing the software in AD DS. Both user and computer configuration sections of a Group Policy Objects (GPO) have a Software Settings section. You can add software to a GPO by adding a new package to the Software Installation node and then specifying whether to assign or publish it.

You also can choose advanced deployment of a package. Use this option to apply a customization file to a package for custom deployment. For example, you can use the Office Customization tool to create a setup customization file to deploy Microsoft Office.

#### Assign software

Assigning software has the following characteristics:

 -  **When you assign software to a user, the user’s Start menu advertises the software when the user logs on**. Installation doesn't begin until the user double-clicks the application's icon or a file that is associated with the application.
 -  **Users don’t share deployed applications**. When you assign software to a user, an application that you install for one user through Group Policy may not be available to other users. Assigning software to a user is preferred when the software is used by a subset of users, or when the software has licensing costs associated with it and you don’t want to purchase licenses that won't be used.
 -  **When you assign an application to a computer, the application is installed the next time that the computer starts**. The application will be available to all users of the computer. Assigning software to a computer is preferred when you need to have the software installed on a specific set of computers or on all computers in an environment, regardless of which users use the computers. This is a common situation when dealing with agent software, such as monitoring agents, security-related agents, or management agents.

#### Publish software

Publishing software has the following characteristics:

 -  The Programs > Programs and Features shortcut in Control Panel advertises a published application to the user. Users can install the application by using the Install a program from the network shortcut, or extension activation can install the application. Extension activation will initiate the program installation when a user selects on a file type that is associated with the program.
 -  Control Panel doesn't advertise applications to users who don't have permission to install them.
 -  Applications can't be published to computers.
