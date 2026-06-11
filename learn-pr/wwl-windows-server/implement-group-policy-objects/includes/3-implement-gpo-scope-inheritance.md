Policy settings in GPOs define configuration. However, you must specify the computers or users to which the GPO applies before the configuration changes in a GPO will affect computers or users in your organization. This is called scoping a GPO. The scope of a GPO is the collection of users and computers that will apply the settings in the GPO.

> [!IMPORTANT]
> You scope a GPO by linking it to an OU that contains the target users and computers.

## Scope a GPO

You can use several methods to manage the scope of domain-based GPOs. The first is the GPO link. In AD DS, you can link GPOs to:

 -  Sites
 -  Domains
 -  OUs

The site, domain, or OU then becomes the maximum scope of the GPO. The configurations that the policy settings in the GPO specify will affect all computers and users within the site, domain, or OU, including those in child OUs. You can link a GPO to more than one domain, OU, or site.

> [!CAUTION]
> Linking GPOs to multiple sites in a multiple domain forest can introduce performance issues when applying the policy, and you should avoid linking GPOs to multiple sites in this situation. This is because, in a multi-forest multiple-site network, the GPOs are stored on the domain controllers in the domain where the GPOs were created. The consequence of this is that computers in other domains might need to traverse a slow wide area network (WAN) link to obtain the GPOs.

You can further narrow the scope of the GPO with one of two types of filters discussed in the following table.

:::row:::
  :::column:::
    **Filter**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security
  :::column-end:::
  :::column:::
    These specify security groups or individual user or computer objects that relate to a GPO’s scope, but to which the GPO explicitly should or shouldn't apply.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    WMI
  :::column-end:::
  :::column:::
    These specify a scope by using characteristics of a system, such as an operating system version or free disk space.
  :::column-end:::
:::row-end:::


:::image type="content" source="../media/m8-group-policy-4-20d1e6db.png" alt-text="A screenshot of the Group Policy Management console. The administrator has selected a GPO linked to the Marketing OU. Displayed on the detail pane are a WMI filter called Windows 10 Devices, and a security filter set to the Marketing group.":::


Use security filters and WMI filters to narrow or specify the scope within the initial scope that the GPO link created. The following is an example of a WMI filter that results in a list of computers running Windows 10.

```powershell
select * from Win32_OperatingSystem where Version like "10.%"

```

## GPO processing order

The GPOs that apply to a user, computer, or both don't apply all at once. GPOs apply in a particular order. Conflicting settings that process later might overwrite settings that process first.

Group Policy follows the following hierarchical processing order:

1.  Local GPOs.
2.  Site-linked GPOs.
3.  Domain-linked GPOs.
4.  OU-linked GPOs.
5.  Child OU-linked GPOs.

> [!IMPORTANT]
> In Group Policy application, the default rule is that the last policy (the most specific policy) applied prevails.

For example, a policy that restricts access to the Control Panel applied at the domain level could be reversed by a policy applied at the OU level for the objects contained in that particular OU.

If you link several GPOs to an OU, their processing occurs in the order that the administrator specifies on the OU’s **Linked Group Policy Objects** tab in the Group Policy Management Console. By default, processing is enabled for all GPO links. You can disable a container’s GPO link to block the application of a GPO completely for a given domain or OU. For example, if you made a recent change to a GPO and it's causing production issues, you can disable the link or links until the issue resolves.

> [!NOTE]
> Note that if the GPO is linked to other containers, they'll continue to process the GPO if their links are enabled.

You also can disable the user or computer configuration of a particular GPO independently from either the user or computer. If one section of a policy is known to be empty, disabling the other section can speed up policy processing slightly. For example, if you have a policy that only delivers user desktop configuration, you could disable the computer section of the policy.

## GPO inheritance

