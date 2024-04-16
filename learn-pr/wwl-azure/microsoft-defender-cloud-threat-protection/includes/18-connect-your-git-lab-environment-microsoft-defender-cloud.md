By connecting your GitHub organizations to Defender for Cloud, you extend the security capabilities of Defender for Cloud to your GitHub resources. These features include:

Foundational Cloud Security Posture Management (CSPM) features: You can assess your GitHub security posture through GitHub-specific security recommendations. You can also learn about all the recommendations for GitHub resources.

Defender CSPM features: Defender CSPM customers receive code to cloud contextualized attack paths, risk assessments, and insights to identify the most critical weaknesses that attackers can use to breach their environment. Connecting your GitHub repositories allows you to contextualize DevOps security findings with your cloud workloads and identify the origin and developer for timely remediation.

## Prerequisites

To complete this quickstart, you need:

 -  An Azure account with Defender for Cloud onboarded. If you don't already have an Azure account, create one for free.
 -  GitHub Enterprise with GitHub Advanced Security enabled for posture assessments of secrets, dependencies, IaC misconfigurations, and code quality analysis within GitHub repositories.

> [!NOTE]
> Security Reader role can be applied on the Resource Group/GitHub connector scope to avoid setting highly privileged permissions on a Subscription level for read access of DevOps security posture assessments.

## Connect your GitHub account

To connect your GitHub account to Microsoft Defender for Cloud:

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Go to **Microsoft Defender for Cloud** &gt; **Environment settings**.
3.  Select **Add environment**.
4.  Select **GitHub**.
5.  Enter a name (**limit of 20 characters**), and then select your subscription, resource group, and region. The subscription is the location where Defender for Cloud creates and stores the GitHub connection.
6.  Select **Next**: **select plans**. Configure the Defender CSPM plan status for your GitHub connector.
    
    :::image type="content" source="../media/select-plans-dd2c495f.png" alt-text="Screenshot showing how to Configure the Defender CSPM plan status for your GitHub connector.":::
    
7.  Select **Next**: **Configure access**.
8.  Select **Authorize** to grant your Azure subscription access to your GitHub repositories. Sign in, if necessary, with an account that has permissions to the repositories that you want to protect.
    
    After authorization, if you wait too long to install the DevOps security GitHub application, the session will time out and you'll get an error message.
9.  Select **Install**.
10. Select the organizations to install the GitHub application. It's recommended to grant access to **all repositories** to ensure Defender for Cloud can secure your entire GitHub environment.
    
    This step grants Defender for Cloud access to the selected organizations.
11. For Organizations, select one of the following:
     -  Select **all existing organizations** to autodiscover all repositories in GitHub organizations where the DevOps security GitHub application is installed.
     -  Select **all existing and future organizations** to autodiscover all repositories in GitHub organizations where the DevOps security GitHub application is installed and future organizations where the DevOps security GitHub application is installed.
12. Select **Next**: **Review and generate**.
13. Select **Create**.

    > [!NOTE]
    > To ensure proper functionality of advanced DevOps posture capabilities in Defender for Cloud, only one instance of a GitHub organization can be onboarded to the Azure Tenant you are creating a connector in.
