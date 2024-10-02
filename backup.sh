#!/bin/bash
SOURCE_DIR="/home/opc/"
CURRENT_DATE=$(date +%Y%m%d)
OUTPUT="~/backupHold/${CURRENT_DATE}_backup.zip"

cd "$SOURCE_DIR"

sudo zip -r "$OUTPUT" mc-server/

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

