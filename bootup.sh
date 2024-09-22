#!/bin/bash

#Get files

#Get most recent load
oci os object get --bucket-name mc-server --name /backups/backup_$CURRENT_DATE.zip

#start server
sudo home/opc/run.sh
