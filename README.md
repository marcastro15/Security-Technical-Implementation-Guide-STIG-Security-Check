# Security-Technical-Implementation-Guide-STIG-Security-Check
COTs products are heavily used by Department of Defense (DoD). Any installation from the COTs' vendors require to securely configure the installation. STIG is a framework used by DoD. For this check developed, it would automate portion of the STIG. This portion script is the automation check of Mission Assurance Category level 3 (MAC III) to conduct day-to-day business operations for Oracle Linux. Oracle Linux STIG Check for Oracle Linux System Administrator is designed to parse the installation of Oracle Linux before rolling out to sandbox, test, or production environment. The goal is to automate the process of running the check instaled conducting it manually.

The following feature will check for the following Oracle Linux Security Configurations required by STIG:
1. Check for Telnet 
2. Check for GNOME 
3. Check for SSH version
4. Check for Patches
5. Disable ctr-alt-del check
6. Vendor Support Release Check
7. Required BIOS
8. Check for unwanted packages - FTP, TFTP, yserv, SNMP, etc.
9. Check for blank/null passwords accounts, root account config, and SSH accounts restriction
10.Check for shosts files
11.FIPS validation
12. AntiVirus installation