You can configure a policy setting in more than one GPO, which might result in GPOs conflicting with each other. In this case, the precedence of the GPOs determines which policy setting the client applies. A GPO with higher precedence prevails over a GPO with lower precedence. Precedence is determined numerically. Each GPO has a precedence value. The lower the number, the higher the precedence. Therefore, a GPO that has a precedence of one prevails over all other GPOs.

The default behavior of Group Policy is that GPOs linked to a higher-level container are inherited by lower-level containers. When a computer starts up or a user signs in, the Group Policy Client Extensions examines the location of the computer or user object in AD DS and evaluates the GPOs with scopes that include the computer or user. Then, the client-side extensions apply policy settings from these GPOs. Policies apply sequentially, beginning with the policies that link to the site, followed by those that link to the domain, followed by those that link to OUs. This sequential application of GPOs creates an effect called policy inheritance. Policies are inherited, which means that the Resultant Set of Policies (RSoPs) for a user or computer will be the cumulative effect of site, domain, and OU policies.

### Block Inheritance

You can configure a domain or OU to prevent the inheritance of policy settings. This is known as blocking inheritance. To block inheritance, right-click or access the context menu for the domain or OU in the GPMC console tree, and then select **Block Inheritance**.

:::image type="content" source="../media/m8-group-policy-5-f65ab601.png" alt-text="A screenshot of the context menu for the Marketing OU in the Group Policy Management console. The administrator has selected Block Inheritance.":::


The Block Inheritance option is a property of a container, so it blocks all Group Policy settings from GPOs that link to parents in the Group Policy hierarchy.

> [!CAUTION]
> Use the Block Inheritance option sparingly because blocking inheritance makes it more difficult to evaluate Group Policy precedence and inheritance.

> [!TIP]
> With security group filtering, you can carefully scope a GPO so that it applies to only the correct users and computers in the first place, making it unnecessary to use the Block Inheritance option.

### Enforce a GPO link

Additionally, you can set a GPO link to be enforced. To enforce a GPO link, right-click or access the context menu for the GPO link in the console tree, and then select **Enforced** from the shortcut menu.

:::image type="content" source="../media/m8-group-policy-6-69631719.png" alt-text="A screenshot of the context menu for the Contoso Domain Security Settings GPO in the Group Policy Management console. The administrator has selected Enforced.":::


When you set a GPO link to Enforced, the GPO takes the highest level of precedence. Policy settings in that GPO prevail over any conflicting policy settings in other GPOs.

> [!IMPORTANT]
> An enforced link applies to child containers even when those containers are set to Block Inheritance. The Enforced option causes the policy to apply to all objects within its scope.

Enforcement is useful when you must configure a GPO that defines a configuration that's mandated by your corporate IT security and usage policies. Therefore, you want to ensure that other GPOs that are linked to the same or lower levels don't override those settings. You can do this by enforcing the GPO’s link.

### Evaluating precedence

To facilitate evaluation of GPO precedence, you can simply select an OU or domain, and then select the **Group Policy Inheritance** tab. This tab displays the resulting precedence of GPOs, accounting for GPO link, link order, inheritance blocking, and link enforcement.

:::image type="content" source="../media/m8-group-policy-7-48f33863.png" alt-text="A screenshot of the Group Policy Management console. The administrator has selected the Group Policy Inheritance tab for the Marketing OU. Four policies are displayed, two of which are Enforced from the domain.":::


> [!IMPORTANT]
> This tab doesn't account for policies that are linked to a site, for GPO security, or WMI filtering.

## Filter GPO scope by using security principals

The scope created by a GPO link includes every user and computer in the linked site, domain, or OU. Security filtering lets you narrow that scope so that the GPO applies only to specific security principals—security groups, individual users, or individual computers.

A computer or user must have two permissions on a GPO before the client applies its settings:

 -  **Read**
 -  **Apply group policy**

By default, both permissions are granted to the **Authenticated Users** group. Because Authenticated Users includes all user *and* computer accounts that authenticate to the domain, a newly linked GPO applies to everyone within its scope.

