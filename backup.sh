#!/bin/bash
SOURCE_DIR="/home/opc/mc-server2"
CURRENT_DATE=$(date +%Y%m%d)
OUTPUT="/home/opc/${CURRENT_DATE}_backup.zip"

sudo rm -rf /home/opc/mc-server2

rsync -av --exclude=".*" --exclude="dev/" --exclude="mc-server2" --exclude="main" --exclude="/lib*" /home/opc/ /home/opc/mc-server2

sudo zip -r "$OUTPUT" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Backup created! Check out $OUTPUT"

    oci os object put --bucket-name mc-server --name "/backups/${CURRENT_DATE}_backup.zip" --file "$OUTPUT"

    if [ $? -eq 0 ]; then
        echo "Uploaded successfully!"
        sudo rm "$OUTPUT"
    else
        echo "Uh Oh Stinky poopy bad! No uploady!"
    fi

else
    echo "Uh Oh Stinky poopy no zippy!"
fi

