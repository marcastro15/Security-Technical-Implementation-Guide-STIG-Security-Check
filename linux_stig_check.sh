#!/bin/bash
#Developer: Mar Castro
#PhD Student
#Dakota State University
#Oracle 7 MAC 3 security configuration check
#Supported until 2024

echo ""
echo "Red Hat Linux 7 - STIG Version MAC III Automation"
echo "Vendor Support is until 2024"
echo "Security Technical Implementation Guide (STIG)- Security Check"
echo "CHECK BASELINE INSTALLATION"
echo "Developer: Mar Castro"
echo ""

#The Oracle Linux operating system must not have the telnet-server package installed.
#Possible Installation: /etc/xinetd.d/telnet
echo ""
echo "------------------------------------------"
echo "STIG V-221763: Checking Telnet Installation"
echo "-------------------------------------------"
#check package
outputpackage=`rpm -qa | grep telnet`
#check process
systemctl status telnet.socket 1> telnet_o 2>&1 
output=`cat telnet_o | grep "could not be found"` 
echo "Status: $output" 
if [ -z "$output" ] 
then         
	echo "WARNING: This is a finding. Telnet is not a secure commmunication."
	echo "Please uninstall the package." 
else         
	echo "Telnet Process Not  Found: Not a finding."         	
fi
echo ""
echo "checking for package..."
if [ ! -z "$outputpackage" ] 
then         
	echo "WARNING: This is a finding."         
	echo "Please uninstall the package." 
else         
	echo "Telnet Package Not Found: Not a finding." 
fi
echo "" 
rm telnet_o #clean up


echo "---------------------------------------" 
echo "STIG V-221694/221695: Check GNOME Installation" 
echo "---------------------------------------"
#The Oracle Linux operating system must not allow an unrestricted logon to the system
# grep -i timedloginenable /etc/gdm/custom.conf TimedLoginEnable=false
gnome_o=`grep -i "timedloginenable=false" /etc/gdm/custom.conf`
#The Oracle Linux operating system must not allow an unattended or automatic logon to the system via a graphical user interface
gnome_o1=`grep -i "AutomaticLoginEnable=true" /etc/gdm/custom.conf`
echo "Checking for Installation.../etc/gdm/custom.conf"
echo "Checking for Configurations (must be set to false)...timedloginenable=false"
echo "Checking for Configurations...(must be set to true) AutomaticLoginEnable=true"
if [[ ! -z "$gnome_o" || ! -z "$gnome_o1" ]]; 
then         
	echo "WARNING: This is a finding."         
	echo "Please set the configuration of timedlogineable to true." 
else         
	echo "SUCCESS: GNOME configuration is not either installed or coonfigured correctly"
	echo "required by STIG requirement."
	echo "Not a finding." 
fi 
echo ""

#The Oracle Linux operating system must be configured so that the SSH daemon is configured to only use the SSHv2 protocol.
echo "-----------------------------------"
echo "STIG V-221856: Check SSH version 2."
echo "-----------------------------------"
ssh -V 1> ssh_o 2>&1
ssh_o=`cat ssh_o | grep 2.0`
ssh_e=`cat ssh_o | grep 1.0`
if [ -z "$ssh_o" ] 
then         
	echo "WARNING: This is a finding. Wrong version of SSH is installed." 
	echo "Version installed is $ssh_e"
	echo "Please installed version 2."
else         
	echo "SUCCESS: SSH 2.0 version found required by STIG." 
	echo "Found: No finding."         
fi
echo ""
rm ssh_o


#The Oracle Linux operating system must prevent the installation of software, patches, service packs, device drivers, or operating system components from a repository without verification they have been digitally signed using a certificate that is issued by a Certificate Authority (CA) that is recognized and approved by the organization.
echo ""
echo "--------------------------------------------------"
echo "STIG V-221710: Patches must be digitally signed."
echo "--------------------------------------------------"
signed_o=`grep gpgcheck /etc/yum.conf`
if [ -n "$signed_o" ]
then
	echo "this is not a finding."
	echo "Required parameter gpdcheck is set to 1"
else
	echo "This is a finding."
	echo "$signed_o"
	echo "This parameter must be set to 1"
fi
echo ""


#The Oracle Linux operating system must be configured so that the x86 Ctrl-Alt-Delete key sequence is disabled on the command line.
echo ""
echo "---------------------------------------------------"
echo "STIG V-221717: Disable ctrl-alt-del"
echo "---------------------------------------------------"
systemctl status ctrl-alt-del.target | grep inactive 1> ctrlaldel 2>&1
ctrl_o=`cat ctrlaldel | grep inactive`
if [ -n "$ctrl_o" ]
then
	echo "This is not a finding."
	echo "$ctrl_o"
	echo "is disabled."
else
	echo "This is a finding. Disable the ctrl-alt-de."
fi
rm ctrlaldel