To filter the scope, use the **Security Filtering** section on a GPO's **Scope** tab:

1.  Remove **Authenticated Users**.
2.  Add the security groups, users, or computers to which the GPO should apply.

When you add a principal in the Security Filtering section, the Group Policy Management Console automatically grants that principal both the **Read** and **Apply group policy** permissions.

> [!IMPORTANT]
> After the MS16-072 security update, Group Policy retrieves the list of GPOs in the computer's security context rather than the user's. As a result, the computer account must have at least **Read** permission to the GPO. If you remove Authenticated Users from Security Filtering, add the **Domain Computers** group (or the relevant computer accounts) with the **Read** permission—but *not* Apply group policy—so user-targeted GPOs still process correctly.

You can also explicitly *exclude* a principal. On the GPO's **Delegation** tab, select **Advanced**, add the principal, and then set **Apply group policy** to **Deny**. A Deny permission always overrides an Allow, so the GPO won't apply to that principal even if it's a member of an included group.

> [!TIP]
> Use Deny sparingly. Explicit Deny permissions don't appear in the Security Filtering section, which can make troubleshooting precedence and scope more difficult.

## Filter GPO scope by using WMI filters

A Windows Management Instrumentation (WMI) filter limits a GPO's scope based on characteristics of the target system, such as operating system version, hardware platform, free disk space, or whether a computer is a laptop. A WMI filter is a query written in the WMI Query Language (WQL) that's evaluated against the WMI repository on each target computer. The GPO applies only if the query evaluates to **true**.

The following example returns true only on computers running a version of Windows that begins with 10:

```powershell
select * from Win32_OperatingSystem where Version like "10.%"

```

The next example returns true only on computers that report a chassis type that corresponds to a portable computer (laptop):

```powershell
select * from Win32_SystemEnclosure where ChassisTypes = "9" or ChassisTypes = "10" or ChassisTypes = "14"

```

Keep the following characteristics of WMI filters in mind:

 -  A GPO can be linked to only **one** WMI filter, but a single WMI filter can be linked to **many** GPOs.
 -  The WMI filter is evaluated every time Group Policy processes, which adds overhead. Extensive use of WMI filters can slow sign-in and startup.
 -  A WMI query that fails to evaluate (for example, because it references a class that doesn't exist on the client) is treated as false, and the GPO doesn't apply.

To apply a WMI filter, select the GPO in the Group Policy Management Console, and on the **Scope** tab, choose the filter from the **WMI Filtering** drop-down list.

## Configure Group Policy loopback processing

Normally, the user configuration settings that apply to a user come from the GPOs scoped to the *user's* location in AD DS, and the computer configuration settings come from the GPOs scoped to the *computer's* location. In some scenarios—such as kiosks, classroom and lab computers, and Remote Desktop Session Hosts—you want the user experience to be determined by the computer that the user signs in to, not by the user's own account location.

Loopback processing applies the **user** configuration settings from the GPOs scoped to the *computer*, regardless of which user signs in. You enable it by configuring **Configure user Group Policy loopback processing mode**, found in **Computer Configuration\Policies\Administrative Templates\System\Group Policy**. The setting offers two modes:

:::row:::
  :::column:::
    **Mode**
  :::column-end:::
  :::column:::
    **Behavior**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Replace
  :::column-end:::
  :::column:::
    The user settings that would normally apply based on the user's location are *not* processed. Only the user settings in the GPOs scoped to the computer apply.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Merge
  :::column-end:::
  :::column:::
    The user settings from the GPOs scoped to the user are applied first, and then the user settings from the GPOs scoped to the computer are applied. Where the two conflict, the computer-scoped user settings prevail because they apply last.
  :::column-end:::
:::row-end:::

> [!NOTE]
> Loopback processing affects only the user configuration settings of GPOs. Computer configuration settings always apply based on the computer's location in AD DS.
