#!/bin/bash

# -----------------------------------------------------------------------------
# ScriptName    ::      sync_vsftp_userlist.sh
# Version       ::      20240213.00
#
# Author        ::      Brivio Simone
#               ::      https://github.com/simobri
# License       ::      GNU General Public License v3.0
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
#
# This script is a quick tool for sync the members of the sytem group
# FTPUSERS_SYS_GROUPNAME to the VSFTP server list of authorized users
# name to keep them aligned.
#
# Usage: set the variables below properly, the provided one are just as 
# an example, then run manually after make changes to your users, or
# schedule it with cron to run automatically.
#
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# Global Variables

# Name of the group to be looked for source of the user list
FTPUSERS_SYS_GROUPNAME="ftp_users"

# Absolute path of the vsftp "userlist_file" file
VSFTPD_USERLIST_FILE="/etc/vsftpd.users_list"

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# Get the current member of the authorized to FTP users
USERLIST=$(/usr/bin/members ${FTPUSERS_SYS_GROUPNAME})

# Empty out the VSFTP user list to start clean
echo -n "" > ${VSFTPD_USERLIST_FILE}

# Populate the VSFTP user list file with the current user list
for i in $USERLIST;
do
    echo ${i} >> ${VSFTPD_USERLIST_FILE}
done

# Reload the vsftp service to apply the new settings
systemctl reload vsftpd
exit $?
