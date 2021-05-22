# Security-Technical-Implementation-Guide-STIG-Security-Check
COTs products are heavily used by the Department of Defense (DoD). Any installation from the COTs' vendors requires configuring the installation securely. STIG is a framework used by DoD. For this check developed, it would automate a portion of the STIG. This portion script is the automation check of Mission Assurance Category level 3 (MAC III) to conduct day-to-day business operations for Oracle Linux. Oracle Linux STIG Check for Oracle Linux System Administrator is designed to parse the installation of Oracle Linux before rolling out to sandbox, test, or production environment. The goal is to automate the process of running the check installed conducting it manually. Usually, Data Centers have over 100 Linux environments deployed in the network. One does not have to check check every single node, but you can run the scripts to automate the checking process ensuring the configuration installation is secure and it conforms to the STIG required by DoD.

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

Pre-requisite Installation/Knowledge
------------------------------------
1. Oracle Linux 7 Version
2. Bash Scripts
3. Enable "sudo" configuration

How to run it?
-------------
Running the bash script is simple. It will check the security configuration setup of the Oracle linux and output the status. The goal here is to automate the process of checking the settings instead of checking them manually by hand. It should be a turn-key operations for the System Administrator of the systems.

./linux_stig_check.sh



