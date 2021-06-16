Here we’ll discuss what criteria you can use to decide when to use Red Hat on Azure. Red Hat offers a complete portfolio of infrastructure software stack—through RHEL, ARO, and JBoss EAP—that are integrated and interoperable across on-site, hybrid, and cloud environments.

## Decision criteria

We’ll list some criteria that you can use to help you decide if Red Hat on Azure is right for you based on your:

- Type of application running
- App development strategy
- Programming language
- Infrastructure environment

## Apply the criteria

Red Hat is a good choice as your Linux distro on Azure because it is built on more than 25 years of enterprise experience with Linux, and it continues to be one of the top Linux kernel contributors.

|Decision criteria  |Considerations  |
|---------|---------|
|Type of application running     |<p>Red Hat has decades of experience working with the largest enterprise software vendors like Oracle, SAS, and SAP to certify their applications on Red Hat products. With these strong partnerships, Red Hat makes a great choice for migrating SAP or SAS applications to Azure.<p>However, if you primarily use another Linux vendor, such as SUSE, you might want to first explore whether or not they offer a package to support your specific application in Linux before adopting RHEL for a couple of isolated workloads. |
|App development strategy      |<p>The Azure Red Hat OpenShift (ARO) service supports a containerized approach to building modern applications. The platform includes all the tools required for the complete software development lifecycle.<p>If you run DevOps or DevSecOps, ARO provides the features you need to build and deploy applications in OpenShift including introducing security best practices and scanning at any stage of the CI/CD pipeline.<p>If you’re using another Kubernetes engine for container management such as Amazon Kubernetes Service or Dockers, ARO is a more feature rich choice for you. |
|Programming language used     |<p>If you are a Java-based development organization that wants to have a cloud-friendly and fully supported enterprise Java application server, Red Hat offers JBoss EAP as the foundation of its Application Services portfolio.<p>JBoss EAP is great for quickly modernizing your Java application as it provides a flexible application server that you can use to simplify your cloud migration plan. It’s optimized for cloud and containers which allows for deployment across public, private, hybrid, and even multi-cloud infrastructures.<p>If you’re using Spring Boot for your standalone, JBoss may not be the best choice.  |
|Infrastructure environment      |<p>Red Hat offerings deliver a consistent, intelligent operating foundation for modern IT and enterprise hybrid cloud deployments. Consistency across infrastructure allows you to deploy applications, workloads, and services using the same tools, regardless of location.<p>When you need to ensure compliance with corporate, regulatory, and industry requirements while also protecting your systems from the latest security threats, Red Hat and Azure meet compliance for some of the most stringent security standards including FIPS, Common Criteria, HIPPA, and PCI.<p>If you run primarily in a competitors’ cloud or if you want to manage your own infrastructure, Red Hat on Azure might not be the right solution for your workloads.     |

### Should the online retailer use Red Hat on Azure?

In the example scenario, the online retailer you work for runs its Java-based website on Red Hat hosted in an on-premises datacenter. To build new capabilities for the website and improve the customer experience, you suggested using Red Hat solutions on Azure, and starting fast by selecting tested and trusted images through Cloud Access or from the Azure Marketplace.

Since the retailer already uses Red Hat on-premises, Red Hat Enterprise Linux on Azure is a logical choice because it offers familiar functionality. Choosing Azure also means getting help staying on top of PCI standards, which your team is required to meet to handle customer’s personal payment information.

To help the team adopt a more modern application development strategy, you suggest using Red Hat OpenShift to help remove roadblocks for developers and enable continuous delivery and deployment of applications at speed without a lot of maintenance. Lastly, seeing as the primary programming language is Java, JBoss EAP makes an excellent choice modernizing the app itself.
