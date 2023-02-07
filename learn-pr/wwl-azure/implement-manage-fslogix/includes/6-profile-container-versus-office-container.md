
It's important to understand the differences between Profile Container and Office Container for proper use and maximum benefit.

Office Container is a subset of Profile Container. Although all of the benefits of Office Container are also delivered from Profile Container, there are times when it may be beneficial to use them together.

Profile Container and Office Container are configured differently. It's important to completely understand the configuration process, especially when using them together.

## Understanding Profile Container

Profile Container is used to redirect the full user profile. Profile Container is used in non-persistent, virtual environments, such as Virtual Desktops. When using Profile Container, the entire user profile is included in the profile container except for data that is excluded using the redirections.xml.

For users familiar with managing profiles in non-persistent environments, the function of Profile Container may be compared to Microsoft User Profile Disk, Microsoft Roaming Profiles, or Citrix UPM.

## Understanding Office Container

Office Container is implemented with another profile solution, and is designed to improve the performance of Microsoft Office in non-persistent environments. As opposed to Profile Container, Office Container redirects only the local user files for Microsoft Office. When configuring Office Container, each Office component is independently included based on the selected settings to include data for specific office components.

When Office Container is used with other profile solutions, it's that those solutions are configured to exclude certain data.

The data contained in the Office Container can be re-created from various server locations. As an example, the .OST file is generated from the email server(S), if the file is lost or damaged it may be recovered.

## Using Profile Container and Office Container together

There are several reasons why Profile Container and Office Container may be used together. The most common reasons are:

 -  Discretion is wanted in the storage location for Office Data vs. other profile data.
 -  If the Office Container or Profile Container is damaged, the remaining data remains intact. Storage discretion is useful if there is a problem with Office Data, which can be recovered from the server as the Office Container can be deleted without impacting the rest of the user configuration.
 -  Office Container may be used with Profile Container as a mechanism to specify which Office components will have their data included in the container.
