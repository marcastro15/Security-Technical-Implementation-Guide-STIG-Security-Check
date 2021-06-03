# Security-Technical-Implementation-Guide-STIG-Security-Check

What is STIG?
------------
It is a guide and rules best practices DISA has created for installation and supporting IT systems.

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

Demo
----
https://www.youtube.com/watch?v=DebY_g7AEYU
or 
https://youtu.be/DebY_g7AEYU


Future Work:
------------
The scripts could be extended to generate JSON output or improve the parsers by using available APIs in its native environment. The shell script is extensible that it can call other APIs written in different language to generate JSON (available in Python API or you can create it your own parser). That's why the baseline of the language is the bash; it's the native language of the Linux/Unix.  Dealing with STIG is like going through the narrow gate because you have limited option of language to use. Everything you do (API import into the systems, generate your own) will have to go through DoD adjudication process that will take a long time to get it approved. That's why you have to be careful what language/scripts you use so that you don't have to write it again. Lesson learned is that DoD has a very strict list of apps/OS to use and they hardly change (Maybe, every 10 years). As a result, your script won't change that much either. You write it once, it stays their for a long time without modifications.

Note the scripts handle only MAC level 3 of STIG; it could easily be extended to handle MAC level 1 and 2.