#The Oracle Linux operating system must be a vendor supported release.
echo ""
echo "-----------------------------------------"
echo "STIG V-221719: Check vendor supported release"
echo "-----------------------------------------"
echo "The Oracle Linux operating system must be a vendor supported release."
echo "Current Version:"
uname -a
echo ""
echo "RELEASE: "
cat /etc/oracle-release
echo "Check Vendor Support: https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf"
echo ""


#Oracle Linux operating systems prior to version 7.2 with a Basic Input/Output System (BIOS) must require authentication upon booting into single-user and maintenance modes
echo ""
echo ""
echo "-----------------------------------------------------------"
echo "STIG V-221698: BIOS must require authentication."
echo "-----------------------------------------------------------"
echo "Goal: Configure the system to encrypt the boot password for root."
echo "Any version higher than 7.2 does not apply to this STIG."
echo "Checking..."
p=`sudo grep -i password_pbkdf2 /boot/grub2/grub.cfg`
s=`sudo grep -i "set superusers=\"root\"" /boot/grub2/grub.cfg`
if [[ -n "$p" || -n "$s" ]]
then
	echo "This is not a finding."
	echo "Configuration of grub is set properly as required by STIG."
	echo "Password: $p"
	echo "Superuser: $s"
else
	echo "This is a finding."
	echo "Please check the configuration of /boot/grub2/grub.cfg"
	echo "superusers must be set to root value and root bust by be encrypted."
fi
echo ""



#	The Oracle Linux operating system must not have the ypserv package installed.
echo ""
echo "-----------------------------------------------------"
echo "STIG V-221705: Must not have ypserv package installed"
echo "-----------------------------------------------------"
yum list installed ypserv 1> output1 2>&1
yserv_o=`cat output1 | grep "No matching Packages"`
if [ -n "$yserv_o" ] 
then         
	echo "SUCCESS: This is not a finding."         
	echo "yserv is not installed."         
	echo "Based on the listed information, no need to do anything."         
	echo "$yserv_o" 
else         
	echo "WARNING: This is a finding. Please uninstall yserve" 
	echo "$yserv_o"
fi 
echo "" 
rm output1

#The Oracle Linux operating system must not have the rsh-server package installed.
echo ""
echo "----------------------------------------"
echo "STIG V-221704: Remove rsh-server package"
echo "----------------------------------------"
echo ""
yum list installed rsh-server 1> output 2>&1
rsh_o=`cat output | grep "No matching Packages"`
if [ -n "$rsh_o" ]
then
	echo "This is not a finding."
	echo "rsh-server is not installed."
	echo "Based on the listed information, no need to do anything."
	echo "$rsh_o"
else
	echo "This is a finding. Please uninstall rsh-server"
fi
echo ""
echo ""
rm output #clean up

#The Oracle Linux operating system must not have accounts configured with blank or null passwords.
echo "--------------------------------------------------------"
echo "STIG V-221687: Accounts must not be configured with blank/null passwords"
echo "--------------------------------------------------------"
outputnull=`grep nullok /etc/pam.d/system-auth /etc/pam.d/password-auth`
if [ -n "$outputnull" ] 
then
	echo "This is a finding"
	echo "Remove any instances of the nullok option in /etc/pam.d/system-auth" 
	echo "and /etc/pam.d/password-auth to prevent logons with empty passwords."
	echo ""
	echo "See the message below..."
	echo "$outputnull"
else
	echo "This is  not a finding."
	echo "Search found that accounts are not allowed to have null passwords."
fi
echo ""
echo ""
#The Oracle Linux operating system must not contain shosts.equiv files.
echo "---------------------------------------------------------"
echo "STIG-221871/V-221870: Remove shosts.equv and .shosts files if found"
echo "---------------------------------------------------------"
echo "Searching for shosts.equv..."
sudo find / -name shosts.equiv 1> shosts_output 2>&1
sudo  find / -name '*.shosts' 1> shosts_output1 2>&1
file_o=`cat shosts_output`
file_o1=`cat shosts_output1`
if [[ -z "$file_o" || -z "$file_o1" ]]
then
	echo "SUCCESS: shosts.equ file NOT found."
	echo "This is not a finding."
else
	echo "Please remove shosts.equv required by STIG."
fi
echo ""
rm shosts_output
rm shosts_output1 #clean up


#The Oracle Linux operating system must be configured so that the SSH daemon does not allow authentication using an empty password.
echo ""
echo "----------------------------------------------------"
echo "STIG V-22188: Check not to permit without password on ssh. "
echo "----------------------------------------------------"
sudo grep -i PermitEmptyPasswords /etc/ssh/sshd_config 1> ssh_out 2>&1
ssh_o=`cat ssh_out | grep "#"`
ssh_yes=`cat ssh_out | grep "yes"`
if [[ -n "$ssh_o" || -n "$ssh_yes" ]]
then 
	echo "This is a finding. "
	echo "$ssh_o"
	echo "Enable the parameter and set it to NO value."
