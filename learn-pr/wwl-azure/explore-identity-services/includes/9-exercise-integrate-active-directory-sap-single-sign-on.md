

Active Directory can be integrated with SAP single sign-on by configuring your SAP system with SNC (Secure Network Communication). The primary purpose of SNC is to secure connections between the NetWeaver ABAP application server and external applications, including SAP GUI. SNC provides an interface for external security products that can be used to enable single sign-on.

## Integrate SAP SSO with Active Directory

1. **Configure the SAP system**: Starting with NetWeaver ABAP version 7.31, use the configuration wizards (transactions SNCWIZARD and SPNEGO) in your SAP system to configure SSO. For earlier versions of NetWeaver ABAP, or if you don’t have access to the configuration wizards, you can configure SSO manually:

    1. Create a new AD user to be used as the service account for the NetWeaver ABAP system (preferably with a nonexpiring password).
    2. Use SETSPN to register the Service Principal Name (SPN) of the user created in the previous step.
    3. Install CommonCryptoLib on your SAP system.
    4. Set the SECUDIR directory (SECUDIR directory is the directory where the CommonCryptoLib license ticket file and PSE files reside). To set a directory as your SECUDIR directory, create a new environment variable called SECUDIR and point it to a directory. For example: **\\usr\\sap\[SID\]\\DVEBMGS00\\sec**
    5. In your SAP instance, set the profile parameters referencing the location of the sapcrypto.dll and the newly created SPN.
    6. Restart the SAP instance.
    7. Create the Kerberos Keytab file and the corresponding SAP Cryptolib PSE file for Kerberos-based SNC.
2. **Configure user mapping**:

    1. Sign in to your SAP instance via SAPGUI and run transaction SU01.
    2. Enter your SAP user (or the user that you want to map for SSO) in the name field and select **Edit**.
    3. Select the **SNC** tab and type the SNC name you configured in the previous task in the format **p:CN=UserPrincipalName@domain**
3. **Install secure login software on client computers**.
4. **Configure SAP GUI for SNC communication**

    1. In the **Secure Network Settings** interface, type the SNC name in the format **p:CN=ServicePrincipalName@domain**
    2. Initiate a connection. You should be signed in without being prompted to enter a password.
