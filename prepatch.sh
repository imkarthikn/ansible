#!/bin/bash
echo -n "Enter the HOSTNAME of the server: "
HOST=$1
echo $HOST
name=`whoami`
if [[ $name != "root" ]]
then
	echo " Kindly execute the script as ROOT user "
	echo " Exiting..... "
	exit
fi
cronjob()
{
	if [[ -f /etc/cron.d/cron.allow ]]
	then
		for user in `cat /etc/cron.d/cron.allow`
		do
			crontab -lu $user >> /tmp/$HOST-preout.txt
			echo " " >> /tmp/$HOST-preout.txt
			echo " " >> /tmp/$HOST-preout.txt
			echo "                                --------------------------------------------------------------                          "  >> /tmp/$HOST-preout.txt    
			echo " " >> /tmp/$HOST-preout.txt  
		done
	else
		ls -lrt /var/spool/cron | awk '{print $9}' > cron_users.txt
		cat cron_users.txt | sed '/^$/d;s/[[:blank:]]//g' > cu.txt 
		for cruser in `cat cu.txt` 
		do
			crontab -lu $cruser >> /tmp/$HOST-preout.txt
			echo " " >> /tmp/$HOST-preout.txt
			echo " " >> /tmp/$HOST-preout.txt
			echo "                                --------------------------------------------------------------                          "  >> /tmp/$HOST-preout.txt
			echo " " >> /tmp/$HOST-preout.txt      
		done
	fi
		
}
echo "Collecting pre-outputs..........." 
echo " "
echo "############################################################## Collecting Preoutput #########################################################" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "Script started at `date +%d-%b-%Y-%T-%Z`" >> /tmp/$HOST-preout.txt
echo "--------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "Hostname: $HOSTNAME" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "Uptime: `uptime`" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "--------------------------------------------------------- Mounted Filesystems ----------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
df -PhT | grep -v tmpfs >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "Total Mounted Filesystems: `df -PhT | grep -v tmpfs | wc -l`" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "-------------------------------------------------------- Filesystem Inode Details -------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
df -Phi | grep -v tmpfs >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ------------------------------------------------------- IP Configuration Details -------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
ifconfig -a >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " --------------------------------------------------------------------------------------------------------------------------------- " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
ip a >> /tmp/$HOST-preout.txt 
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ------------------------------------------------------------ Hosts Details --------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
cat /etc/hosts >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ----------------------------------------------------------- Route Information ------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
route -n >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ------------------------------------------------------------ FSTAB entries --------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
cat /etc/fstab >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " --------------------------------------------------------- - rc.local entries ------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
cat /etc/rc.local >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- SUDOERS Details -----------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
cat /etc/sudoers >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Disk Details ---------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
fdisk -l >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Multipath Details ----------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
multipath -ll >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Physical Volume Details ----------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
pvs -v >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " --------------------------------------------------------------------------------------------------------------------------------------" >> /tmp/$HOST-preout.txt
pvdisplay >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Volume Group Details --------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
vgs -v >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt 
echo " --------------------------------------------------------------------------------------------------------------------------------------" >> /tmp/$HOST-preout.txt
vgdisplay -v >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Logical Volume Details ----------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
lvs -v >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ------------------------------------------------------------------------------------------------------------------------------------ " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
lvdisplay -v >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " --------------------------------------------------------------- Process Details ------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
ps -ef >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- User Login History -----------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
last >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ---------------------------------------------------------------- Limits Details --------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
ulimit -a >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ----------------------------------------------------------------------------------------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
cat /etc/security/limits.conf >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ---------------------------------------------------------------------------------------------------------------------------------------- " >> /tmp/$HOST-preout.txt
cat /etc/security/limits.d/* >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Hardware Information ----------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
dmidecode >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ----------------------------------------------------------------- DMESG Details ------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
dmesg >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " -------------------------------------------------------------- Crontab Information ----------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
cronjob
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " ----------------------------------------------------------------- Firewall Rules -------------------------------------------------------" >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
iptables -vnL >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo " " >> /tmp/$HOST-preout.txt
echo "#################################################################### Script Completed #############################################################" >> /tmp/$HOST-preout.txt

echo -e "Hi Team, \n\n Please find the attached preoutput details taken from the server $HOST. \n \n \n Regards, \nIT Support" | mail -s "Pre-output from $HOST @`date -I`" -a /tmp/$HOST-preout.txt gurumohan.g@gaincredit.com revathy.sekar@gaincredit.com arunkumar.vv@gaincredit.com vinay.mahadevarao@gaincredit.com 



