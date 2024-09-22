#!/bin/bash
SOURCE_DIR="/home/opc/backup1"
CURRENT_DATE=$(date +%Y%m%d)
OUTPUT="/home/opc/backup_$CURRENT_DATE.zip"


sudo zip -r "$OUTPUT" "$SOURCE_DIR"

if [$? -eq 0]; then
    echo "Backup created! Check out $OUTPUT"

    oci os object put --bucket-name mc-server --name "backup_$CURRENT_DATE.zip" --file "$OUTPUT"

    if [$? -eq 0]; then
        echo "Uploaded successfully!"
    else
        echo "Uh Oh Stinky poopy bad!"
    fi

else
    echo "Uh Oh Stinky poopy no zippy!"
fi