else
	echo "This is not a finding."
	echo "PermitEmptyPasswords is set to NO"
fi
echo ""
echo ""
rm ssh_out

#The Oracle Linux operating system must not have a File Transfer Protocol (FTP) server package installed unless needed.
#The Oracle Linux operating system must not have the Trivial File Transfer Protocol (TFTP) server package installed if not required for operational support.
echo ""
echo "-----------------------------------------------------------"
echo "STIG V-221884/V-221885 - Uninstall Unsecure FTP packages"
echo "-----------------------------------------------------------"
yum list installed tftp-server  1> tftp_out 2>&1
yum list installed vsftpd  1> ftp_out 2>&1
tftpo=`cat tftp_out| grep "No matching Packages"`
ftpo=`cat ftp_out| grep "No matching Packages"`
if [[ -n "$tftpa" || -n "$ftpa" ]]
then
	echo "This is a finding. Please check FTP/TFTP to make sure they are not installed."
else
	echo "SUCCESS: No FTP/TFTP installed in the system."
fi
	echo "Due to unsecure nature of FTP/TFTP, they are forbidden to be installed."

echo ""
rm tftp_out #clean up
rm ftp_out

#The Oracle Linux operating system must be configured so that the root account must be the only account having unrestricted access to the system.
echo ""
echo "-----------------------------------------------------------"
echo "STIG V-221723: Make Root account unrestricted."
echo "-----------------------------------------------------------"
acct=`awk -F: '$3 == 0 {print $1}' /etc/passwd`
if [ -n "$acct" ]
then
	echo "This is a finding. The following account below is detected with unstricted access."
	echo $acct
else
	echo "This is not a finding. No unrestricted access detected."
fi
echo ""

#SNMP community strings on the Oracle Linux operating system must be changed from the default.
#/etc/snmp/snmpd.conf
echo "------------------------------------------------------------------"
echo "STIG V-221891: Checking Simple Network Management Protocol (SNMP)"
echo "------------------------------------------------------------------"
echo "Checking SNMP Installation..."
snmp_installed=`ls -al /etc/snmp/snmpd.conf` 
if [ -n "$snmp_installed" ]
then
	echo "	Installed: $snmp_installed"
	echo "		Checking for configurations...public|private snmpd.conf settings"
	echo "		Note: If the "/etc/snmp/snmpd.conf" file exists, modify any lines"
	echo "		that contain a community string value of public or private" 
	echo "		to another string value."
 	#sudo grep public /etc/snmp/snmpd.conf > snmpd_o 
	#sudo grep private /etc/snmp/snmpd.conf >> snmpd_o
        snmpd_o=`sudo grep public /etc/snmp/snmpd.conf`
	snmpd_o1=`sudo grep private /etc/snmp/snmpd.conf`
	if [[ -n "$snmpd_o" || -n "$snmpd_o" ]] 
	then
		echo "			WARNING: This is a finding."
		echo "			Modify any lines that contain a community string value of "
		echo "			public or private to another string value."	
	else
		echo "SUCCESS: Not a finding."
		echo "public/private are not set."
	fi
else
	echo "SUCCESS: It's not a finding. SNMP is not installed."
fi
echo ""
#The Oracle Linux operating system must implement NIST FIPS-validated cryptography for the following: to provision digital signatures, to generate cryptographic hashes, and to protect data requiring data-at-rest protections in accordance with applicable federal laws, Executive Orders, directives, policies, regulations, and standards.
echo "" 
echo "---------------------------------------------------------------" 
echo "STIG V-221758: Check for Disk Encryption (NIST FIPS validated)" 
echo "--------------------------------------------------------------" 
enc=`sudo dmsetup status | grep crypt` 
if [ -n "$enc" ]
then
	echo "Disk is encrpted."
	echo "Warning: Check NIST Encryption Validation for further detail."
	echo "https://csrc.nist.gov/projects/cryptographic-module-validation-program/validated-modules/search"
else
	echo "WARNING: This is a finding. No encryption is detected."
	echo "Disks are not encrypted."
	echo "Please apply encryption with NIST Encryption Validation, not Compliant."
	echo "Check: https://csrc.nist.gov/projects/cryptographic-module-validation-program/validated-modules/search"
fi
echo ""

#The Oracle Linux operating system must use a virus scan program.
#Scan for Anti-Virus: clamav-daemon.socket - Socket for Clam AntiVirus userspace daemon
echo "-----------------------------------------------------"
echo "STIG V-221837: Checking Anti-Virus (AV) Installation"
echo "-----------------------------------------------------"
systemctl status clamav-daemon.socket 1> output 2>&1
output=`cat output | grep "could not be found"`
echo "Status: $output"
if [ ! -z "$output" ]
then
	echo "WARNING: This is a finding. Install an antivirus solution on the system."
else
	echo "SUCCESS: AV Found: No finding."
fi
echo ""
echo "----End of STIG Check---"
echo ""
rm output #cliean up
